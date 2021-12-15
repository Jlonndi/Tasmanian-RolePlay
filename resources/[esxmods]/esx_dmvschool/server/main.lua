ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
  TriggerEvent('esx_license:getLicenses', source, function(licenses)
    TriggerClientEvent('esx_dmvschool:loadLicenses', source, licenses)
  end)
end)

RegisterNetEvent('esx_dmvschool:addLicense')
AddEventHandler('esx_dmvschool:addLicense', function(type)

  local _source = source

  TriggerEvent('esx_license:addLicense', _source, type, function()
    TriggerEvent('esx_license:getLicenses', _source, function(licenses)
      TriggerClientEvent('esx_dmvschool:loadLicenses', _source, licenses)
    end)
  end)

end)

RegisterNetEvent('esx_dmvschool:pay')
AddEventHandler('esx_dmvschool:pay', function(price, type)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  if xPlayer.getInventoryItem('money').count >= price then
  xPlayer.removeInventoryItem('money', price)

  TriggerClientEvent('esx:showNotification', _source, _U('you_paid') .. price)
  TriggerClientEvent('esx_dmvschool:startdrivetestpaid', source, type)
  else 
    TriggerClientEvent('esx:showNotification', _source, 'You Don\'t have Enough Money you need $' .. price)
  end

end)
RegisterNetEvent('esx_dmvschool:pay1')
AddEventHandler('esx_dmvschool:pay1', function(price, type)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  if xPlayer.getInventoryItem('money').count >= price then
  xPlayer.removeInventoryItem('money', price)

  TriggerClientEvent('esx:showNotification', _source, _U('you_paid') .. price)
  TriggerClientEvent('esx_dmvschool:startdrivetest1paid', source, type)
  else 
    TriggerClientEvent('esx:showNotification', _source, 'You Don\'t have Enough Money you need $' .. price)
  end

end)
