ESX = nil

TriggerEvent(Config.Strings.trigEv, function(obj) ESX = obj end)

Notify = function(src, text, timer)
	if timer == nil then
		timer = 5000
	end
	-- TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = text, length = timer, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
	-- TriggerClientEvent('pNotify:SendNotification', src, {text = text, type = 'error', queue = GetCurrentResourceName(), timeout = timer, layout = 'bottomCenter'})
	TriggerClientEvent('esx:showNotification', src, text)
end

ESX.RegisterServerCallback('TRP-Drugs:getPlayerData', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT club, club_rank FROM users WHERE identifier=@identifier', {['@identifier'] = xPlayer.identifier}, function(result)
		if result and result[1] and result[1].club then
			xPlayer.gang = result[1].club
		else
			xPlayer.gang = 'NULL'
		end
		cb(xPlayer)
	end)
end)