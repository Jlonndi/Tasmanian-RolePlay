ESX.Trace = function(str)
	if Config.EnableDebug then
		print('ESX> ' .. str)
	end
end

ESX.SetTimeout = function(msec, cb)
	local id = ESX.TimeoutCount + 1

	SetTimeout(msec, function()
		if ESX.CancelledTimeouts[id] then
			ESX.CancelledTimeouts[id] = nil
		else
			cb()
		end
	end)

	ESX.TimeoutCount = id

	return id
end

ESX.ClearTimeout = function(id)
	ESX.CancelledTimeouts[id] = true
end

ESX.RegisterServerCallback = function(name, cb)
	ESX.ServerCallbacks[name] = cb
end

ESX.TriggerServerCallback = function(name, requestId, source, cb, ...)
	if ESX.ServerCallbacks[name] ~= nil then
		ESX.ServerCallbacks[name](source, cb, ...)
	else
		print('es_extended: TriggerServerCallback => [' .. name .. '] does not exist')
	end
end

ESX.SavePlayer = function(xPlayer, cb)
	xPlayer.setLastPosition(xPlayer.getCoords())
	MySQL.Async.execute([===[
		UPDATE users SET
			job = @job, job_grade = @job_grade, loadout = @loadout,
			position = @position, name = @name
			WHERE identifier = @identifier
		]===], {
		['@position'] = json.encode(xPlayer.getLastPosition()),
		['@job'] = xPlayer.job.name, ['@job_grade'] = xPlayer.job.grade,
		['@loadout'] = json.encode(xPlayer.getLoadout(true)), ['@identifier'] = xPlayer.getIdentifier(),
		['@name'] = xPlayer.getIdentifier()
	}, function(rowsChanged)
		for i=1, #xPlayer.inventory, 1 do

			if ESX.LastPlayerData[xPlayer.source].items[xPlayer.inventory[i].name] ~= xPlayer.inventory[i].count then
	
				--table.insert(asyncTasks, function(cb)
					MySQL.Async.execute('UPDATE user_inventory SET `count` = @count WHERE identifier = @identifier AND item = @item',
					{
						['@count']      = xPlayer.inventory[i].count,
						['@identifier'] = xPlayer.identifier,
						['@item']       = xPlayer.inventory[i].name
					}, function(rowsChanged)
					--	cb()
					end)
				--end)
	
				ESX.LastPlayerData[xPlayer.source].items[xPlayer.inventory[i].name] = xPlayer.inventory[i].count
	
			end
		end
		print(('[ESX] [^2INFO^7] Saved player "%s^7"'):format(xPlayer.getName()))
		
		if cb then cb(rowsChanged) end 

	
	end)	
end

ESX.SavePlayers = function(cb)
	local xPlayers, asyncTasks, timeStart = ESX.GetPlayers(), {}, os.clock()

	if #xPlayers > 0 then
		for i=1, #xPlayers, 1 do
			table.insert(asyncTasks, function(cb2)
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

				if xPlayer then
					ESX.SavePlayer(xPlayer, cb2)
				end
			end)
		end

		Async.parallelLimit(asyncTasks, 8, function(results)
			local elapsedTime = os.clock() - timeStart
			print(('[ESX] [^2INFO^7] Saved %s player(s), operation took %.0f second(s)'):format(#xPlayers, elapsedTime))

			if cb then
				cb()
			end
		end)
	end
end

ESX.StartDBSync = function()
	function saveData()
		ESX.SavePlayers()
		SetTimeout(5 * 60 * 1000, saveData)
	end
	SetTimeout(5 * 60 * 1000, saveData)
end

ESX.GetPlayers = function()
	local sources = {}

	for k,v in pairs(ESX.Players) do
		table.insert(sources, k)
	end

	return sources
end


ESX.GetPlayerFromId = function(source)
	return ESX.Players[tonumber(source)]
end

ESX.GetPlayerFromIdentifier = function(identifier)
	for k,v in pairs(ESX.Players) do
		if v.identifier == identifier then
			return v
		end
	end
end

ESX.RegisterUsableItem = function(item, cb)
	ESX.UsableItemsCallbacks[item] = cb
end

ESX.UseItem = function(source, item)
	ESX.UsableItemsCallbacks[item](source)
end

ESX.GetItemLabel = function(item)
	if ESX.Items[item] ~= nil then
		return ESX.Items[item].label
	end
end

ESX.CreatePickup = function(type, name, count, label, player)
	local pickupId = (ESX.PickupId == 65635 and 0 or ESX.PickupId + 1)

	ESX.Pickups[pickupId] = {
		type  = type,
		name  = name,
		count = count
	}

	TriggerClientEvent('esx:pickup', -1, pickupId, label, player)
	ESX.PickupId = pickupId
end
