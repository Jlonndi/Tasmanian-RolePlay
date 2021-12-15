TRP             = nil
local ShopItems = {}

TriggerEvent('esx:getSharedObject', function(obj) TRP = obj end)

MySQL.ready(function()
	MySQL.Async.fetchAll('SELECT * FROM trp_shops LEFT JOIN items ON items.name = trp_shops.item', {}, function(shopResult)
		for i=1, #shopResult, 1 do
			if shopResult[i].name then
				if ShopItems[shopResult[i].store] == nil then
					ShopItems[shopResult[i].store] = {}
				end

				table.insert(ShopItems[shopResult[i].store], {
					label = shopResult[i].label,
					item  = shopResult[i].item,
					price = shopResult[i].price,
					imglink = shopResult[i].imglink
				})
			else
				print(('trp_shops: invalid item "%s" found!'):format(shopResult[i].item))
			end
		end
	end)
end)

TRP.RegisterServerCallback('trp_shops:requestDBItems', function(source, cb)
	cb(ShopItems)
end)

RegisterServerEvent('trp_shops:buyItem')
AddEventHandler('trp_shops:buyItem', function(itemName, amount, zone, item)
	local _source = source
	local xPlayer = TRP.GetPlayerFromId(_source)

	amount = TRP.Math.Round(amount)

	-- is the player trying to exploit?
	if amount < 0 then
		print('trp_shops: ' .. xPlayer.identifier .. ' attempted to exploit the shop!')
		return
	end

	-- get price
	local price = 0
	local itemLabel = ''

	for i=1, #ShopItems[zone], 1 do
		if ShopItems[zone][i].item == itemName then
			price = ShopItems[zone][i].price
			itemLabel = ShopItems[zone][i].label
			break
		end
	end

	price = price * amount

	-- can the player afford this item?
	if xPlayer.getInventoryItem('money').count >= price then
		-- can the player carry the said amount of x item?
		-- Workaround to the fact thatt attempt to call a nil value (field 'canCarryItem') is fucking broken in our base for whatever fucking niggerish reason lol
		if xPlayer.getInventoryItem('money', 1) then
			xPlayer.removeInventoryItem("money", price)
			xPlayer.addInventoryItem(itemName, amount)
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You bought ' .. amount .. ' x ' .. itemName .. ' for ' .. price .. '$', length = 2500, style = { ['background-color'] = '#2f5c73', ['color'] = '#FFFFFF' } })
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You cannot carry anymore', length = 2500, style = { ['background-color'] = '#2f5c73', ['color'] = '#FFFFFF' } })
		end
	else
		local missingMoney = price - xPlayer.getInventoryItem('money').count
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You Need' .. TRP.Math.GroupDigits(missingMoney) .. "$", length = 2500, style = { ['background-color'] = '#2f5c73', ['color'] = '#FFFFFF' } })
	end
end)