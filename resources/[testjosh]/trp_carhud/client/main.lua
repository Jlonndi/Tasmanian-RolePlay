-- Variable
local currVeh = 0; 
local cruiseEnabled, seatbeltEnabled = false, false;
local vehData = {
    hasBelt = false,
    engineRunning = false,

    currSpd = 0.0,
    cruiseSpd = 0.0,
    prevVelocity = {x = 0.0, y = 0.0, z = 0.0}, 
};      

AddEventHandler('seatbelt:sounds', function(soundFile, soundVolume)
    SendNUIMessage({
        transactionType = 'playSound',
        transactionFile = soundFile,
        transactionVolume = soundVolume
    })
end)

function IsCar(veh)
    local vc = GetVehicleClass(veh)
    return (vc >= 0 and vc <= 7) or (vc >= 10 and vc <= 12) or (vc >= 17 and vc <= 20)
end	
local threesecond = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3500)
        local ped = PlayerPedId()
        local car = GetVehiclePedIsIn(ped)
        speed = Config['useKM'] and math.floor(vehData['currSpd'] * 3.6) or math.floor(vehData['currSpd'] * 2.236936)

    if not seatbeltEnabled and (currVeh ~= 0) and IsCar(car) and not IsPauseMenuActive() and speed > 40 and not threesecond then
      TriggerEvent("seatbelt:sounds", "seatbelt", 0.2)
      Citizen.Wait(30000)
      threesecond = true
		end    
	end
end)


local playerPed = nil;
-- Thread
Citizen.CreateThread(function()
    while true do
        if (currVeh ~= 0) then
            local position = GetEntityCoords(playerPed);

            -- //NOTE: Copy from original (DyzCarSystem)
            local EntityHealth = GetEntityHealth(currVeh) - 100;
            local maxEntityHealth = GetEntityMaxHealth(currVeh) - 100;
            local vehicleHealth = (EntityHealth / maxEntityHealth) * 100;

            local heading = Config['Directions'][math.floor((GetEntityHeading(playerPed) + 45.0) / 45.0)];
            local zoneNameFull = Config['Zones'][GetNameOfZone(position.x, position.y, position.z)];
            local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(position.x, position.y, position.z));
            local locationText = string.format("<strong><b style='color:#ffa866'>" .. heading .. "</b>")
            locationText = (streetName == "" or streetName == nil) and (locationText) or (locationText .. ", " .. streetName);
            locationText = (zoneNameFull == "" or zoneNameFull == nil) and (locationText) or (locationText .. ", " .. zoneNameFull);
 local vehicleGear = GetVehicleCurrentGear(currVeh)

            if (vehData['currSpd'] == 0 and vehicleGear == 0) or (vehData['currSpd'] == 0 and vehicleGear == 1) then
                vehicleGear = 'N'
            elseif vehData['currSpd'] > 0 and vehicleGear == 0 then
                vehicleGear = 'R'
            end
            triggerNUI("updateInfo", {
                -- Vehicle Status
                carHealth = vehicleHealth,
                carFuel = math.floor(GetVehicleFuelLevel(currVeh)),

                -- Speed
                speed = Config['useKM'] and math.floor(vehData['currSpd'] * 3.6) or math.floor(vehData['currSpd'] * 2.236936),

                -- Gear
                gear = vehicleGear,

                -- Streat name
                streetName = locationText,

                -- Unit
                speedUnit = Config['useKM'] and 'KM' or 'M'
            })
        end

        Citizen.Wait(95);
    end
end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
            HideHudComponentThisFrame(1)  -- Wanted Stars
            --HideHudComponentThisFrame(2)  -- Weapon Icon
            --HideHudComponentThisFrame(3)  -- Cash
            --HideHudComponentThisFrame(4)  -- MP Cash
            HideHudComponentThisFrame(6)  -- Vehicle Name
            HideHudComponentThisFrame(7)  -- Area Name
            HideHudComponentThisFrame(8)  -- Vehicle Class
            HideHudComponentThisFrame(9)  -- Street Name
            --HideHudComponentThisFrame(13) -- Cash Change
            --HideHudComponentThisFrame(17) -- Save Game
           -- HideHudComponentThisFrame(20) -- Weapon Stats
    end
end)
Citizen.CreateThread(function()
    while true do
        if (currVeh ~= 0) then
            local position = GetEntityCoords(playerPed);

            -- Seat Belt
            if (IsControlJustReleased(0, Config['seatbeltInput']) and vehData['hasBelt']) then 
                seatbeltEnabled = not seatbeltEnabled;
                print(vehData['hasBelt'], seatbeltEnabled)
                triggerNUI("toggleBelt", { hasBelt = vehData['hasBelt'], beltOn = seatbeltEnabled })
            end
            
            local prevSpeed = vehData['currSpd'];
            vehData['currSpd'] = GetEntitySpeed(currVeh);

            if (not vehData['hasBelt'] or not seatbeltEnabled) then
                seatbeltEnabled = false;

                local vehIsMovingFwd = GetEntitySpeedVector(currVeh, true).y > 1.0;
                local vehAcc = (prevSpeed - vehData['currSpd']) / GetFrameTime();
                if (vehIsMovingFwd and (prevSpeed > (Config['seatbeltEjectSpeed']/2.237)) and (vehAcc > (Config['seatbeltEjectAccel']*9.81))) then
                    SetEntityCoords(playerPed, position.x, position.y, position.z - 0.47, true, true, true);
                    SetEntityVelocity(playerPed, vehData['prevVelocity'].x, vehData['prevVelocity'].y, vehData['prevVelocity'].z);
                    Citizen.Wait(1);
                    SetPedToRagdoll(playerPed, 1000, 1000, 0, 0, 0, 0);
                else
                    vehData['prevVelocity'] = GetEntityVelocity(currVeh);
                end
            elseif (seatbeltEnabled) then
                DisableControlAction(0, 75);
            end

          

            local engineRunning = GetIsVehicleEngineRunning(currVeh);
            if (engineRunning ~= vehData['engineRunning']) then
                vehData['engineRunning'] = engineRunning;
                triggerNUI("toggleEngine", vehData['engineRunning']);
            end
        end

        Citizen.Wait(currVeh == 0 and 500 or 5);
    end
end)

RegisterKeyMapping('speedlimit', 'Speed Limiter', 'keyboard', 'X')
RegisterCommand("speedlimit", function(source, args, rawCommand)

    local isDriver = (GetPedInVehicleSeat(currVeh, -1) == playerPed);
if (isDriver) then
   -- if (IsControlJustReleased(0, Config['cruiseInput'])) then
        cruiseEnabled = not cruiseEnabled;
        triggerNUI("toggleCruise", { hasCruise = isDriver, cruiseStatus = cruiseEnabled })

        vehData['cruiseSpd'] = vehData['currSpd'];
    --end

    local maxSpeed = cruiseEnabled and vehData['cruiseSpd'] or GetVehicleHandlingFloat(currVeh,"CHandlingData","fInitialDriveMaxFlatVel");
    SetEntityMaxSpeed(currVeh, maxSpeed);
else
    cruiseEnabled = false;
end

end, false)
Citizen.CreateThread(function()
    while true do
        playerPed = PlayerPedId();
        local veh = GetVehiclePedIsIn(playerPed, false);

        if (veh ~= currVeh) then
            currVeh = veh;
            triggerNUI("toggleUI", veh ~= 0);
            threesecond = false
            if (veh == 0) and seatbeltEnabled then
                cruiseEnabled, seatbeltEnabled = false, false;
                vehData['currSpd'] = 0.0;
                triggerNUI("toggleBelt", { hasBelt = vehData['hasBelt'], beltOn = seatbeltEnabled })  
            else if (veh == 0) and not seatbeltEnabled then
                cruiseEnabled, seatbeltEnabled = false, false;
                vehData['currSpd'] = 0.0;
               -- triggerNUI("toggleBelt", { hasBelt = vehData['hasBelt'], beltOn = seatbeltEnabled })
            else 
                local vehicleClass = GetVehicleClass(veh);
                vehData['hasBelt'] = isVehicleClassHasBelt(vehicleClass);
            end
            end
        end

        Citizen.Wait(500);
    end
end)

RegisterNUICallback('seatbeltbuckle', function(data, cb)
	TriggerEvent('InteractSound_CL:PlayOnOne', 'buckle', 0.5) -- todo add multiple sounds math.random
end)

RegisterNUICallback('seatbeltunbuckle', function(data, cb)
	TriggerEvent('InteractSound_CL:PlayOnOne', 'unbuckle', 0.5)
end)