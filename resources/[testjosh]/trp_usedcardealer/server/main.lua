ESX = nil
local availableVehiclesForSale, isVehicleBusy = {}, {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

MySQL.ready(function()
	MySQL.Async.fetchAll('SELECT plate, owner, label, vehicle_props, price FROM trp_usedcardealer', {}, function(result)
		for k,v in ipairs(result) do
			availableVehiclesForSale[v.plate] = {
				owner = v.owner,
				--networkID = v.network_id,
				label = v.label,
				vehicleProps = v.vehicle_props,
				price = v.price
			}
		end
	end)

	Citizen.Wait(2000)
	-- reload midgame
	TriggerClientEvent('trp_usedcardealer:setVehiclesForSale', -1, availableVehiclesForSale)

	for k,playerId in ipairs(ESX.GetPlayers()) do
		local xPlayer = ESX.GetPlayerFromId(playerId)

		if xPlayer and xPlayer.get('networkID') then
			TriggerClientEvent('trp_usedcardealer:relayMyNetworkID', playerId, xPlayer.get('networkID'))
		end
	end
end)

AddEventHandler('adrp_characterspawn:characterSet', function(character)
	TriggerClientEvent('trp_usedcardealer:setVehiclesForSale', character.playerId, availableVehiclesForSale)
	TriggerClientEvent('trp_usedcardealer:relayMyNetworkID', character.playerId, character.networkID)
end)

ESX.RegisterServerCallback('trp_usedcardealer:buyVehicle', function(playerId, cb, plate, price)
	if not isVehicleBusy[plate] then
		isVehicleBusy[plate] = true
		local xPlayer = ESX.GetPlayerFromId(playerId)

		if xPlayer and availableVehiclesForSale[plate] then
			local bankBalance, buyingVehicle = xPlayer.getAccount('bank').money, availableVehiclesForSale[plate]

			-- is the price parsed from client the same we have saved?
			-- this is to make sure that the owner cant change the price
			-- whilst someone is in the process of buying their vehicle
			if price == buyingVehicle.price then
				if bankBalance >= buyingVehicle.price then
					local xOwner, payDatabase = ESX.GetPlayerFromIdentifier(buyingVehicle.owner), false

					-- is owner online?
					if xOwner then
						local networkID = xOwner.get('networkID')

						-- is owner playing on the same character?
						if networkID == buyingVehicle.networkID then
							MySQL.Async.execute('DELETE FROM trp_usedcardealer WHERE plate = @plate', {
								['@plate'] = plate
							}, function(rowsChanged)
								if rowsChanged > 0 then
									MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, state) VALUES (@owner, @plate, @vehicle, @state)', {
										['@owner'] = xPlayer.identifier,
										['@plate'] = plate,
										['@vehicle'] = buyingVehicle.vehicleProps,
										['@state'] = 1
									}, function(rowsChanged)
										if rowsChanged > 0 then
											xPlayer.removeAccountMoney('bank', buyingVehicle.price)
											xOwner.addAccountMoney('bank', buyingVehicle.price)
											TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = ('You\'ve bought a ~y~%s~s~ for ~g~$%s~s~, it has been delivered to your garage'):format(buyingVehicle.label, ESX.Math.GroupDigits(buyingVehicle.price)), length = 10000, style = { ['background-color'] = '#09d940', ['color'] = '#FFFFFF' } })
											--xPlayer.showNotification(('You\'ve bought a ~y~%s~s~ for ~g~$%s~s~, it has been delivered to your garage'):format(buyingVehicle.label, ESX.Math.GroupDigits(buyingVehicle.price)))
											TriggerClientEvent('mythic_notify:client:SendAlert', xOwner.source, { type = 'success', text = ('Someone have bought one of your vehicles from the used dealership and wired ~g~$%s~s~'):format(ESX.Math.GroupDigits(buyingVehicle.price)), length = 10000, style = { ['background-color'] = '#09d940', ['color'] = '#FFFFFF' } })
											--xOwner.showNotification(('Someone have bought one of your vehicles from the used dealership and wired ~g~$%s~s~'):format(ESX.Math.GroupDigits(buyingVehicle.price)))
				
											availableVehiclesForSale[plate] = nil
											isVehicleBusy[plate] = nil
											TriggerClientEvent('trp_usedcardealer:setVehiclesForSale', -1, availableVehiclesForSale)
											cb(true)
										else
											isVehicleBusy[plate] = nil
											cb(false)
										end
									end)
								else
									isVehicleBusy[plate] = nil
									cb(false)
								end
							end)
						else
							-- the owner is online, but is not playing on the same character as the one he put out the vehicle on, so we will have to pay via db, too
							payDatabase = true
						end
					else
						payDatabase = true
					end

					if payDatabase then
						MySQL.Async.fetchAll('SELECT bank FROM users WHERE identifier = @networkID', {
							['@networkID'] = buyingVehicle.networkID
						}, function(result)
							if result[1] then
								MySQL.Async.execute('UPDATE users SET bank = @bank WHERE identifier = @networkID', {
									['@bank'] = result[1].bank + buyingVehicle.price,
									['@networkID'] = buyingVehicle.networkID
								}, function(rowsChanged)
									if rowsChanged > 0 then
										MySQL.Async.execute('DELETE FROM trp_usedcardealer WHERE plate = @plate', {
											['@plate'] = plate
										}, function(rowsChanged)
											if rowsChanged > 0 then
												MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, state) VALUES (@owner, @plate, @vehicle, @state)', {
													['@owner'] = xPlayer.identifier,
													['@plate'] = plate,
													['@vehicle'] = buyingVehicle.vehicleProps,
													['@state'] = 1
												}, function(rowsChanged)
													if rowsChanged > 0 then
														xPlayer.removeAccountMoney('bank', buyingVehicle.price)
														--xPlayer.showNotification(('You\'ve bought a ~y~%s~s~ for ~g~$%s~s~, it has been delivered to your garage'):format(buyingVehicle.label, ESX.Math.GroupDigits(buyingVehicle.price)))
														TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = ('You\'ve bought a ~y~%s~s~ for ~g~$%s~s~, it has been delivered to your garage'):format(buyingVehicle.label, ESX.Math.GroupDigits(buyingVehicle.price)), length = 10000, style = { ['background-color'] = '#09d940', ['color'] = '#FFFFFF' } })
		
														availableVehiclesForSale[plate] = nil
														isVehicleBusy[plate] = nil
														TriggerClientEvent('trp_usedcardealer:setVehiclesForSale', -1, availableVehiclesForSale)
														cb(true)
													else
														isVehicleBusy[plate] = nil
														cb(false)
													end
												end)
											else
												isVehicleBusy[plate] = nil
												cb(false)
											end
										end)
									else
										isVehicleBusy[plate] = nil
										cb(false)
									end
								end)
							else
								print('trp_usedcardealer: could not handle exception db-missing-networkid')
								--xPlayer.showNotification('This vehicle cannot be bought since the owner of this vehicle has deleted his character. This vehicle will automatically unlist itself.')
								TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = 'This vehicle cannot be bought since the owner of this vehicle has deleted his character. This vehicle will automatically unlist itself.', length = 10000, style = { ['background-color'] = '#09d940', ['color'] = '#FFFFFF' } })
		
								isVehicleBusy[plate] = nil
								cb(false)
							end
						end)
					end
				else
					--xPlayer.showNotification('You cannot afford the vehicle!')
					TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'You cannot afford the vehicle!', length = 10000, style = { ['background-color'] = '#c20808', ['color'] = '#FFFFFF' } })
					isVehicleBusy[plate] = nil
					cb(false)
				end
			else
				--xPlayer.showNotification('The vehicle price was just changed! Please reload your menu to reveal the new price.')
				TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'The vehicle price was just changed! Please reload your menu to reveal the new price.', length = 10000, style = { ['background-color'] = '#c20808', ['color'] = '#FFFFFF' } })
				isVehicleBusy[plate] = nil
				cb(false)
			end
		else
			--xPlayer.showNotification('That vehicle is no longer for sale, please reload your menu.')
			TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'That vehicle is no longer for sale, please reload your menu.', length = 10000, length = 10000, style = { ['background-color'] = '#c20808', ['color'] = '#FFFFFF' } })
			isVehicleBusy[plate] = nil
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('trp_usedcardealer:changePrice', function(playerId, cb, plate, price)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer and availableVehiclesForSale[plate] and tonumber(price) then
		price = ESX.Math.Round(price)
		local buyingVehicle = availableVehiclesForSale[plate]

		if buyingVehicle.networkID == xPlayer.get('networkID') then
			if price > 0 and price <= Config.MaxVehiclePrice then
				if price ~= buyingVehicle.price then
					MySQL.Async.execute('UPDATE trp_usedcardealer SET price = @price WHERE plate = @plate', {
						['@plate'] = plate,
						['@price'] = price
					}, function(rowsChanged)
						if rowsChanged > 0 then
							availableVehiclesForSale[plate].price = price
							TriggerClientEvent('trp_usedcardealer:setVehiclesForSale', -1, availableVehiclesForSale)
						end

						--xPlayer.showNotification('The vehicle price has been changed.')
						TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = 'The vehicle price has been changed.', length = 10000, style = { ['background-color'] = '#09d940', ['color'] = '#FFFFFF' } })
						cb(true)
					end)
				else
					--xPlayer.showNotification('That\'s the current vehicle price!')
					TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'That\'s the current vehicle price!', length = 10000, style = { ['background-color'] = '#c20808', ['color'] = '#FFFFFF' } })
					cb(false)
				end
			else
				--xPlayer.showNotification('That price is not allowed!')
				TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'That price is not allowed!', length = 10000, style = { ['background-color'] = '#c20808', ['color'] = '#FFFFFF' } })
				cb(false)
			end
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'You do not own this vehicle!', length = 10000, style = { ['background-color'] = '#c20808', ['color'] = '#FFFFFF' } })
			--xPlayer.showNotification('You do not own this vehicle!')
			cb(false)
		end
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('trp_usedcardealer:unlistVehicle', function(playerId, cb, plate)
	if not isVehicleBusy[plate] then
		isVehicleBusy[plate] = true
		local xPlayer = ESX.GetPlayerFromId(playerId)

		if xPlayer and availableVehiclesForSale[plate] then
			local buyingVehicle, networkID = availableVehiclesForSale[plate], xPlayer.get('networkID')

			if buyingVehicle.networkID == networkID then
				MySQL.Async.execute('DELETE FROM trp_usedcardealer WHERE plate = @plate', {
					--['@network_id'] = networkID,
					['@plate'] = plate
				}, function(rowsChanged)
					if rowsChanged > 0 then
						MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, state) VALUES (@owner, @plate, @vehicle, @state)', {
							['@owner'] = xPlayer.identifier,
							['@plate'] = plate,
							['@vehicle'] = buyingVehicle.vehicleProps,
							['@state'] = 1
						}, function(rowsChanged)
							if rowsChanged > 0 then
								availableVehiclesForSale[plate] = nil
								isVehicleBusy[plate] = nil
								TriggerClientEvent('trp_usedcardealer:setVehiclesForSale', -1, availableVehiclesForSale)
								cb(true)
							else
								isVehicleBusy[plate] = nil
								cb(false)
							end
						end)
					else
						isVehicleBusy[plate] = nil
						cb(false)
					end
				end)
			else
			--	xPlayer.showNotification('You do not own this vehicle!')
					TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'You do not own this vehicle!', length = 10000, style = { ['background-color'] = '#c20808', ['color'] = '#FFFFFF' } })
				isVehicleBusy[plate] = nil
				cb(false)
			end
		else
			isVehicleBusy[plate] = nil
			cb(false)
		end
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('trp_usedcardealer:addVehicle', function(playerId, cb, plate, label, price)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if not isVehicleBusy[plate] and tonumber(price) and not availableVehiclesForSale[plate] and xPlayer then
		local networkID = xPlayer.get('networkID')
		isVehicleBusy[plate] = true
		price = ESX.Math.Round(price)

		if price > 0 and price <= Config.MaxVehiclePrice then
			MySQL.Async.fetchAll('SELECT vehicle FROM owned_vehicles WHERE owner = @identifier AND plate = @plate', {
				['@identifier'] = xPlayer.identifier,
				['@plate'] = plate
			}, function(result)
				if result[1] then
					MySQL.Async.execute('INSERT INTO trp_usedcardealer (plate, owner, label, vehicle_props, price) VALUES (@plate, @owner, @label, @vehicle_props, @price)', {
						['@plate'] = plate,
						['@owner'] = xPlayer.identifier,
						--['@network_id'] = networkID,
						['@label'] = label,
						['@vehicle_props'] = result[1].vehicle,
						['@price'] = price
					}, function(rowsChanged)
						MySQL.Async.execute('DELETE FROM owned_vehicles WHERE plate = @plate', {
							['@plate'] = plate
						}, function(rowsChanged)
							availableVehiclesForSale[plate] = {
								owner = xPlayer.identifier,
								--networkID = networkID,
								label = label,
								vehicleProps = result[1].vehicle,
								price = price
							}

							TriggerClientEvent('trp_usedcardealer:setVehiclesForSale', -1, availableVehiclesForSale)
						--	TriggerClientEvent('esx:showNotification', xPlayer, 'The vehicle has been put out for sale!')
							TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = 'The vehicle has been put out for sale!', length = 10000, style = { ['background-color'] = '#09d940', ['color'] = '#FFFFFF' } })
							isVehicleBusy[plate] = nil
							cb(true)
						end)
					end)
				else
					--xPlayer.showNotification('You do not own that vehicle!')
						TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'You do not own that vehicle!', length = 10000, style = { ['background-color'] = '#c20808', ['color'] = '#FFFFFF' } })
					isVehicleBusy[plate] = nil
					cb(false)
				end
			end)
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'error', text = 'That price is not allowed', length = 10000, style = { ['background-color'] = '#c20808', ['color'] = '#FFFFFF' } })
			--xPlayer.showNotification('That price is not allowed')
			isVehicleBusy[plate] = nil
			cb(false)
		end
	else
		cb(false)
	end
end)