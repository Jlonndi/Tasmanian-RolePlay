local display = false
local states = {} -- stores positions
local togglePanel = true
local group = {} -- stores group information
ESX = nil
local idPlayers = 0
local namePlayers = '' -- nil until server talks to client
local players = {} -- stores player data
states.frozen = false
states.frozenPos = nil -- stores admin position for when unspectate

Citizen.CreateThread(function()
	while ESX == nil do
	    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	    Citizen.Wait(0)
	end
	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('trp_administration:SetGroup')
AddEventHandler('trp_administration:SetGroup', function(g)
	group = g
end)

RegisterNetEvent('trp_admin:playSound')
AddEventHandler('trp_admin:playSound', function()
	PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
end)

isOnDuty = false

RegisterNetEvent('trp_admin:isAdminOnDuty')
AddEventHandler('trp_admin:isAdminOnDuty', function(val)
	isOnDuty = val
end)

RegisterNetEvent('snipes_admin:sendticket')
AddEventHandler('snipes_admin:sendticket', function(ticketData, IDoftheguy, PlayerNameCock, IdentSV)
  SendNUIMessage({
    type = "ticketdata",
    message = ticketData.message, -- report message
    name = PlayerNameCock, --ingame name
    source = IDoftheguy, -- source id big pp
    identifier = IdentSV -- steamID lmao
  })
  
  ESX.TriggerServerCallback('trp:core:isperm', function(aceperm)
	if aceperm then
		TriggerEvent("pNotify:SendNotification",{
			text = "<h2>Admin Notification</h2>" .. "<h1>TICKET:</h1>" .. "<p>Somebody has submitted a support ticket, press insert to open the admin panel.</p>",
			type = "success",
			timeout = (17000),
			layout = "centerLeft",
			queue = "global"
		})
	end
	end)
end)

RegisterNetEvent('snipes_admin:closeticketglobal')
AddEventHandler('snipes_admin:closeticketglobal', function(ticketID)
  SendNUIMessage({
    type = "closeticket",
    playerid = ticketID
  })
end)

RegisterNetEvent('snipes_admin:claimticketglobal')
AddEventHandler('snipes_admin:claimticketglobal', function(ticketID, adminClaimer, adminName)
  SendNUIMessage({
    type = "claimticket",
		admin = adminClaimer,
		adminname = adminName,
    playerid = ticketID
  })
end)



Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustReleased(1, 121) and group ~= "user" then
		    if togglePanel then
					TriggerServerEvent('snipes_admin:opengroupvalidation')	
					togglePanel = false
		    else
		        closeAdminPanel()
			    players = {} -- stores player data
		        togglePanel = true
		    end
    	end
		if IsControlJustReleased(1, 56) or IsDisabledControlJustReleased(1, 56) then
			if isOnDuty then
				if (PlayerData ~= nil) and (PlayerData.stafflevel > 0) then
					TriggerEvent("trp_admin:doNoclip")
				end
			end
		end
	end
end)

RegisterCommand("rd", function()
  	closeAdminPanel()
 	players = {} -- stores player data
	NetworkSetInSpectatorMode(false, 0)
	DoScreenFadeIn(500)
end)

RegisterNUICallback('closereportpanel', function(data, cb)
  	closeAdminPanel()
  	players = {} -- stores player data
	Citizen.Wait(100)
	TransitionFromBlurred(100.0)
  	cb('ok')
end)

RegisterNUICallback('submitreport', function(data, cb)
	reportData = {
		message = data.report
	}
	TriggerEvent("pNotify:SendNotification",{
    text = "<h2>Admin Notification</h2>" .. "<h1>Reported:</h1>" .. "<p>You have submitted a report, a staff member will be with you shortly if available.</p>",
		type = "success",
		timeout = (17000),
		layout = "centerLeft",
		queue = "global"
  })
  TriggerServerEvent("snipes_admin:openticket", reportData)
  cb('ok')
end)

RegisterNUICallback('closedticket', function(data, cb)
	TriggerServerEvent('snipes_admin:closereportticket', data.userid)
  cb('ok')
end)

RegisterNUICallback('claimticket', function(data, cb)
	TriggerServerEvent('snipes_admin:claimreportticket', data.userid, GetPlayerServerId(PlayerId()))
	print(data.userid)
  cb('ok')
end)

local dicks = false

RegisterNUICallback('gototicket', function(data, cb)
	if dicks == false then
		dicks = true
		local ticketPlayer = tonumber(data.userid)
		local ticketPlayerPanel = tonumber(data.ticketID)
		print(data.type)
		TriggerServerEvent('trp_admin:goto_panel', ticketPlayer, 'goto')
		Wait(1000)
		dicks = false
	end
end)

RegisterNUICallback('gototicketPanel', function(data, cb)
	if dicks == false then
		dicks = true
		local ticketPlayer = tonumber(data.userid)
		local ticketPlayerPanel = tonumber(data.ticketID)
		TriggerServerEvent('trp_admin:goto_panel', ticketPlayerPanel, 'goto')
		Wait(1000)
		dicks = false
	end
end)

RegisterNUICallback('bringticket', function(data, cb)
	if dicks == false then
		dicks = true
		local ticketPlayer = tonumber(data.userid)
		print(ticketPlayer)
		TriggerServerEvent('trp_admin:bring_panel', ticketPlayer, 'bring')
		print('bring')
		Wait(1000)
		dicks = false
	end
end)

RegisterNUICallback('bringticketPanel', function(data, cb)
	if dicks == false then
		dicks = true
		local ticketPlayer = tonumber(data.ticketID)
		print(ticketPlayer)
		TriggerServerEvent('trp_admin:bring_panel', ticketPlayer, 'bring')
		print('bring')
		Wait(1000)
		dicks = false
	end
end)

local vegana = false

RegisterNUICallback('spectateticket', function(data, cb)
	local ticketPlayer = tonumber(data.userid)
TriggerServerEvent('trp:requestSpectate', ticketPlayer)
end)

RegisterNUICallback('spectateticketPanel', function(data, cb)

	local ticketPlayer = tonumber(data.ticketID)
TriggerServerEvent('trp:requestSpectate', ticketPlayer)
end)

local cocks = false



RegisterNUICallback('syncticket', function(data, cb)
	local ticketPlayer = tonumber(data.userid)
	local ped = GetPlayerPed(GetPlayerFromServerId(ticketPlayer))
	FreezeEntityPosition(GetEntityCoords(ped), true)
	SetEntityVisible(ped, true)
	SetEntityCollision(ped, true)
	SetPlayerInvincible(ped, false)
	TaskPlayAnim(ped,"mp_heists@keypad@","idle_a",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0, 130)
	Citizen.Wait(10)
	ClearPedTasksImmediately(ped)
  cb('ok')
end)

RegisterNetEvent('trp_admin:teleportUser')
AddEventHandler('trp_admin:teleportUser', function(x, y, z)
	SetEntityCoords(PlayerPedId(), x, y, z)
	states.frozenPos = {x = x, y = y, z = z}
end)

switchAdmin = true

RegisterNUICallback('adminonreportpanel', function(data, cb)
		TriggerEvent('trp-core:adminveston')
		print('ree')
end)

function closeAdminPanel()
  TriggerEvent("snipes_admin:close", true)
  players = {} -- stores player data
  SetNuiFocus(false, false)
  togglePanel = true
end

RegisterNetEvent('snipes_admin:open')
AddEventHandler('snipes_admin:open', function(group)
	TransitionToBlurred(100.0)
print(group)
SetNuiFocus(true, true)
	TriggerEvent('ui:blurHud', true)
	if group > 0 then
        TriggerServerEvent('trp_admin2:checkC')
		SendNUIMessage ({
	    type = "toggleui",
	    display = true
	  })
		SendNUIMessage ({
			type = "adminlogin",
			rank = group,
			admin = GetPlayerServerId(PlayerId())
		})
		Citizen.Wait(400) -- stops fuck ups
		TriggerEvent('snipes_admin:getplayers')
	else
		SendNUIMessage ({
	    type = "toggleui",
	    display = true
	  })
		SendNUIMessage ({
			type = "adminlogin",
			rank = group,
			admin = GetPlayerServerId(PlayerId())
		})
	end
end)

RegisterNetEvent('trp_admin2:checkC')
AddEventHandler('trp_admin2:checkC', function(names, ids)
    idPlayers = ids
    namePlayers = names
	table.insert(players, {id = idPlayers, name = namePlayers})
end)

RegisterNetEvent('snipes_admin:getplayers')
AddEventHandler('snipes_admin:getplayers', function()
		for i,player in ipairs(players) do -- Pulls Infinity Players from SV Event Above
			SendNUIMessage ({
				type = "registerplayers",
				playerId = player.id,
				playerName = player.name
			})
		end
end)

RegisterNetEvent('snipes_admin:sendplayerstopanel')
AddEventHandler('snipes_admin:sendplayerstopanel', function(id, name)
	SendNUIMessage ({
		type = "registerplayers",
		playerId = id,
		playerName = name
	})
end)

RegisterNetEvent('snipes_admin:close')
AddEventHandler('snipes_admin:close', function()
	TriggerEvent('ui:blurHud', false)
	 players = {} -- stores player data
  SendNUIMessage({
    type = "toggleui",
    display = false
  })
end)
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