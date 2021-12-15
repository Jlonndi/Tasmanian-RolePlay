ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterUsableItem('zipties', function(source)
    TriggerClientEvent('bixbi_zipties:startziptie', source)
end)

for k,v in pairs(Config.ZiptieRemovers) do
	ESX.RegisterUsableItem(k, function(source)
		TriggerClientEvent('bixbi_zipties:startziptieremove', source, k)
	end)
end

RegisterServerEvent('bixbi_zipties:RemoveItem')
AddEventHandler('bixbi_zipties:RemoveItem', function(source, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(item, 1)
end)

RegisterServerEvent('bixbi_zipties:ApplyZipties')
AddEventHandler('bixbi_zipties:ApplyZipties', function(source)
	TriggerClientEvent('bixbi_zipties:ziptie', source)
end)

RegisterServerEvent('bixbi_zipties:RemoveZipties')
AddEventHandler('bixbi_zipties:RemoveZipties', function(source)
	TriggerClientEvent('bixbi_zipties:removeziptie', source)
end)