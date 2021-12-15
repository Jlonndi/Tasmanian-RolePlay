ESX.RegisterUsableItem('fishing_rod', function(source)
	TriggerClientEvent('esx_fishing:startFishing', source)
end)

ESX.RegisterUsableItem('fish', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('fish', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 140000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx_fishing:onEatFish', source)
	TriggerClientEvent('esx:showNotification', source, 'You have ate 1x ~b~fish~s~')
end)

local foodtable = { -- Food Table
	{fooditem = 'broadbillswordfish', foodpercent = 2, eatmessage = '1x Raw Broadbill Swordfish Consumed'},
	{fooditem = 'southerntuna', foodpercent = 2, eatmessage = '1x Raw Southern Bluefin Tuna Consumed'},
	{fooditem = 'southernflatty', foodpercent = 2, eatmessage = '1x Raw Southern Sand Flathead Consumed'},
	{fooditem = 'southernblueflatty', foodpercent = 2, eatmessage = '1x Raw Southern Bluespotted Flathead Consumed'},
	{fooditem = 'rockflatty', foodpercent = 2, eatmessage = '1x Raw Rock Flathead Consumed'},
	{fooditem = 'duskyflatty', foodpercent = 2, eatmessage = '1x Raw Dusky Flathead Consumed'},
	--{fooditem = 'blueringoctopus', foodpercent = 2, eatmessage = '1x Raw Blue-ringed Octopus Consumed'}, -- TOXIC
	--{fooditem = 'congereel', foodpercent = 2, eatmessage = '1x Raw Conger Eel Consumed'}, -- TOXIC
	{fooditem = 'bluespottedgoatfish', foodpercent = 2, eatmessage = '1x Raw Bluespotted Goatfish Consumed'},
	{fooditem = 'flounder', foodpercent = 2, eatmessage = '1x Raw Flounder Consumed'},
	{fooditem = 'cod', foodpercent = 2, eatmessage = '1x Raw Cod Consumed'},
	{fooditem = 'groperblue', foodpercent = 2, eatmessage = '1x Raw Groper, Blue Consumed'},
	{fooditem = 'mullet', foodpercent = 2, eatmessage = '1x Raw Mullet Consumed'},
	{fooditem = 'salmon', foodpercent = 2, eatmessage = '1x Raw Salmon Consumed'},
	{fooditem = 'snapper', foodpercent = 2, eatmessage = '1x Raw Snapper Consumed'},
	{fooditem = 'trout', foodpercent = 2, eatmessage = '1x Raw Trout Consumed'},
	{fooditem = 'whiting', foodpercent = 2, eatmessage = '1x Raw Whiting, King George Consumed'},
	{fooditem = 'whiting1', foodpercent = 2, eatmessage = '1x Raw Whiting Consumed'},
	{fooditem = 'blobfish', foodpercent = 2, eatmessage = '1x Raw Blob Fish Consumed'},
}

Citizen.CreateThread(function() -- Food items
	for k,var in ipairs(foodtable) do
		ESX.RegisterUsableItem(var.fooditem, function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem(var.fooditem, 1)
		TriggerClientEvent('esx_status:add', source, 'hunger', 10000 * var.foodpercent)
		TriggerClientEvent('esx_basicneeds:onEat', source)
		TriggerClientEvent('esx:showNotification', source, var.eatmessage)
	    end)
	end
end)

RegisterServerEvent('esx_fishing:caughtFish')
AddEventHandler('esx_fishing:caughtFish', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local randomfish = math.random(1, 19)
	if randomfish == 1 then 
		xPlayer.addInventoryItem('broadbillswordfish', 1) -- Broadbill Swordfish
	end
	if randomfish == 2 then 
		xPlayer.addInventoryItem('southerntuna', 1) -- Southern Bluefin Tuna
	end
	if randomfish == 3 then 
		xPlayer.addInventoryItem('southernflatty', 1) -- Southern Sand Flathead 
	end
	if randomfish == 4 then 
		xPlayer.addInventoryItem('southernblueflatty', 1) -- Southern Bluespotted Flathead 
	end
	if randomfish == 5 then 
		xPlayer.addInventoryItem('rockflatty', 1) -- Rock Flathead 
	end
	if randomfish == 6 then 
		xPlayer.addInventoryItem('duskyflatty', 1) -- Dusky Flathead 
	end
	if randomfish == 7 then 
		xPlayer.addInventoryItem('blueringoctopus', 1) -- Blue-ringed Octopus [Deadly]
	end
	if randomfish == 8 then 
		xPlayer.addInventoryItem('congereel', 1) -- Conger Eel [Deadly]
	end
	if randomfish == 9 then 
		xPlayer.addInventoryItem('bluespottedgoatfish', 1) -- Bluespotted Goatfish [Unusual]
	end
	if randomfish == 10 then 
		xPlayer.addInventoryItem('flounder', 1) -- Flounder
	end
	if randomfish == 11 then 
		xPlayer.addInventoryItem('cod', 1) -- Cod
	end
	if randomfish == 12 then 
		xPlayer.addInventoryItem('groperblue', 1) -- Groper, Blue [Endangered Considered Valuable]
	end
	if randomfish == 13 then 
		xPlayer.addInventoryItem('mullet', 1) -- Mullet
	end
	if randomfish == 14 then 
		xPlayer.addInventoryItem('salmon', 1) -- Salmon
	end
	if randomfish == 15 then 
		xPlayer.addInventoryItem('snapper', 1) -- Snapper
	end
	if randomfish == 16 then 
		xPlayer.addInventoryItem('trout', 1) -- Trout
	end
	if randomfish == 17 then 
		xPlayer.addInventoryItem('whiting', 1) -- Whiting, King George
	end
	if randomfish == 18 then 
		xPlayer.addInventoryItem('whiting1', 1) -- Whiting
	end
	if randomfish == 19 then 
		xPlayer.addInventoryItem('blobfish', 1) -- Blob Fish
	end
end)


RegisterServerEvent('fishing:startSell')
AddEventHandler('fishing:startSell', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local fishQuantity = xPlayer.getInventoryItem('fish').count
	local earned = math.random(25, 50)

	if fishQuantity > 0 then
		xPlayer.removeInventoryItem('fish', 1)
		xPlayer.addInventoryItem('money', earned)
		TriggerClientEvent('esx:showNotification', _source, 'You sold a ~b~fish~s~ for ~g~$'..earned)
	else
		TriggerClientEvent('esx:showNotification', _source, 'You dont have any fish to sell.')
	end
end)
