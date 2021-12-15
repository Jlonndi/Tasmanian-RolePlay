local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function FindSQLname(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]
		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
		    name = identity['name'],
		}
	else
		return nil	
	end
end

RegisterServerEvent('CheckHandsUpRob')
AddEventHandler('CheckHandsUpRob', function(ClosestPlayer)
    print(ClosestPlayer)
    print(source)
local src = source 
TriggerClientEvent('ishandsup', ClosestPlayer, source, ClosestPlayer)
end)
RegisterServerEvent('canRob')
AddEventHandler('canRob', function(RobPlayer, ClosestPlayer)
print('this is canrob')
print(RobPlayer)
print(ClosestPlayer)
TriggerClientEvent('RobPerson', ClosestPlayer, RobPlayer)
end)

RegisterServerEvent('CannotRob')
AddEventHandler('CannotRob', function(RobPlayer, ClosestPlayer)
local src = source 
TriggerClientEvent('CannotRobPerson', RobPlayer)
end)
