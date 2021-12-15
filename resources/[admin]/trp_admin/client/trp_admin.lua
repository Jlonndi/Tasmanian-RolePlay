local group = {} -- stores group information
local states = {} -- stores positions
local idPlayers = 0
local namePlayers = '' -- nil until server talks to client
local players = {} -- stores player data
states.frozen = false
states.frozenPos = nil -- stores admin position for when unspectate
ESX = nil
print(group)
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('trp_admin:checkC')
AddEventHandler('trp_admin:checkC', function(names, ids)
    idPlayers = ids
    namePlayers = names
	table.insert(players, {id = idPlayers, name = namePlayers})
	print(players)
end)

local saPACZnwHt3BvqCTp2EwdBWzDQ5d = false -- brings up panel when true

RegisterCommand("trp_admin",function()
	ESX.TriggerServerCallback('trp:core:isperm', function(aceperm)
		if aceperm then
		TriggerServerEvent('trp_admin:checkS') -- populates table
		Wait(1000) -- needs to be 1 second
		SetNuiFocus(true, true)
		SendNUIMessage({type = 'open', players = players})
	end
end)
end,false)


RegisterKeyMapping('trp_admin', 'Admin Panel', 'keyboard', 'home')

RegisterNetEvent('trp:tpm')
AddEventHandler('trp:tpm', function()
    local WaypointHandle = GetFirstBlipInfoId(8)
    if DoesBlipExist(WaypointHandle) then
        local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)
        for height = 1, 1000 do
            SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)    
            local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)
            if foundGround then
                SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
                break
            end
            Citizen.Wait(5)
        end
        ESX.ShowNotification("<p>Teleported.</p>")
    else
        ESX.ShowNotification("<p>Please place your waypoint.</p>")
    end
end)

isOnDuty = false

RegisterNetEvent("trp-core:adminveston")
AddEventHandler("trp-core:adminveston", function(toggleAdmin)
    if (isOnDuty == true) then TriggerEvent("trp-core:adminvestoff") return end
    isOnDuty = true TriggerEvent('isonduty') notification('success', '<p>You Are Now On-Duty</p>')
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
		ESX.TriggerServerCallback('trp:core:steamidentifier', function(steam)
			if skin.sex == 1 then
				SetPedComponentVariation(playerPed, 9, 25, 6)-- support vest female
		    else
				SetPedComponentVariation(playerPed, 9, 25, 6)-- support vest male
		    end 
        end)
    end)
end)

RegisterNetEvent("trp-core:adminvestoff")
AddEventHandler("trp-core:adminvestoff", function(toggleAdmin)
	local playerPed = PlayerPedId()
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(id)
	if (isOnDuty == false) then
		TriggerEvent("trp-core:adminveston")
		return
		end
		notification('success', '<p>You Are Now Off-Duty')
		TriggerEvent('isOffDuty')
        isOnDuty = false
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        Citizen.Wait(0)
	    SetPedComponentVariation(playerPed, 9, 0, 0)
    end)
end)


RegisterNetEvent('esx_repairkit:adminrepair')
AddEventHandler('esx_repairkit:adminrepair', function()
	local playerPed = PlayerPedId()
		if (isOnDuty == true) then --check duty
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		SetVehicleEngineHealth(vehicle, 1000)
		SetVehicleEngineOn( vehicle, true, true )
		SetVehicleFixed(vehicle)
		exports['mythic_notify']:SendAlert('inform', 'Your vehicle has been fixed!')
	else
		exports['mythic_notify']:SendAlert('error', 'You are not on duty')
	end
end)

RegisterNetEvent('trp_admin:setGroup')
AddEventHandler('trp_admin:setGroup', function(g)
	group = g -- checks group
end)

RegisterNUICallback('close', function(data, cb)
	SetNuiFocus(false)
	players = {} -- stores players
end)

RegisterNetEvent("trp:spectaterequest")
AddEventHandler("trp:spectaterequest", function(id)
TriggerServerEvent("trp:requestSpectate", id)
end)

RegisterNUICallback('quick', function(data, cb)
	if data.type == "veston" or data.type == "vestoff" or data.type == "slap_all" then
		TriggerServerEvent('trp_admin:all', data.type)
		--TriggerServerEvent('trp-AdminPanel:NubsBigDickSlaySystem', data.type) -- Logs to Armory DC not needed maybe fix webhook? 
	else
		if (isOnDuty == false) then
			exports['mythic_notify']:SendAlert('error', 'You must be on duty to do this')
		elseif (isOnDuty == true) then
			print(data.type)
			print(data.id)
		TriggerServerEvent('trp_admin:quick', data.id, data.type)
	end
end
end)
RegisterNUICallback('rep_panel', function(data, cb)
			print(data.type)
			print(data.id)
		TriggerServerEvent('trp_admin:rep_panel', data.id, data.type)
end)
RegisterNUICallback('bring_panel', function(data, cb)
	print(data.type)
	print(data.id)
TriggerServerEvent('trp_admin:bring_panel', data.id, data.type)
end)
RegisterNUICallback('set', function(data, cb)
	TriggerServerEvent('trp_admin:set', data.type, data.user, data.param)
end)

RegisterNetEvent('trp_admin:Admin_BringC')
AddEventHandler('trp_admin:Admin_BringC', function(plyCoords)
	SetEntityCoords(plyPed, plyCoords)
end)

local noclip = false
RegisterNetEvent('trp_admin:quick')
AddEventHandler('trp_admin:quick', function(t, target)
	if t == "slay" then SetEntityHealth(PlayerPedId(), 0) TriggerServerEvent('trp-armoury:sendToDiscord', 'slay') end
	if t == "spectate" then TriggerServerEvent("trp:requestSpectate", target) end
	if t == "goto" then SetEntityCoords(PlayerPedId(), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))) end
	if t == "bring" then TriggerEvent('trp_admin:Admin_BringC' ,GetPlayerFromServerId(target)) end
	if t == "slap" then ApplyForceToEntity(PlayerPedId(), 1, 9500.0, 3.0, 7100.0, 1.0, 0.0, 0.0, 1, false, true, false, false) end
	if t == "screenshot" then --[[TriggerEvent('trp:Screenshot', GetPlayerFromServerId(target))]] print(random.math(1-100)) end
	if t == "freeze" then
		local player = PlayerId()
        local ped = PlayerPedId()
        states.frozen = not states.frozen
		states.frozenPos = GetEntityCoords(ped, false)
		if not state then
			if not IsEntityVisible(ped) then
				SetEntityVisible(ped, true)
			end
			if not IsPedInAnyVehicle(ped) then
				SetEntityCollision(ped, true)
			end
			FreezeEntityPosition(ped, false)
			SetPlayerInvincible(player, false)
		else
			SetEntityCollision(ped, false)
			FreezeEntityPosition(ped, true)
			SetPlayerInvincible(player, true)
			if not IsPedFatallyInjured(ped) then
				ClearPedTasksImmediately(ped)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if(states.frozen)then
			ClearPedTasksImmediately(PlayerPedId())
			SetEntityCoords(PlayerPedId(), states.frozenPos)
		end
	end
end)
--local heading = 0 not needed?
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if (noclip) then -- checks if true 
			ToggleNoClipMode()
		end
	end
end)

RegisterNetEvent('trp_admin:spawnVehicle')
AddEventHandler('trp_admin:spawnVehicle', function(v)
	local carid = GetHashKey(v)
	local playerPed = PlayerPedId()
	if playerPed and playerPed ~= -1 then
		RequestModel(carid)
		while not HasModelLoaded(carid) do
				Citizen.Wait(0)
		end
		local playerCoords = GetEntityCoords(playerPed)
		veh = CreateVehicle(carid, playerCoords, 0.0, true, false)
		SetVehicleAsNoLongerNeeded(veh)
		TaskWarpPedIntoVehicle(playerPed, veh, -1)
	end
end)

RegisterNetEvent('trp_admin:freezePlayer')
AddEventHandler("trp_admin:freezePlayer", function(state)
	local player = PlayerId()
	local ped = PlayerPedId()

	states.frozen = state
	states.frozenPos = GetEntityCoords(ped, false)
	if not state then
		if not IsEntityVisible(ped) then
			SetEntityVisible(ped, true)
		end
		if not IsPedInAnyVehicle(ped) then
			SetEntityCollision(ped, true)
		end
		FreezeEntityPosition(ped, false)
		SetPlayerInvincible(player, false)
	else
		SetEntityCollision(ped, false)
		FreezeEntityPosition(ped, true)
		SetPlayerInvincible(player, true)
		if not IsPedFatallyInjured(ped) then
			ClearPedTasksImmediately(ped)
		end
	end
end)

RegisterNetEvent('trp_admin:teleportUser')
AddEventHandler('trp_admin:teleportUser', function(x, y, z)
	SetEntityCoords(PlayerPedId(), x, y, z)
	states.frozenPos = {x = x, y = y, z = z}
end)

RegisterNetEvent('trp_admin:givePosition')
AddEventHandler('trp_admin:givePosition', function()
	local pos = GetEntityCoords(PlayerPedId())
	local string = "{ ['x'] = " .. pos.x .. ", ['y'] = " .. pos.y .. ", ['z'] = " .. pos.z .. " },\n"
	    TriggerServerEvent('trp_admin:givePos', string)
	    TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, 'Position saved to file.')
end)

RegisterNetEvent('trp_admin:kill')
AddEventHandler('trp_admin:kill', function()
	SetEntityHealth(PlayerPedId(), 0)
end)

RegisterNetEvent('trp_admin:heal')
AddEventHandler('trp_admin:heal', function()
	SetEntityHealth(PlayerPedId(), 200)
end)

RegisterNetEvent("trp:noclip")
AddEventHandler("trp:noclip", function(t)
			if group ~= "mod" or "admin" or "superadmin" then
			if (isOnDuty == true) then -- checks adminrole
				ToggleNoClipMode()
				notification('success', '<p>No-Clip Enabled</p>')
				else if (isOnDuty == false) then -- checks adminrole
				notification('error', '<p>You Are Not On-Duty</p>')
		    end
	    end
    end
end)

isDead = false -- default local

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)

AddEventHandler('TRP:Core:isAlive', function()
	isDead = false
end)

secondsUntilKick = 900 --30mins
kickWarning = true
--playerPed = PlayerPedId()
Citizen.CreateThread(function()
    while true do
        Wait(1000)
			if not isDead then
				if not isOnDuty then -- checks admin duty if vest no kickerino
				playerPed = PlayerPedId()
				if playerPed then
					currentPos = GetEntityCoords(playerPed, true)
					if currentPos == prevPos then
							if time > 0 then
								if kickWarning and time == math.ceil(secondsUntilKick / 4) then
									local msg = "KickMessage"
									--TriggerServerEvent("TRP:CORE:LOG", msg, time)
								end
							    time = time - 1
							else
								if not isDead then
								   -- TriggerServerEvent("trp_admin:afkkick") -- runs kick event
                            end
                        end
					else
						time = secondsUntilKick
					end
					prevPos = currentPos
				end
			end
        end
    end
end)

-----------------------------------------------------------------------
-- Admin Notifications Global Client
-----------------------------------------------------------------------

function notification(text, type)
	ESX.TriggerServerCallback("trp:core:identifier", function(steamid)
		TriggerEvent("pNotify:SendNotification",{
			text = "<h2>Admin Notification</h2>" .. steamid .. ""..type.."",
			type = text,
	        timeout = (6000),
	        layout = "centerLeft",
	        queue = "global"
        })
	end)
end

-----------------------------------------------------------------------
-- TRP Forced Screenshots
-----------------------------------------------------------------------

RegisterNetEvent("trp:Screenshot")
AddEventHandler("trp:Screenshot", function(id)
	    local playerid = id
        screenshot = true
        exports['screenshot-basic']:requestScreenshotUpload("http://tassierp.com:3555/upload", 'files[]', function(data2)
        local resp = json.decode(data2)
        TriggerServerEvent("trp:admin:screenshot", resp.files[1].url, id) 
    end)
end)

RegisterNetEvent("trp:ScreenshotAC")
AddEventHandler("trp:ScreenshotAC", function(id, reason)
	    local playerid = id
        screenshot = true
        exports['screenshot-basic']:requestScreenshotUpload("http://tassierp.com:3555/upload", 'files[]', function(data2)
        local resp = json.decode(data2)
        TriggerServerEvent("trp:admin:screenshotAC", resp.files[1].url, id, reason) 
    end)
end)

-----------------------------------------------------------------------
-- TRP Spectate
-----------------------------------------------------------------------

RegisterNetEvent("trp:requestSpectate")
AddEventHandler('trp:requestSpectate', function(playerServerId, ICanSeeHim)
	local localPlayerPed = PlayerPedId()
	if ((not ICanSeeHim) or (ICanSeeHim.z == 0.0)) then ICanSeeHim = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerServerId))) end
	if playerServerId == GetPlayerServerId(PlayerId()) then 
		if oldCoords then
			RequestCollisionAtCoord(oldCoords.x, oldCoords.y, oldCoords.z)
			Wait(500)
			SetEntityCoords(playerPed, oldCoords.x, oldCoords.y, oldCoords.z, 0, 0, 0, false)
			oldCoords=nil
		end
		spectatePlayer(GetPlayerPed(PlayerId()),GetPlayerFromServerId(PlayerId()),GetPlayerName(PlayerId()))
		frozen = false
		return 
	else
		if not oldCoords then
			oldCoords = GetEntityCoords(PlayerPedId())
		end
	end
	SetEntityCoords(localPlayerPed, ICanSeeHim.x, ICanSeeHim.y, ICanSeeHim.z - 10.0, 0, 0, 0, false)
	frozen = true
	local adminPed = localPlayerPed
	local playerId = GetPlayerFromServerId(playerServerId)
	repeat
		Wait(200)
		playerId = GetPlayerFromServerId(playerServerId)
	until ((GetPlayerPed(playerId) > 0) and (playerId ~= -1))
	spectatePlayer(GetPlayerPed(playerId),playerId,GetPlayerName(playerId))
end)

function spectatePlayer(targetPed,target,name)
	local playerPed = PlayerPedId() -- yourself
	enable = true
	if (target == PlayerId() or target == -1) then enable = false end
	if(enable)then
			if targetPed == playerPed then
				Wait(500)
				targetPed = GetPlayerPed(target)
			end
			local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))

			RequestCollisionAtCoord(targetx,targety,targetz)
			NetworkSetInSpectatorMode(true, targetPed)
			SetEntityVisible(playerPed,  false) -- invisble 
			SetEntityCollision(playerPed,  false,  false) -- invisible
			if not RedM then
				print("spectatinguser")
			end
	    else
			if oldCoords then
				RequestCollisionAtCoord(oldCoords.x, oldCoords.y, oldCoords.z)
				Wait(500)
				SetEntityCoords(playerPed, oldCoords.x, oldCoords.y, oldCoords.z, 0, 0, 0, false)
				oldCoords=nil
			end
			    NetworkSetInSpectatorMode(false, targetPed)
			if not RedM then -- CITIZEN NATIVE WHY O WHY
				print("stoppedspectating")
				SetEntityVisible(playerPed,  true) --  not invisble 
			    SetEntityCollision(playerPed,  true,  true) -- not invisible
	    end
			    frozen = false
	end
end

function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(0,1)
end