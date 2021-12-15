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
    Surge landscaping Squiddy Approves]] 
    
print(label)

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

ESX.RegisterServerCallback('Surge:GETLANDSCAPERXP', function(source, cb)
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

RegisterServerEvent('Surge:doRewardLandscaper')
AddEventHandler('Surge:doRewardLandscaper', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local identifier = xPlayer.getIdentifier()
    MySQL.Async.fetchAll('select landlevel from users where identifier = @identifier', {['@identifier'] = identifier}, function(result)
        local exp = nil
        local landlevel = result[1].landlevel
        local pay = 400 -- base pay
        local val = nil
        if landlevel >= 0 and landlevel < 3000 then
            val = math.random(100, 250)
            pay = pay + val 
            exp = math.random(100, 240)
        elseif landlevel >= 3000 and landlevel < 8000 then
            val = math.random(100, 250)
			pay = pay + val
            exp = math.random(300, 450)
		elseif landlevel >= 8000 and landlevel < 25000 then
			val = math.random(100, 250)
            pay = pay + val 
            exp = math.random(350, 700)
		elseif landlevel >= 25000 then
			val = math.random(100, 250)
            pay = pay + val
            exp = math.random(400, 800)
		end
		xPlayer.addInventoryItem('money', pay) -- pay more on xp level
    MySQL.Sync.execute('update users set landlevel = @landlevel where identifier = @identifier', {['@identifier'] = identifier, ['@landlevel'] = landlevel + exp })
end)
end)
--Start functions

ESX.RegisterUsableItem('landscaperStart', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('startlandscape', _source)
    --TriggerClientEvent('Surge:jobs:doFindYard', _source)	
end)
-- DO functions
ESX.RegisterUsableItem('landscaperTools', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('landscapeactive', _source)
    --TriggerClientEvent('Surge:jobs:doStartLandscaping', _source)	
end)
-- Finish functions
ESX.RegisterUsableItem('landscaperFinish', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('landscapefinish', _source)
    --TriggerClientEvent('Surge:jobs:doCancelLandscaping', _source)	
end)

RegisterServerEvent('Surge:core:landscapegiveitems')
AddEventHandler('Surge:core:landscapegiveitems', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.setInventoryItem('landscaperStart', 1)
    xPlayer.setInventoryItem('landscaperTools', 1)
    xPlayer.setInventoryItem('landscaperFinish', 1)
end)

RegisterServerEvent('Surge:core:removelandscapingitems')
AddEventHandler('Surge:core:removelandscapingitems', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.setInventoryItem('landscaperStart', 0)
    xPlayer.setInventoryItem('landscaperTools', 0)
    xPlayer.setInventoryItem('landscaperFinish', 0)
end)