local label = [[
       .--'''''''''--.
    .'      .---.      '.
   /    .-----------.    \
  /        .-----.        \
  |       .-.   .-.       |
  |      /   \ /   \      |
   \    | .-. | .-. |    /
    '-._| | | | | | |_.-'
        | '-' | '-' |
         \___/ \___/
      _.-'  /   \  `-._
    .' _.--|     |--._ '.
    ' _...-|     |-..._ '
           |     |
           '.___.'
             | |
            _| |_
           /\( )/\
          /  ` '  \
         | |     | |
         '-'     '-'
         | |     | |
         | |     | |
         | |-----| |
      .`/  |     | |/`.
      |    |     |    |
      '._.'| .-. |'._.'
            \ | /
            | | |
            | | |
            | | |
           /| | |\
         .'_| | |_`.
TRP       `.| | | .'
      .    /  |  \    .
     /o`.-'  / \  `-.`o\
    /o  o\ .'   `. /o  o\
    `.___.'       `.___.'
    Surge Welding Squiddy Approves]] 
    
print(label)

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

ESX.RegisterServerCallback('Surge:GETWeldingXP', function(source, cb)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local identifier = xPlayer.getIdentifier()
    Citizen.Wait(1000)
    MySQL.Async.fetchAll('select * from users where identifier = @identifier', {['@identifier'] = identifier}, function(result)
    local landlevel = result[1].landlevel -- not pretty but does job
    cb(landlevel)
    print(landlevel)
    end)
end)

RegisterServerEvent('Surge:doRewardWelding')
AddEventHandler('Surge:doRewardWelding', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local identifier = xPlayer.getIdentifier()
    MySQL.Async.fetchAll('select * from users where identifier = @identifier', {['@identifier'] = identifier}, function(result)
        local landlevel = result[1].landlevel
        local pay = 600 -- base pay
        if landlevel <= 50 then 
            pay = math.random(430, 850)
        elseif landlevel >= 50 and landlevel < 100 then
			pay = pay + 300
		elseif landlevel >= 150 and landlevel < 300 then
			pay = pay + 600
		elseif landlevel >= 500 then
			pay = pay + 900
		end
		xPlayer.addInventoryItem('money', pay) -- pay more on xp level
    MySQL.Sync.execute('update users set landlevel = @landlevel where identifier = @identifier', {['@identifier'] = identifier, ['@landlevel'] = landlevel + 1})
end)
end)
--Start functions

ESX.RegisterUsableItem('WeldingStart', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('startWelding', _source)
    --TriggerClientEvent('Surge:jobs:doFindYard', _source)	
end)
-- DO functions
ESX.RegisterUsableItem('WeldingTools', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('Weldingactive', _source)
    --TriggerClientEvent('Surge:jobs:doStartWelding', _source)	
end)
-- Finish functions
ESX.RegisterUsableItem('WeldingFinish', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('Weldingfinish', _source)
    --TriggerClientEvent('Surge:jobs:doCancelWelding', _source)	
end)

RegisterServerEvent('Surge:core:Weldinggiveitems')
AddEventHandler('Surge:core:Weldinggiveitems', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.setInventoryItem('WeldingStart', 1)
    xPlayer.setInventoryItem('WeldingTools', 1)
    xPlayer.setInventoryItem('WeldingFinish', 1)
end)

RegisterServerEvent('Surge:core:removeWeldingitems')
AddEventHandler('Surge:core:removeWeldingitems', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.setInventoryItem('WeldingStart', 0)
    xPlayer.setInventoryItem('WeldingTools', 0)
    xPlayer.setInventoryItem('WeldingFinish', 0)
end)