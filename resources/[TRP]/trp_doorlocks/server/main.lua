ESX = nil
local doorInfo = {}

Citizen.CreateThread(function()
	local xPlayers = #ESX.GetPlayers()
	local path = GetResourcePath(GetCurrentResourceName())
	path = path:gsub('//', '/')..'/server/states.json'
	local file = io.open(path, 'r')
	if not file or xPlayers == 0 then
		file = io.open(path, 'a')
		for k,v in pairs(Config.DoorList) do
			doorInfo[k] = v.locked
		end
	else
		local data = file:read('*a')
		file:close()
		if #json.decode(data) > #Config.DoorList then -- Config.DoorList contains less doors than states.json, so don't restore states
			return
		elseif #json.decode(data) > 0 then
			for k,v in pairs(json.decode(data)) do
				doorInfo[k] = v
			end
		end
	end
end)

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	local path = GetResourcePath(resourceName)
	path = path:gsub('//', '/')..'/server/states.json'
	local file = io.open(path, 'r+')
	if file and doorInfo then
		local json = json.encode(doorInfo)
		file:write(json)
		file:close()
	end
end)

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('trp_doorlocks:updateState')
AddEventHandler('trp_doorlocks:updateState', function(doorID, locked, src, usedLockpick)
	local playerId = source
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if type(doorID) ~= 'number' then
		print(('trp_doorlocks: %s (%s) didn\'t send a number! (Sent %s)'):format(xPlayer.getName(), xPlayer.identifier, doorID))
		return
	end

	if type(locked) ~= 'boolean' then
		print(('trp_doorlocks: %s (%s) attempted to update invalid state! (Sent %s)'):format(xPlayer.getName(), xPlayer.identifier, locked))
		return
	end

	if not Config.DoorList[doorID] then
		print(('trp_doorlocks: %s (%s) attempted to update invalid door! (Sent %s)'):format(xPlayer.getName(), xPlayer.identifier, doorID))
		return
	end
	
	if not IsAuthorized(xPlayer, Config.DoorList[doorID], doorInfo[doorID], usedLockpick) then
		return
	end

	doorInfo[doorID] = locked
	if not src then TriggerClientEvent('trp_doorlocks:setState', -1, playerId, doorID, locked)
	else TriggerClientEvent('trp_doorlocks:setState', -1, playerId, doorID, locked, src) end

	if Config.DoorList[doorID].autoLock then
		Citizen.SetTimeout(Config.DoorList[doorID].autoLock, function()
			if doorInfo[doorID] == true then return end
			doorInfo[doorID] = true
			TriggerClientEvent('trp_doorlocks:setState', -1, -1, doorID, true)
		end)
	end
end)

ESX.RegisterServerCallback('trp_doorlocks:getDoorInfo', function(source, cb)
	cb(doorInfo)
end)

function IsAuthorized(xPlayer, doorID, locked, usedLockpick)
	local jobName, grade = {}, {}
	jobName[1] = xPlayer.job.name
	grade[1] = xPlayer.job.grade
	if xPlayer.job2 then
		jobName[2] = xPlayer.job2.name
		grade[2] = xPlayer.job2.grade
	end
	local canOpen = false
	if doorID.lockpick and usedLockpick then
		count = xPlayer.getInventoryItem('lockpick').count
		if count and count >= 1 then canOpen = true end
	end

	if not canOpen and doorID.authorizedJobs then
		for job,rank in pairs(doorID.authorizedJobs) do
			if (job == jobName[1] and rank <= grade[1]) or (jobName[2] and job == jobName[2] and rank <= grade[2]) then
				canOpen = true
				if canOpen then break end
			end
		end
		if not canOpen and not doorID.items then
			print(('trp_doorlocks: %s (%s) was not authorized to open a locked door!'):format(xPlayer.getName(), xPlayer.identifier))
		end
	end

	if not canOpen and doorID.items then
		local count
		for k,v in pairs(doorID.items) do
			count = xPlayer.getInventoryItem(v).count
			if count and count >= 1 then
				canOpen = true
				local consumables = { ['ticket']=1 }
				if locked and consumables[v] then
					xPlayer.removeInventoryItem(v, 1)
				end
				break
			end
		end
		if not count or count < 1 then canOpen = false end
	end
	return canOpen
end

TriggerEvent('es:addGroupCommand', 'newdoor', "superadmin", function(source, args, user)
	TriggerClientEvent('trp_doorlocks:newDoorSetup', source, args)
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end, {help = "Add new doors", params = {{name = "", help = ""}}})

RegisterServerEvent('imagineluainjectingforthis:lmfaooooojgfsjg')
AddEventHandler('imagineluainjectingforthis:lmfaooooojgfsjg', function(model, heading, coords, jobs, item, doorLocked, maxDistance, slides, garage, doubleDoor, doorname, PVKEY)
	xPlayer = ESX.GetPlayerFromId(source)
	if PVKEY == '235943894' then print(xPlayer.getName().. ' Correct Key used for DoorLock Command') else print(xPlayer.getName().. ' WRONG Key used for DoorLock Command') return end
	doorLocked = tostring(doorLocked)
	slides = tostring(slides)
	garage = tostring(garage)
	local newDoor = {}
	if jobs[1] then auth = tostring("['"..jobs[1].."']=0") end
	if jobs[2] then auth = auth..', '..tostring("['"..jobs[2].."']=0") end
	if jobs[3] then auth = auth..', '..tostring("['"..jobs[3].."']=0") end
	if jobs[4] then auth = auth..', '..tostring("['"..jobs[4].."']=0") end

	if auth then newDoor.authorizedJobs = { auth } end
	if item then newDoor.items = { item } end
	newDoor.locked = doorLocked
	newDoor.maxDistance = maxDistance
	newDoor.slides = slides
	if not doubleDoor then
		newDoor.garage = garage
		newDoor.objHash = model
		newDoor.objHeading = heading
		newDoor.objCoords = coords
		newDoor.fixText = false
	else
		newDoor.doors = {
			{objHash = model[1], objHeading = heading[1], objCoords = coords[1]},
			{objHash = model[2], objHeading = heading[2], objCoords = coords[2]}
		}
	end
		newDoor.audioRemote = false
		newDoor.lockpick = false
	local path = GetResourcePath(GetCurrentResourceName())
	path = path:gsub('//', '/')..'/config-gabz.lua'

	file = io.open(path, 'a+')
	if not doorname then label = '\n\n-- UNNAMED DOOR CREATED BY TRP ADMIN\ntable.insert(Config.DoorList, {'
	else
		label = '\n\n-- '..doorname.. '\ntable.insert(Config.DoorList, {'
	end
	file:write(label)
	for k,v in pairs(newDoor) do
		if k == 'authorizedJobs' then
			local str =  ('\n	%s = { %s },'):format(k, auth)
			file:write(str)
		elseif k == 'doors' then
			local doorStr = {}
			for i=1, 2 do
				table.insert(doorStr, ('	{objHash = %s, objHeading = %s, objCoords = %s}'):format(model[i], heading[i], coords[i]))
			end
			local str = ('\n	%s = {\n	%s,\n	%s\n },'):format(k, doorStr[1], doorStr[2])
			file:write(str)
		elseif k == 'items' then
			local str = ('\n	%s = { \'%s\' },'):format(k, item)
			file:write(str)
		else
			local str = ('\n	%s = %s,'):format(k, v)
			file:write(str)
		end
	end
	file:write([[
		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000]])
	file:write('\n})')
	file:close()
	local doorID = #Config.DoorList + 1
	
	if jobs[4] then newDoor.authorizedJobs = { [jobs[1]] = 0, [jobs[2]] = 0, [jobs[3]] = 0, [jobs[4]] = 0 }
	elseif jobs[3] then newDoor.authorizedJobs = { [jobs[1]] = 0, [jobs[2]] = 0, [jobs[3]] = 0 }
	elseif jobs[2] then newDoor.authorizedJobs = { [jobs[1]] = 0, [jobs[2]] = 0 }
	elseif jobs[1] then newDoor.authorizedJobs = { [jobs[1]] = 0 } end
	if item then newDoor.Items = { item } end

	Config.DoorList[doorID] = newDoor
	doorInfo[doorID] = doorLocked 
	TriggerClientEvent('trp_doorlocks:newDoorAdded', -1, newDoor, doorID, doorLocked)
end)