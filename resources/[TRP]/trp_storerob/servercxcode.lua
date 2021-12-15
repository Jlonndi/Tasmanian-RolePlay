ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local deadPeds = {}

RegisterServerEvent('trp:robbery:pedDead')
AddEventHandler('trp:robbery:pedDead', function(store)
    if not deadPeds[store] then
        deadPeds[store] = 'deadlol'
        TriggerClientEvent('trp:robbery:onPedDeath', -1, store)
        local second = 1000
        local minute = 60 * second
        local hour = 60 * minute
        local cooldown = Config.Shops[store].cooldown
        local wait = cooldown.hour * hour + cooldown.minute * minute + cooldown.second * second
        Wait(wait)
        if not Config.Shops[store].robbed then
            for k, v in pairs(deadPeds) do if k == store then table.remove(deadPeds, k) end end
            TriggerClientEvent('trp:robbery:resetStore', -1, store)
        end
    end
end)

RegisterServerEvent('trp:robbery:handsUp')
AddEventHandler('trp:robbery:handsUp', function(store)
    TriggerClientEvent('trp:robbery:handsUp', -1, store)
end)

RegisterServerEvent('trp:robbery:pickUp')
AddEventHandler('trp:robbery:pickUp', function(store, authkey, playerid)
   -- if key 'saP%*ACZnwHt3B&vqCTp2EwdBWzDQ5dZbG#56' then
    local xPlayer = ESX.GetPlayerFromId(source)
    print(authkey)
    print(playerid)
    local randomAmount = math.random(Config.Shops[store].money[1], Config.Shops[store].money[2])
    xPlayer.addInventoryItem("money", randomAmount)
    TriggerClientEvent('esx:showNotification', source, Translation[Config.Locale]['cashrecieved'] .. ' ~g~' .. randomAmount .. ' ' .. Translation[Config.Locale]['currency'])
    --TriggerClientEvent('trp:robbery:removePickup', -1, store) 
   
end)

ESX.RegisterServerCallback('trp:robbery:canRob', function(source, cb, store)
    local cops = 0
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            cops = cops + 1
        end
    end
    if cops >= Config.Shops[store].cops then
        if not Config.Shops[store].robbed and not deadPeds[store] then
            cb(true)
        else
            cb(false)
        end
    else
        cb('no_cops')
    end
end)

RegisterServerEvent('trp:robbery:rob')
AddEventHandler('trp:robbery:rob', function(store)
    local src = source
    Config.Shops[store].robbed = true
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            TriggerClientEvent('trp:robbery:msgPolice', xPlayer.source, store, src)
        end
    end
    TriggerClientEvent('trp:robbery:rob', -1, store)
    Wait(30000)
    TriggerClientEvent('trp:robbery:robberyOver', src)

    local second = 1000
    local minute = 60 * second
    local hour = 60 * minute
    local cooldown = Config.Shops[store].cooldown
    local wait = cooldown.hour * hour + cooldown.minute * minute + cooldown.second * second
    Wait(wait)
    Config.Shops[store].robbed = false
    for k, v in pairs(deadPeds) do if k == store then table.remove(deadPeds, k) end end
    TriggerClientEvent('trp:robbery:resetStore', -1, store)
end)

Citizen.CreateThread(function()
    while true do
        for i = 1, #deadPeds do TriggerClientEvent('trp:robbery:pedDead', -1, i) end -- update dead peds
        Citizen.Wait(500)
    end
end)
