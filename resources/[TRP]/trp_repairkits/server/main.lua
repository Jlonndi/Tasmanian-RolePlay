ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Make the kit usable!
ESX.RegisterUsableItem('repairkit', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if Config.AllowMecano then
		TriggerClientEvent('esx_repairkit:onUse', _source)
	else
		if xPlayer.job.name ~= 'mecano' then
			TriggerClientEvent('esx_repairkit:onUse', _source)
		end
	end
end)

RegisterNetEvent('esx_repairkit:removeKit')
AddEventHandler('esx_repairkit:removeKit', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if not Config.InfiniteRepairs then
		xPlayer.removeInventoryItem('repairkit', 1)
		TriggerClientEvent('esx:showNotification', _source, _U('used_kit'))
	end
end)


TriggerEvent('es:addGroupCommand', 'arepair', 'mod', function(source, args, user)
	if args[1] ~= nil then
		if GetPlayerName(tonumber(args[1])) ~= nil then
			print(('trp_repairkits: %s used admin repair'):format(GetPlayerIdentifiers(source)[1]))
			TriggerClientEvent('esx_repairkit:adminrepair', source)
		end
	else
		TriggerClientEvent('esx_repairkit:adminrepair', source)

			end
		end, function(source, args, user)
			TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
		end, { help = ('Admin Vehicle Repair Command'), })

		TriggerEvent('es:addGroupCommand', 'ar', 'mod', function(source, args, user)
			if args[1] ~= nil then
				if GetPlayerName(tonumber(args[1])) ~= nil then
					print(('trp_repairkits: %s used admin repair'):format(GetPlayerIdentifiers(source)[1]))
					TriggerClientEvent('esx_repairkit:adminrepair', source)
				end
			else
				TriggerClientEvent('esx_repairkit:adminrepair', source)
		
					end
				end, function(source, args, user)
					TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
				end, { help = ('Admin Vehicle Repair Command'), })