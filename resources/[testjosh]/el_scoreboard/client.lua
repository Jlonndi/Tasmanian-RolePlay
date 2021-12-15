ESX = nil
local open, peek, mygroup = false, false, "user"

function updateNuiData()
	ESX.TriggerServerCallback("el_scoreboard:getPlayerData", function(a,b,c)
		SendNuiMessage(json.encode({type="update",data={pd=a,con=b,disc=c},mygroup=mygroup}))
	end)
end

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('fg_scoreboard:updateConnectedPlayers')
AddEventHandler('fg_scoreboard:updateConnectedPlayers', function(players)
	cocks = ('Players Online: %s/128'):format(#players)
	SendNuiMessage(json.encode({type="setup",pc=cocks}))
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.TriggerServerCallback("el_scoreboard:getServerName", function(sn)
		SendNuiMessage(json.encode({type="setup",pn=GetPlayerName(PlayerId()),sid=xPlayer.identifier,sn=sn}))
end)
    ESX.TriggerServerCallback("el_scoreboard:whatsMyGroup", function(mg)
        mygroup=mg
    end)
	updateNuiData()
end)

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(5000)
		if open or peek then
			updateNuiData()
		end
	end
end)

RegisterNetEvent("el_scoreboard:adminBringReq")
AddEventHandler("el_scoreboard:adminBringReq", function(target)
	ESX.Game.Teleport(GetPlayerPed(-1),GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target))))
end)

RegisterNetEvent("el_scoreboard:adminSlayReq")
AddEventHandler("el_scoreboard:adminSlayReq", function()
	isFrozen = not isFrozen
end)

Citizen.CreateThread(function()
    while true do
        FreezeEntityPosition(GetPlayerPed(-1), isFrozen)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent("el_scoreboard:adminSpectateReq")
AddEventHandler("el_scoreboard:adminSpectateReq", function()
local Spectating      = {}
local InSpectatorMode = false
local TargetSpectate  = nil
local LastPosition    = nil
local polarAngleDeg   = 0;
local azimuthAngleDeg = 90;
local radius          = -3.5;
local cam             = nil
	if InSpectatorMode and target == -1 then
		resetNormalCamera()
	end
	if target ~= -1 then
		spectate(target)
	end
end)

RegisterNetEvent("el_scoreboard:adminHealReq")
AddEventHandler("el_scoreboard:adminHealReq", function()
	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'thirst', 1000000)
	local ped = GetPlayerPed(-1)
	SetEntityHealth(ped, GetEntityMaxHealth(ped))
end)

RegisterNUICallback("toggle", function(data,cb) SetNuiFocus(data, data); open = data end)

RegisterNUICallback("admin-ctx", function(data,cb)
	local action = data.action -- string
	local target = data.target -- player server id (string)
	local args = data.args -- text input from user (can be null if input isn't needed, string)
	if action=="warn" then
		ESX.TriggerServerCallback("el_bwh:warn",function(success)
			if success then ESX.ShowNotification("~g~Successfully warned player") else ESX.ShowNotification("~r~Something went wrong") end
		end, target, args, false)
	elseif action=="kick" then
		ESX.TriggerServerCallback("el_scoreboard:kick",function(success)
		end, target)
	elseif action=="goto" then
		--ESX.Game.Teleport(GetPlayerPed(-1),GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target))))
		TriggerServerEvent('trp_admin:rep_panel', target, target)
	elseif action=="bring" then
		--ESX.TriggerServerCallback("el_scoreboard:bringPlayer", function(success)
		--end, target)
		TriggerServerEvent('trp_admin:bring_panel', target, target)
	elseif action=="slay" then
		ESX.TriggerServerCallback("el_scoreboard:slayPlayer", function(success)
		end, target)
	elseif action=="heal" then
		--ESX.TriggerServerCallback("el_scoreboard:healPlayer", function(success)
		--end, target)
	elseif action=="spectate" then
		--ESX.TriggerServerCallback("el_scoreboard:spectate", function(success)
		--end, target)
		TriggerServerEvent('trp_admin:quick', target, 'spectate')
	elseif action=="revive" then
		--ESX.TriggerServerCallback("el_scoreboard:revivePlayer", function(success)
		--end, target)
		TriggerServerEvent('trp_admin:quick', target, 'revive')
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(0, 178) and not peek then
			open = not open
			SendNuiMessage(json.encode({type="toggle",state=open}))
			SetNuiFocus(open, open)
			if open then
				updateNuiData()
			end
		end
	end
end)

