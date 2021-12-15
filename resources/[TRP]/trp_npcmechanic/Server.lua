ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
RegisterServerEvent('mechanic:withdraw')
AddEventHandler('mechanic:withdraw', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local base = 0
        xPlayer.removeAccountMoney('bank', 5000)
        TriggerClientEvent('trp-core:NPCMECH', _source, "Mechman")
    end)
