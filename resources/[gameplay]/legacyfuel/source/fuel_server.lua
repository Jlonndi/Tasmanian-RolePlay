ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('LegacyFuel:PayFuel')
AddEventHandler('LegacyFuel:PayFuel', function(price)
	local xPlayer = ESX.GetPlayerFromId(source)
	local amount  = round(price, 0)

	xPlayer.removeInventoryItem('money', amount)
end)

function round(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end