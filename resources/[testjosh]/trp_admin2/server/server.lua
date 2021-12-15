
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('trp_admin2:checkC')
AddEventHandler('trp_admin2:checkC',function()
	local xPlayers = ESX.GetPlayers()
	for i = 1, #xPlayers, 1 do
		local thePlayer = GetPlayerName(xPlayers[i])
		TriggerClientEvent('trp_admin2:checkC',source, thePlayer,xPlayers[i])
	end
end)

RegisterNetEvent('snipes_admin:opengroupvalidation')
AddEventHandler('snipes_admin:opengroupvalidation',function()
	local xPlayers = ESX.GetPlayers()
	if IsPlayerAceAllowed(source, "trp_adminpanel") then
		TriggerClientEvent('snipes_admin:open',source, 1)
        TriggerClientEvent('trp_administration:SetGroup',source, 1)
	
	end
end)

RegisterServerEvent('trp_admin:bring_panel')
AddEventHandler('trp_admin:bring_panel', function(id, type)
	    local ids = source
	    local idped = GetPlayerPed(ids)
	    local idcoords = GetEntityCoords(idped)
		if IsPlayerAceAllowed(source, "trp_adminpanel") then
	    TriggerClientEvent('trp_admin:teleportUser', id, idcoords.x, idcoords.y, idcoords.z) 	
		else
			DCLOGTIPRAT(source, 'Bring Panel Exploit, FiddleTriedToDiddleBring')
		end
end)

ESX.RegisterServerCallback('trp:core:isperm', function(source, cb)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	if IsPlayerAceAllowed(source, "trp_adminpanel") then
		Penis = true
        cb(Penis) -- Callback
    else
		Penis = false
		cb(Penis)
	end	
end)

RegisterServerEvent('trp_admin:goto_panel')
AddEventHandler('trp_admin:goto_panel', function(id, type)
	    local ids = id
	    local idped = GetPlayerPed(ids)
	    local idcoords = GetEntityCoords(idped)
		if IsPlayerAceAllowed(source, "trp_adminpanel") then
	    TriggerClientEvent('trp_admin:teleportUser', source, idcoords.x, idcoords.y, idcoords.z) 
		else
			DCLOGTIPRAT(source, 'Goto Panel Exploit, FiddleTriedToDiddleGoto')
		end	
end)

RegisterServerEvent("trp:requestSpectate") -- messy I know but works in onesync infinity
AddEventHandler('trp:requestSpectate', function(playerId)
	local Source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local ICanSeeHim = GetEntityCoords(GetPlayerPed(playerId))
		TriggerClientEvent("trp:requestSpectate", source, playerId, ICanSeeHim)
		print('spectate')
	end)
end)

RegisterServerEvent('snipes_admin:openticket')
AddEventHandler('snipes_admin:openticket', function(reportdata)
local _source = source
local fucker = GetPlayerName(_source) or 'unknown'
local identifier = GetPlayerIdentifiers(_source)[1]
TriggerClientEvent('snipes_admin:sendticket', -1, reportdata, _source, fucker, identifier)
end)

RegisterServerEvent('snipes_admin:claimreportticket')
AddEventHandler('snipes_admin:claimreportticket', function(data1, data2)
	local _source = source
local SteamNameLOL = GetPlayerName(_source) or 'unknown'
local identifier = GetPlayerIdentifiers(_source)[1]
	if IsPlayerAceAllowed(source, "trp_adminpanel") then
TriggerClientEvent('snipes_admin:claimticketglobal', -1, data1, data2, SteamNameLOL)
	end
end)

RegisterServerEvent('snipes_admin:closereportticket')
AddEventHandler('snipes_admin:closereportticket', function(ticketid)
	if IsPlayerAceAllowed(source, "trp_adminpanel") then
TriggerClientEvent('snipes_admin:closeticketglobal', -1, ticketid)
	end
end)

RegisterCommand("coords", function(source, args, rawCommand)
	if IsPlayerAceAllowed(source, "trp_adminpanel") then
		TriggerClientEvent('TRP:COORDS', source)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You don\'t have permission to do this and this was logged.', style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
	end
end, false)

RegisterServerEvent('es_camera:requestSpectating')
AddEventHandler('es_camera:requestSpectating', function()
	TriggerClientEvent('es_camera:onSpectate', source, Spectating)
end)