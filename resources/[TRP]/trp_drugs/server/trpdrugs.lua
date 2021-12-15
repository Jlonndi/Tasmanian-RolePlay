local playersProcessing = {}
ESX = nil
local label = 
[[
                                    _____
                              _.--""     ""--._
                          _.-"                 "-._
                        .F                         Y.
                      .F                             Y.
                     /   ..___                 ___..   \
                    F   /   | """""-------""""" |   \   Q
                   F   F    (.-"""-.     .-"""-.)    Q   Q
                  F   F    .'       `. .'       `.    Q   Q
                 J   F    /|    o    | |    o    |\    Q   L
                 |  J     .`.       .' `.       .'.     L  |
                 |  F    ( " `-...-'(   )'-...-' " )    Q  |
                 | |      `.    _.-' '-' `-._    .'      | |
                 Y |        L .'             `. J        | J
                  L|        Q'                 `F        |J
                   Q        |                   |        J
                    L       C                   D       J
                     \      \  ---...____..---  /     _/
                      `L .-' `.               .' `-. P
                       |`L   (|`-.__     __.-'|)   J'|__
                       |  `-._`-..__"""""__..-'_.-'  |  """..
           _..--""-..-' `.    `-..__"""""__..-"    .'\       `-.
        .-"         L     `-._      """""      _.-'   L  *****:::.
      ."            |         ""--.........--""        Q  *****...L
     /"""""--..     F    .-""-.      |\ \               L  ::::::::L
    J  ("  /| J    J   .' _/\_ `.    |_\ \              |   L____...L
    F ._) /"| F    |   |  >..<  |    | |\.'             |            Q
   J-----..._J     F   `.==..==.'    |_|                Q             L
   F              J      '-..-'      | |                `.             Q
  J               F                  |_|                  Q             Q
 /               J                   | |                   L             L
 F           __ J                    |_|                    Q            Q
J           `._\|                    | |                     L            L
F              ""L      .-""-.       |_|       .-""-.         L           Q
Q                |    .'  ..  `.     | |     .'  ..  `.       |.__   __..::
 L               |    |  (  )  |     |_|     |  (  )  |       |':::::::''' |
 Q               Q    `.  ''  .'     | |     `.  ''  .'       |            |
  L               L     `-..-'       |_|       `-..-'         J.-.         |
   Q            _..Q                                         J'  J   .  |  J
    L   __....:::'' \                                        F  J   J  J._J
     L::::''''       Q                                      J  (  _J._,"
      L               `.                                    Q_  `"
      |          ."`.   )                           __...--"" \
      |          Q   "-'                          .'\          L
      Q   L  L    L                              <   Q       ___Q
       L  Q   Q    `.            ""TTTT--""       \   L--""""    L
        '_.`.  `.    )            J     Q          Q  Q           |
         J   `-' `-.'.._         |       L          L  L          Q
         F            F `.       F       |          Q  |           L
        L""""""--..._|   F      J        Q           L  Q   ___..--'
        |           F   |       |         L          '---"""       |
        |           |  J        F          L                       Q
        |           |  |       |           Q                        L
        ."""""---.._|  |     `.F            L                       |
         `"""----.___`.|     ._)            Q                       Q
          L          ""       )             |                        L
          |                   Q             L                        L
          Q                    L             |                       |
           L                    L            |                      J
            Q                   Q            F                      F
             L                  .L          J                      J
              Q             _..:' `.        |                      |
               `.    ___...::''.   `.       |                      |
                 `::::::'''    J    :       Q                      F
                .' ___        J    .:        L                    J
               J"""   "".._  .    .:'       .'::...___            |
              J            '/    .:'       J  `.'''::::........:::'Q
             F                 .::'        L    `.     ''''''''    'L
             L               .::'          :.     L__   __..---..-' Q
             :.            .::'            `:.       """             L
              ':.._  _...::''               `::                      |
                `':::::''                     ::.                    |
                                                ::.                  |
             TassieRP Drugs Is Running Homer     `::.              J
                   Is Ready for Duty                `'::..__   __..:'
                                                       `'::::::::''
]]
print(label)
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('TRP-Drugs:giveESX')
AddEventHandler('TRP-Drugs:giveESX', function()
    TriggerClientEvent('TRP-Drugs:getESX', source)
end)

SwapZones = function()
    math.randomseed(os.time())
    if Config then
        if Config.Zones then
            for k, v in pairs(Config.Zones) do
                local zoneVal = math.random(#Config.Zones[k])
                local newZone = Config.Zones[k][zoneVal]
                if Config.Drugs then
                    Config.Drugs[k] = newZone
                else
                    print('config drugs error')
                end
            end
            TriggerClientEvent('TRP-Drugs:getZones', -1, Config.Drugs)
        else
            print('config zone error')
        end
    else
        print('config error')
    end
end

if Config then
    if Config.Swap then
        if Config.Swap.Once then
            SwapZones()
        else
            Citizen.CreateThread(function()
                while true do
                    SwapZones()
                    Citizen.Wait(Config.Swap.Wait * 60000)
                end
            end)
        end
    else
        print('config swap error')
    end
else
    print('config error')
end

CancelProcessing = function(playerID)
    if playerID ~= nil and playerID ~= 0 and type(playerID) == 'number' then
        if playersProcessing[playerID] then
            ESX.ClearTimeout(playersProcessing[playerID])
            playersProcessing[playerID] = nil
        end
    else
        print('player error')
    end
end

hasCopJob = function(PlayerData)
    local worker = false
    if PlayerData ~= nil and type(PlayerData) == 'table' then
        if Config then
            if Config.Jobs then
                if Config.Jobs.Police then
                    for i = 1, #Config.Jobs.Police do
                        if PlayerData.job.name == Config.Jobs.Police[i] then
                            worker = true
                        end
                    end
                else
                    print('police job error')
                end
            else
                print('config job error')
            end
        else
            print('config error')
        end
        return worker
    else
        print('error for playerdata')
    end
end

ESX.RegisterServerCallback('TRP-Drugs:areEnoughCopsOn', function(source, cb, drug, selling)
    local xPlayers = ESX.GetPlayers()
    local copsOn = 0
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer ~= nil and type(xPlayer) == 'table' then
            if hasCopJob(xPlayer) then
                copsOn = copsOn + 1
            end
        else
            print('error for xPlayer')
        end
    end
    if Config then
        if selling then
            if Config.SellableDrugs then
                if Config.SellableDrugs[drug] then
                    if Config.SellableDrugs[drug].copsNeeded then
                        if copsOn >= Config.SellableDrugs[drug].copsNeeded then
                            cb(true)
                        else
                            cb(false)
                        end
                    else
                        print('cops needed error')
                    end
                else
                    print('sellable drug error')
                end
            else
                print('config sellable drug error')
            end
        else
            if Config.Drugs then
                if Config.Drugs[drug] then
                    if Config.Drugs[drug].reqCops then
                        if Config.Drugs[drug].reqCops ~= 0 then
                            if copsOn >= Config.Drugs[drug].reqCops then
                                cb(true)
                            else
                                cb(false)
                            end
                        else
                            cb(true)
                        end
                    else
                        print('req cops error')
                    end
                else
                    print('drugs drug error')
                end
            else
                print('config drugs error')
            end
        end
    else
        print('config error')
    end
end)

ESX.RegisterServerCallback('TRP-Drugs:getItemAmount', function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and type(xPlayer) == 'table' then
        local xItem = xPlayer.getInventoryItem(item)
        if xItem ~= nil and type(xItem) == 'table' then
            local canCarry = false
            if xItem.count and type(xItem.count) == 'number' then
                local quantity = xItem.count
                if quantity == nil then
                    quantity = 0
                end
                if xPlayer.canCarryItem == nil then
                    if xItem.limit and type(xItem.limit) == 'number' then
                        if xItem.limit == -1 or (quantity < xItem.limit) then
                            canCarry = true
                        end
                    else
                        cb(0, false)
                        print('limit error')
                    end
                else
                    if xItem.name then
                        if xPlayer.canCarryItem(xItem.name, 1) then
                            canCarry = true
                        end
                    else
                        cb(0, false)
                        print('name error')
                    end
                end
                cb(quantity, canCarry)
            else
                cb(0, false)
                print('count error')
            end
        else
            Notify(xPlayer.source, 'No item found for ' .. item)
            cb(0, false)
            print('error for item')
        end
    else
        print('error for xPlayer')
    end
end)

ESX.RegisterServerCallback("TRP-Drugs:getPlayerDrugs", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and type(xPlayer) == 'table' then
        local inventory = {}
        if Config then
            if Config.SellableDrugs then
                for k, v in ipairs(xPlayer.inventory) do
                    if Config.SellableDrugs[v.name] then
                        if v.count > 0 then
                            table.insert(inventory, v)
                        end
                    end
                end
                cb(inventory)
            else
                print('sellable drugs error')
            end
        else
            print('config error')
        end
    else
        print('error for xPlayer')
    end
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
    CancelProcessing(playerID)
end)

RegisterServerEvent('TRP-Drugs:giveZones')
AddEventHandler('TRP-Drugs:giveZones', function()
    local src = source
    if Config then
        if Config.Drugs ~= nil and type(Config.Drugs) == 'table' then
            TriggerClientEvent('TRP-Drugs:getZones', src, Config.Drugs)
        else
            print('config drugs error')
        end
    else
        print('config error')
    end
end)

RegisterServerEvent('TRP-Drugs:copsCalled')
AddEventHandler('TRP-Drugs:copsCalled', function()
    local src = source
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if hasCopJob(xPlayer) then
            TriggerClientEvent('TRP-Drugs:callCops', xPlayer.source, src)
        end
    end
end)

RegisterServerEvent('TRP-Drugs:pickedUpPlant')
AddEventHandler('TRP-Drugs:pickedUpPlant', function(drug, maxPick)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer ~= nil and type(xPlayer) == 'table' then
        local xItem = xPlayer.getInventoryItem(drug)
        if maxPick == nil or tonumber(maxPick) == nil then
            maxPick = 1
        end
        local picked = math.random(tonumber(maxPick))
        if xItem ~= nil and type(xItem) == 'table' then
            if xPlayer.canCarryItem == nil then
                if xItem.limit then
                    if xItem.count then
                        if xItem.limit ~= -1 and (xItem.count + picked) > xItem.limit then
                            local reroll = (xItem.limit - xItem.count)
                            if Config then
                                if Config.Strings then
                                    if Config.Strings.tooMany then
                                        Notify(xPlayer.source, Config.Strings.tooMany:format(drug, reroll))
                                    else
                                        print('tooMany string error')
                                    end
                                else
                                    print('config strings error')
                                end
                            else
                                print('config error')
                            end
                            xPlayer.addInventoryItem(xItem.name, reroll)
                        else
                            TriggerClientEvent('trp-core:druggatherweed', src, xItem.name, picked)
                            print('this is working')
                            xPlayer.addInventoryItem(xItem.name, picked)
                            print('Huh Someones stealing drugs')
                        end
                    else
                        print('count error')
                    end
                else
                    print('limit error')
                end
            else
                if xItem.name then
                    if xPlayer.canCarryItem(xItem.name, picked) then
                        xPlayer.addInventoryItem(xItem.name, picked)
                    elseif xPlayer.canCarryItem(xItem.name, 1) then
                        if Config then
                            if Config.Strings then
                                if Config.Strings.tooMany then
                                    Notify(xPlayer.source, Config.Strings.tooMany:format(drug, 1))
                                else
                                    print('tooMany string error')
                                end
                            else
                                print('config strings error')
                            end
                        else
                            print('config error')
                        end
                        xPlayer.addInventoryItem(xItem.name, 1)
                    end
                else
                    print('name error')
                end
            end
        else
            Notify(xPlayer.source, 'No item found for ' .. drug)
            print('item error')
        end
    else
        print('xPlayer error')
    end
end)

RegisterServerEvent('TRP-Drugs:soldDrugs')
AddEventHandler('TRP-Drugs:soldDrugs', function(drug, amount, price, stolen)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer ~= nil and type(xPlayer) == 'table' then
        local xItem = xPlayer.getInventoryItem(drug.name)
        if xItem ~= nil and type(xItem) == 'table' then
            if xItem.name then
                if stolen ~= nil then
                    xPlayer.removeInventoryItem(xItem.name, xItem.count)
                else
                    TriggerClientEvent('trp-core:druglog', src, xItem.name, amount, price, price)
                    print('working2')
                    xPlayer.removeInventoryItem(xItem.name, amount)
                    if Config then
                        if Config.SellableDrugs then
                            if Config.SellableDrugs[xItem.name] then
                                if Config.SellableDrugs[xItem.name].account then
                                    if Config.SellableDrugs[drug.name].account ~= 'money' then
                                        xPlayer.addInventoryItem('black_money', price)
                                    else
                                        xPlayer.addInventoryItem('black_money', price)
                                    end
                                else
                                    print('account error')
                                end
                            else
                                print('sellable drug drug error')
                            end
                        else
                            print('config sellable drug error')
                        end
                    else
                        print('config error')
                    end
                end
            else
                print('name error')
            end
        else
            Notify(xPlayer.source, 'No item found for ' .. drug)
            print('item error')
        end
    else
        print('xPlayer error')
    end
end)

RegisterServerEvent('TRP-Drugs:convertTo')
AddEventHandler('TRP-Drugs:convertTo', function(data)
    local src = source
    if Config then
        if not playersProcessing[src] then
            if data then
                if data.delay then
                    playersProcessing[src] = ESX.SetTimeout(data.delay, function()
                        local xPlayer = ESX.GetPlayerFromId(src)
                        if xPlayer ~= nil and type(xPlayer) == 'table' then
                            if data.lastdrug then
                                if data.name then
                                    local xdrug1, xdrug2 = xPlayer.getInventoryItem(data.lastdrug), xPlayer.getInventoryItem(data.name)
                                    if Config.Strings then
                                        if data.reward then
                                            if data.cost then
                                                if data.label then
                                                    if xdrug1 ~= nil and type(xdrug1) == 'table' then
                                                        if xdrug2 ~= nil and type(xdrug2) == 'table' then
                                                            if xPlayer.canCarryItem == nil then
                                                                if xdrug1.limit then
                                                                    if xdrug1.count then
                                                                        if xdrug2.limit then
                                                                            if xdrug2.count then
                                                                                if xdrug2.limit ~= -1 and (xdrug2.count + data.reward) > xdrug2.limit then
                                                                                    if Config.Strings.cantCarry then
                                                                                        Notify(xPlayer.source, Config.Strings.cantCarry:format(data.label))
                                                                                    else
                                                                                        print('cant carry error')
                                                                                    end
                                                                                elseif xdrug1.count < data.cost then
                                                                                    if Config.Strings.notEnough then
                                                                                        if Config.Drugs then
                                                                                            if Config.Drugs[data.lastdrug] then
                                                                                                if Config.Drugs[data.lastdrug].label then
                                                                                                    if Config.Strings.notEnough then
                                                                                                        Notify(xPlayer.source, Config.Strings.notEnough:format(Config.Drugs[data.lastdrug].label))
                                                                                                    else
                                                                                                        print('not enough string error')
                                                                                                    end
                                                                                                else
                                                                                                    print('last drug label error')
                                                                                                end
                                                                                            else
                                                                                                print('config drugs last drug error')
                                                                                            end
                                                                                        else
                                                                                            print('config drugs error')
                                                                                        end
                                                                                    else
                                                                                        print('not enough strings error') end
                                                                                else
                                                                                    if Config.Strings.didProcess then
                                                                                        if Config.Drugs then
                                                                                            if Config.Drugs[data.lastdrug] then
                                                                                                if Config.Drugs[data.lastdrug].label then
                                                                                                    if Config.Strings.didProcess then
                                                                                                        local text = Config.Strings.didProcess:format(data.cost, Config.Drugs[data.lastdrug].label, data.reward, data.label)
                                                                                                        if data.lastdrug == 'marijuana' then
                                                                                                            
                                                                                                            if Config.Strings.didRoll then
                                                                                                                
                                                                                                                text = Config.Strings.didRoll:format(data.cost, Config.Drugs[data.lastdrug].label, data.reward, data.label)
                                                                                                            
                                                                                                            else
                                                                                                                
                                                                                                                print('did roll string error')
                                                                                                            
                                                                                                            end
                                                                                                        end
                                                                                                        if data.reqitem ~= nil and type(data.reqitem) == 'string' then
                                                                                                            
                                                                                                            if Config.Strings.whileUse then
                                                                                                                
                                                                                                                text = text .. Config.Strings.whileUse:format(data.reqitemname)
                                                                                                            
                                                                                                            else
                                                                                                                
                                                                                                                print('while use string error')
                                                                                                            
                                                                                                            end
                                                                                                            
                                                                                                            if data.reqitemremove then
                                                                                                                
                                                                                                                xPlayer.removeInventoryItem(data.reqitem, 1)
                                                                                                            
                                                                                                            end
                                                                                                        end
                                                                                                        xPlayer.removeInventoryItem(data.lastdrug, data.cost)
                                                                                                        TriggerClientEvent('trp-core:combinedrug', src, data.name, data.reward)
                                                                                                        print('working')
                                                                                                        xPlayer.addInventoryItem(data.name, data.reward)
                                                                                                        print('item added')
                                                                                                        Notify(xPlayer.source, text)
                                                                                                    else
                                                                                                        print('did process string error')
                                                                                                    end
                                                                                                else
                                                                                                    print('last drug label error')
                                                                                                end
                                                                                            else
                                                                                                print('config drugs last drug error')
                                                                                            end
                                                                                        else
                                                                                            print('config drugs error')
                                                                                        end
                                                                                    else
                                                                                        print('did proces string error')
                                                                                    end
                                                                                end
                                                                            else
                                                                                print('drug2 count error')
                                                                            end
                                                                        else
                                                                            print('drug2 limit error')
                                                                        end
                                                                    else
                                                                        print('drug1 count error')
                                                                    end
                                                                else
                                                                    print('drug1 limit error')
                                                                end
                                                            else
                                                                xPlayer.removeInventoryItem(data.lastdrug, data.cost)
                                                                if xPlayer.canCarryItem(data.name, data.reward) then
                                                                    if xdrug1.count < data.cost then
                                                                        if Config.Strings.notEnough then
                                                                            if Config.Drugs then
                                                                                if Config.Drugs[data.lastdrug] then
                                                                                    if Config.Drugs[data.lastdrug].label then if Config.Strings.notEnough then
                                                                                        Notify(xPlayer.source, Config.Strings.notEnough:format(Config.Drugs[data.lastdrug].label))
                                                                                    else
                                                                                        print('not enough string error')
                                                                                    end
                                                                                    else
                                                                                        print('last drug label error')
                                                                                    end
                                                                                else
                                                                                    print('config drugs last drug error')
                                                                                end
                                                                            else
                                                                                print('config drugs error')
                                                                            end
                                                                        else
                                                                            print('not enough strings error')
                                                                        end
                                                                        xPlayer.addInventoryItem(data.lastdrug, data.cost)
                                                                    else
                                                                        if Config.Strings.didProcess then
                                                                            if Config.Drugs then
                                                                                if Config.Drugs[data.lastdrug] then
                                                                                    if Config.Drugs[data.lastdrug].label then if Config.Strings.didProcess then local text = Config.Strings.didProcess:format(data.cost, Config.Drugs[data.lastdrug].label, data.reward, data.label)
                                                                                        if data.lastdrug == 'marijuana' then
                                                                                            if Config.Strings.didRoll then
                                                                                                text = Config.Strings.didRoll:format(data.cost, Config.Drugs[data.lastdrug].label, data.reward, data.label)
                                                                                            else
                                                                                                print('did roll string error')
                                                                                            end
                                                                                        end
                                                                                        if data.reqitem then
                                                                                            if Config.Strings.whileUse then
                                                                                                text = text .. Config.Strings.whileUse:format(data.reqitemname)
                                                                                            else
                                                                                                print('while use string error')
                                                                                            end
                                                                                            if data.reqitemremove then
                                                                                                xPlayer.removeInventoryItem(data.reqitem, 1)
                                                                                            end
                                                                                        end
                                                                                        xPlayer.addInventoryItem(data.name, data.reward)
                                                                                        
                                                                                        Notify(xPlayer.source, text)
                                                                                    else
                                                                                        print('did process string error')
                                                                                    end
                                                                                    else
                                                                                        print('last drug label error')
                                                                                    end
                                                                                else
                                                                                    print('config drugs last drug error')
                                                                                end
                                                                            else
                                                                                print('config drugs error')
                                                                            end
                                                                        else
                                                                            print('did proces string error')
                                                                        end
                                                                    end
                                                                else
                                                                    if Config.Strings.cantCarry then
                                                                        Notify(xPlayer.source, Config.Strings.cantCarry:format(data.label))
                                                                    else
                                                                        print('cant carry string error')
                                                                    end
                                                                    xPlayer.addInventoryItem(data.lastdrug, data.cost)
                                                                end
                                                            end
                                                            playersProcessing[src] = nil
                                                        else
                                                            Notify(xPlayer.source, 'No item found for ' .. data.lastdrug)
                                                            print('item2 error')
                                                        end
                                                    else
                                                        Notify(xPlayer.source, 'No item found for ' .. data.name)
                                                        print('item1 error')
                                                    end
                                                else
                                                    print('data label error')
                                                end
                                            else
                                                print('cost error')
                                            end
                                        else
                                            print('reward error')
                                        end
                                    else
                                        print('config string error')
                                    end
                                else
                                    print('name error')
                                end
                            else
                                print('lastdrug error')
                            end
                        else
                            print('error for xPlayer')
                        end
                    end)
                else
                    print('delay error')
                end
            else
                print('data error')
            end
        end
    else
        print('config error')
    end
end)

RegisterServerEvent('TRP-Drugs:cancelProcessing')
AddEventHandler('TRP-Drugs:cancelProcessing', function()
    CancelProcessing(source)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
    CancelProcessing(source)
end)

ESX.RegisterUsableItem('marijuana', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and type(xPlayer) == 'table' then
        local wraps = xPlayer.getInventoryItem('bluntwrap')
        if wraps ~= nil and type(wraps) == 'table' then
            if wraps.count and type(wraps.count) == 'number' then
                if wraps.count > 0 then
                    TriggerClientEvent('TRP-Drugs:useItem', xPlayer.source, 'marijuana')
                else
                    if Config then
                        if Config.Strings then
                            if Config.Strings.cantRoll then
                                Notify(source, Config.Strings.cantRoll)
                            else
                                print('cantroll string error')
                            end
                        else
                            print('config strings error')
                        end
                    else
                        print('config error')
                    end
                end
            else
                print('count error')
            end
        else
            print('item error')
        end
    else
        print('xPlayer error')
    end
end)
