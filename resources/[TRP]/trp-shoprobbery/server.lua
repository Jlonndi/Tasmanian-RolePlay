OPCore = nil
        local alarmTriggered = false
----------------------------------------SETTING TIMER ROBBERY---------------------------------------------------

local timerRoberry = 100*600 --set the timer between robberies (100*600 = 1min)  (200*600 = 2min) (1000*600 = 10min) (3000*600 = 30min)

----------------------------------------------------------------------------------------------------------------

TriggerEvent('OPCore:GetObject', function(obj) OPCore = obj end)

local deadPeds = {}

RegisterServerEvent('loffe_robbery:pedDead')
AddEventHandler('loffe_robbery:pedDead', function(store)
    if not deadPeds[store] then
        deadPeds[store] = 'deadlol'
        TriggerClientEvent('loffe_robbery:onPedDeath', -1, store)
        local second = 1000
        local minute = 60 * second
        local hour = 60 * minute
        local cooldown = Config.Shops[store].cooldown
        local wait = cooldown.hour * hour + cooldown.minute * minute + cooldown.second * second
        Wait(wait)
        if not Config.Shops[store].robbed then
            for k, v in pairs(deadPeds) do if k == store then table.remove(deadPeds, k) end end
            TriggerClientEvent('loffe_robbery:resetStore', -1, store)
        end
        alarmTriggered = false
    end
end)

RegisterServerEvent('loffe_robbery:handsUp')
AddEventHandler('loffe_robbery:handsUp', function(store)
    TriggerClientEvent('loffe_robbery:handsUp', -1, store)
end)

RegisterServerEvent('loffe_robbery:pickUp')
AddEventHandler('loffe_robbery:pickUp', function(store)
    local xPlayer = OPCore.Functions.GetPlayer(source)  
    local randomAmount = math.random(Config.Shops[store].money[1], Config.Shops[store].money[2])
    xPlayer.Functions.AddMoney("cash", randomAmount, "sold-pawn-items")
	TriggerClientEvent('OPCore:Notify', source, 'Successful robbery you stole '..randomAmount..' $', "success")  
    
    TriggerClientEvent('loffe_robbery:removePickup', -1, store) 
end)

RegisterServerEvent('loffe_robbery:rob')
AddEventHandler('loffe_robbery:rob', function(store)
    local src = source
    Config.Shops[store].robbed = true
    TriggerClientEvent('loffe_robbery:rob', -1, store)

    Wait(timerRoberry) --set the timer between robberies

    TriggerClientEvent('loffe_robbery:robberyOver', src)

    local second = 1000
    local minute = 60 * second
    local hour = 60 * minute
    local cooldown = Config.Shops[store].cooldown
    local wait = cooldown.hour * hour + cooldown.minute * minute + cooldown.second * second
    Wait(wait)
    Config.Shops[store].robbed = false
    TriggerClientEvent('loffe_robbery:resetStore', -1, store)
    --for k, v in pairs(deadPeds) do if k == store then table.remove(deadPeds, k) end end
    --TriggerClientEvent('loffe_robbery:resetStore', -1, store)
    alarmTriggered = false
end)

Citizen.CreateThread(function()
    while true do
        for i = 1, #deadPeds do TriggerClientEvent('loffe_robbery:pedDead', -1, i) end -- update dead peds
        Citizen.Wait(500)
    end
end)


RegisterServerEvent('alarm:server:PoliceAlertMessage')
AddEventHandler('alarm:server:PoliceAlertMessage', function(title, coords, blip)
    local src = source
    local alertData = {
        title = title,
        coords = {x = coords.x, y = coords.y, z = coords.z},
        description = "Robbery Market",
    }

    for k, v in pairs(OPCore.Functions.GetPlayers()) do
        local Player = OPCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                if blip then
                    if not alarmTriggered then
                        TriggerClientEvent("cash-telephone:client:addPoliceAlert", v, alertData)
                        TriggerClientEvent("cash-vangelicoheist:client:PoliceAlertMessage", v, title, coords, blip)
                        alarmTriggered = true
                    end
                else
                    TriggerClientEvent("cash-telephone:client:addPoliceAlert", v, alertData)
                    TriggerClientEvent("cash-vangelicoheist:client:PoliceAlertMessage", v, title, coords, blip)
                end
            end
        end
    end
end)