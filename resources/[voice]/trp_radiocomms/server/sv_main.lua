TRP = nil

TriggerEvent('esx:getSharedObject', function(obj) TRP = obj end)

TRP.RegisterUsableItem('radio', function(source)
	local xPlayer = TRP.GetPlayerFromId(source)

	TriggerClientEvent('TRP_RadioComms:use', source, true)
end)


-- checking is player have item

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    local CockPlayers = TRP.GetPlayers()
    for i=1, #CockPlayers, 1 do
        local xPlayer = TRP.GetPlayerFromId(CockPlayers[i])
          if xPlayer ~= nil then
              if xPlayer.getInventoryItem('radio').count == 0 then
                local source = CockPlayers[i]
                TriggerClientEvent('TRP_RadioComms:hentaigirls', source)
                break
              end
          end
      end
  end
end)