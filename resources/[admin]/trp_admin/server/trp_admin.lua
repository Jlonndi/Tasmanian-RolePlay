ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent("es:addGroup", "mod", "user", function(group) end)

RegisterServerEvent('trp_admin:all')
AddEventHandler('trp_admin:all', function(type)
	local Source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		TriggerEvent('es:canGroupTarget', user.getGroup(), "mod" or "admin" or "superadmin", function(available)
			if available or user.getGroup() == "mod" or "admin" or "superadmin" then
				if type == "veston" then TriggerClientEvent('trp-core:adminveston', source) end
				if type == "vestoff" then TriggerClientEvent('trp-core:adminvestoff', source) end
				if type == "slap_all" then TriggerClientEvent('trp_admin:quick', -1, 'slap') end
			else
				TriggerClientEvent('chatMessage', Source, "SYSTEM", {255, 0, 0}, "You do not have permission to do this")
			end
		end)
	end)
end)

RegisterServerEvent('trp_admin:rep_panel')
AddEventHandler('trp_admin:rep_panel', function(id, type)
	TriggerEvent('es:getPlayerFromId', source, function(user)
	TriggerEvent('es:getPlayerFromId', id, function(target)
	    local ids = id
	    local idped = GetPlayerPed(ids)
		local idcoords = GetEntityCoords(idped)
		    TriggerEvent('es:canGroupTarget', user.getGroup(), "mod" or "admin" or "superadmin", function(available)
		    TriggerEvent('es:canGroupTarget', user.getGroup(), "mod" or "admin" or "superadmin", function(canTarget)
		if canTarget and available then
	        TriggerClientEvent('trp_admin:teleportUser', source, idcoords.x, idcoords.y, idcoords.z) 	
                    end 
                end)
            end)
        end)
    end)
end)

RegisterServerEvent('trp_admin:bring_panel')
AddEventHandler('trp_admin:bring_panel', function(id, type)
	TriggerEvent('es:getPlayerFromId', source, function(user)
	TriggerEvent('es:getPlayerFromId', id, function(target)
	    local ids = source
	    local idped = GetPlayerPed(ids)
	    local idcoords = GetEntityCoords(idped)
		    TriggerEvent('es:canGroupTarget', user.getGroup(), "mod" or "admin" or "superadmin", function(available)
		    TriggerEvent('es:canGroupTarget', user.getGroup(), "mod" or "admin" or "superadmin", function(canTarget)
	    if canTarget and available then
	        TriggerClientEvent('trp_admin:teleportUser', id, idcoords.x, idcoords.y, idcoords.z) 	
                    end
                end)
            end)
        end)
    end)
end)

RegisterServerEvent('trp_admin:quick')
AddEventHandler('trp_admin:quick', function(id, type)
	local Source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		TriggerEvent('es:getPlayerFromId', id, function(target)
			TriggerEvent('es:canGroupTarget', user.getGroup(), "mod" or "admin" or "superadmin", function(available)
				if available or user.getGroup() == "mod" or "admin" or "superadmin" then
						if type == "slay" then TriggerClientEvent('trp_admin:quick', id, type) end
						if type == "spectate" then TriggerClientEvent('trp:spectaterequest', Source, id) end
						if type == "screenshot" then TriggerClientEvent('trp:Screenshot', id, id) end
						if type == "freeze" then TriggerClientEvent('trp_admin:quick', id, type) end
						if type == "bring" then TriggerClientEvent('trp_admin:teleportUser', target.get('source'), user.getCoords().x, user.getCoords().y, user.getCoords().z) end
						if type == "goto" then TriggerClientEvent('trp_admin:teleportUser', source, target.getCoords().x, target.getCoords().y, target.getCoords().z) end
                        if type == "slay" then TriggerClientEvent('trp_admin:quick', id, type) end
						if type == "revive" then TriggerClientEvent('TRP:AMBULANCEJOB', id) end
						if type == "kick" then print('gay') end		
					else
						if not available then
							TriggerClientEvent('chatMessage', Source, 'SYSTEM', {255, 0, 0}, "Your group can not use this command.")
						else
							TriggerClientEvent('chatMessage', Source, 'SYSTEM', {255, 0, 0}, "Permission denied.")
					end
				end
			end)
		end)
	end)
end)

AddEventHandler('es:playerLoaded', function(Source, user)
	TriggerClientEvent('trp_admin:setGroup', Source, user.getGroup())
end)

RegisterServerEvent('trp_admin:set')
AddEventHandler('trp_admin:set', function(t, USER, GROUP)
	local Source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		TriggerEvent('es:canGroupTarget', user.getGroup(), "admin" or "superadmin", function(available)
			if available then
			if t == "group" then
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Player not found")
				else
					TriggerEvent("es:getAllGroups", function(groups)
						if(groups[GROUP])then
							TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Do this Through DB")
						else
							TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Group not found")
						end
					end)
				end
			elseif t == "level" then
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Player not found")
				else
					GROUP = tonumber(GROUP)
					if(GROUP ~= nil and GROUP > -1)then
						TriggerEvent("es:setPlayerData", USER, "permission_level", GROUP, function(response, success)
							if(true)then
								TriggerClientEvent('chatMessage', -1, "CONSOLE", {0, 0, 0}, "Permission level of ^2" .. GetPlayerName(tonumber(USER)) .. "^0 has been set to ^2 " .. tostring(GROUP))
							end
						end)	
					else
						TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Invalid integer entered")
					end
				end
			elseif t == "kickreason" then -- KICK FUNCTION REPURPOSED
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Player not found")
					
				else
					if(GROUP ~= nil)then
						TriggerEvent('es:getPlayerFromId', USER, function(target)
							DropPlayer(USER, GROUP)
						end)
					else
						TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Invalid reason entered")
					end
				end
			elseif t == "bank" then
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Player not found")
				else
					GROUP = tonumber(GROUP)
					if(GROUP ~= nil and GROUP > -1)then
						TriggerEvent('es:getPlayerFromId', USER, function(target)
							target.setBankBalance(GROUP)
						end)
					else
						TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "Invalid integer entered")
					end
				end
			end
			else
				TriggerClientEvent('chatMessage', source, 'SYSTEM', {255, 0, 0}, "dev required to do this")
			end
		end)
	end)	
end)

AddEventHandler('rconCommand', function(commandName, args)
	if commandName == 'setadmin' then
		if #args ~= 2 then
				RconPrint("Usage: setadmin [user-id] [permission-level]\n")
				CancelEvent()
				return
		end
		if(GetPlayerName(tonumber(args[1])) == nil)then
			RconPrint("Player not ingame\n")
			CancelEvent()
			return
		end
		TriggerEvent("es:setPlayerData", tonumber(args[1]), "permission_level", tonumber(args[2]), function(response, success)
			RconPrint(response)
			if(true)then
				print(args[1] .. " " .. args[2])
				TriggerClientEvent('es:setPlayerDecorator', tonumber(args[1]), 'rank', tonumber(args[2]), true)
				TriggerClientEvent('chatMessage', -1, "CONSOLE", {0, 0, 0}, "Permission level of ^2" .. GetPlayerName(tonumber(args[1])) .. "^0 has been set to ^2 " .. args[2])
			end
		end)
		CancelEvent()
	elseif commandName == 'setgroup' then
		if #args ~= 2 then
				RconPrint("Usage: setgroup [user-id] [group]\n")
				CancelEvent()
				return
		end
		if(GetPlayerName(tonumber(args[1])) == nil)then
			RconPrint("Player not ingame\n")
			CancelEvent()
			return
		end
		TriggerEvent("es:getAllGroups", function(groups)
			if(groups[args[2]])then
				TriggerEvent("es:setPlayerData", tonumber(args[1]), "group", args[2], function(response, success)

					if(true)then
						TriggerClientEvent('es:setPlayerDecorator', tonumber(args[1]), 'group', tonumber(args[2]), true)
						TriggerClientEvent('chatMessage', -1, "CONSOLE", {0, 0, 0}, "Group of ^2^*" .. GetPlayerName(tonumber(args[1])) .. "^r^0 has been set to ^2^*" .. args[2])
					end
				end)
			else
				RconPrint("This group does not exist.\n")
			end
		end)
		CancelEvent()
	elseif commandName == 'giverole' then
		if #args < 2 then
				RconPrint("Usage: giverole [user-id] [role]\n")
				CancelEvent()
				return
		end
		if(GetPlayerName(tonumber(args[1])) == nil)then
			RconPrint("Player not ingame\n")
			CancelEvent()
			return
		end
			TriggerEvent("es:getPlayerFromId", tonumber(args[1]), function(user)
				table.remove(args, 1)
				user.giveRole(table.concat(args, " "))
				TriggerClientEvent("chatMessage", user.get('source'), "SYSTEM", {255, 0, 0}, "You've been given a role: ^2" .. table.concat(args, " "))
			end)
		CancelEvent()
	elseif commandName == 'removerole' then
		if #args < 2 then
				RconPrint("Usage: removerole [user-id] [role]\n")
				CancelEvent()
				return
		end
		if(GetPlayerName(tonumber(args[1])) == nil)then
			RconPrint("Player not ingame\n")
			CancelEvent()
			return
		end
			TriggerEvent("es:getPlayerFromId", tonumber(args[1]), function(user)
				table.remove(args, 1)
				user.removeRole(table.concat(args, " "))
				TriggerClientEvent("chatMessage", user.get('source'), "SYSTEM", {255, 0, 0}, "A role was removed: ^2" .. table.concat(args, " "))
			end)
		CancelEvent()
	elseif commandName == 'setmoney' then
			if #args ~= 2 then
					RconPrint("Usage: setmoney [user-id] [money]\n")
					CancelEvent()
					return
			end
			if(GetPlayerName(tonumber(args[1])) == nil)then
				RconPrint("Player not ingame\n")
				CancelEvent()
				return
			end
			TriggerEvent("es:getPlayerFromId", tonumber(args[1]), function(user)
				if(user)then
					user.setMoney(tonumber(args[2]))
					RconPrint("Money set")
					TriggerClientEvent('chatMessage', tonumber(args[1]), "CONSOLE", {0, 0, 0}, "Your money has been set to: ^2^*$" .. tonumber(args[2]))
				end
			end)
			CancelEvent()
		end
end)

TriggerEvent('es:addCommand', 'admin', function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Level: ^*^2 " .. tostring(user.get('permission_level')))
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Group: ^*^2 " .. user.getGroup())
end, {help = "Shows what admin level you are and what group you're in"})

TriggerEvent('es:addGroupCommand', 'tpm', 'mod', function(source, args, user)
	TriggerClientEvent('trp:tpm', source)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = 'tp to waypoint'})

TriggerEvent('es:addGroupCommand', 'screenshot', "mod", function(source, args, user)
	if args[1] then
		if(GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])
			TriggerEvent("es:getPlayerFromId", player, function(target)
				TriggerClientEvent('trp:Screenshot', args[1], args[1])

				TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Player ^2" .. GetPlayerName(player) .. "^0 has been screenshotted")
			end)
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
		end
	else
		TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end)

TriggerEvent('es:addGroupCommand', 'kick', "mod", function(source, args, user)
	if args[1] then
		if(GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])
			TriggerEvent("es:getPlayerFromId", player, function(target)
				local reason = args
				table.remove(reason, 1)
				if(#reason == 0)then
					TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You Must Type a reason out to kick the player', length = 10000, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
					return
				else
					reason = "Kicked: " .. table.concat(reason, " ")
				end
				DropPlayer(player, reason)
			end)
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
		end
	else
		TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end, {help = "Kick a user with the specified reason or no reason", params = {{name = "userid", help = "The ID of the player"}, {name = "reason", help = "The reason as to why you kick this player"}}})

TriggerEvent('es:addGroupCommand', 'announce', "superadmin", function(source, args, user) -- requires rewrite to log.
	TriggerClientEvent('chatMessage', -1, "Staff Announcement", {255, 0, 0}, "" .. table.concat(args, " "))
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end, {help = "Announce a message to the entire server", params = {{name = "announcement", help = "The message to announce"}}})

local frozen = {}
TriggerEvent('es:addGroupCommand', 'freeze', "mod", function(source, args, user)
	if args[1] then
		if(GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])
			TriggerEvent("es:getPlayerFromId", player, function(target)
				if(frozen[player])then
					frozen[player] = false
				else
					frozen[player] = true
				end
				TriggerClientEvent('trp_admin:freezePlayer', player, frozen[player])
				local state = "unfrozen"
				if(frozen[player])then
					state = "frozen"
				end
				TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Player ^2" .. GetPlayerName(player) .. "^0 has been " .. state)
			end)
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
		end
	else
		TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end, {help = "Freeze or unfreeze a user", params = {{name = "userid", help = "The ID of the player"}}})

TriggerEvent('es:addGroupCommand', 'bring', "mod", function(source, args, user)
	if args[1] then
		if(GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])
			TriggerEvent("es:getPlayerFromId", player, function(target)
				TriggerClientEvent('trp_admin:teleportUser', target.get('source'), user.getCoords().x, user.getCoords().y, user.getCoords().z)
				TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Player ^2" .. GetPlayerName(player) .. "^0 a etait tp")
			end)
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
		end
	else
		TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end, {help = "Teleport a user to you", params = {{name = "userid", help = "The ID of the player"}}})

TriggerEvent('es:addGroupCommand', 'goto', "mod", function(source, args, user)
	if args[1] then
		if(GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])
			TriggerEvent("es:getPlayerFromId", player, function(target)
				if(target)then
					TriggerClientEvent('trp_admin:teleportUser', source, target.getCoords().x, target.getCoords().y, target.getCoords().z)
					TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Teleported to player ^2" .. GetPlayerName(player) .. "")
				end
			end)
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
		end
	else
		TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end, {help = "Teleport to a user", params = {{name = "userid", help = "The ID of the player"}}})

TriggerEvent('es:addGroupCommand', 'slay', "superadmin", function(source, args, user)
	if args[1] then
		if(GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])
			TriggerEvent("es:getPlayerFromId", player, function(target)
				TriggerClientEvent('trp_admin:kill', player)
				TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Player ^2" .. GetPlayerName(player) .. "^0 has been killed.")
			end)
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
		end
	else
		TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end, {help = "Slay a user", params = {{name = "userid", help = "The ID of the player"}}})

TriggerEvent('es:addGroupCommand', 'pos', "mod", function(source, args, user)
	local coords = GetEntityCoords(GetPlayerPed(source))
    TriggerEvent('trp:core:positionlogs', coords, source, args)
end, {help = "Save position to discord"})

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

RegisterNetEvent('trp_admin:checkS')
AddEventHandler('trp_admin:checkS',function()
	local xPlayers = ESX.GetPlayers()
	for i = 1, #xPlayers, 1 do
		local thePlayer = GetPlayerName(xPlayers[i])
		TriggerClientEvent('trp_admin:checkC',source, thePlayer,xPlayers[i])
	end
end)

RegisterNetEvent('trp_admin:afkkick')
AddEventHandler('trp_admin:afkkick',function()
	local _source = source
	local reasonafk = "Kicked For AFK"
	DropPlayer(_source, reasonafk)
end)


RegisterServerEvent("trp:GetInfinityPlayerList")
AddEventHandler("trp:GetInfinityPlayerList", function()
	if IsPlayerAdmin(source) then
		local l = {}
		local players = GetPlayers()

		for i, player in pairs(players) do
			local player = tonumber(player)
			for i, cached in pairs(CachedPlayers) do
				if (cached.id == player) then
					table.insert(l, CachedPlayers[i])
				end
			end
		end
		TriggerClientEvent("trp:GetInfinityPlayerList", source, l) 
	end
end)

RegisterServerEvent("trp:GetPlayerList")
AddEventHandler("trp:GetPlayerList", function()
	if IsPlayerAdmin(source) then
		local l = {}
		local players = GetPlayers()
		for i, player in pairs(players) do
			if CachedPlayers[player] then
				table.insert(l, CachedPlayers[player])
			end
		end
		TriggerClientEvent("trp:GetPlayerList", source, l) 
	end
end)

--[[RegisterServerEvent("trp:requestSpectate") -- messy I know but works in onesync infinity
AddEventHandler('trp:requestSpectate', function(playerId)
	local Source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		TriggerEvent('es:canGroupTarget', user.getGroup(), "mod" or "admin" or "superadmin", function(available)
			if available or user.getGroup() == "mod" or "admin" or "superadmin" then
		local ICanSeeHim = GetEntityCoords(GetPlayerPed(playerId))
		TriggerClientEvent("trp:requestSpectate", source, playerId, ICanSeeHim) -- sends playercoords and ID to admin 
			end
		end)
	end)
end)]]

AnonymousAdmins = {} -- useless shit
CachedPlayers = {} -- stores player data for cached player
function getName(src,anonymousdisabled)
	if (src == 0 or src == "") then
		return "Console"
	else
		if AnonymousAdmins[src] and not anonymousdisabled then
			return GetLocalisedText("anonymous") -- why does this exist?
		elseif CachedPlayers[src] and CachedPlayers[src].name then
			return CachedPlayers[src].name
		elseif (GetPlayerName(src)) then
			return GetPlayerName(src)
		else
			return "Unknown - " .. src
		end
	end
end