ESX = nil
local playerdata,recentconnect,recentdisconnect,servername = {},{},{},GetConvar("GetNumberOfPlayers","N/A")

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

local connectedPlayers = {}

ESX.RegisterServerCallback('fg_scoreboard:getConnectedPlayers', function(source, cb)
	cb(connectedPlayers) 
end)

AddEventHandler('esx:playerLoaded', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	--	AddPlayerToScoreboard(xPlayer, true)
end)

AddEventHandler('esx:playerDropped', function(playerId)
	connectedPlayers[playerId] = nil

	--TriggerClientEvent('fg_scoreboard:updateConnectedPlayers', -1, connectedPlayers)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.CreateThread(function()
			Citizen.Wait(1000)
			AddPlayersToScoreboard()
		end)
	end
end)

function AddPlayerToScoreboard(xPlayer, update)
	local playerId = xPlayer.source

	connectedPlayers[playerId] = {}
	connectedPlayers[playerId].ping = GetPlayerPing(playerId)
	connectedPlayers[playerId].id = playerId
	connectedPlayers[playerId].name = xPlayer.getName()
	connectedPlayers[playerId].job = xPlayer.job.name

	if update then
		--TriggerClientEvent('fg_scoreboard:updateConnectedPlayers', -1, connectedPlayers)
	end

	if xPlayer.player.getGroup() == 'user' then
		Citizen.CreateThread(function()
			Citizen.Wait(3000)
			TriggerClientEvent('fg_scoreboard:toggleID', playerId, false)
		end)
	end
end
Citizen.CreateThread(function()
   while true do
    Citizen.Wait(10000) -- wait for clients to load their lazy asses
   --if resource gets restarted, re-setup online players
        AddPlayersToScoreboard()
    end
end)
function AddPlayersToScoreboard()
	local players = ESX.GetPlayers()
	for i=1, #players, 1 do
		local xPlayer = ESX.GetPlayerFromId(players[i])
	--	AddPlayerToScoreboard(xPlayer, false)
    --print(('Players Online: %s/64'):format(#players))
    
	end
	TriggerClientEvent('fg_scoreboard:updateConnectedPlayers', -1, players, players)
end



function isAdmin(xPlayer)
    local admin = false
    local xGroup = xPlayer.getGroup()
    for k,v in ipairs(Config.admin_groups) do
        if v==xGroup then admin = true; break end
    end
    return admin
end

ESX.RegisterServerCallback("el_scoreboard:getPlayerData", function(source,cb)
    cb(playerdata,recentconnect,recentdisconnect)
end)

ESX.RegisterServerCallback("el_scoreboard:getServerName", function(source,cb)
    cb(servername)
end)

ESX.RegisterServerCallback("el_scoreboard:whatsMyGroup", function(source,cb)
    cb(ESX.GetPlayerFromId(source).getGroup())
end)

ESX.RegisterServerCallback("el_scoreboard:bringPlayer", function(source,cb,target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local admin = isAdmin(xPlayer)
    if admin then
        TriggerClientEvent("el_scoreboard:adminBringReq",target,source)
    end
    cb(admin)
end)

ESX.RegisterServerCallback("el_scoreboard:slayPlayer", function(source,cb,target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local admin = isAdmin(xPlayer)
    if admin then
        TriggerClientEvent("el_scoreboard:adminSlayReq",target)
    end
    cb(admin)
end)

ESX.RegisterServerCallback("el_scoreboard:revivePlayer",function(source,cb,target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local admin = isAdmin(xPlayer)
    if admin then
        TriggerClientEvent('tp_ambulancejob:revive', target)
    end
    cb(admin)
end)

ESX.RegisterServerCallback("el_scoreboard:healPlayer",function(source,cb,target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local admin = isAdmin(xPlayer)
    if admin then
        TriggerClientEvent("el_scoreboard:adminHealReq", target)
    end
    cb(admin)
end)

ESX.RegisterServerCallback("el_scoreboard:spectatePlayer", function(source,cb,target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local admin = isAdmin(xPlayer)
    if admin then
        TriggerClientEvent("el_scoreboard:adminSpectateReq",target)
    end
    cb(admin)
end)

AddEventHandler("playerConnecting", function(playername, kickreason, def)
    table.insert(recentconnect,{name=playername,time=os.time()})
end)

AddEventHandler("playerDropped", function(reason)
    table.insert(recentdisconnect,{name=GetPlayerName(source),time=os.time(),reason=reason})
end)

Citizen.CreateThread(function()
    Citizen.Wait(1500) -- wait for clients to load their lazy asses
    for k,v in ipairs(GetPlayers()) do -- if resource gets restarted, re-setup online players
        TriggerClientEvent("esx:playerLoaded", v, ESX.GetPlayerFromId(v))
    end
end)
Config = {
    open_key = 57, -- f9
    peek_key = 27, -- default scoreboard (arrow up/mouse 3)
    peek_delay = 250, -- how long you have to hold the button before the menu shows up (you probably don't need this if your peek key isn't 27, if that's the case, set this to 0)
    connect_history = 15, -- number of connects to keep in the log
    disconnect_history = 15, -- number of disconnects to keep in the log
    admin_groups = {"mod","admin","superadmin"}, -- admin groups
    data_update_interval = 500 -- scoreboard data updating, probably don't touch, there's no reason to
}

Citizen.CreateThread(function()
    while true do
        local newplayerdata = {}
        for k,v in ipairs(GetPlayers()) do
            local xPlayer = ESX.GetPlayerFromId(v)
            if xPlayer then
                table.insert(newplayerdata,{sid=v,ping=GetPlayerPing(v),name=GetPlayerName(v),group=xPlayer.getGroup(),job=xPlayer.getJob().label,stid=xPlayer.identifier})
            end
        end
        playerdata = newplayerdata
        if #recentconnect>=Config.connect_history then
            table.remove(recentconnect,1)
        end
        if #recentdisconnect>=Config.disconnect_history then
            table.remove(recentdisconnect,1)
        end
        Citizen.Wait(500)
    end
end)
