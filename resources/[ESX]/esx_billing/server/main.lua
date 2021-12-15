-- ~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~= --
--		   	   Created By: indilo53 AKA GiZz              --
--			 Protected By: ATG-Github AKA ATG			  --
-- ~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~= --

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local societies = {}

AddEventHandler("esx_society:registerSociety", function(n, label, a)
	local name, account = n, a;
    local tbl = {
        ["name"] = name,
        ["account"] = account,
    }
	local exists = false;

    for _, i in pairs(societies) do
        if i.name == name then
            exists, i = true, tbl
            break
        end
    end

    if exists == false then
		societies[#societies+1] = tbl
    end
end)

function findSociety(account)
    for _, i in pairs(societies) do
        if i["account"] == account then
            return i
        end
    end
end

RegisterServerEvent('esx_billing:sendBill')
AddEventHandler('esx_billing:sendBill', function(target, sharedAccountName, label, amount)
	local src, tgt = source;
	local xPlayer, xTarget = ESX.GetPlayerFromId(src), ESX.GetPlayerFromId(target)
	amount = ESX.Math.Round(amount)

	if amount > 0 and xTarget then

		local society = findSociety(sharedAccountName)
		if xPlayer.job.name == society.name then
			TriggerEvent('esx_addonaccount:getSharedAccount', sharedAccountName, function(account)
				if account then
					MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)', {
						['@identifier'] = xTarget.identifier,
						['@sender'] = xPlayer.identifier,
						['@target_type'] = 'society',
						['@target'] = sharedAccountName,
						['@label'] = label,
						['@amount'] = amount
					}, function(rowsChanged)
						TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'success', text = 'You Have Recieved an Invoice!', length = 10000, style = { ['background-color'] = '#09d940', ['color'] = '#FFFFFF' }})
					end)
				else
					MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)', {
						['@identifier'] = xTarget.identifier,
						['@sender'] = xPlayer.identifier,
						['@target_type'] = 'player',
						['@target'] = xPlayer.identifier,
						['@label'] = label,
						['@amount'] = amount
					}, function(rowsChanged)
						TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'success', text = 'You Have Recieved an Invoice!', length = 10000, style = { ['background-color'] = '#09d940', ['color'] = '#FFFFFF' }})
					end)
				end
			end)
		else
			print(
				string.format(
					"^2%s^7 -> [^1%s^7] ^1%s^7 has attempted to send a bill to [^5%s^7] ^5%s^7 from the ^2%s^7 via the society but, the player was not in the society job.",
					GetCurrentResourceName(), src, GetPlayerName(src), tgt, GetPlayerName(tgt), society.name
				)
			)
		end
	end
end)

ESX.RegisterServerCallback('esx_billing:getBills', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT amount, id, label FROM billing WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		cb(result)
	end)
end)

ESX.RegisterServerCallback('esx_billing:getTargetBills', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	if xPlayer then
		MySQL.Async.fetchAll('SELECT amount, id, label FROM billing WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		}, function(result)
			cb(result)
		end)
	else
		cb({})
	end
end)

ESX.RegisterServerCallback('esx_billing:payBill', function(source, cb, billId)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT sender, target_type, target, amount FROM billing WHERE id = @id', {
		['@id'] = billId
	}, function(result)
		if result[1] then
			local amount = result[1].amount
			local xTarget = ESX.GetPlayerFromIdentifier(result[1].sender)
			local steamname = GetPlayerName(xPlayer.source)
			--local steamnamexTarget = GetPlayerName(xTarget.source)
			if result[1].target_type == 'player' then
				if xTarget then
					if xPlayer.getMoney() >= amount then
						MySQL.Async.execute('DELETE FROM billing WHERE id = @id', {
							['@id'] = billId
						}, function(rowsChanged)
							if rowsChanged == 1 then
								xPlayer.removeMoney(amount)
								xTarget.addMoney(amount)
								
								--renterdiscordCocks('**Steam Name:  **' ..steamname.. ' **Paid Invoice:**\n'..ESX.Math.GroupDigits(amount)..' To '..steamnamexTarget..'' )

								TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = 'You paid Invoice '..ESX.Math.GroupDigits(amount)..'', length = 10000, style = { ['background-color'] = '#09d940', ['color'] = '#FFFFFF' } })
								TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'success', text = 'Invoice Paid '..ESX.Math.GroupDigits(amount)..'', length = 10000, style = { ['background-color'] = '#09d940', ['color'] = '#FFFFFF' } })
							end

							cb()
						end)
					elseif xPlayer.getAccount('bank').money >= amount then
						MySQL.Async.execute('DELETE FROM billing WHERE id = @id', {
							['@id'] = billId
						}, function(rowsChanged)
							if rowsChanged == 1 then
								xPlayer.removeAccountMoney('bank', amount)
								xTarget.addAccountMoney('bank', amount)
								--	renterdiscordCocks('**Steam Name:  **' ..steamname.. ' **Paid Invoice:**\n'..ESX.Math.GroupDigits(amount)..' To '..steamnamexTarget..'' )
								TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = 'You paid Invoice '..ESX.Math.GroupDigits(amount)..'', length = 10000, style = { ['background-color'] = '#09d940', ['color'] = '#FFFFFF' } })
								TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'success', text = 'Invoice Paid '..ESX.Math.GroupDigits(amount)..'', length = 10000, style = { ['background-color'] = '#09d940', ['color'] = '#FFFFFF' } })
							end

							cb()
						end)
					else
						TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = 'no money to Pay invoice', length = 10000, style = { ['background-color'] = '#09d940', ['color'] = '#FFFFFF' } })
						TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'success', text = 'Person has no money to Pay invoice', length = 10000, style = { ['background-color'] = '#09d940', ['color'] = '#FFFFFF' } })

						cb()
					end
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = 'Player Not Online', length = 10000, style = { ['background-color'] = '#09d940', ['color'] = '#FFFFFF' } })
					cb()
				end
			else
				TriggerEvent('esx_addonaccount:getSharedAccount', result[1].target, function(account)
					if xPlayer.getMoney() >= amount then
						MySQL.Async.execute('DELETE FROM billing WHERE id = @id', {
							['@id'] = billId
						}, function(rowsChanged)
							if rowsChanged == 1 then
								xPlayer.removeMoney(amount)
								account.addMoney(amount)
								renterdiscordCocks('**' ..steamname.. ' **Paid Invoice: $'..ESX.Math.GroupDigits(amount)..' To '..result[1].target..'' )
								TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = 'You paid Invoice '..ESX.Math.GroupDigits(amount)..'', length = 10000, style = { ['background-color'] = '#09d940', ['color'] = '#FFFFFF' } })
								--TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = _U('paid_invoice', ESX.Math.GroupDigits(amount))), length = 10000, style = { ['background-color'] = '#09d940', ['color'] = '#FFFFFF' } })
								if xTarget then
									TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'success', text = 'Invoice Paid '..ESX.Math.GroupDigits(amount)..'', length = 10000, style = { ['background-color'] = '#09d940', ['color'] = '#FFFFFF' } })
								end
							end

							cb()
						end)
					elseif xPlayer.getAccount('bank').money >= amount then
						MySQL.Async.execute('DELETE FROM billing WHERE id = @id', {
							['@id'] = billId
						}, function(rowsChanged)
							if rowsChanged == 1 then
								xPlayer.removeAccountMoney('bank', amount)
								account.addMoney(amount)
								renterdiscordCocks('**' ..steamname.. ' **Paid Invoice: $'..ESX.Math.GroupDigits(amount)..' To '..result[1].target..'' )
								TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = 'Invoice Paid '..ESX.Math.GroupDigits(amount)..'', length = 10000, style = { ['background-color'] = '#09d940', ['color'] = '#FFFFFF' } })
								--TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = _U('paid_invoice', ESX.Math.GroupDigits(amount))), length = 10000, style = { ['background-color'] = '#09d940', ['color'] = '#FFFFFF' } })
								if xTarget then
									TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'success', text = 'person Invoice Paid '..ESX.Math.GroupDigits(amount)..'', length = 10000, style = { ['background-color'] = '#09d940', ['color'] = '#FFFFFF' } })
									--TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'success', text = _U('received_payment', ESX.Math.GroupDigits(amount))), length = 10000, style = { ['background-color'] = '#09d940', ['color'] = '#FFFFFF' } })
								end
							end

							cb()
						end)
					else
						if xTarget then
							TriggerClientEvent('mythic_notify:client:SendAlert', xTarget.source, { type = 'success', text = 'no Money', length = 10000, style = { ['background-color'] = '#09d940', ['color'] = '#FFFFFF' } })
						end
						TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'success', text = 'no money', length = 10000, style = { ['background-color'] = '#09d940', ['color'] = '#FFFFFF' } })
						cb()
					end
				end)
			end
		end
	end)
end)



function renterdiscordCocks(message)
	local content = {
        {
        	["color"] = '3863105',  --verde
            ["title"] = "TassieRP Paid Invoices",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "© TassieRP - "..os.date("%x %X %p")
            }, 
        }
    }
        
  	PerformHttpRequest( "https://discord.com/api/webhooks/836866133637857280/ON8Ct_AmZfj_a_SHId__yQpQYKozoRxY8GPz9VJbykvKM9_9BlognOYn4P9lwGauP9KS" , function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
end