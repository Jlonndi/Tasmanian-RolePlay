local esx_service = exports["esx_service"]
local currentLaunderer = math.random(1, #Config.launderLocations)
local copsConnected = 0
local conversionRate = Config.baseRate
local copsCalled = false
local updatingLaunderer = false
local launderers = {}

ESX = nil
TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

-- Launderer Logic
RegisterServerEvent("otaku_moneylaunderer:getLaunderer")
AddEventHandler(
    "otaku_moneylaunderer:getLaunderer",
    function()
        if updatingLaunderer ~= true then
            TriggerClientEvent("otaku_moneylaunderer:updateLaunderer", source, currentLaunderer)
        end
    end
)

RegisterServerEvent("otaku_moneylaunderer:setLaunderer")
AddEventHandler(
    "otaku_moneylaunderer:setLaunderer",
    function()
        if updatingLaunderer ~= true then
            updatingLaunderer = true
            launderers = {}
            TriggerClientEvent("otaku_moneylaunderer:removeLaunderer", -1)
            setNewlaunderer()
        end
    end
)

function setNewlaunderer()
    local oldLaunderer = currentLaunderer
    local newLaunderer = oldLaunderer -- At this point, all launderers should be the same
    while newLaunderer == oldLaunderer do -- ensure new launderer is different from current
        local rn = math.random(1, #Config.launderLocations)
        newLaunderer = rn
    end

    currentLaunderer = newLaunderer
    copsCalled = false
    TriggerClientEvent("otaku_moneylaunderer:updateLaunderer", -1, currentLaunderer)
    updatingLaunderer = false
end

-- Laundering Logic
local flagged = false
CreateThread(
    function()
        while true do
            Wait(Config.policeCooldown)

            if flagged then
                copsCalled = false
            end

            if copsCalled then
                flagged = true
            end
        end
    end
)

RegisterServerEvent("otaku_moneylaunderer:launderMoney")
AddEventHandler("otaku_moneylaunderer:launderMoney", function(launderer)
        local source = source
        local launderer = launderer
        launderers[source] = true
        SetTimeout(Config.launderSpeed, function() 
                getCleanMoney(source, launderer)
            end)
end)

RegisterServerEvent("otaku_moneylaunderer:stopLaundering")
AddEventHandler("otaku_moneylaunderer:stopLaundering", function()
        launderers[source] = false
end)

function CountCops()
    local xPlayers = ESX.GetPlayers()
    copsConnected = 1
end

function getCleanMoney(source, launderer)
    local xPlayer = ESX.GetPlayerFromId(source)
    local player = source
    local launderer = launderer
    local moneyLaundered = 0
    local moomoo = 0

    local ped = GetPlayerPed(source)
    local currentCoord = GetEntityCoords(ped)
    local originalCoord = Config.launderLocations[currentLaunderer].pos

    if not Timer or ((GetGameTimer() - Timer) > 90000) then --- 90s
        CountCops()
        Timer = GetGameTimer()
    end

    conversionRate = Config.baseRate
    conversionRate = (conversionRate + (copsConnected * Config.bonusPerCop)) / 100
    if conversionRate > Config.maxRate then
        conversionRate = Config.maxRate
    end

    local callThePigs = math.random(1, Config.callPoliceChance)
    if copsCalled == false and callThePigs == 5 then
        local ped = GetPlayerPed(player)
        local pCoord = GetEntityCoords(ped)
        local notification = {
            subject = "[10-21] Suspicious Activity",
            msg = "Suspicious Activity Spotted",
            icon = "fas fa-headset",
            iconStyle = "red",
            locationX = pCoord.x,
            locationY = pCoord.y,
            caller = 0
        }
        TriggerEvent("esx_service:callAllInService", notification, "police")
        copsCalled = true
    end

    if launderer == currentLaunderer and #(currentCoord.xy - originalCoord.xy) < 8.0 and launderers[source] then
        SetTimeout(
            Config.launderSpeed,
            function()
                local dirty_money = xPlayer.getInventoryItem("black_money").count
                if dirty_money > Config.maxStack then
                    moneyLaundered = math.random(Config.minStack, Config.maxStack)
                elseif dirty_money > 0 then
                    moneyLaundered = dirty_money
                end

                if moneyLaundered > 0 then
                    xPlayer.removeInventoryItem("black_money", moneyLaundered)
                    moomoo = math.floor(moneyLaundered * conversionRate)
                    TriggerEvent("Acountant:makeEntry", player, "Money Launderer", moomoo)
                    xPlayer.addInventoryItem('money', moomoo)

                    TriggerClientEvent(
                        "esx:showAdvancedNotification",
                        player,
                        "Money Laundering",
                        "I've been able to launder <b>$" ..
                            moneyLaundered .. "</b> into <b>$" .. moomoo .. "</b> for you. Stick around, I got more for ya!",
                        "fas fa-money-bill",
                        "green"
                    )
                    getCleanMoney(player, launderer)
                else
                    TriggerClientEvent(
                        "esx:showAdvancedNotification",
                        player,
                        "Money Laundering",
                        "That's it! You've got no more money to clean, pleasure doing business!",
                        "fas fa-money-bill",
                        "blue"
                    )
                end
            end
        )
    elseif launderer ~= currentLaunderer then
        SetTimeout(
            Config.launderSpeed,
            function()
                TriggerClientEvent(
                    "esx:showAdvancedNotification",
                    player,
                    "Money Laundering",
                    "I've laundered what I can, there's too much heat around here, I'm out!",
                    "fas fa-money-bill",
                    "red"
                )
            end
        )
    else
        TriggerClientEvent("esx:showAdvancedNotification", player, "Money Laundering", "Hey.. where'd you go?!", "fas fa-money-bill", "red")
    end
end

Citizen.CreateThread(
    function()
        local vRaw = LoadResourceFile(GetCurrentResourceName(), "version.json")
        if vRaw and Config.versionCheck then
            local v = json.decode(vRaw)
            PerformHttpRequest(
                "https://raw.githubusercontent.com/Sojobo/otaku_moneylaunderer/main/version.json",
                function(code, res, headers)
                    if code == 200 then
                        local rv = json.decode(res)
                        if rv.version ~= v.version then
                            print(
                                ([[^1

-------------------------------------------------------
otaku_moneylaunderer
UPDATE: %s AVAILABLE
CHANGELOG: %s
-------------------------------------------------------
^0]]):format(
                                    rv.version,
                                    rv.changelog
                                )
                            )
                        end
                    else
                        print("otaku_moneylaunderer unable to check version")
                    end
                end,
                "GET"
            )
        end
    end
)
