local ESX = nil
local robbableItems = {
    [1] = {chance = 1, id = 'money', name = 'Money', quantity = math.random(10, 300)}, -- really common
    [2] = {chance = 1, id = 'cannabis', name = 'Pistol', quantity = 1}, -- rare
    [3] = {chance = 7, id = 'louisvuittonbag', name = 'Louis Vuitton Bag', quantity = 1}, -- rare
    [4] = {chance = 15, id = 'armor', name = 'Armour', quantity =  math.random(1, 2)}, -- common
    [5] = {chance = 6, id = 'bandage', name = 'Bandage', quantity = math.random(1, 25)}, -- common
    [6] = {chance = 5, id = 'jagerbomb', name = 'Jägerbomb', quantity = math.random(1, 2)}, -- common
    [7] = {chance = 6, id = 'gta5', name = 'PS4 GTA V', quantity = 1}, -- common
    [8] = {chance = 4, id = 'ps5', name = 'Playstation 5', quantity = math.random(1, 2)}, -- rare
    [9] = {chance = 1, id = 'macbook', name = 'Apple Mac-Book', quantity = math.random(1, 2)}, -- rare
    [10] = {chance= 3, id = 'advancedlockpick', name = 'Multi-pick', quantity = math.random(1, 2)}, -- rare
    [11] = {chance = 2, id = 'nikeairforceone', name = 'Nike Air Forces', quantity = math.random(1, 2)}, -- rare
    [12] = {chance = 6, id = 'cannabis', name = 'Cannabis Plant', quantity = 2}, -- rare
    [13] = {chance = 5, id = 'diamondring', name = 'Diamond Ring', quantity = 1}, -- rare
    [14] = {chance = 2, id = 'cyberpunk', name = 'PS4 CyberPunk', quantity = 1}, -- common
    [15] = {chance = 6, id = 'gold', name = 'Gold', quantity = 1}, -- rare
    [16] = {chance = 8, id = 'coke', name = 'Cocaine', quantity = 5}, -- rare
    [17] = {chance = 2, id = 'coldwar', name = 'PS5 Cold-War', quantity = 1}, -- rare
    [18] = {chance = 7, id = 'jewels', name = 'Jewels', quantity = math.random(1, 25)}, -- rare
    [19] = {chance = 4, id = 'fixkit', name = 'Repair Kit', quantity = 1}, -- rare
    [20] = {chance = 2, id = 'thedarknightbluray', name = 'The Dark Night Bluray', quantity = math.random(1, 2)}, -- common
    [21] = {chance = 3, id = 'avengersendgamedvd', name = 'Avengers End Game', quantity = 2},
    [22] = {chance = 3, id = 'crack', name = 'Crack', quantity = math.random(1, 2)}, 
    [23] = {chance = 5, id = 'marijuana', name = 'Bag of Weed', quantity = math.random(1, 5)}, 
    [24] = {chance = 8, id = 'medikit', name = 'Medikit', quantity = 1}, 
    [25] = {chance = 5, id = 'oxygen_mask', name = 'Oxygen Mask', quantity = 1}, 
    [26] = {chance = 7, id = 'diamondring', name = 'Diamond Ring', quantity = math.random(1, 2)}, 
    [27] = {chance = 5, id = 'rolex', name = 'Rolex', quantity = math.random(1, 3)}, 
    [28] = {chance = 6, id = 'gazbottle', name = 'Gas Bottle', quantity = 1},
    [29] = {chance = 5, id = 'lowradio', name = 'Stock Radio', quantity = 2}, 
    [30] = {chance = 3, id = 'spice', name = 'Bag of spice', quantity = 2}, 
    [31] = {chance = 5, id = 'icetea', name = 'Ice Tea', quantity = 1},
   -- [32] = {chance = 1, id = 'WEAPON_KNIFE', name = 'Knife', quantity = 1},
   -- [33] = {chance = 1, id = 'WEAPON_APPISTOL', name = 'AP Pistol', quantity = math.random(1, 2)},
    [32] = {chance = 1, id = 'keycard', name = 'Keycard', quantity = 1},
}
--[[chance = 1 is very common, the higher the value the less the chance]]--

TriggerEvent('esx:getSharedObject', function(obj)
 ESX = obj
end)

ESX.RegisterUsableItem('advancedlockpick', function(source) --Hammer high time to unlock but 100% call cops
 local source = tonumber(source)
 local xPlayer = ESX.GetPlayerFromId(source)
 TriggerClientEvent('houseRobberies:attempt', source, xPlayer.getInventoryItem('advancedlockpick').count)
end)

RegisterServerEvent('houseRobberies:removeLockpick')
AddEventHandler('houseRobberies:removeLockpick', function()
 local source = tonumber(source)
 local xPlayer = ESX.GetPlayerFromId(source)
 xPlayer.removeInventoryItem('advancedlockpick', 1)
 --TriggerClientEvent('chatMessage', source, '^1Your lockpick has bent out of shape')
 TriggerClientEvent('notification', source, 'The lockpick bent out of shape.', 2)
end)

RegisterServerEvent('houseRobberies:giveMoney')
AddEventHandler('houseRobberies:giveMoney', function()
 local source = tonumber(source)
 local xPlayer = ESX.GetPlayerFromId(source)
 local cash = math.random(500, 3000)
 xPlayer.addInventoryItem('money', math.random(10, 300))
 
 --TriggerClientEvent('chatMessage', source, '^4You have found $'..cash)
 TriggerClientEvent('notification', source, 'You found $'..cash)
end)


RegisterServerEvent('houseRobberies:searchItem')
AddEventHandler('houseRobberies:searchItem', function()
 local source = tonumber(source)
 local item = {}
 local xPlayer = ESX.GetPlayerFromId(source)
 local gotID = {}


 for i=1, math.random(1, 2) do
  item = robbableItems[math.random(1, #robbableItems)]
  if math.random(1, 10) >= item.chance then
   if tonumber(item.id) == 0 and not gotID[item.id] then
    gotID[item.id] = true
    --xPlayer.addMoney(item.quantity)
    xPlayer.addInventoryItem('money', math.random(10, 300))
    TriggerClientEvent('trp-core:loghouserobberies', source, 'money', item.quantity)
    --TriggerClientEvent('chatMessage', source, 'You found $'..item.quantity)
    TriggerClientEvent('notification', source, 'You found $'..item.quantity)
   elseif item.isWeapon and not gotID[item.id] then
    gotID[item.id] = true
    xPlayer.addWeapon(item.id, 50)
    TriggerClientEvent('trp-core:loghouserobberies', source, item.id, 50)
    --TriggerClientEvent('chatMessage', source, 'You found a '..item.name)
    TriggerClientEvent('notification', source, 'Item Added!', 2)
   elseif not gotID[item.id] then
    gotID[item.id] = true
    xPlayer.addInventoryItem(item.id, item.quantity)
    TriggerClientEvent('trp-core:loghouserobberies', source, item.id, item.quantity)
    --TriggerClientEvent('chatMessage', source, 'You have found '..item.quantity..'x '..item.name)
    TriggerClientEvent('notification', source, 'Item Added!', 2)
   end
  end
 end
end)

