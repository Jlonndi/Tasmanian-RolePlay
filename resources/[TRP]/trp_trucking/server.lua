    local label =[[                                /`--._   _.---'`-._
                               / /`-. \-'     `-._.-'
                             .'\ `-./ /`-/`--._  `-._
                           /`-._`-._.'`-/ /`-._`.    `-._
                          .---.  `-._.--. \    \ \       `._
                         /     \.--.     \ `-._| |          `-._
                        /     .'     \   |`-..__/           `-._`-._
                       /     /       |   |  |  |          `-.__.`-._.'
                      | .-. /  .-.  /    \  |  /          `._.-'
                   .-`\/ O /  / O \/ __   \ | | .`_..---..  `._
                  /    `-./_ .---.'     `-._| / `-._      `-._.'
                  |.'          .' _.--.     \/`-._.-'
\`-......______.-`          .' _.'     )   .'
 `-._                       _.'   _..-' _.'
     `-._               _.-' _.--' _..-'
         `-..________.-`-._.'   .-'
                      \       .'
                     _|      /
             _...---` '_..--'|
            / `-.__.--'  _.-._\
            \`-._/    _.' .-../
             `-._\_.-'   /    `.
               /\        |      `.._
              / |        |          `-.
             /  |        |`.           \ 
           .'  _|        |  `-._./     /
          /   ` |        |     .'    .'_       _.-._.--._
          \     |    .-. |\   '.____/.' \  _.-'          \
           `._ /     | | | \  '.____/  .'.`_.-.-.-._.-._.'
              /      | `-'  \ |     \ <._  `--._.--._.-_-._
             /    _.-'       \\     |    `-._.-._.-._      `-._
            `----' |          \`.  /   `-._)         `-.._      \
             /_.- .'\         |  `.   `-.._)              `-.._.'
             |_.-'  .\        |    `-..___)
               \_.-` '`-.____/           |
                    /     `._            |
                   /          `.         |
     TRP          |           /|         |
           __.----'.         / |-.._...-'`-.._
        .-'         `-...--'\  |              `-._
       /    .---            |  |          `-._    \
       |  .'                /  \              `.   |
       `./                .'    `.              \ .'
         `.           _.-'        `._           .`
           '---...--'`               '--.....--`
                Tasmania Trucking is here to serve!]]
TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

ESX.RegisterServerCallback('trp:jobs:getTruckingXP', function(source, cb) -- TODO CX ADD XP FUNCTION
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xp = 199
    cb(xp)
    print(xp)
end)
RegisterServerEvent('trp:jobs:doRewardTrucking')
AddEventHandler('trp:jobs:doRewardTrucking', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addInventoryItem('money', amount)
end)

ESX.RegisterUsableItem('truckersGPS', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('starttruckingjob', _source)
    --TriggerClientEvent('trp:jobs:doFindTruckingLocation', _source)	
end)

ESX.RegisterUsableItem('TruckingDeliver', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('truckingdeliver', _source)
    --TriggerClientEvent('trp:job:delivertrucking', _source)	
end) 
ESX.RegisterUsableItem('TruckingFinish', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('stoptruckingjob', _source)
    --TriggerClientEvent('trp:jobs:doCancelTrucking', _source)	
end) 


RegisterServerEvent('trp:core:truckgiveitems')
AddEventHandler('trp:core:truckgiveitems', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.setInventoryItem('truckersGPS', 1)
    xPlayer.setInventoryItem('TruckingDeliver', 1)
    xPlayer.setInventoryItem('TruckingFinish', 1)
end)
RegisterServerEvent('trp:core:removetruckingitems')
AddEventHandler('trp:core:removetruckingitems', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.setInventoryItem('truckersGPS', 0)
    xPlayer.setInventoryItem('TruckingDeliver', 0)
    xPlayer.setInventoryItem('TruckingFinish', 0)
end)