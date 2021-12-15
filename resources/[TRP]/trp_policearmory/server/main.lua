ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterServerEvent('trp:buyPistolAmmo')
AddEventHandler('trp:buyPistolAmmo', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

		xPlayer.addInventoryItem('boxpistol', 1)
end)

RegisterServerEvent('trp:buycuffs')
AddEventHandler('trp:buycuffs', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

		xPlayer.addInventoryItem('cuffs', 1)
end)

RegisterServerEvent('trp:TAZER')
AddEventHandler('trp:TAZER', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

		xPlayer.addWeapon('WEAPON_STUNGUN', 250) -- FUCKER
end)
RegisterServerEvent('trp:policecombatpistol')
AddEventHandler('trp:policecombatpistol', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

		xPlayer.addWeapon('WEAPON_COMBATPISTOL', 250) -- FUCKER
end)
RegisterServerEvent('trp:carbine_rifle')
AddEventHandler('trp:carbine_rifle', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

		xPlayer.addWeapon('WEAPON_CARBINERIFLE', 250) -- FUCKER
end)
