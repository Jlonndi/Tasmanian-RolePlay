ESX = nil
--This triggerEvent is forever breaking... If it does rewrite it in a new format and cry.....
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
function Message(Chat, Player)
	TriggerClientEvent('esx:showNotification', Player.source, Chat)
end
-----Sale
RegisterServerEvent('esx_pawnshop:sellps5')
AddEventHandler('esx_pawnshop:sellps5', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local ps5 = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "ps5" then
			ps5 = item.count
		end
	end
    
    if ps5 > 0 then
		TriggerClientEvent('trp-core:pawnshop', _source, "ps5")
		xPlayer.removeInventoryItem('ps5', 1)
        xPlayer.addInventoryItem('money', math.random(400,600))
		Message('You sold a ps5....', xPlayer)
	else 
		Message('You Dont Have Anymore', xPlayer)
    end
end)

RegisterServerEvent('esx_pawnshop:sellgta5')
AddEventHandler('esx_pawnshop:sellgta5', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local gta5 = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "gta5" then
			gta5 = item.count
		end
	end
    
    if gta5 > 0 then
		TriggerClientEvent('trp-core:pawnshop', _source, "gta5")
		xPlayer.removeInventoryItem('gta5', 1)
		xPlayer.addInventoryItem('money', math.random(30, 80))
		Message('You sold a copy of gta V', xPlayer)
	else 
		Message('You Dont have anymore to sell', xPlayer)
    end
end)

RegisterServerEvent('esx_pawnshop:selldiamondring')
AddEventHandler('esx_pawnshop:selldiamondring', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local diamondring = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "diamondring" then
			diamondring = item.count
		end
	end
    
    if diamondring > 0 then
		TriggerClientEvent('trp-core:pawnshop', _source, "Diamond Ring")
		xPlayer.removeInventoryItem('diamondring', 1)
        xPlayer.addInventoryItem('money', math.random(300,450))
		Message('You Sold a Diamond Ring', xPlayer)
	else 
		Message('You Dont have anymore to sell', xPlayer)
    end
end)

RegisterServerEvent('esx_pawnshop:sellmacbook')
AddEventHandler('esx_pawnshop:sellmacbook', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local macbook = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "macbook" then
			macbook = item.count
		end
	end
    
    if macbook > 0 then
		TriggerClientEvent('trp-core:pawnshop', _source, "Playstation 5")
		xPlayer.removeInventoryItem('macbook', 1)
        xPlayer.addInventoryItem('money', math.random(200, 600))
		Message('You have sold a Mac Book', xPlayer)
	else 
		Message('You dont have anymore to sell', xPlayer)
    end
end)

RegisterServerEvent('esx_pawnshop:sellcyberpunk')
AddEventHandler('esx_pawnshop:sellcyberpunk', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local cyberpunk = 0
	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "cyberpunk" then
			cyberpunk = item.count
		end
	end
    
    if cyberpunk > 0 then
		TriggerClientEvent('trp-core:pawnshop', _source, "Cyber Punk")
		xPlayer.removeInventoryItem('cyberpunk', 1)
        xPlayer.addInventoryItem('money', math.random(10,80))
		Message('You Sold a copy of Cyber-Punk', xPlayer)
	else 
		Message('You dont have anymore to sell', xPlayer)
    end
end)

RegisterServerEvent('esx_pawnshop:sellgold')
AddEventHandler('esx_pawnshop:sellgold', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local gold = 0
	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "gold" then
			gold = item.count
		end
	end
    
    if gold > 0 then
		TriggerClientEvent('trp-core:pawnshop', _source, "Gold")
		xPlayer.removeInventoryItem('gold', 1)
        xPlayer.addInventoryItem('money', math.random(100, 200))
		Message('You sold a gold bar', xPlayer)
	else 
		Message('You dont have anymore to sell', xPlayer)
    end
end)

RegisterServerEvent('esx_pawnshop:sellcoldwar')
AddEventHandler('esx_pawnshop:sellcoldwar', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local coldwar = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "coldwar" then
			coldwar = item.count
		end
	end
  
    if coldwar > 0 then
		TriggerClientEvent('trp-core:pawnshop', _source, "Cold War")
		xPlayer.removeInventoryItem('coldwar', 1)
        xPlayer.addInventoryItem('money', math.random(30, 90))
		Message('You sold a copy of Cold-War', xPlayer)
	else 
		Message('You dont have anymore to sell', xPlayer)
    end
end)

RegisterServerEvent('esx_pawnshop:sellthedarknightbluray')
AddEventHandler('esx_pawnshop:sellthedarknightbluray', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local thedarknightbluray = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "thedarknightbluray" then
			thedarknightbluray = item.count
		end
	end
    
    if thedarknightbluray > 0 then
		TriggerClientEvent('trp-core:pawnshop', _source, "The Dark Knight Rises")
		xPlayer.removeInventoryItem('thedarknightbluray', 1)
        xPlayer.addInventoryItem('money', math.random(50, 80))
		Message('You sold a copy of the Dark-Knight Rises', xPlayer)
	else
		Message('You dont have anymore to sell', xPlayer)
    end
end)

RegisterServerEvent('esx_pawnshop:selllouisvuittonbag')
AddEventHandler('esx_pawnshop:selllouisvuittonbag', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local louisvuittonbag = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "louisvuittonbag" then
			louisvuittonbag = item.count
		end
	end
    
    if louisvuittonbag > 0 then
		TriggerClientEvent('trp-core:pawnshop', _source, "Louis Vuitton Bag")
		xPlayer.removeInventoryItem('louisvuittonbag', 1)
        xPlayer.addInventoryItem('money', math.random(100, 300))
		Message('You sold a Louis Vuitton Bag', xPlayer)
	else 
		Message('You dont have anymore to sell', xPlayer)
    end
end)


RegisterServerEvent('esx_pawnshop:sellavengersendgamedvd')
AddEventHandler('esx_pawnshop:sellavengersendgamedvd', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local avengersendgamedvd = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "avengersendgamedvd" then
			avengersendgamedvd = item.count
		end
	end
    
    if avengersendgamedvd > 0 then
		TriggerClientEvent('trp-core:pawnshop', _source, "Avengers End Game DvD")
		xPlayer.removeInventoryItem('avengersendgamedvd', 1)
        xPlayer.addInventoryItem('money', math.random(20, 40))
		Message('You sold a copy of Avengers End Game', xPlayer)
	else 
		Message('You dont have anymore to sell', xPlayer)
    end
end)

RegisterServerEvent('esx_pawnshop:selloxygen_mask')
AddEventHandler('esx_pawnshop:selloxygen_mask', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local oxygen_mask = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "oxygen_mask" then
			oxygen_mask = item.count
		end
	end
    
    if oxygen_mask > 0 then
		TriggerClientEvent('trp-core:pawnshop', _source, "oxygen_mask")
		xPlayer.removeInventoryItem('oxygen_mask', 1)
        xPlayer.addInventoryItem('money', math.random(80, 160))
		Message('You sold an oxygen_mask', xPlayer)
	else 
		Message('You dont have anymore to sell', xPlayer)
    end
end)


RegisterServerEvent('esx_pawnshop:airforceones')
AddEventHandler('esx_pawnshop:airforceones', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local nikeairforceone = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "nikeairforceone" then
			nikeairforceone = item.count
		end
	end
    
    if nikeairforceone > 0 then
		TriggerClientEvent('trp-core:pawnshop', _source, "nikeairforceone")
		xPlayer.removeInventoryItem('nikeairforceone', 1)
        xPlayer.addInventoryItem('money', math.random(60, 100))
		Message('You sold an airforce one', xPlayer)
	else 
		Message('You dont have anymore to sell', xPlayer)
    end
end)

RegisterServerEvent('esx_pawnshop:sellrolex')
AddEventHandler('esx_pawnshop:sellrolex', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local rolex = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "rolex" then
			rolex = item.count
		end
	end
    
    if rolex > 0 then
		TriggerClientEvent('trp-core:pawnshop', _source, "rolex")
		xPlayer.removeInventoryItem('rolex', 1)
        xPlayer.addInventoryItem('money', math.random(70,200))
	 Message('You sold a Rolex Watch', xPlayer)
	else 
		Message('You dont have anymore to sell', xPlayer)
    end
end)

RegisterServerEvent('esx_pawnshop:sellgazbottle')
AddEventHandler('esx_pawnshop:sellgazbottle', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local gazbottle = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "gazbottle" then
			gazbottle = item.count
		end
	end
    
    if gazbottle > 0 then
		TriggerClientEvent('trp-core:pawnshop', _source, "Gas Bottle")
		xPlayer.removeInventoryItem('gazbottle', 1)
        xPlayer.addInventoryItem('money', math.random(30,90))
		Message('You have sold a gas Bottle', xPlayer)
	else 
		Message('You dont have anymore to sell', xPlayer)
    end
end)

RegisterServerEvent('esx_pawnshop:selllowradio')
AddEventHandler('esx_pawnshop:selllowradio', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local lowradio = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "lowradio" then
			lowradio = item.count
		end
	end
    
    if lowradio > 0 then
		TriggerClientEvent('trp-core:pawnshop', _source, "low radio")
		xPlayer.removeInventoryItem('lowradio', 1)
        xPlayer.addInventoryItem('money', math.random(30,80))
		Message('You have sold a low radio', xPlayer)
	else 
		Message('You dont have anymore to sell', xPlayer)
    end
end)
