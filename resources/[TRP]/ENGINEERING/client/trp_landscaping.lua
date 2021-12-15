
local WeldingBlips          = {}
local lastFoundLocation  = GetGameTimer() - 5 * 60000
local hasFoundYard   = false
local WeldingAreas = {
}

ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100) -- checks job every 100 ms
    end

    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob') -- Net Event Trigger EVENT any EVENT in lua is fucking stupid....
AddEventHandler('esx:setJob', function(job)
    Citizen.Wait(1000) -- waits to avoid flooding the job.list flooding the list may result in items being given to incorrect job values
    PlayerData = ESX.GetPlayerData()
    if PlayerData.job.name == "Welder" then
        TriggerServerEvent('Surge:core:Weldergiveitems')
        PlayerData.job = job 
    else
        TriggerServerEvent('Surge:core:removeWeldingitems')
        print('This Is Running')
    end
end)
------Stop players from starting a job if they don't have the required job set.------
RegisterNetEvent('startWelding')
AddEventHandler('startWelding', function()
Citizen.Wait(1000) -- waits to avoid flooding the job.list flooding the list may result in items being given to incorrect job values
PlayerData = ESX.GetPlayerData()
if PlayerData.job.name == "Welder" then
TriggerEvent('Surge:jobs:FindWeldingLocation')
else 
    notification('You don\'t Have the required job for this',"error")
end
end)

RegisterNetEvent('WeldingActive')
AddEventHandler('WeldingActive', function()
Citizen.Wait(1000) -- waits to avoid flooding the job.list flooding the list may result in items being given to incorrect job values
PlayerData = ESX.GetPlayerData()
if PlayerData.job.name == "Welder" then
TriggerEvent('Surge:jobs:doStartWelding')
else 
    notification('You don\'t Have the required job for this',"error")
end
end)

RegisterNetEvent('WeldingFnish')
AddEventHandler('WeldingFnish', function()
Citizen.Wait(1000) -- waits to avoid flooding the job.list flooding the list may result in items being given to incorrect job values
PlayerData = ESX.GetPlayerData()
if PlayerData.job.name == "Welder" then
    TriggerEvent('Surge:jobs:CancelWelding')
else 
    notification('You don\'t Have the required job for this',"error")
    end
end)

LowLevelWelding = {

    { [ 'x' ] = 	 -1809.49	, [ 'y' ] = 	-366.22  , [ 'z' ] = 	49.24	},
    { [ 'x' ] = 	 1850.78	, [ 'y' ] = 	2581.08  , [ 'z' ] = 	45.67	},
    { [ 'x' ] = 	 172.76	    , [ 'y' ] = 	3091.15  , [ 'z' ] = 	43.04	},
    { [ 'x' ] = 	 2350.13	, [ 'y' ] = 	4877.56  , [ 'z' ] = 	41.82	},
    { [ 'x' ] = 	 42.49   	, [ 'y' ] = 	3708.46  , [ 'z' ] = 	39.74	},
    { [ 'x' ] = 	 3317.49	, [ 'y' ] = 	5167.65  , [ 'z' ] = 	18.42	},
    { [ 'x' ] = 	 -1164.155	, [ 'y' ] = 	4925.60  , [ 'z' ] = 	222.93	}

}

local firstQueryWelding = true


RegisterNetEvent('Surge:jobs:FindWeldingLocation')
AddEventHandler('Surge:jobs:FindWeldingLocation', function()
    local status1 = status2
    local status3 = status4
    if status1 == nil and status3 == nil then
       
        if GetGameTimer() - lastFoundLocation > 2.5 * 60000 then
    		eraseWeldingLocations()
            if firstQueryWelding then
                firstQueryWelding = false
                ESX.TriggerServerCallback('Surge:GETWelderXP', function(xp)
local WelderXP = xp
                    if status3 ~= nil then -- workaround

                        WeldingXP = xp
                        if WeldingXP <= 199 then
                            FindWeldingLocation(1)
                        elseif WeldingXP >= 200 and WeldingXP <= 399 then
                            FindWeldingLocation(2)
                        elseif WeldingXP >= 400 and WeldingXP <= 599 then
                            FindWeldingLocation(3)
                        elseif WeldingXP >= 600 then
                            FindWeldingLocation(4)
                        end
                        notification('The Welding depot has given you a new job.', 'success')
                    else
                        FindWeldingLocation(1)
                        notification('The Welding depot has given you a new job.', 'success')
                    end
                end)
            else
                ESX.TriggerServerCallback('Surge:GETWelderXP', function(xp)
                    WeldingXP = xp
                if WeldingXP <= 199 then
                    FindWeldingLocation(1)
                elseif WeldingXP >= 200 and WeldingXP <= 399 then
                    FindWeldingLocation(2)
                elseif WeldingXP >= 400 and WeldingXP <= 599 then
                    FindWeldingLocation(3)
                elseif WeldingXP >= 600 then
                    FindWeldingLocation(4)
                end
            end)
                notification('The Welding depot has given you a new job.', 'success')
           
        end
    		lastFoundLocation = GetGameTimer()
        else
            notification('You have recieved a new job recently. Please wait a bit for another job.', 'error')
        end
    else
        notification('You are in the middle of a job. Please wait until you are done for another job.', 'error')
   
    end
end)

function RandomLocation(WelderLevel)
    if WelderLevel == 1 then
        local index = GetRandomIntInRange(1, #LowLevelWelding)
        for k,v in pairs(WeldingAreas) do
            if v.Pos.x == LowLevelWelding[index].x and v.Pos.y == LowLevelWelding[index].y and v.Pos.z == LowLevelWelding[index].z then
                return k
            end
        end
        print("This is broken")
    end
end

function FindWeldingLocation(WelderLevel)
    WeldingLocations = RandomLocation(WelderLevel) -- Selects a random location based off Welders Level
    local zone = WeldingAreas[WeldingLocations] -- Refers to 173 Below us Which finds zone and sets blip..
    WeldingBlips['WeldingLocations'] = AddBlipForCoord(zone.Pos.x, zone.Pos.y, zone.Pos.z) -- Sets Blips for Zones..
    SetBlipRoute(WeldingBlips['WeldingLocations'], true) -- Sets the blip Route
    hasFoundYard = true
end

function doAnim()
	Citizen.CreateThread(function()
        val = math.random(1,3)
        if val == 1 then
            TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GARDENER_LEAF_BLOWER", 0, true)
        elseif val == 2 then
            TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GARDENER_PLANT", 0, true)
        else
            TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CONST_DRILL", 0, true)
        end
		Citizen.Wait(20000)
		ClearPedTasks(PlayerPedId())
	end)
end

function eraseWeldingLocations(cancel)
    if WeldingBlips['WeldingLocations'] ~= nil then
        RemoveBlip(WeldingBlips['WeldingLocations'])
        WeldingBlips['WeldingLocations'] = nil
    end
    notification('You Have Signed Out Of Work', 'error')
end

RegisterCommand("resetWelding", function(source, args)
	TriggerEvent("Surge:jobs:CancelWelding")
end, false)

function WeldingReturnStatus()
    return WeldingBlips['WeldingLocations']
end

RegisterNetEvent('Surge:jobs:CancelWelding')
AddEventHandler('Surge:jobs:CancelWelding', function()
    eraseWeldingLocations()
end)

function notification(text, type) -- general notification
		TriggerEvent("pNotify:SendNotification",{
			text = "<h2>Welding Notification</h2>"..text.."",
			type = type,
	        timeout = (6000),
	        layout = "centerLeft",
	        queue = "global"
        })
end
for i=1, #LowLevelWelding, 1 do

    WeldingAreas['LowLevelWelding' .. i] = {
        Pos   = LowLevelWelding[i],
        Size  = {x = 1.5, y = 1.5, z = 1.0},
        Color = {r = 204, g = 204, b = 0},
        Type  = -1
    }

end
----- Job Completed ---
RegisterNetEvent('Surge:jobs:notifyjobdone')
AddEventHandler('Surge:jobs:notifyjobdone', function()
    ESX.TriggerServerCallback('Surge:GETWelderXP', function(xp)
        print(xp)
notification('You have completed this job your total xp is now '..xp..'', 'success')
Citizen.Wait(10000)
notification('Total Jobs Completed: '..xp..'', 'success')
if xp <= 50 then 
notification('You need 50 EXP To Achieve Level 2 So far You have '..xp..'', 'success')
elseif xp <= 150 then 
    notification('You need 300 EXP To Achieve Level 3 So far You have '..xp..'', 'success')   
    end
end)
end)

RegisterNetEvent('Surge:jobs:doStartWelding') -- starts job for client
AddEventHandler('Surge:jobs:doStartWelding', function()
   local zone   = WeldingAreas[WeldingLocations]
    local coords = GetEntityCoords(PlayerPedId())
    if not hasFoundYard then
        notification('You need to use the Welding job sheet to find a job.', 'error')
    else
        if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < 10 then
			if not IsPedSittingInAnyVehicle(PlayerPedId()) then
				doAnim()
				exports['mythic_progbar']:Progress({
					name = "do_Welding",
					duration = 20000,
					label = "Welding in Progress...",
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
						TriggerServerEvent('Surge:doRewardWelder', payOutAmount)
						if WeldingBlips['WeldingLocations'] ~= nil then
							RemoveBlip(WeldingBlips['WeldingLocations'])
							WeldingBlips['WeldingLocations'] = nil
                           TriggerEvent('Surge:jobs:notifyjobdone')
						end
					else
						notification('Seems you stopped working. Use your Welding job item to start another job', 'success')

					end
				end)
				hasFoundYard = false
    		else
    			notification('You must exit vehicle before using the Welding tools', 'error')
    		end
        else
            notification('You need to be abit closer to use the Welding tools', 'error')
        end
    end
end)