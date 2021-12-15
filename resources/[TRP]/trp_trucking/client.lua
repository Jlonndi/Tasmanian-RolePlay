--==TRP Trucking Designed for TassieRP==--
--==     NUB AND CX, == 0--
--Trucking Locals
local truckingBlips          = {}

local lastFoundTruckingLocation  = GetGameTimer() - 3 * 60000

local timeSinceLastTruckSpawned  = GetGameTimer() - 5 * 60000

local hasFoundTruckingLocation   = false

local truckingZones = {

    -- leave empty for now, will populate with for loop below later.

}
--Notification function
function notification(text, type) -- general notification
    --    print('fuckyou')
            TriggerEvent("pNotify:SendNotification",{
                text = "<h2>Trucking Notification</h2>"..text.."",
                type = type,
                timeout = (6000),
                layout = "centerLeft",
                queue = "global"
            })
    
    end 

ESX          = nil



Citizen.CreateThread(function()

    while ESX == nil do

        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

        Citizen.Wait(0)

while ESX.GetPlayerData().job == nil do
    Citizen.Wait(100) -- checks job every 100 ms
end

PlayerData = ESX.GetPlayerData()
end
end)


RegisterNetEvent('esx:setJob') -- Net Event Trigger EVENT any EVENT in lua is fucking stupid....

AddEventHandler('esx:setJob', function(job)
Citizen.Wait(1000) -- waits to avoid flooding the job.list flooding the list may result in items being given to incorrect job values
PlayerData = ESX.GetPlayerData()
if PlayerData.job.name == "trucker" then
    TriggerServerEvent('trp:core:truckgiveitems')
    PlayerData.job = job 
else
    TriggerServerEvent('trp:core:removetruckingitems')
    print('Nubs learning curb')
end

end)
-- (server side script)

-- Registers a command named 'ping'.

RegisterCommand("spawntruck", function(source, args, rawCommand)
    Citizen.Wait(560) -- waits to avoid flooding the job.list flooding the list may result in items being given to incorrect job values
PlayerData = ESX.GetPlayerData()
    if PlayerData.job.name == "trucker" then
        TriggerEvent('trp:jobs:doSpawnTruck')
        PlayerData.job = job 
    else
        --TriggerServerEvent('trp:core:removetruckingitems')
        print('Nubs learning curb')
    end

end, false)
RegisterNetEvent('trp:jobs:doSpawnTruck')
AddEventHandler('trp:jobs:doSpawnTruck', function()
    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -265.036, -963.630, 30.223, true) < 60 then -- find LS location
        if not ESX.Game.IsSpawnPointClear({x = -270.16, y = -992.22, z = 30.93}, 10.0) then
            vehicles = ESX.Game.GetVehiclesInArea({x = -270.16, y = -992.22, z = 30.93}, 20.0)
			if #vehicles > 0 then
				for k,v in ipairs(vehicles) do
					ESX.Game.DeleteVehicle(v)
				end
			end
            notification('Please Wait Clearing Spawn...',"error")
            Wait(2000)
        end
    elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 1700.71, 3784.92, 34.77, true) < 30 then -- find SS location.
        if not ESX.Game.IsSpawnPointClear({x = 1674.9, y = 3821.64, z = 35.92}, 10.0) then
            vehicles = ESX.Game.GetVehiclesInArea({x = 1674.9, y = 3821.64, z = 35.92}, 20.0)
			for k,v in ipairs(vehicles) do
				ESX.Game.DeleteVehicle(v)
			end
         --[[   TriggerEvent("pNotify:SendNotification",{
                text = "<h2>Notification</h2>" .. "<h1>TRUCKING:</h1>" .. "<p>Please wait, clearing spawn point...</p>",
                type = "success",
                timeout = (3000),
                layout = "centerLeft",
                queue = "global"
            })]]
            notification('Please Wait Clearing Spawn...',"error")
            print('clearning spawnpoint')
            Wait(2000)
        end
    elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -147.53, 6289.10, 31.50, true) < 30 then -- find BC location
        if not ESX.Game.IsSpawnPointClear({x = -152.33, y = 6308.31, z = 31.38}, 10.0) then
            vehicles = ESX.Game.GetVehiclesInArea({x = -152.33, y = 6308.31, z = 31.38}, 20.0)
			if #vehicles > 0 then
				for k,v in ipairs(vehicles) do
					ESX.Game.DeleteVehicle(v)
				end
			end
            notification('Please Wait Clearing Spawn...',"error")
            print('clearing spawn point...')
            Wait(2000)
        end
    end
    local val = math.random(0, 2)
    local playerPed = PlayerPedId()
    timeSinceLastTruckSpawned = GetGameTimer()
    if truckingBlips['truckLocation'] ~= nil then
        if vehicleCount >= 3 then
            if GetGameTimer() - lastFoundTruckingLocation > 60 * 60000 then
                vehicleCount = 0
            else
                notification('You Borrowed too mnay trucks Please Wait...',"error")
                
            end
        else
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -265.036, -963.630, 30.223, true) < 60 then -- find LS location
                if val == 0 then
                    ESX.Game.SpawnVehicle('benson', {x = -270.16, y = -992.22, z = 30.93}, 250.44, function(vehicle)
                        if lastVehicle ~= nil then
                            DeleteEntity(lastVehicle)
                        end
                        lastVehicle = vehicle
                        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                    end)
					vehicleCount = vehicleCount + 1
                elseif val == 1 then
                    ESX.Game.SpawnVehicle('mule', {x = -270.16, y = -992.22, z = 30.93}, 250.44, function(vehicle)
                        if lastVehicle ~= nil then
                            DeleteEntity(lastVehicle)
                        end
                        lastVehicle = vehicle
                        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                    end)
					vehicleCount = vehicleCount + 1
                elseif val == 2 then
                    ESX.Game.SpawnVehicle('mule2', {x = -270.16, y = -992.22, z = 30.93}, 250.44, function(vehicle)
                        if lastVehicle ~= nil then
                            DeleteEntity(lastVehicle)
                        end
                        lastVehicle = vehicle
                        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                    end)
					vehicleCount = vehicleCount + 1
                end
            elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 1700.71, 3784.92, 34.77, true) < 30 then -- find SS location.
                if val == 0 then
                    ESX.Game.SpawnVehicle('benson', {x = 1674.9, y = 3821.64, z = 35.92}, 214.24, function(vehicle)
                        if lastVehicle ~= nil then
                            DeleteEntity(lastVehicle)
                        end
                        lastVehicle = vehicle
                        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                    end)
					vehicleCount = vehicleCount + 1
                elseif val == 1 then
                    ESX.Game.SpawnVehicle('mule',  {x = 1674.9, y = 3821.64, z = 35.92}, 214.24, function(vehicle)
                        if lastVehicle ~= nil then
                            DeleteEntity(lastVehicle)
                        end
                        lastVehicle = vehicle
                        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                    end)
					vehicleCount = vehicleCount + 1
                elseif val == 2 then
                    ESX.Game.SpawnVehicle('mule2',  {x = 1674.9, y = 3821.64, z = 35.92}, 214.24, function(vehicle)
                        if lastVehicle ~= nil then
                            DeleteEntity(lastVehicle)
                        end
                        lastVehicle = vehicle
                        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                        ESX.Game.SpawnVehicle("trailers2", {x = 1671.33, y = 3827.28, z = 34.92}, 214.24, function(vehicle)
                            AttachVehicleToTrailer(vehicle, trailer, 1.1)
                        end)
                    end)
					vehicleCount = vehicleCount + 1
                end
            elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -147.53, 6289.10, 31.50, true) < 30 then -- find BC location
                if val == 0 then
                    ESX.Game.SpawnVehicle('benson', {x = -152.33, y = 6308.31, z = 31.38}, 312.66, function(vehicle)
                        if lastVehicle ~= nil then
                            DeleteEntity(lastVehicle)
                        end
                        lastVehicle = vehicle
                        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                    end)
					vehicleCount = vehicleCount + 1
                elseif val == 1 then
                    ESX.Game.SpawnVehicle('mule', {x = -152.33, y = 6308.31, z = 31.38}, 312.66, function(vehicle)
                        if lastVehicle ~= nil then
                            DeleteEntity(lastVehicle)
                        end
                        lastVehicle = vehicle
                        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                    end)
					vehicleCount = vehicleCount + 1
                elseif val == 2 then
                    ESX.Game.SpawnVehicle('mule2', {x = -152.33, y = 6308.31, z = 31.38}, 312.66, function(vehicle)
                        if lastVehicle ~= nil then
                            DeleteEntity(lastVehicle)
                        end
                        lastVehicle = vehicle
                        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                    end)
					vehicleCount = vehicleCount + 1
                end
            else
                notification('You need to be near the job center to spawn this in.',"error")
                print('do')
			end
        end
    else
        notification('You need to use your trucking gps to borrow a truck..',"error")
        print('dodo')
    end
end)
------Stop players from starting a job if they don't have the required job set.------
RegisterNetEvent('starttruckingjob')
AddEventHandler('starttruckingjob', function()
Citizen.Wait(1000) -- waits to avoid flooding the job.list flooding the list may result in items being given to incorrect job values
PlayerData = ESX.GetPlayerData()
if PlayerData.job.name == "trucker" then
TriggerEvent('trp:jobs:doFindTruckingLocation')
else 
    notification('You don\'t Have the required job for this',"error")
end
end)

RegisterNetEvent('stoptruckingjob')
AddEventHandler('stoptruckingjob', function()
Citizen.Wait(1000) -- waits to avoid flooding the job.list flooding the list may result in items being given to incorrect job values
PlayerData = ESX.GetPlayerData()
if PlayerData.job.name == "trucker" then
TriggerEvent('trp:jobs:doCancelTrucking')
else 
    notification('You don\'t Have the required job for this',"error")
end
end)
RegisterNetEvent('truckingdeliver')
AddEventHandler('truckingdeliver', function()
Citizen.Wait(1000) -- waits to avoid flooding the job.list flooding the list may result in items being given to incorrect job values
PlayerData = ESX.GetPlayerData()
if PlayerData.job.name == "trucker" then
TriggerEvent('trp:job:delivertrucking')
else 
    notification('You don\'t Have the required job for this',"error")
end
end)
--Allowed vehicles
allowedVehicles = {
    "nmule",
    
    "mule3",

	"benson",

	"hauler",

	"actros",

	"phantom"

}


--Vehicle check--
function isAnAllowedVehicle()

	local isAnAllowedVehicle = false

	local playerPed = PlayerPedId()

	for i=1, #allowedVehicles, 1 do

		if IsVehicleModel(GetVehiclePedIsUsing(playerPed), allowedVehicles[i]) then

			isAnAllowedVehicle = true

			break

		end

	end

	return isAnAllowedVehicle

end


--Delivery coordinations
CityArea = {


--Delivery coordinations
    { [ 'x' ] = 	 495.702	, [ 'y' ] = 	-1644.86 , [ 'z' ] = 	29.219	},

    { [ 'x' ] = 	 -165.365	, [ 'y' ] = 	-1306.33 , [ 'z' ] = 	31.354	},

    { [ 'x' ] = 	 -647.254	, [ 'y' ] = 	-937.745 , [ 'z' ] = 	22.264	},

    { [ 'x' ] = 	 -1487.696  , [ 'y' ] = 	-898.718 , [ 'z' ] = 	10.024	},

    { [ 'x' ] = 	 -1644.89	, [ 'y' ] = 	140.661  , [ 'z' ] = 	62.073	},

    { [ 'x' ] = 	 -307.88   	, [ 'y' ] = 	627.061  , [ 'z' ] = 	175.587	},

    { [ 'x' ] = 	 250.641	, [ 'y' ] = 	305.841  , [ 'z' ] = 	105.571	},

    { [ 'x' ] = 	 1103.75   	, [ 'y' ] = 	-368.55  , [ 'z' ] = 	67.106	},

    { [ 'x' ] = 	 1494.03	, [ 'y' ] = 	-1924.50 , [ 'z' ] = 	71.176	},

    { [ 'x' ] = 	 -219.33   	, [ 'y' ] = 	-944.81  , [ 'z' ] = 	29.27	},

    { [ 'x' ] = 	 -1814.25	, [ 'y' ] = 	775.81   , [ 'z' ] = 	136.89	},

    { [ 'x' ] = 	 -410.83	, [ 'y' ] = 	1175.64  , [ 'z' ] = 	325.70	}



}



SandyArea = {


--Delivery coordinations
    { [ 'x' ] = 	 2502.16	, [ 'y' ] = 	4101.847 , [ 'z' ] = 	38.291	},

    { [ 'x' ] = 	 1707.249	, [ 'y' ] = 	3745.78	 , [ 'z' ] = 	33.825	},

    { [ 'x' ] = 	 345.07 	, [ 'y' ] = 	3443.22  , [ 'z' ] = 	35.85	},

    { [ 'x' ] = 	 619.41 	, [ 'y' ] = 	2737.31	 , [ 'z' ] = 	42.06	},

    { [ 'x' ] = 	 1184.438	, [ 'y' ] = 	2688.54	 , [ 'z' ] = 	37.87	},

    { [ 'x' ] = 	 2558.45	, [ 'y' ] = 	2705.09  , [ 'z' ] = 	42.0	},

    { [ 'x' ] = 	 2573.15	, [ 'y' ] = 	319.72	 , [ 'z' ] = 	107.80	},

    { [ 'x' ] = 	 3501.91	, [ 'y' ] = 	3768.33	 , [ 'z' ] = 	29.98	},

    { [ 'x' ] = 	 1862.32	, [ 'y' ] = 	2587.21	 , [ 'z' ] = 	45.74	},

    { [ 'x' ] = 	 2662.835	, [ 'y' ] = 	1638.34  , [ 'z' ] = 	24.65	}



}



BlaineArea = {


--Delivery coordinations
    { [ 'x' ] = 	 2108.02	, [ 'y' ] = 	4769.29	, [ 'z' ] = 	41.26	},

    { [ 'x' ] = 	 1311.94	, [ 'y' ] = 	4319.05	, [ 'z' ] = 	38.16	},

    { [ 'x' ] = 	 722.58	    , [ 'y' ] = 	4178.74	, [ 'z' ] = 	40.77	},

    { [ 'x' ] = 	 -1108.98	, [ 'y' ] = 	2684.24	, [ 'z' ] = 	18.96	},

    { [ 'x' ] = 	 -1589.53	, [ 'y' ] = 	2800.91	, [ 'z' ] = 	16.95	},

    { [ 'x' ] = 	 -1913.12	, [ 'y' ] = 	2045.87 , [ 'z' ] = 	140.79	},

    { [ 'x' ] = 	-2530.97	, [ 'y' ] =     2324.88 , [ 'z' ] = 	33.11	},

    { [ 'x' ] = 	 -2218.38	, [ 'y' ] = 	4276.64	, [ 'z' ] = 	47.30	},

    { [ 'x' ] = 	 -787.01	, [ 'y' ] = 	5548.25	, [ 'z' ] = 	33.28	},

    { [ 'x' ] = 	 87.64  	, [ 'y' ] = 	6374.86 , [ 'z' ] = 	31.51	},

    { [ 'x' ] = 	1581.39 	, [ 'y' ] =     6443.01 , [ 'z' ] = 	24.96	}





}



BlaineArea2 = {


--Delivery coordinations
    { [ 'x' ] = 	 2108.02	, [ 'y' ] = 	4769.29	, [ 'z' ] = 	41.26	},

    { [ 'x' ] = 	 1311.94	, [ 'y' ] = 	4319.05	, [ 'z' ] = 	38.16	},

    { [ 'x' ] = 	 722.58	    , [ 'y' ] = 	4178.74	, [ 'z' ] = 	40.77	},

    { [ 'x' ] = 	 -1108.98	, [ 'y' ] = 	2684.24	, [ 'z' ] = 	18.96	},

    { [ 'x' ] = 	 -1589.53	, [ 'y' ] = 	2800.91	, [ 'z' ] = 	16.95	},

    { [ 'x' ] = 	 -1913.12	, [ 'y' ] = 	2045.87 , [ 'z' ] = 	140.79	},

    { [ 'x' ] = 	-2530.97	, [ 'y' ] =     2324.88 , [ 'z' ] = 	33.11	},

    { [ 'x' ] = 	 -2218.38	, [ 'y' ] = 	4276.64	, [ 'z' ] = 	47.30	},

    { [ 'x' ] = 	 -787.01	, [ 'y' ] = 	5548.25	, [ 'z' ] = 	33.28	},

    { [ 'x' ] = 	 87.64  	, [ 'y' ] = 	6374.86 , [ 'z' ] = 	31.51	},

    { [ 'x' ] = 	1581.39 	, [ 'y' ] =     6443.01 , [ 'z' ] = 	24.96	}





}



for i=1, #CityArea, 1 do



    truckingZones['CityArea' .. i] = {

        Pos   = CityArea[i],

        Size  = {x = 1.5, y = 1.5, z = 1.0},

        Color = {r = 204, g = 204, b = 0},

        Type  = -1

    }



end



for i=1, #SandyArea, 1 do



    truckingZones['SandyArea' .. i] = {

        Pos   = SandyArea[i],

        Size  = {x = 1.5, y = 1.5, z = 1.0},

        Color = {r = 204, g = 204, b = 0},

        Type  = -1

    }



end



for i=1, #BlaineArea, 1 do



    truckingZones['BlaineArea' .. i] = {

        Pos   = BlaineArea[i],

        Size  = {x = 1.5, y = 1.5, z = 1.0},

        Color = {r = 204, g = 204, b = 0},

        Type  = -1

    }



end



for i=1, #BlaineArea2, 1 do



    truckingZones['BlaineArea2' .. i] = {

        Pos   = BlaineArea2[i],

        Size  = {x = 1.5, y = 1.5, z = 1.0},

        Color = {r = 204, g = 204, b = 0},

        Type  = -1

    }



end

local vehicleCount = 0

local lastVehicle = nil
RegisterNetEvent('trp:jobs:doSpawnTruck')

AddEventHandler('trp:jobs:doSpawnTruck', function()



    local val = math.random(0, 2)

    local playerPed = PlayerPedId()

    timeSinceLastTruckSpawned = GetGameTimer()

    if truckingBlips['truckLocation'] ~= nil then

        if vehicleCount >= 3 then

            if GetGameTimer() - lastFoundTruckingLocation > 60 * 60000 then

                vehicleCount = 0

            else

                TriggerEvent('Chat:addMessage', {

                    template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(47, 92, 115, 0.9); border-radius: 3px; "><i class="far fa-envelope"></i> Job Information: You have borrowed more than 3 vehicles during this hour. Please try again in one hour.</div>'

                })

            end

        else

            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -265.036, -963.630, 30.223, true) < 60 then -- find LS location

                if val == 0 then

                    ESX.Game.SpawnVehicle('hauler', {x = -270.16, y = -992.22, z = 30.93}, 250.44, function(vehicle)

                        if lastVehicle ~= nil then

                            DeleteEntity(lastVehicle)

                        end

                        lastVehicle = vehicle

                        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

						ESX.Game.SpawnVehicle("trailers2", {x = -270.16, y = -992.22, z = 30.93}, 250.44, function(trailer)

                            AttachVehicleToTrailer(vehicle, trailer, 1.1)

                        end)

                    end)

					vehicleCount = vehicleCount + 1

                elseif val == 1 then

                    ESX.Game.SpawnVehicle('phantom', {x = -270.16, y = -992.22, z = 30.93}, 250.44, function(vehicle)

                        if lastVehicle ~= nil then

                            DeleteEntity(lastVehicle)

                        end

                        lastVehicle = vehicle

                        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

                        ESX.Game.SpawnVehicle("trailers2", {x = -270.16, y = -992.22, z = 30.93}, 250.44, function(trailer)

                            AttachVehicleToTrailer(vehicle, trailer, 1.1)

                        end)

                    end)

					vehicleCount = vehicleCount + 1

                elseif val == 2 then

                    ESX.Game.SpawnVehicle('actros', {x = -270.16, y = -992.22, z = 30.93}, 250.44, function(vehicle)

                        if lastVehicle ~= nil then

                            DeleteEntity(lastVehicle)

                        end

                        lastVehicle = vehicle

                        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

                        ESX.Game.SpawnVehicle("trailers2", {x = -270.16, y = -992.22, z = 30.93}, 250.44, function(trailer)

                            AttachVehicleToTrailer(vehicle, trailer, 1.1)

                        end)

                    end)

					vehicleCount = vehicleCount + 1

                end

            elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 2519.742, 4126.265, 37.65, true) < 30 then -- find SS location.

                if val == 0 then

                    ESX.Game.SpawnVehicle('hauler', {x = 2487.36, y = 4118.69, z = 38.07}, 239.87, function(vehicle)

                        if lastVehicle ~= nil then

                            DeleteEntity(lastVehicle)

                        end

                        lastVehicle = vehicle

                        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

                        ESX.Game.SpawnVehicle("trailers2", {x = 2487.36, y = 4118.69, z = 38.07}, 239.87, function(trailer)

                            AttachVehicleToTrailer(vehicle, trailer, 1.1)

                        end)

                    end)

					vehicleCount = vehicleCount + 1

                elseif val == 1 then

                    ESX.Game.SpawnVehicle('phantom', {x = 2487.36, y = 4118.69, z = 38.07}, 239.87, function(vehicle)

                        if lastVehicle ~= nil then

                            DeleteEntity(lastVehicle)

                        end

                        lastVehicle = vehicle

                        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

                        ESX.Game.SpawnVehicle("trailers2", {x = 2487.36, y = 4118.69, z = 38.07}, 239.87, function(trailer)

                            AttachVehicleToTrailer(vehicle, trailer, 1.1)

                        end)

                    end)

					vehicleCount = vehicleCount + 1

                elseif val == 2 then

                    ESX.Game.SpawnVehicle('actros', {x = 2487.36, y = 4118.69, z = 38.07}, 239.87, function(vehicle)

                        if lastVehicle ~= nil then

                            DeleteEntity(lastVehicle)

                        end

                        lastVehicle = vehicle

                        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

                        ESX.Game.SpawnVehicle("trailers2", {x = 2487.36, y = 4118.69, z = 38.07}, 239.87, function(trailer)

                            AttachVehicleToTrailer(vehicle, trailer, 1.1)

                        end)

                    end)

					vehicleCount = vehicleCount + 1

                end

            elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -147.53, 6289.10, 31.50, true) < 30 then -- find BC location

                if val == 0 then

                    ESX.Game.SpawnVehicle('hauler', {x = -152.33, y = 6308.31, z = 31.38}, 312.66, function(vehicle)

                        if lastVehicle ~= nil then

                            DeleteEntity(lastVehicle)

                        end

                        lastVehicle = vehicle

                        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

                        ESX.Game.SpawnVehicle("trailers2", {x = -152.33, y = 6308.31, z = 31.38}, 312.66, function(trailer)

                            AttachVehicleToTrailer(vehicle, trailer, 1.1)

                        end)

                    end)

					vehicleCount = vehicleCount + 1

                elseif val == 1 then

                    ESX.Game.SpawnVehicle('phantom', {x = -152.33, y = 6308.31, z = 31.38}, 312.66, function(vehicle)

                        if lastVehicle ~= nil then

                            DeleteEntity(lastVehicle)

                        end

                        lastVehicle = vehicle

                        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

                        ESX.Game.SpawnVehicle("trailers2", {x = -152.33, y = 6308.31, z = 31.38}, 312.66, function(trailer)

                            AttachVehicleToTrailer(vehicle, trailer, 1.1)

                        end)

                    end)

					vehicleCount = vehicleCount + 1

                elseif val == 2 then

                    ESX.Game.SpawnVehicle('actros', {x = -152.33, y = 6308.31, z = 31.38}, 312.66, function(vehicle)

                        if lastVehicle ~= nil then

                            DeleteEntity(lastVehicle)

                        end

                        lastVehicle = vehicle

                        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

                        ESX.Game.SpawnVehicle("trailers2", {x = -152.33, y = 6308.31, z = 31.38}, 312.66, function(trailer)

                            AttachVehicleToTrailer(vehicle, trailer, 1.1)

                        end)

                    end)

					vehicleCount = vehicleCount + 1

                end

            else

				TriggerEvent('Chat:addMessage', {

					template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(47, 92, 115, 0.9); border-radius: 3px; "><i class="far fa-envelope"></i> Job Information: You need to be near a job centre to use this item (Purple Information Icon on the map).</div>'

				})

			end

        end

    else

        TriggerEvent('Chat:addMessage', {

            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(47, 92, 115, 0.9); border-radius: 3px; "><i class="far fa-envelope"></i> Job Information: You need to have used your Trucking GPS to borrow a vehicle.</div>'

        })

    end

end)



local firstQueryTrucking = true

local truckingXP = 1



RegisterNetEvent('trp:jobs:doFindTruckingLocation')

AddEventHandler('trp:jobs:doFindTruckingLocation', function()
print('testtestest')


    if GetGameTimer() - lastFoundTruckingLocation > 3 * 60000 then

		eraseTruckingLocation()

        if firstQueryTrucking then

            firstQueryTrucking = false

            ESX.TriggerServerCallback('trp:jobs:getTruckingXP', function(xp)




                if data ~= nil then

                    truckingXP = xp

                    if truckingXP <= 199 then

                        doFindTruckingLocation(1)

                    elseif truckingXP >= 200 and truckingXP <= 399 then

                        doFindTruckingLocation(2)

                    elseif truckingXP >= 400 and truckingXP <= 599 then

                        doFindTruckingLocation(3)

                    elseif truckingXP >= 600 then

                        doFindTruckingLocation(4)

                    end

                    notification('You are in the middle of a job. Please wait until you are done for another job.', 'error')

                else

                    doFindTruckingLocation(1)

                    notification('You are in the middle of a job. Please wait until you are done for another job.', 'error')

                end

            end)

        else

            if truckingXP <= 199 then

                doFindTruckingLocation(1)

            elseif truckingXP >= 200 and truckingXP <= 399 then

                doFindTruckingLocation(2)

            elseif truckingXP >= 400 and truckingXP <= 599 then

                doFindTruckingLocation(3)

            elseif truckingXP >= 600 then

                doFindTruckingLocation(4)

            end

            notification('The trucking job has given you a new delivery!', 'error')
        end

		lastFoundTruckingLocation = GetGameTimer()

    else

        notification('You have alreay done a job recently please try again in 3 minutes.', 'error')

    end

end)



function selectRandomDeliveryLocation(deliveryGrade)

    if deliveryGrade == 1 then

        local index = GetRandomIntInRange(1, #CityArea)

        for k,v in pairs(truckingZones) do

            if v.Pos.x == CityArea[index].x and v.Pos.y == CityArea[index].y and v.Pos.z == CityArea[index].z then

                return k

            end

        end

    elseif deliveryGrade == 2 then

        local index = GetRandomIntInRange(1, #SandyArea)

        for k,v in pairs(truckingZones) do

            if v.Pos.x == SandyArea[index].x and v.Pos.y == SandyArea[index].y and v.Pos.z == SandyArea[index].z then

                return k

            end

        end

    elseif deliveryGrade == 3 then

        local index = GetRandomIntInRange(1, #BlaineArea)

        for k,v in pairs(truckingZones) do

            if v.Pos.x == BlaineArea[index].x and v.Pos.y == BlaineArea[index].y and v.Pos.z == BlaineArea[index].z then

                return k

            end

        end

    elseif deliveryGrade == 4 then

        local index = GetRandomIntInRange(1, #BlaineArea2)

        for k,v in pairs(truckingZones) do

            if v.Pos.x == BlaineArea2[index].x and v.Pos.y == BlaineArea2[index].y and v.Pos.z == BlaineArea2[index].z then

                return k

            end

        end

    else

        local index = GetRandomIntInRange(1, #CityArea)

        for k,v in pairs(truckingZones) do

            if v.Pos.x == CityArea[index].x and v.Pos.y == CityArea[index].y and v.Pos.z == CityArea[index].z then

                return k

            end

        end

        print("Error! Please report to NUB on github!")
        --print('I personally blame ozzy gaming for this error code...')
    end

end



function doFindTruckingLocation(deliveryGrade)

    truckLocation = selectRandomDeliveryLocation(deliveryGrade)

    local zone = truckingZones[truckLocation]

    truckingBlips['truckLocation'] = AddBlipForCoord(zone.Pos.x, zone.Pos.y, zone.Pos.z)

    SetBlipRoute(truckingBlips['truckLocation'], true)

    hasFoundTruckingLocation = true

end



RegisterNetEvent('trp:job:delivertrucking')

AddEventHandler('trp:job:delivertrucking', function()



    local zone   = truckingZones[truckLocation]

    local coords = GetEntityCoords(PlayerPedId())



    if not hasFoundTruckingLocation then



        notification('You need to be given a location by the delivery company before using this item', 'error')



    else



        if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < 10 then



			if (IsPedSittingInAnyVehicle(PlayerPedId())) and isAnAllowedVehicle() then



				exports['mythic_progbar']:Progress({



					name = "do_trucking",

					duration = 20000,

					label = "Unloading The Truck",

					useWhileDead = false,

					canCancel = false,

					controlDisables = {

						disableMovement = true,

						disableCarMovement = true,

						disableMouse = false,

						disableCombat = true,

					},



					animation = {

						animDict = "",

						anim = "",

						flags = 49,

					},



					prop = {

						model = "",

					}





				}, function(cancelled)

					local coords = GetEntityCoords(PlayerPedId())



					if not cancelled and GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < 10 then

						TriggerServerEvent('trp:jobs:doRewardTrucking', math.random(100,1000))

						if truckingBlips['truckLocation'] ~= nil then

							RemoveBlip(truckingBlips['truckLocation'])

							truckingBlips['truckLocation'] = nil

							truckingXP = truckingXP + 1

                            notification('You have delivered the Package! Use the truckers sheet to find another delivery!', 'error')
						end

						hasFoundTruckingLocation = false

					else

                        notification('You have Cancelled the delivery Maybe you should finish the', 'error')



					end

				end)

    		else

                notification('You must be in the truck to deliver the goods!', 'error')

    		end

        else

            notification('You need to move closer to the delivery location!', 'error')

        end

    end

end)



RegisterCommand("resettrucking", function(source, args)

	TriggerEvent("trp:jobs:doCancelTrucking")

end, false)



RegisterNetEvent('trp:jobs:doCancelTrucking')

AddEventHandler('trp:jobs:doCancelTrucking', function()
    eraseTruckingLocation()
    notification('You have reset the trucking sheet', 'error')
end)



function eraseTruckingLocation(cancel)

    if truckingBlips['truckLocation'] ~= nil then

        RemoveBlip(truckingBlips['truckLocation'])

        truckingBlips['truckLocation'] = nil

    end

    --[[if lastVehicle ~= nil then

        DeleteEntity(lastVehicle)

    end]]
end

