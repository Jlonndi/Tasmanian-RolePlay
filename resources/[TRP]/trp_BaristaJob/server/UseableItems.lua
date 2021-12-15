ESX = nil 
ESX.RegisterUsableItem('Milk', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    xPlayer.removeInventoryItem('Milk', 1)
    Message('Moo, moo moo MOO MOO Moo', xPlayer)
    Citizen.Wait(1000)
    Message('Translation: You Drink the Milk', xPlayer)
 end)
 
 ESX.RegisterUsableItem('Latte', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    xPlayer.removeInventoryItem('Latte', 1)
    Message('You Drink the Latte', xPlayer)
 end)
 
 ESX.RegisterUsableItem('IrishCoffee', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    xPlayer.removeInventoryItem('IrishCoffee', 1)
    Message('You Drink the Irish Coffee', xPlayer)
 end)
 
 ESX.RegisterUsableItem('Black_Coffee', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    xPlayer.removeInventoryItem('Black_Coffee', 1)
    Message('You Drink the Black Coffee', xPlayer)
 end)
 
 ESX.RegisterUsableItem('Frappe', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    xPlayer.removeInventoryItem('Frappe', 1)
    Message('You Drink the Frappe', xPlayer)
 end)
 
 ESX.RegisterUsableItem('Espresso', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    xPlayer.removeInventoryItem('Espresso', 1)
    Message('You Drink the Espresso', xPlayer)
 end)
 
 ESX.RegisterUsableItem('Cappuccino', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    xPlayer.removeInventoryItem('Cappuccino', 1)
    Message('You Drink the Cappuccino', xPlayer)
 end)
 
 ESX.RegisterUsableItem('FlatWhite', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    xPlayer.removeInventoryItem('FlatWhite', 1)
    Message('You Drink the Flat White', xPlayer)
 end)
 
 --ESX.RegisterUsableItem('White_Coffee', function(playerId)
  --  local xPlayer = ESX.GetPlayerFromId(playerId)
   -- xPlayer.removeInventoryItem('White_Coffee', 1)
    --Message('You Drink the White Coffee', xPlayer)
 --end)
 
 ESX.RegisterUsableItem('White_Coffee', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer.getInventoryItem('White_Coffee').count > 0 and xPlayer.getInventoryItem('emptycoffeecup2').count > 0 then 
    xPlayer.removeInventoryItem('White_Coffee', 1)
    xPlayer.removeInventoryItem('emptycoffeecup', 1)
    xPlayer.addInventoryItem('whitecoffee2go', 1)
    Message('You Make a White Coffee To Go!', xPlayer)
    else 
       if xPlayer.getInventoryItem('White_Coffee').count > 0 and xPlayer.getInventoryItem('coke').count > 0 then 
          xPlayer.removeInventoryItem('White_Coffee', 1)
          xPlayer.removeInventoryItem('coke', 1)
          Message('You start pouring cocaine into your coffee', xPlayer)
          Citizen.Wait(1500)
          xPlayer.addInventoryItem('cocainewhitecoffee', 1)
          Message('You\'ve Poured all your Cocaine into the cup', xPlayer)
       --else   need to make new registerableItem here....
         -- if xPlayer.getInventoryItem('White_Coffee2go').count > 0 and xPlayer.getInventoryItem('coke').count > 0 then 
            -- removeInventoryItem('White_Coffee2go', 1)
            -- removeInventoryItem('coke', 1)
             --Message('You start pouring cocaine into your coffee', xPlayer)
             --Citizen.Wait(1500)
             --addInventoryItem('cocaineWhite_Coffee2go')
             --Message('You\'ve Poured all your Cocaine into the cup', xPlayer)
       else 
       if xPlayer.getInventoryItem('White_Coffee', 1) then 
       xPlayer.removeInventoryItem('White_Coffee', 1)
       Message('You drink the White Coffee', xPlayer)
       end
   --end
    end
 end
    end)
 ESX.RegisterUsableItem('coffee', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer.getInventoryItem('coffee').count > 0 and xPlayer.getInventoryItem('cocaine').count > 0 then 
    xPlayer.removeInventoryItem('cocaine', 1)
    xPlayer.removeInventoryItem('coffee', 1)
    Message('you mix the cocaine with the coffee', xPlayer)
    xPlayer.addInventoryItem('cocainecoffee', 1)
    else if xPlayer.getInventoryItem('coffee').count > 0 then 
       xPlayer.removeInventoryItem('coffee', 1)
       Message('You drinky the drinky winky', xPlayer)
    end
    end
 end)