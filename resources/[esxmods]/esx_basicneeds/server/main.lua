TRP = nil

TriggerEvent('esx:getSharedObject', function(obj) TRP = obj end)

local foodtable = { -- Food Table
	{fooditem = 'bread', foodpercent = 10, eatmessage = '1x Bread Consumed'},
}

local drinktable = { -- Drink Table
	{drinkitem = 'water', drinkpercent = 15, drinkmessage = '1x Water Consumed'},
	{drinkitem = 'daredbl500ml', drinkpercent = 20, drinkmessage = '1x Dare Iced Coffee Consumed'}
}

Citizen.CreateThread(function() -- Food items
	for k,cock in ipairs(foodtable) do
		TRP.RegisterUsableItem(cock.fooditem, function(source)
		local xPlayer = TRP.GetPlayerFromId(source)
		xPlayer.removeInventoryItem(cock.fooditem, 1)
		TriggerClientEvent('esx_status:add', source, 'hunger', 10000 * cock.foodpercent)
		TriggerClientEvent('esx_basicneeds:onEat', source)
		TriggerClientEvent('esx:showNotification', source, cock.eatmessage)
	    end)
	end
end)

Citizen.CreateThread(function() -- Drink Items
	for k,bobs in ipairs(drinktable) do
		TRP.RegisterUsableItem(bobs.drinkitem, function(source)
		local xPlayer = TRP.GetPlayerFromId(source)
		xPlayer.removeInventoryItem(bobs.drinkitem, 1)
		TriggerClientEvent('esx_status:add', source, 'thirst', 10000 * bobs.drinkpercent)
		TriggerClientEvent('esx_basicneeds:onDrink', source)
		TriggerClientEvent('esx:showNotification', source, bobs.drinkmessage)
		end)
	end
end)
