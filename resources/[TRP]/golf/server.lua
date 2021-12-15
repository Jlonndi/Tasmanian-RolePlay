ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

-- TassieRP custom coded payment and verification function.
RegisterServerEvent("golf:payment")
AddEventHandler("golf:payment", function(depositAmount, depositDate)
    -- custom random number generator for price <3 
    local _amountdue = math.random(500, 500)
    --print(_amountdue)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local _identifier = xPlayer.getIdentifier()
   if _amountdue == nil or _amountdue <= 0 or _amountdue > xPlayer.getInventoryItem('money').count then
      -- if NIL trigger notification that you don't have enough money
      
      --TriggerClientEvent("")
      TriggerClientEvent("golf:beginGolfnomoney", _source)
    else

		-- -example else if have enough money pull from inventory $500
        xPlayer.removeInventoryItem('money', _amountdue)
        --TriggerClientEvent('golf:spawnCart')
        TriggerClientEvent("golf:beginGolf", _source)
       -- TriggerClientEvent("beginGolf")
       -- TriggerClientEvent("golf:beginGolfHud")
       
	  -- TriggerClientEvent("golf:spawnCart")
       

        end
    
end)