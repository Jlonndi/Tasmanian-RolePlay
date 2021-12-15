ESX = nil
position = {}

TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)



RegisterServerEvent("barbershop:pay")
AddEventHandler("barbershop:pay", function(source, price)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer.getInventoryItem('money').count >= price then
        xPlayer.removeInventoryItem('money', price)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Paid', style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
        print('Paid')
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Not Enough Money', style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
        print('not enough money')
    end
end)


ESX.RegisterServerCallback('barbershop:checkposition', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local identifier = xPlayer.identifier
    if #position > 0 then
        cb(false)
    else
        table.insert(position, identifier)
        cb(true)
    end
end)

AddEventHandler('esx:playerDropped', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local identifier = xPlayer.identifier
    if #position > 0 then
        if identifier == position[1] then
            table.remove(position, 1)
        end
    end
end)

RegisterServerEvent('barbershop:removeposition')
AddEventHandler('barbershop:removeposition', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local identifier = xPlayer.identifier
    if #position > 0 then
        if identifier == position[1] then
            table.remove(position, 1)
        end
    end
end)