--Surge_landscaping

ESX = nil

-- Config variables
local landscapingBlips          = {}
local LastLocation  = GetGameTimer() - 5 * 60000
local LocationFound   = false
local landscapingZones = {}
local PlayerData = {}
---ESX FUNCTIONS---
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
    if PlayerData.job.name == "landscaper" then
        TriggerServerEvent('Surge:core:landscapegiveitems')
        PlayerData.job = job 
    else
        TriggerServerEvent('Surge:core:removelandscapingitems')
        print('This Is Running')
    end
end)
--END OF ESX FUNCTION--

------Stop players from starting a job if they don't have the required job set.------
RegisterNetEvent('startlandscape')
AddEventHandler('startlandscape', function()
Citizen.Wait(1000) -- waits to avoid flooding the job.list flooding the list may result in items being given to incorrect job values
PlayerData = ESX.GetPlayerData()
if PlayerData.job.name == "landscaper" then
TriggerEvent('Surge:jobs:FindLocation')
else 
    notification('You don\'t Have the required job for this',"error")
end
end)

RegisterNetEvent('landscapeactive')
AddEventHandler('landscapeactive', function()
Citizen.Wait(1000) -- waits to avoid flooding the job.list flooding the list may result in items being given to incorrect job values
PlayerData = ESX.GetPlayerData()
if PlayerData.job.name == "landscaper" then
TriggerEvent('Surge:jobs:doStartLandscaping')
else 
    notification('You don\'t Have the required job for this',"error")
end
end)

RegisterNetEvent('landscapefinish')
AddEventHandler('landscapefinish', function()
Citizen.Wait(1000) -- waits to avoid flooding the job.list flooding the list may result in items being given to incorrect job values
PlayerData = ESX.GetPlayerData()
if PlayerData.job.name == "landscaper" then
    TriggerEvent('Surge:jobs:doCancelLandscaping')
else 
    notification('You don\'t Have the required job for this',"error")
    end
end)


local firstQueryLandscaping = true

RegisterNetEvent('Surge:jobs:FindLocation')
AddEventHandler('Surge:jobs:FindLocation', function()
    local status1 = status2
    local status3 = status4
    if status1 == nil and status3 == nil then
       
        if GetGameTimer() - LastLocation > 2.5 * 60000 then
    		eraseLandscapingLocation()
            if firstQueryLandscaping then
                firstQueryLandscaping = false
                ESX.TriggerServerCallback('Surge:GETLANDSCAPERXP', function(xp)
local landscaperXP = xp
                    if status3 ~= nil then -- workaround

                        landscapingXP = xp
                        if landscapingXP <= 0 then
                            FindLocation(1)
                        elseif landscapingXP >= 3000 and landscapingXP <= 8000 then
                            FindLocation(2)
                        elseif landscapingXP >= 8000 and landscapingXP <= 25000 then
                            FindLocation(3)
                        elseif landscapingXP >= 25000 then
                            FindLocation(4)
                        end
                        notification('The Landscaping depot has given you a new job.', 'success')
                    else
                        FindLocation(1)
                        notification('The Landscaping depot has given you a new job.', 'success')
                    end
                end)
            else
                ESX.TriggerServerCallback('Surge:GETLANDSCAPERXP', function(xp)
                    landscapingXP = xp
                if landscapingXP <= 0 then
                    FindLocation(1)
                elseif landscapingXP >= 3000 and landscapingXP <= 8000 then
                    FindLocation(2)
                elseif landscapingXP >= 8000 and landscapingXP <= 25000 then
                    FindLocation(3)
                elseif landscapingXP >= 25000 then
                    FindLocation(4)
                end
            end)
                notification('The Landscaping depot has given you a new job.', 'success')
           
        end
    		LastLocation = GetGameTimer()
        else
            notification('You have recieved a new job recently. Please wait a bit for another job.', 'error')
        end
    else
        notification('You are in the middle of a job. Please wait until you are done for another job.', 'error')
   
    end
end)

function FindLocation(LandscaperLevel)
    LandscapingLocation = SelectNewLocation(LandscaperLevel)
    local zone = landscapingZones[LandscapingLocation]
    landscapingBlips['LandscapingLocation'] = AddBlipForCoord(zone.Pos.x, zone.Pos.y, zone.Pos.z)
    SetBlipRoute(landscapingBlips['LandscapingLocation'], true)
    LocationFound = true
end

-- Main Core Function
RegisterNetEvent('Surge:jobs:doStartLandscaping') -- starts job for client
AddEventHandler('Surge:jobs:doStartLandscaping', function()
    local zone   = landscapingZones[LandscapingLocation]
    local coords = GetEntityCoords(PlayerPedId())
    if not LocationFound then
        notification('You need to use the landscaping job sheet to find a job.', 'error')
    else
        if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < 10 then
			if not IsPedSittingInAnyVehicle(PlayerPedId()) then
				doAnim()
				exports['mythic_progbar']:Progress({
					name = "do_landscaping",
					duration = 20000,
					label = "Landscaping Please Wait...",
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
						TriggerServerEvent('Surge:doRewardLandscaper', payOutAmount)
						if landscapingBlips['LandscapingLocation'] ~= nil then
							RemoveBlip(landscapingBlips['LandscapingLocation'])
							landscapingBlips['LandscapingLocation'] = nil
                           TriggerEvent('Surge:jobs:notifyjobdone')
						end
					else
						notification('Seems you stopped working. Use your landscaping job item to start another job', 'success')

					end
				end)
				LocationFound = false
    		else
    			notification('You must exit vehicle before using the landscaping tools', 'error')
    		end
        else
            notification('You need to be abit closer to use the landscaping tools', 'error')
        end
    end
end)
-- End of Main Core Function

--Erase the Location which removes blip and cancels job function--
function eraseLandscapingLocation(cancel)
    if landscapingBlips['LandscapingLocation'] ~= nil then
        RemoveBlip(landscapingBlips['LandscapingLocation'])
        landscapingBlips['LandscapingLocation'] = nil
    end
    notification('You Have Signed Out Of Work', 'error')
end
-- End of Cancel function--

--Reset Landscaping command / Stop landscaping command --
RegisterCommand("resetlandscaping", function(source, args)
	TriggerEvent("Surge:jobs:doCancelLandscaping")
end, false)
-- End of reset command -- 

function landscapingReturnStatus()
    return landscapingBlips['LandscapingLocation']
end
--Stop Landscaping Function--
RegisterNetEvent('Surge:jobs:doCancelLandscaping')
AddEventHandler('Surge:jobs:doCancelLandscaping', function()
    eraseLandscapingLocation()
end)
--- End of Stop landscaping function -- 

--Notification Function --
function notification(text, type) -- general notification
		TriggerEvent("pNotify:SendNotification",{
			text = "<h2>Landscaping Notification</h2>"..text.."",
			type = type,
	        timeout = (6000),
	        layout = "centerLeft",
	        queue = "global"
        })
end
-- End of Notification Function-- 

-- Job Finish Function / Exp Reward Function --
RegisterNetEvent('Surge:jobs:notifyjobdone')
AddEventHandler('Surge:jobs:notifyjobdone', function()
    ESX.TriggerServerCallback('Surge:GETLANDSCAPERXP', function(xp)
        print(xp)
notification('You have completed this job your total xp is now '..xp..'', 'success')
Citizen.Wait(10000)
notification('Total Jobs Completed: '..xp..'', 'success')
if xp >= 0 and xp < 3000 then 
notification('You need 3000 EXP To Achieve Level 2 So far You have '..xp..'', 'success')
elseif xp <= 150 then 
    notification('You need 300 EXP To Achieve Level 3 So far You have '..xp..'', 'success')   
    end
end)
end)
-- End of Exp Reward / Finish function --

-- Landscaper Level Function--
function SelectNewLocation(LandscaperLevel)
    if LandscaperLevel == 1 then
        local index = GetRandomIntInRange(1, #lowLevelLandscaping)
        for k,v in pairs(landscapingZones) do
            if v.Pos.x == lowLevelLandscaping[index].x and v.Pos.y == lowLevelLandscaping[index].y and v.Pos.z == lowLevelLandscaping[index].z then
                return k
            end
        end
    elseif LandscaperLevel == 2 then
        local index = GetRandomIntInRange(1, #MediumLevelLandscaping)
        for k,v in pairs(landscapingZones) do
            if v.Pos.x == MediumLevelLandscaping[index].x and v.Pos.y == MediumLevelLandscaping[index].y and v.Pos.z == MediumLevelLandscaping[index].z then
                return k
            end
        end
    elseif LandscaperLevel == 3 then
        local index = GetRandomIntInRange(1, #HighLevelLandscaping)
        for k,v in pairs(landscapingZones) do
            if v.Pos.x == HighLevelLandscaping[index].x and v.Pos.y == HighLevelLandscaping[index].y and v.Pos.z == HighLevelLandscaping[index].z then
                return k
            end
        end
    elseif LandscaperLevel == 4 then
        local index = GetRandomIntInRange(1, #BossLocation)
        for k,v in pairs(landscapingZones) do
            if v.Pos.x == BossLocation[index].x and v.Pos.y == BossLocation[index].y and v.Pos.z == BossLocation[index].z then
                return k
            end
        end
    else
        local index = GetRandomIntInRange(1, #lowLevelLandscaping)
        for k,v in pairs(landscapingZones) do
            if v.Pos.x == lowLevelLandscaping[index].x and v.Pos.y == lowLevelLandscaping[index].y and v.Pos.z == lowLevelLandscaping[index].z then
                return k
            end
        end
        print("This is broken")
    end
end
-- End of Landscaper Level Function -- 

--Landscaping Level Location Function --
lowLevelLandscaping = {
    { [ 'x' ] = 	 -1809.49	, [ 'y' ] = 	-366.22  , [ 'z' ] = 	49.24	},
    { [ 'x' ] = 	 1850.78	, [ 'y' ] = 	2581.08  , [ 'z' ] = 	45.67	},
    { [ 'x' ] = 	 172.76	    , [ 'y' ] = 	3091.15  , [ 'z' ] = 	43.04	},
    { [ 'x' ] = 	 2350.13	, [ 'y' ] = 	4877.56  , [ 'z' ] = 	41.82	},
    { [ 'x' ] = 	 42.49   	, [ 'y' ] = 	3708.46  , [ 'z' ] = 	39.74	},
    { [ 'x' ] = 	 3317.49	, [ 'y' ] = 	5167.65  , [ 'z' ] = 	18.42	},
    { [ 'x' ] = 	 -1164.155	, [ 'y' ] = 	4925.60  , [ 'z' ] = 	222.93	}, -- original end point remove all below later
    { [ 'x' ] = 	 -3087.293	, [ 'y' ] = 	353.94   , [ 'z' ] = 	7.47	},
    { [ 'x' ] = 	 -3160.84	, [ 'y' ] = 	1312.37	 , [ 'z' ] = 	16.28	},
    { [ 'x' ] = 	 -1937.49	, [ 'y' ] = 	1825.27  , [ 'z' ] = 	170.61	},
    { [ 'x' ] = 	 -2197.07	, [ 'y' ] = 	4299.52	 , [ 'z' ] = 	48.48	},
    { [ 'x' ] = 	 -1580.34	, [ 'y' ] = 	5170.90	 , [ 'z' ] = 	19.55	},
    { [ 'x' ] = 	 -731.21	, [ 'y' ] = 	5579.95 , [ 'z' ] = 	36.22	},
    { [ 'x' ] = 	 -30.096	, [ 'y' ] = 	6634.62	 , [ 'z' ] = 	30.88	},
    { [ 'x' ] = 	 1719.37	, [ 'y' ] = 	6420.88  , [ 'z' ] = 	33.48	},
    { [ 'x' ] = 	 -1987.77	, [ 'y' ] = 	652.60	, [ 'z' ] = 	122.53	},
    { [ 'x' ] = 	 -1362.20	, [ 'y' ] = 	282.13	, [ 'z' ] = 	64.09	},
    { [ 'x' ] = 	 -561.455	, [ 'y' ] = 	574.191	, [ 'z' ] = 	112.99	},
    { [ 'x' ] = 	 290.798	, [ 'y' ] = 	515.698	, [ 'z' ] = 	150.49	},
    { [ 'x' ] = 	 -785.95	, [ 'y' ] = 	160.62	, [ 'z' ] = 	68.927	},
    { [ 'x' ] = 	 -1874.43	, [ 'y' ] = 	-611.18 , [ 'z' ] = 	11.873	},
    { [ 'x' ] = 	-1355.57	, [ 'y' ] =    -1472.81 , [ 'z' ] = 	5.679	},
    { [ 'x' ] = 	 -1017.92	, [ 'y' ] = 	-916.97	, [ 'z' ] = 	2.229	}
}
MediumLevelLandscaping = {
    { [ 'x' ] = 	 -3087.293	, [ 'y' ] = 	353.94   , [ 'z' ] = 	7.47	},
    { [ 'x' ] = 	 -3160.84	, [ 'y' ] = 	1312.37	 , [ 'z' ] = 	16.28	},
    { [ 'x' ] = 	 -1937.49	, [ 'y' ] = 	1825.27  , [ 'z' ] = 	170.61	},
    { [ 'x' ] = 	 -2197.07	, [ 'y' ] = 	4299.52	 , [ 'z' ] = 	48.48	},
    { [ 'x' ] = 	 -1580.34	, [ 'y' ] = 	5170.90	 , [ 'z' ] = 	19.55	},
    { [ 'x' ] = 	 -731.21	, [ 'y' ] = 	5579.95 , [ 'z' ] = 	36.22	},
    { [ 'x' ] = 	 -30.096	, [ 'y' ] = 	6634.62	 , [ 'z' ] = 	30.88	},
    { [ 'x' ] = 	 1719.37	, [ 'y' ] = 	6420.88  , [ 'z' ] = 	33.48	}
}
HighLevelLandscaping = {
    { [ 'x' ] = 	 -1987.77	, [ 'y' ] = 	652.60	, [ 'z' ] = 	122.53	},
    { [ 'x' ] = 	 -1362.20	, [ 'y' ] = 	282.13	, [ 'z' ] = 	64.09	},
    { [ 'x' ] = 	 -561.455	, [ 'y' ] = 	574.191	, [ 'z' ] = 	112.99	},
    { [ 'x' ] = 	 290.798	, [ 'y' ] = 	515.698	, [ 'z' ] = 	150.49	},
    { [ 'x' ] = 	 -785.95	, [ 'y' ] = 	160.62	, [ 'z' ] = 	68.927	},
    { [ 'x' ] = 	 -1874.43	, [ 'y' ] = 	-611.18 , [ 'z' ] = 	11.873	},
    { [ 'x' ] = 	-1355.57	, [ 'y' ] =    -1472.81 , [ 'z' ] = 	5.679	},
    { [ 'x' ] = 	 -1017.92	, [ 'y' ] = 	-916.97	, [ 'z' ] = 	2.229	}
}
BossLocation = {
    { [ 'x' ] = 	 -1079.54	, [ 'y' ] = 	13.706	, [ 'z' ] = 	50.776	},
    { [ 'x' ] = 	 -419.037	, [ 'y' ] = 	1126.62	, [ 'z' ] = 	325.90	},
    { [ 'x' ] = 	 243.86 	, [ 'y' ] = 	1112.74	, [ 'z' ] = 	220.72	},
    { [ 'x' ] = 	 1848.26	, [ 'y' ] = 	2615.82 , [ 'z' ] = 	45.65	},
    { [ 'x' ] = 	 3526.34	, [ 'y' ] = 	3728.57 , [ 'z' ] = 	36.44	},
    { [ 'x' ] = 	 -2783.72	, [ 'y' ] = 	1447.37	, [ 'z' ] = 	100.86	},
    { [ 'x' ] = 	 -523.466	, [ 'y' ] = 	-240.58 , [ 'z' ] = 	36.07	},
    { [ 'x' ] = 	 -60.507	, [ 'y' ] = 	-900.58	, [ 'z' ] = 	41.573	}
} 
-- End of Landscaping Level Location Function --

--- Landscaping Blip Function---
    for i=1, #lowLevelLandscaping, 1 do
    landscapingZones['lowLevelLandscaping' .. i] = {
        Pos   = lowLevelLandscaping[i],
        Size  = {x = 1.5, y = 1.5, z = 1.0},
        Color = {r = 204, g = 204, b = 0},
        Type  = -1
    }

end
    for i=1, #MediumLevelLandscaping, 1 do
    landscapingZones['MediumLevelLandscaping' .. i] = {
        Pos   = MediumLevelLandscaping[i],
        Size  = {x = 1.5, y = 1.5, z = 1.0},
        Color = {r = 204, g = 204, b = 0},
        Type  = -1
    }

end
    for i=1, #HighLevelLandscaping, 1 do
    landscapingZones['HighLevelLandscaping' .. i] = {
        Pos   = HighLevelLandscaping[i],
        Size  = {x = 1.5, y = 1.5, z = 1.0},
        Color = {r = 204, g = 204, b = 0},
        Type  = -1
    }
end
    for i=1, #BossLocation, 1 do
    landscapingZones['BossLocation' .. i] = {
        Pos   = BossLocation[i],
        Size  = {x = 1.5, y = 1.5, z = 1.0},
        Color = {r = 204, g = 204, b = 0},
        Type  = -1
   }
end
-- End of landscaping Blip Function --

--Landscaping Animation Function--
function doAnim()
	Citizen.CreateThread(function()
        val = math.random(1,3)
        if val == 1 then
            TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GARDENER_LEAF_BLOWER", 0, true)
        elseif val == 2 then
            TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GARDENER_PLANT", 0, true)
        elseif val == 3 then 
            TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CONST_DRILL", 0, true)
        end
		Citizen.Wait(20000)
		ClearPedTasks(PlayerPedId())
	end)
end
--End of Landscaping Animation Function--
