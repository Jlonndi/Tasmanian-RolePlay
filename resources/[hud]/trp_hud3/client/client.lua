local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

local AllWeapons = json.decode('{"melee":{"dagger":"0x92A27487","bat":"0x958A4A8F","bottle":"0xF9E6AA4B","crowbar":"0x84BD7BFD","unarmed":"0xA2719263","flashlight":"0x8BB05FD7","golfclub":"0x440E4788","hammer":"0x4E875F73","hatchet":"0xF9DCBF2D","knuckle":"0xD8DF3C3C","knife":"0x99B507EA","machete":"0xDD5DF8D9","switchblade":"0xDFE37640","nightstick":"0x678B81B1","wrench":"0x19044EE0","battleaxe":"0xCD274149","poolcue":"0x94117305","stone_hatchet":"0x3813FC08"},"handguns":{"pistol":"0x1B06D571","pistol_mk2":"0xBFE256D4","combatpistol":"0x5EF9FEC4","appistol":"0x22D8FE39","stungun":"0x3656C8C1","pistol50":"0x99AEEB3B","snspistol":"0xBFD21232","snspistol_mk2":"0x88374054","heavypistol":"0xD205520E","vintagepistol":"0x83839C4","flaregun":"0x47757124","marksmanpistol":"0xDC4DB296","revolver":"0xC1B3C3D1","revolver_mk2":"0xCB96392F","doubleaction":"0x97EA20B8","raypistol":"0xAF3696A1"},"smg":{"microsmg":"0x13532244","smg":"0x2BE6766B","smg_mk2":"0x78A97CD0","assaultsmg":"0xEFE7E2DF","combatpdw":"0xA3D4D34","machinepistol":"0xDB1AA450","minismg":"0xBD248B55","raycarbine":"0x476BF155"},"shotguns":{"pumpshotgun":"0x1D073A89","pumpshotgun_mk2":"0x555AF99A","sawnoffshotgun":"0x7846A318","assaultshotgun":"0xE284C527","bullpupshotgun":"0x9D61E50F","musket":"0xA89CB99E","heavyshotgun":"0x3AABBBAA","dbshotgun":"0xEF951FBB","autoshotgun":"0x12E82D3D"},"assault_rifles":{"assaultrifle":"0xBFEFFF6D","assaultrifle_mk2":"0x394F415C","carbinerifle":"0x83BF0278","carbinerifle_mk2":"0xFAD1F1C9","advancedrifle":"0xAF113F99","specialcarbine":"0xC0A3098D","specialcarbine_mk2":"0x969C3D67","bullpuprifle":"0x7F229F94","bullpuprifle_mk2":"0x84D6FAFD","compactrifle":"0x624FE830"},"machine_guns":{"mg":"0x9D07F764","combatmg":"0x7FD62962","combatmg_mk2":"0xDBBD7280","gusenberg":"0x61012683"},"sniper_rifles":{"sniperrifle":"0x5FC3C11","heavysniper":"0xC472FE2","heavysniper_mk2":"0xA914799","marksmanrifle":"0xC734385A","marksmanrifle_mk2":"0x6A6C02E0"},"heavy_weapons":{"rpg":"0xB1CA77B1","grenadelauncher":"0xA284510B","grenadelauncher_smoke":"0x4DD2DC56","minigun":"0x42BF8A85","firework":"0x7F7497E5","railgun":"0x6D544C99","hominglauncher":"0x63AB0442","compactlauncher":"0x781FE4A","rayminigun":"0xB62D1F67"},"throwables":{"grenade":"0x93E220BD","bzgas":"0xA0973D5E","smokegrenade":"0xFDBC8A50","flare":"0x497FACC3","molotov":"0x24B17070","stickybomb":"0x2C3731D9","proxmine":"0xAB564B93","snowball":"0x787F0BB","pipebomb":"0xBA45E8B8","ball":"0x23C9F95C"},"misc":{"petrolcan":"0x34A67B97","fireextinguisher":"0x60EC506","parachute":"0xFBAB5776"}}')

local vehiclesCars = {0,1,2,3,4,5,6,7,8,9,10,11,12,17,18,19,20};

Citizen.CreateThread(function()
        local isPauseMenu = false
        while true do
            Citizen.Wait(0)

            if IsPauseMenuActive() then -- ESC Key
                if not isPauseMenu then
                    isPauseMenu = not isPauseMenu
                    SendNUIMessage({ action = 'toggleUi', value = false })
            end
            else
                if isPauseMenu then
                    isPauseMenu = not isPauseMenu
                    SendNUIMessage({ action = 'toggleUi', value = true })
                end
                HideHudComponentThisFrame(1)  -- Wanted Stars
                HideHudComponentThisFrame(2)  -- Weapon Icon
                HideHudComponentThisFrame(3)  -- Cash
                HideHudComponentThisFrame(4)  -- MP Cash
                HideHudComponentThisFrame(6)  -- Vehicle Name
                HideHudComponentThisFrame(7)  -- Area Name
                HideHudComponentThisFrame(8)  -- Vehicle Class
                HideHudComponentThisFrame(9)  -- Street Name
                HideHudComponentThisFrame(13) -- Cash Change
                HideHudComponentThisFrame(17) -- Save Game
                HideHudComponentThisFrame(20) -- Weapon Stats
            end
        end
end)

-- Vehicle Info
local vehicleCruiser
local vehicleSignalIndicator = 'off'
local seatbeltEjectSpeed = 45.0
local seatbeltEjectAccel = 100.0
local seatbeltIsOn = false
local currSpeed = 0.0
local prevVelocity = {x = 0.0, y = 0.0, z = 0.0}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)

        local player = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(player, false)
        local position = GetEntityCoords(player)
        local vehicleIsOn = GetIsVehicleEngineRunning(vehicle)
        local vehicleInfo

        if IsPedInAnyVehicle(player, false) and vehicleIsOn then
            local vehicleClass = GetVehicleClass(vehicle)

            -- Vehicle Speed
            local vehicleSpeedSource = GetEntitySpeed(vehicle)
            local vehicleSpeed
            vehicleSpeed = math.ceil(vehicleSpeedSource * 3.6)

            -- Vehicle Gradient Speed
            local vehicleNailSpeed

            if vehicleSpeed > Config.vehicle.maxSpeed then
                vehicleNailSpeed = math.ceil(  280 - math.ceil( math.ceil(Config.vehicle.maxSpeed * 205) / Config.vehicle.maxSpeed) )
            else
                vehicleNailSpeed = math.ceil(  280 - math.ceil( math.ceil(vehicleSpeed * 205) / Config.vehicle.maxSpeed) )
            end

            -- Vehicle Fuel and Gear
            local vehicleFuel
            vehicleFuel = GetVehicleFuelLevel(vehicle)

            local vehicleGear = GetVehicleCurrentGear(vehicle)

            if (vehicleSpeed == 0 and vehicleGear == 0) or (vehicleSpeed == 0 and vehicleGear == 1) then
                vehicleGear = 'N'
            elseif vehicleSpeed > 0 and vehicleGear == 0 then
                vehicleGear = 'R'
            end

            -- Vehicle Lights
            local vehicleVal,vehicleLights,vehicleHighlights  = GetVehicleLightsState(vehicle)
            local vehicleIsLightsOn
            if vehicleLights == 1 and vehicleHighlights == 0 then
                vehicleIsLightsOn = 'normal'
            elseif (vehicleLights == 1 and vehicleHighlights == 1) or (vehicleLights == 0 and vehicleHighlights == 1) then
                vehicleIsLightsOn = 'high'
            else
                vehicleIsLightsOn = 'off'
            end

            -- Vehicle Siren
            local vehicleSiren

            if IsVehicleSirenOn(vehicle) then
                vehicleSiren = true
            else
                vehicleSiren = false
            end

            -- Vehicle Seatbelt
            if has_value(vehiclesCars, vehicleClass) == true and vehicleClass ~= 8 then

                local prevSpeed = currSpeed
                currSpeed = vehicleSpeedSource

                SetPedConfigFlag(PlayerPedId(), 32, true)

                if not seatbeltIsOn then
                    local vehIsMovingFwd = GetEntitySpeedVector(vehicle, true).y > 1.0
                    local vehAcc = (prevSpeed - currSpeed) / GetFrameTime()
                    if (vehIsMovingFwd and (prevSpeed > (seatbeltEjectSpeed/2.237)) and (vehAcc > (seatbeltEjectAccel*9.81))) then

                        SetEntityCoords(player, position.x, position.y, position.z - 0.47, true, true, true)
                        SetEntityVelocity(player, prevVelocity.x, prevVelocity.y, prevVelocity.z)
                        SetPedToRagdoll(player, 1000, 1000, 0, 0, 0, 0)
                    else
                        -- Update previous velocity for ejecting player
                        prevVelocity = GetEntityVelocity(vehicle)
                    end

                else
                    DisableControlAction(0, 75)
                end
            end
            vehicleInfo = {
                action = 'updateVehicle',
                status = true,
                speed = vehicleSpeed,
                nail = vehicleNailSpeed,
                gear = vehicleGear,
                fuel = vehicleFuel,
                lights = vehicleIsLightsOn,
                signals = vehicleSignalIndicator,
                cruiser = vehicleCruiser,
                type = vehicleClass,
                siren = vehicleSiren,
                seatbelt = {},

                config = {
                    speedUnit = Config.vehicle.speedUnit,
                    maxSpeed = Config.vehicle.maxSpeed
                }
            }

            vehicleInfo['seatbelt']['status'] = seatbeltIsOn

        else
            Citizen.Wait(1000)  -- Performance

            vehicleCruiser = false
            vehicleNailSpeed = 0
            vehicleSignalIndicator = 'off'

            seatbeltIsOn = false

            vehicleInfo = {
                action = 'updateVehicle',
                status = false,
                nail = vehicleNailSpeed,
                seatbelt = { status = seatbeltIsOn },
                cruiser = vehicleCruiser,
                signals = vehicleSignalIndicator,
                type = 0,
            }
        end
        SendNUIMessage(vehicleInfo)
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000) -- 1000 default

        local playerStatus
        local showPlayerStatus = 0
        playerStatus = { action = 'setStatus', status = {} }

        showPlayerStatus = (showPlayerStatus+1)

        playerStatus['isdead'] = false

        playerStatus['status'][showPlayerStatus] = {
            name = 'health',
            value = GetEntityHealth(PlayerPedId()) - 100
        }

        if IsEntityDead(PlayerPedId()) then
            playerStatus.isdead = true
        end


        showPlayerStatus = (showPlayerStatus+1)

        playerStatus['status'][showPlayerStatus] = {
            name = 'armor',
            value = GetPedArmour(PlayerPedId()),
        }

        showPlayerStatus = (showPlayerStatus+1)

        playerStatus['status'][showPlayerStatus] = {
            name = 'stamina',
            value = 100 - GetPlayerSprintStaminaRemaining(PlayerId()),
        }

        TriggerServerEvent('trew_hud_ui:getServerInfo')

        if showPlayerStatus > 0 then
            SendNUIMessage(playerStatus)
        end
    end
end)

-- Overall Info
RegisterNetEvent('trew_hud_ui:setInfo')
AddEventHandler('trew_hud_ui:setInfo', function(info)

        SendNUIMessage({ action = 'setText', id = 'job', value = info['job'] })
        SendNUIMessage({ action = 'setMoney', id = 'wallet', value = info['money'] })
        SendNUIMessage({ action = 'setMoney', id = 'bank', value = info['bankMoney'] })
        SendNUIMessage({ action = 'setMoney', id = 'blackMoney', value = info['blackMoney'] })

        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
            ESX.PlayerData = ESX.GetPlayerData()
        end)

        local playerStatus
        local showPlayerStatus = 0
        playerStatus = { action = 'setStatus', status = {} }

        showPlayerStatus = (showPlayerStatus+1)

        TriggerEvent('esx_status:getStatus', 'hunger', function(status)
            playerStatus['status'][showPlayerStatus] = {
                name = 'hunger',
                value = math.floor(100-status.getPercent())
            }
        end)

        showPlayerStatus = (showPlayerStatus+1)

        TriggerEvent('esx_status:getStatus', 'thirst', function(status)
            playerStatus['status'][showPlayerStatus] = {
                name = 'thirst',
                value = math.floor(100-status.getPercent())
            }
        end)

        if showPlayerStatus > 0 then
            SendNUIMessage(playerStatus)
        end
end)

Citizen.CreateThread(function()

        if Config.ui.showVoice == true then

            RequestAnimDict('facials@gen_male@variations@normal')
            RequestAnimDict('mp_facial')

            while true do
                Citizen.Wait(300)
                local playerID = PlayerId()

                for _,player in ipairs(GetActivePlayers()) do
                    local boolTalking = NetworkIsPlayerTalking(player)

                    if player ~= playerID then
                        if boolTalking then
                            PlayFacialAnim(GetPlayerPed(player), 'mic_chatter', 'mp_facial')
                        elseif not boolTalking then
                            PlayFacialAnim(GetPlayerPed(player), 'mood_normal_1', 'facials@gen_male@variations@normal')
                        end
                    end
                end
            end

        end
end)


-- Weapons
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)

        local player = PlayerPedId()
        local status = {}

        if IsPedArmed(player, 7) then
            local weapon = GetSelectedPedWeapon(player)
            local ammoTotal = GetAmmoInPedWeapon(player,weapon)
            local bool,ammoClip = GetAmmoInClip(player,weapon)
            local ammoRemaining = math.floor(ammoTotal - ammoClip)

            status['armed'] = true

            for key,value in pairs(AllWeapons) do
                for keyTwo,valueTwo in pairs(AllWeapons[key]) do
                    if weapon == GetHashKey('weapon_'..keyTwo) then
                        status['weapon'] = keyTwo

                        if key == 'melee' then
                            SendNUIMessage({ action = 'element', task = 'disable', value = 'weapon_bullets' })
                            SendNUIMessage({ action = 'element', task = 'disable', value = 'bullets' })
                        else
                        if keyTwo == 'stungun' then
                            SendNUIMessage({ action = 'element', task = 'disable', value = 'weapon_bullets' })
                            SendNUIMessage({ action = 'element', task = 'disable', value = 'bullets' })
                        else
                            SendNUIMessage({ action = 'element', task = 'enable', value = 'weapon_bullets' })
                            SendNUIMessage({ action = 'element', task = 'enable', value = 'bullets' })
                        end
                        end
                    end
                end
            end
            SendNUIMessage({ action = 'setText', id = 'weapon_clip', value = ammoClip })
            SendNUIMessage({ action = 'setText', id = 'weapon_ammo', value = ammoRemaining })
        else
            status['armed'] = false
        end
        SendNUIMessage({ action = 'updateWeapon', status = status })
    end
end)

-- Everything that neededs to be at WAIT 0
Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)

            local player = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(player, false)
            local vehicleClass = GetVehicleClass(vehicle)

            -- Vehicle Seatbelt
            if IsPedInAnyVehicle(player, false) and GetIsVehicleEngineRunning(vehicle) then
                if IsControlJustReleased(0, 29) and (has_value(vehiclesCars, vehicleClass) == true and vehicleClass ~= 8) then
                    seatbeltIsOn = not seatbeltIsOn
                end
            end

            -- Vehicle Cruiser
            if IsControlJustPressed(1, 137) and GetPedInVehicleSeat(vehicle, -1) == player and (has_value(vehiclesCars, vehicleClass) == true) then

                local vehicleSpeedSource = GetEntitySpeed(vehicle)

                if vehicleCruiser == 'on' then
                    vehicleCruiser = 'off'
                    SetEntityMaxSpeed(vehicle, GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel"))

                else
                    vehicleCruiser = 'on'
                    SetEntityMaxSpeed(vehicle, vehicleSpeedSource)
                end
            end

            --[[ Vehicle Signal Lights
            if IsControlJustPressed(1, 174) and (has_value(vehiclesCars, vehicleClass) == true) then
                if vehicleSignalIndicator == 'off' then
                    vehicleSignalIndicator = 'left'
                else
                    vehicleSignalIndicator = 'off'
                end

                TriggerEvent('trew_hud_ui:setCarSignalLights', vehicleSignalIndicator)
            end

            if IsControlJustPressed(1, 175) and (has_value(vehiclesCars, vehicleClass) == true) then
                if vehicleSignalIndicator == 'off' then
                    vehicleSignalIndicator = 'right'
                else
                    vehicleSignalIndicator = 'off'
                end

                TriggerEvent('trew_hud_ui:setCarSignalLights', vehicleSignalIndicator)
            end

            if IsControlJustPressed(1, 173) and (has_value(vehiclesCars, vehicleClass) == true) then
                if vehicleSignalIndicator == 'off' then
                    vehicleSignalIndicator = 'both'
                else
                    vehicleSignalIndicator = 'off'
                end

                TriggerEvent('trew_hud_ui:setCarSignalLights', vehicleSignalIndicator)
            end
            ]]--
        end
end)

AddEventHandler('onClientMapStart', function()
    if Config.voice.levels.current == 0 then
        NetworkSetTalkerProximity(Config.voice.levels.default)
    elseif Config.voice.levels.current == 1 then
        NetworkSetTalkerProximity(Config.voice.levels.shout)
    elseif Config.voice.levels.current == 2 then
        NetworkSetTalkerProximity(Config.voice.levels.whisper)
    end
end)

AddEventHandler('playerSpawned', function()
    NetworkSetTalkerProximity(5.0)

    HideHudComponentThisFrame(7) -- Area
    HideHudComponentThisFrame(9) -- Street
    HideHudComponentThisFrame(6) -- Vehicle
    HideHudComponentThisFrame(3) -- SP Cash
    HideHudComponentThisFrame(4) -- MP Cash
    HideHudComponentThisFrame(13) -- Cash changes!
end)

AddEventHandler('trew_hud_ui:setCarSignalLights', function(status)
    local driver = GetVehiclePedIsIn(PlayerPedId(), false)
    local hasTrailer,vehicleTrailer = GetVehicleTrailerVehicle(driver,vehicleTrailer)
    local leftLight
    local rightLight

    if status == 'left' then
        leftLight = false
        rightLight = true
        if hasTrailer then driver = vehicleTrailer end

    elseif status == 'right' then
        leftLight = true
        rightLight = false
        if hasTrailer then driver = vehicleTrailer end

    elseif status == 'both' then
        leftLight = true
        rightLight = true
        if hasTrailer then driver = vehicleTrailer end

    else
        leftLight = false
        rightLight = false
        if hasTrailer then driver = vehicleTrailer end

    end

    TriggerServerEvent('trew_hud_ui:syncCarLights', status)

    SetVehicleIndicatorLights(driver, 0, leftLight)
    SetVehicleIndicatorLights(driver, 1, rightLight)
end)

RegisterNetEvent('trew_hud_ui:syncCarLights')
AddEventHandler('trew_hud_ui:syncCarLights', function(driver, status)

        if GetPlayerFromServerId(driver) ~= PlayerId() then
            local driver = GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(driver)), false)

            if status == 'left' then
                leftLight = false
                rightLight = true

            elseif status == 'right' then
                leftLight = true
                rightLight = false

            elseif status == 'both' then
                leftLight = true
                rightLight = true

            else
                leftLight = false
                rightLight = false
            end

            SetVehicleIndicatorLights(driver, 0, leftLight)
            SetVehicleIndicatorLights(driver, 1, rightLight)

        end
end)

function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

local sakrijui = false
RegisterCommand('ui', function()
    if not sakrijui then
        SendNUIMessage({ action = 'element', task = 'disable', value = 'job' })
        SendNUIMessage({ action = 'element', task = 'disable', value = 'bank' })
        SendNUIMessage({ action = 'element', task = 'disable', value = 'blackMoney' })
        SendNUIMessage({ action = 'element', task = 'disable', value = 'wallet' })
        SendNUIMessage({ action = 'element', task = 'disable', value = 'health' })
        SendNUIMessage({ action = 'element', task = 'disable', value = 'armor' })
        SendNUIMessage({ action = 'element', task = 'disable', value = 'stamina' })
        SendNUIMessage({ action = 'element', task = 'disable', value = 'hunger' })
        SendNUIMessage({ action = 'element', task = 'disable', value = 'thirst' })
        SendNUIMessage({ action = 'element', task = 'disable', value = 'voice' })
        SendNUIMessage({ action = 'element', task = 'disable', value = 'weapon' })
        TriggerEvent('chat:toggleChat')
        for i=1, #ESX.PlayerData.inventory, 1 do
        if ESX.PlayerData.inventory[i].name == 'gps' then
          if ESX.PlayerData.inventory[i].count > 0 then
            DisplayRadar(false)
          end
         end
        end
    else
        SendNUIMessage({ action = 'element', task = 'disable', value = 'job' })
        SendNUIMessage({ action = 'element', task = 'disable', value = 'bank' })
        SendNUIMessage({ action = 'element', task = 'disable', value = 'blackMoney' })
        SendNUIMessage({ action = 'element', task = 'disable', value = 'wallet' })
        SendNUIMessage({ action = 'element', task = 'disable', value = 'health' })
        SendNUIMessage({ action = 'element', task = 'disable', value = 'armor' })
        SendNUIMessage({ action = 'element', task = 'disable', value = 'stamina' })
        SendNUIMessage({ action = 'element', task = 'disable', value = 'hunger' })
        SendNUIMessage({ action = 'element', task = 'disable', value = 'thirst' })
        SendNUIMessage({ action = 'element', task = 'disable', value = 'voice' })
        SendNUIMessage({ action = 'element', task = 'disable', value = 'weapon' })
        TriggerEvent('chat:toggleChat')
        for i=1, #ESX.PlayerData.inventory, 1 do
        if ESX.PlayerData.inventory[i].name == 'gps' then
          if ESX.PlayerData.inventory[i].count > 0 then
            DisplayRadar(true)
          end
         end
        end
    end
    sakrijui = not sakrijui
end)

exports('createStatus', function(args)
    local statusCreation = { action = 'createStatus', status = args['status'], color = args['color'], icon = args['icon'] }
    SendNUIMessage(statusCreation)
end)

exports('setStatus', function(args)
    local playerStatus = { action = 'setStatus', status = {
        { name = args['name'], value = args['value'] }
    }}
    SendNUIMessage(playerStatus)
end)