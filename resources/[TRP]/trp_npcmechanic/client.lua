RegisterNetEvent('trp-core:NPCMECH')
   AddEventHandler('trp-core:NPCMECH', function(ItemName)  
   TriggerServerEvent('trp-core:NPCMECH', ItemName)
   end)
AddEventHandler("trp:mech", function()
    TriggerEvent('trp-core:NPCMECH', _source, "NPC Mechanic")
    player = PlayerPedId()
    playerPos = GetEntityCoords(player)

    local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords(player, 0.0, 5.0, 0.0)
    local targetVeh = GetTargetVehicle(player, inFrontOfPlayer)
    GetMechPed()
    local driverhash = GetHashKey(mechPedPick.model)
    RequestModel(driverhash)
    local vehhash = GetHashKey(mechPedPick.vehicle)
    RequestModel(vehhash)
    --CellPhone Animation
    loadAnimDict("cellphone@")
    while not HasModelLoaded(driverhash) and RequestModel(driverhash) or not HasModelLoaded(vehhash) and RequestModel(vehhash) do
        RequestModel(driverhash)
        RequestModel(vehhash)
        Citizen.Wait(0)
    end
--Spawns Mechanic to come to you
    if DoesEntityExist(targetVeh) then
    	if DoesEntityExist(mechVeh) then
			DeleteVeh(mechVeh, mechPed)
			SpawnVehicle(playerPos.x, playerPos.y, playerPos.x, vehhash, driverhash)
		else
			SpawnVehicle(playerPos.x, playerPos.y, playerPos.x, vehhash, driverhash)
		end
		playRadioAnim(player)
		GoToTarget(GetEntityCoords(targetVeh).x, GetEntityCoords(targetVeh).y, GetEntityCoords(targetVeh).z, mechVeh, mechPed, vehhash, targetVeh)
    end
end)
--Car spawning functions
function SpawnVehicle(x, y, z, vehhash, driverhash)                                                     
    local found, spawnPos, spawnHeading = GetClosestVehicleNodeWithHeading(x + math.random(-spawnRadius, spawnRadius), y + math.random(-spawnRadius, spawnRadius), z, 0, 3, 0)

    if found and HasModelLoaded(vehhash) and HasModelLoaded(vehhash) then
        mechVeh = CreateVehicle(vehhash, spawnPos, spawnHeading, true, false)                           
        ClearAreaOfVehicles(GetEntityCoords(mechVeh), 5000, false, false, false, false, false);  
        SetVehicleOnGroundProperly(mechVeh)
        SetVehicleColours(mechVeh, mechPedPick.colour, mechPedPick.colour)
        mechPed = CreatePedInsideVehicle(mechVeh, 26, driverhash, -1, true, false)              		
        mechBlip = AddBlipForEntity(mechVeh)                                                        	
        SetBlipFlashes(mechBlip, true)  
        SetBlipColour(mechBlip, 5)
    Citizen.Wait(500)
    end
end
--Car removal driver removal and blip removal.
function DeleteVeh(vehicle, driver)
    SetEntityAsMissionEntity(vehicle, false, false)                                            		
    DeleteEntity(vehicle)
    SetEntityAsMissionEntity(driver, false, false)                                              		
    DeleteEntity(driver)
    RemoveBlip(mechBlip)                                                                    			
end
-- Tells the AI to spawn and drive to the player
function GoToTarget(x, y, z, vehicle, driver, vehhash, target)
    TaskVehicleDriveToCoord(driver, vehicle, x, y, z, 17.0, 0, vehhash, drivingStyle, 1, true)
    ShowAdvancedNotification(companyIcon, companyName, "Text Message", "We have recieved your call, an employee will be on his way shortly. ~y~" .. companyName)
    enroute = true
    while enroute do
        Citizen.Wait(1500)
        distanceToTarget = GetDistanceBetweenCoords(GetEntityCoords(target), GetEntityCoords(vehicle).x, GetEntityCoords(vehicle).y, GetEntityCoords(vehicle).z, true)
        if simplerRepair then
            if distanceToTarget < 20 then
                TaskVehicleTempAction(driver, vehicle, 27, 6000)
                Citizen.Wait(3000)
                RepairVehicle(target, vehicle, driver)
            end
        else
            if distanceToTarget < 20 then
                TaskVehicleTempAction(driver, vehicle, 27, 6000)
                SetVehicleUndriveable(vehicle, true)
                GoToTargetWalking(target, vehicle, driver)
            end
        end
    end
end
-- Tells the AI to walk the Player
function GoToTargetWalking(target, vehicle, driver)
    while enroute do
        Citizen.Wait(500)
        engine = GetWorldPositionOfEntityBone(target, GetEntityBoneIndexByName(target, "engine"))
        TaskGoToCoordAnyMeans(driver, engine, 2.0, 0, 0, 786603, 0xbf800000)
        distanceToTarget = GetDistanceBetweenCoords(engine, GetEntityCoords(driver).x, GetEntityCoords(driver).y, GetEntityCoords(driver).z, true)
        norunrange = false 
        if distanceToTarget <= 10 and not norunrange then -- stops ai from sprinting when close
            TaskGoToCoordAnyMeans(driver, engine, 1.0, 0, 0, 786603, 0xbf800000)
            norunrange = true
        end
        if distanceToTarget <= 2 then
            SetVehicleUndriveable(target, true)
            TaskTurnPedToFaceCoord(driver, GetEntityCoords(target), -1)
            Citizen.Wait(1000)
            TaskStartScenarioInPlace(driver, "PROP_HUMAN_BUM_BIN", 0, 1)
            SetVehicleDoorOpen(target, 4, false, false)
            Citizen.Wait(10000)
            ClearPedTasks(driver)
            RepairVehicle(target, vehicle, driver)
        end
        
    end
end
--Repair Vehicle function
function RepairVehicle(target, vehicle, driver)
	enroute = false
    norunrange = false
	FreezeEntityPosition(driver, false)
	SetVehicleDoorShut(target, 4, false,    false)
    Citizen.Wait(500)
	ShowAdvancedNotification(mechPedPick.icon, mechPedPick.name, "Your Vehicle Has been Repaired" , mechPedPick.lines[math.random(#mechPedPick.lines)])
    TriggerServerEvent("mechanic:withdraw")
    Citizen.Wait(2000)
    ShowNotification("You have been charged $5000 AUD")
    if repairComsticDamage then
		SetVehicleFixed(target)
	else
		SetVehicleEngineHealth(target, 1000.0)
	end
	if flipVehicle then
		--TriggerEvent("trp:tow") = false 
        SetVehicleOnGroundProperly(target)
    end
    if enabletow then 
        TriggerEvent("trp:tow")
    end
    SetVehicleUndriveable(target, false)
	Citizen.Wait(5000)
	LeaveTarget(vehicle, driver)
end

function LeaveTarget(vehicle, driver)
	TaskVehicleDriveWander(driver, vehicle, 17.0, drivingStyle)
	SetEntityAsNoLongerNeeded(vehicle)
	SetPedAsNoLongerNeeded(driver)
	RemoveBlip(mechBlip)
	mechVeh = nil
	mechPed = nil
	targetVeh = nil
end

function GetTargetVehicle(player, dir)
    if IsPedSittingInAnyVehicle(player) then 
        dmgVeh = GetVehiclePedIsIn(player, false)
    else
        dmgVeh = GetVehicleInDirection(GetEntityCoords(player), dir)
    end
    
    if DoesEntityExist(dmgVeh) then
        return dmgVeh
    else
        ShowNotification("Failed to find a vehicle.")
    end
end

function GetMechPed()
    mechPedPick = mechPeds[math.random(#mechPeds)]
end

function GetVehicleInDirection(coordFrom, coordTo)
    local rayHandle = CastRayPointToPoint( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, PlayerPedId(), 0)
    local _, _, _, _, vehicle = GetRaycastResult(rayHandle)
    return vehicle
end

function playRadioAnim(player)
    Citizen.CreateThread(function()
        RequestAnimDict(arrests)
        TaskPlayAnim(player, "cellphone@", "cellphone_call_in", 1.5, 2.0, -1, 50, 2.0, 0, 0, 0 )
        Citizen.Wait(6000)
        ClearPedTasks(player)
    end)
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(0)
    end
end

function ShowAdvancedNotification(icon, sender, title, text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    SetNotificationMessage(icon, icon, true, 4, sender, title, text)
    DrawNotification(false, true)
end

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end