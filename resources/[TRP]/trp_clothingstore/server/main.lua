ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_np_skinshop:saveOutfit')
AddEventHandler('esx_np_skinshop:saveOutfit', function(label, skin)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local dressing = store.get('dressing')

		if dressing == nil then
			dressing = {}
		end

		table.insert(dressing, {
			label = label,
			skin  = skin
		})

		store.set('dressing', dressing)
	end)
end)

ESX.RegisterServerCallback('esx_np_skinshop:buyClothes', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getInventoryItem('money').count >= Config.Price then
		xPlayer.removeInventoryItem('money', Config.Price)
		TriggerClientEvent('esx:showNotification', source, _U('you_paid', Config.Price))
		cb(true)
	else 
		if xPlayer.getAccount('bank').money >= Config.Price then
			xPlayer.removeAccountMoney('bank', Config.Price)
			TriggerClientEvent('esx:showNotification', source, _U('you_paidbank', Config.Price))
			cb(true)
	else
		cb(false)
	end
end
end)

ESX.RegisterServerCallback('esx_np_skinshop:checkPropertyDataStore', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundStore = false

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		foundStore = true
	end)

	cb(foundStore)
end)
