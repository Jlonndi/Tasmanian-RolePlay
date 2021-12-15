ESX = nil
local availableVehiclesForSale, isInsideDealership, isSellMenuOpen, myNetworkID, currentSpawnedVehicle, isChangingVehicle = {}, false, false, 0, nil, false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.DealershipCoords)

	SetBlipSprite(blip, 147)
	SetBlipColour(blip, 4)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Used Car Dealership')
	EndTextCommandSetBlipName(blip)
end)

RegisterNetEvent('trp_usedcardealer:setVehiclesForSale')
AddEventHandler('trp_usedcardealer:setVehiclesForSale', function(_availableVehiclesForSale)
	availableVehiclesForSale = _availableVehiclesForSale
end)

RegisterNetEvent('trp_usedcardealer:relayMyNetworkID')
AddEventHandler('trp_usedcardealer:relayMyNetworkID', function(_myNetworkID)
	myNetworkID = _myNetworkID
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed, letSleep = PlayerPedId(), true
		local playerCoords = GetEntityCoords(playerPed)
		local distance = #(playerCoords - Config.DealershipCoords)

		if distance < 2 and IsPedOnFoot(playerPed) and not isInsideDealership then
			letSleep = false
			ESX.Game.Utils.DrawText3D(Config.DealershipCoords, '[E] ~y~Access Dealership~s~', 1.5, 1)

			if IsControlJustReleased(0, 38) then
				if ESX.Table.SizeOf(availableVehiclesForSale) > 0 then
					TriggerEvent('ui:toggle', false)
					DisplayRadar(false)
					DoScreenFadeOut(1000)
					Citizen.Wait(2000)
					SetEntityVisible(playerPed, false)

					ESX.Game.Teleport(playerPed, Config.InsideCoords, function()
						FreezeEntityPosition(playerPed, true)
						openDealershipMenu()
					end)
				else
					ESX.ShowNotification('There is currently no vehicles out for sale.')
				end
			end
		end

		distance = #(playerCoords - Config.GarageCoords)

		if distance < 50 then
			letSleep = false
			local text

			if IsPedSittingInAnyVehicle(playerPed) then
				text = '[E] ~y~Put vehicle for sale~s~'
			else
				text = 'Bring your vehicle here in order to sell it'
			end

			ESX.Game.Utils.DrawText3D(Config.GarageCoords, text, 2, 1)

			if IsControlJustReleased(0, 38) and distance < 2 and IsPedSittingInAnyVehicle(playerPed) and not isSellMenuOpen then
				isSellMenuOpen = true

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sell_vehicle', {
					title    = 'Used Dealership',
					align    = 'top-left',
					elements = {
						{label = 'Current sell price: not set', action = 'price', price = 0},
						{label = 'Change sell price', action = 'change'},
						{label = 'Put out vehicle for sale', action = 'sell'}
				}}, function(data, menu)
					if data.current.action == 'change' then
						ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sell_vehicle_dialog', {
							title = 'Input new Vehicle Price'
						}, function(data2, menu2)
							local vehiclePrice = tonumber(data2.value)
			
							if vehiclePrice and vehiclePrice > 0 and vehiclePrice <= Config.MaxVehiclePrice then
								local newData = {
									label = ('Current sell price: <span style="color:#00ea1b;">$%s</span>'):format(ESX.Math.GroupDigits(vehiclePrice)),
									action = 'price',
									price = vehiclePrice
								}

								menu2.close()
								menu.update({action = 'price'}, newData)
								menu.refresh()
							else
								ESX.ShowNotification('Invalid vehicle price!')
							end
						end, function(data2, menu2)
							menu2.close()
						end)
					elseif data.current.action == 'sell' then
						local price = data.elements[1].price

						if price > 0 then
							local vehicle = GetVehiclePedIsIn(playerPed, false)
							local displayName = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
							local label = GetLabelText(displayName)
							local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))

							if label == 'NULL' then label = displayName end
							ESX.TriggerServerCallback('trp_usedcardealer:addVehicle', function(success)
								if success then
									ESX.Game.DeleteVehicle(vehicle)
									ESX.UI.Menu.CloseAll()
									isSellMenuOpen = false
								end
							end, plate, label, price)
						else
							ESX.ShowNotification('Please set an vehicle price first!')
						end
					end
				end, function(data, menu)
					menu.close()
					isSellMenuOpen = false
				end)
			end

			if distance > 3 and isSellMenuOpen then
				ESX.UI.Menu.CloseAll()
				isSellMenuOpen = false
			end
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

function openDealershipMenu()
	local playerPed, elements, storedVehicleProps, firstVehiclePlate = PlayerPedId(), {}, {}, nil
	isInsideDealership = true
	startAsyncInputRestriction()

	for k,v in pairs(availableVehiclesForSale) do
		local vehicleProps = json.decode(v.vehicleProps)

		if IsModelInCdimage(vehicleProps.model) then
			storedVehicleProps[vehicleProps.plate] = vehicleProps

			table.insert(elements, {
				label = ('%s: <span style="color:#00ea1b;">$%s</span>'):format(v.label, ESX.Math.GroupDigits(v.price)),
				vehicleLabel = v.label,
				isOwner = (v.networkID == myNetworkID),
				plate = vehicleProps.plate,
				price = v.price
			})

			if not firstVehiclePlate then firstVehiclePlate = vehicleProps.plate end
		else
			print(('trp_usedcardealer: ignoring invalid vehicle model "%s" from networkID "%s"'):format(vehicleProps.model, v.networkID))
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'main_menu', {
		title    = 'Used Dealership',
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		if data.current.isOwner then
			openOwnerMenu(menu, data.current)
		else
			openBuyMenu(menu, data.current)
		end
	end, function(data, menu)
		if not isChangingVehicle then
			menu.close()

			DoScreenFadeOut(1000)
			Citizen.Wait(2000)
	
			deletePreviousVehicle(playerPed)
			SetEntityVisible(playerPed, true)
	
			ESX.Game.Teleport(playerPed, Config.DealershipCoords, function()
				FreezeEntityPosition(playerPed, false)
				DoScreenFadeIn(1000)
				TriggerEvent('ui:toggle', true)
				DisplayRadar(true)
				isInsideDealership = false
			end)
		end
	end, function(data, menu)
		if not isChangingVehicle then
			isChangingVehicle = true
			deletePreviousVehicle(playerPed)

			if data.current then
				local vehicleProps = storedVehicleProps[data.current.plate]
				requestVehicleModel(vehicleProps.model)
		
				ESX.Game.SpawnLocalVehicle(vehicleProps.model, Config.InsideCoords, 178.67, function(vehicle)
					TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
					FreezeEntityPosition(vehicle, true)
					ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
					currentSpawnedVehicle = vehicle
					SetVehicleCurrentRpm(vehicle, 3000)
					SetModelAsNoLongerNeeded(vehicleProps.model)
					isChangingVehicle = false
				end)
			else
				isChangingVehicle = false
			end
		end
	end)

	local firstVehicleProps = storedVehicleProps[firstVehiclePlate]
	requestVehicleModel(firstVehicleProps.model)

	-- spawn first vehicle
	ESX.Game.SpawnLocalVehicle(firstVehicleProps.model, Config.InsideCoords, 178.67, function(vehicle)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)
		ESX.Game.SetVehicleProperties(vehicle, firstVehicleProps)
		currentSpawnedVehicle = vehicle
		SetVehicleCurrentRpm(vehicle, 3000)
		SetModelAsNoLongerNeeded(firstVehicleProps.model)
	end)

	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
end

function startAsyncInputRestriction()
	Citizen.CreateThread(function()
		while isInsideDealership do
			Citizen.Wait(0)
			DisableAllControlActions(0)
	
			EnableControlAction(0, 27, true)
			EnableControlAction(0, 173, true)
			EnableControlAction(0, 174, true)
			EnableControlAction(0, 175, true)
			EnableControlAction(0, 18, true)
			EnableControlAction(0, 177, true)
			EnableControlAction(0, 1, true)
			EnableControlAction(0, 0, true)
		end
	end)
end

function requestVehicleModel(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		BeginTextCommandBusyspinnerOn('STRING')
		AddTextComponentSubstringPlayerName('Requesting vehicle model')
		EndTextCommandBusyspinnerOn(4)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(0)
			DisableAllControlActions(0)
		end

		BusyspinnerOff()
	end
end

function deletePreviousVehicle(playerPed)
	if currentSpawnedVehicle and DoesEntityExist(currentSpawnedVehicle) then
		ESX.Game.DeleteVehicle(currentSpawnedVehicle)
	end
end

function openOwnerMenu(parentMenu, currentData)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'owner_menu', {
		title    = 'Used Dealership',
		align    = 'bottom-right',
		elements = {
			{label = 'Change Price', action = 'change'},
			{label = 'Unlist vehicle from dealership', action = 'unlist'},
	}}, function(data, menu)
		if data.current.action == 'change' then
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'owner_menu_price', {
				title = 'Input new Vehicle Price'
			}, function(data2, menu2)
				local vehiclePrice = tonumber(data2.value)

				if vehiclePrice then
					ESX.TriggerServerCallback('trp_usedcardealer:changePrice', function(success)
						if success then
							currentData.price = vehiclePrice
							currentData.label = ('%s: <span style="color:#00ea1b;">$%s</span>'):format(currentData.vehicleLabel, ESX.Math.GroupDigits(vehiclePrice)),
							menu2.close()
							menu.close()
							parentMenu.update({plate = currentData.plate}, currentData)
							parentMenu.refresh()
						end
					end, currentData.plate, vehiclePrice)
				else
					ESX.ShowNotification('Invalid vehicle price!')
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.action == 'unlist' then
			ESX.TriggerServerCallback('trp_usedcardealer:unlistVehicle', function(success)
				if success then
					parentMenu.removeElement({plate = currentData.plate})
					parentMenu.refresh()
					menu.close()
				end
			end, currentData.plate)
		end
	end, function(data, menu)
		menu.close()
	end)
end

function openBuyMenu(parentMenu, currentData)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'owner_menu', {
		title    = 'Confirm Purchase Vehicle',
		align    = 'bottom-right',
		elements = {
			{label = 'Don\'t buy vehicle', confirm = false},
			{label = ('Buy vehicle for <span style="color:#00ea1b;">$%s</span>'):format(ESX.Math.GroupDigits(currentData.price)), confirm = true}
	}}, function(data, menu)
		if data.current.confirm then
			ESX.TriggerServerCallback('trp_usedcardealer:buyVehicle', function(success)
				if success then
					parentMenu.removeElement({plate = currentData.plate})
					parentMenu.refresh()
					menu.close()
					deletePreviousVehicle(PlayerPedId())
					cocks()
					isInsideDealership = false
				end
			end, currentData.plate, currentData.price)
		else
			menu.close()
		end
	end, function(data, menu)
		menu.close()
	end)
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then

		if isInsideDealership then
			local playerPed = PlayerPedId()

			deletePreviousVehicle(playerPed)
			ESX.UI.Menu.CloseAll()

			ESX.Game.Teleport(playerPed, Config.DealershipCoords, function()
				FreezeEntityPosition(playerPed, false)
				SetEntityVisible(playerPed, true)
				TriggerEvent('ui:toggle', true)
				DisplayRadar(true)
			end)
		end

		if isSellMenuOpen then
			ESX.UI.Menu.CloseAll()
		end
	end
end)

function cocks()
	if isInsideDealership then
		local playerPed = PlayerPedId()

		deletePreviousVehicle(playerPed)
		ESX.UI.Menu.CloseAll()

		ESX.Game.Teleport(playerPed, Config.DealershipCoords, function()
			FreezeEntityPosition(playerPed, false)
			SetEntityVisible(playerPed, true)
			TriggerEvent('ui:toggle', true)
			DisplayRadar(true)
		end)
	end

	if isSellMenuOpen then
		ESX.UI.Menu.CloseAll()
	end
end