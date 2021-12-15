ESX = nil
local insert, found = false, false


TriggerEvent('esx:getSharedObject', function( obj ) ESX = obj end)

ESX.RegisterUsableItem('boxpistol', function(source)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('TRP_AMMO:AmmoBox', _source, '9 mm')
    xPlayer.removeInventoryItem('boxpistol', 1)
end)

ESX.RegisterUsableItem('boxshot', function(source)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('TRP_AMMO:AmmoBox', _source, '12 mm')
    xPlayer.removeInventoryItem('box_12mm', 1)
end)

ESX.RegisterUsableItem('boxrifle', function(source)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('TRP_AMMO:AmmoBox', _source, '7.62 mm')
    xPlayer.removeInventoryItem('box_7.62mm', 1)
end)

ESX.RegisterUsableItem('boxsmg', function(source)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('TRP_AMMO:AmmoBox', _source, '.45 ACP')
    xPlayer.removeInventoryItem('box_.45ACP', 1)
end)

RegisterServerEvent('TRP_AMMO:ReturnIsNotValid')
AddEventHandler('TRP_AMMO:ReturnIsNotValid', function(type)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    if type == '9 mm' then
	    xPlayer.addInventoryItem('boxpistol', 1)	
   elseif type == '12 mm' then
	    xPlayer.addInventoryItem('boxshot', 1)	
    elseif type == '.45 ACP' then
	    xPlayer.addInventoryItem('boxsmg', 1)	
    elseif type == '7.62 mm' then
	    xPlayer.addInventoryItem('boxrifle', 1)
    end	
end)