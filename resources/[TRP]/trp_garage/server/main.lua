ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)

	ESX = obj

end)
-------------------------------------------------------------------------------------------------------------------------------
-- AUTOMATIC IMPOUNDS ACTIVE VEHICLES EVERY 2 HOURS.....                                                                     --
-------------------------------------------------------------------------------------------------------------------------------

local label = 
[[
	 _______ _____  _____        _____          _____            _____ ______ 
	|__   __|  __ \|  __ \      / ____|   /\   |  __ \     /\   / ____|  ____|
	   | |  | |__) | |__) |    | |  __   /  \  | |__) |   /  \ | |  __| |__   
	   | |  |  _  /|  ___/     | | |_ | / /\ \ |  _  /   / /\ \| | |_ |  __|  
	   | |  | | \ \| |         | |__| |/ ____ \| | \ \  / ____ \ |__| | |____ 
	   |_|  |_|  \_\_|          \_____/_/    \_\_|  \_\/_/    \_\_____|______|																																																																										   
]]

local print69420 = [[

          _    _ _______ ____  __  __       _______ _____ _____   _____ __  __ _____   ____  _    _ _   _ _____  
     /\  | |  | |__   __/ __ \|  \/  |   /\|__   __|_   _/ ____| |_   _|  \/  |  __ \ / __ \| |  | | \ | |  __ \ 
    /  \ | |  | |  | | | |  | | \  / |  /  \  | |    | || |        | | | \  / | |__) | |  | | |  | |  \| | |  | |
   / /\ \| |  | |  | | | |  | | |\/| | / /\ \ | |    | || |        | | | |\/| |  ___/| |  | | |  | | . ` | |  | |
  / ____ \ |__| |  | | | |__| | |  | |/ ____ \| |   _| || |____   _| |_| |  | | |    | |__| | |__| | |\  | |__| |
 /_/    \_\____/   |_|  \____/|_|  |_/_/    \_\_|  |_____\_____| |_____|_|  |_|_|     \____/ \____/|_| \_|_____/ 

            _____ _______ _______      ________  __      ________ _    _ _____ _____ _      ______  _____ 
     /\   / ____|__   __|_   _\ \    / /  ____| \ \    / /  ____| |  | |_   _/ ____| |    |  ____|/ ____|
    /  \ | |       | |    | |  \ \  / /| |__     \ \  / /| |__  | |__| | | || |    | |    | |__  | (___  
   / /\ \| |       | |    | |   \ \/ / |  __|     \ \/ / |  __| |  __  | | || |    | |    |  __|  \___ \ 
  / ____ \ |____   | |   _| |_   \  /  | |____     \  /  | |____| |  | |_| || |____| |____| |____ ____) |
 /_/    \_\_____|  |_|  |_____|   \/   |______|     \/   |______|_|  |_|_____\_____|______|______|_____/ 
                                                                                                                                                                                                                                                                                                                                                                                                                                           
]]



local second = 1000
local minute = 60 * second
local hour = 60 * minute
local twohour = 2 * hour

AddEventHandler('onResourceStart', function(resourceName)

	if (GetCurrentResourceName() ~= resourceName) then

	  return

	end

	Citizen.Wait(20000) -- delay for database to stop fucking ESX from FUCKING UP

	MySQL.Sync.execute('UPDATE owned_vehicles SET state=0 WHERE state=8', {}) -- force states 

	print(label)

    TriggerEvent('TRP:LOOP2HOURLY') -- loops 2 hourly 

end)

RegisterServerEvent('TRP:LOOP2HOURLY') -- FORCES STATE 0

AddEventHandler('TRP:LOOP2HOURLY', function(plate, stored)
    
    Citizen.Wait(twohour)
	
    MySQL.Sync.execute('UPDATE owned_vehicles SET state=0 WHERE state=8', {}) -- force states 

	print(print69420)
    
    TriggerEvent('TRP:LOOP2HOURLY') -- loops 2 hourly 

end)

ESX.RegisterServerCallback('trp_garage:loadVehicles', function(source, cb) -- loads state for garage.

	local _source = source

    local xPlayer = ESX.GetPlayerFromId(_source)

    local vehicules = {}

    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner=@identifier', {
        ['@identifier'] = xPlayer.getIdentifier()
    }, function(data)
		
        for _, v in pairs(data) do

            local vehicle = json.decode(v.vehicle)

            table.insert(vehicules, {

                vehicle = vehicle,

                state = v.state,

                plate = v.plate

            })

        end

        cb(vehicules)

	end)

end)


ESX.RegisterServerCallback('trp_garage:canYouPay', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)

    local price = 500

	if xPlayer.getInventoryItem('money').count >= price then

		xPlayer.removeInventoryItem('money', price)

		cb(true)

	else

		cb(false)

	end

end)

ESX.RegisterServerCallback('trp_garage:loadVehicle', function(source, cb, plate)

	local s = source

	local x = ESX.GetPlayerFromId(s)	

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {['@plate'] = plate}, function(vehicle)

		cb(vehicle)

	end)

end)

ESX.RegisterServerCallback('trp_garage:isOwned', function(source, cb, plate)
	
	local s = source
	
	local x = ESX.GetPlayerFromId(s)	
	
	MySQL.Async.fetchAll('SELECT vehicle FROM owned_vehicles WHERE plate = @plate AND owner = @owner', {['@plate'] = plate, ['@owner'] = x.identifier}, function(vehicle)
		
		if next(vehicle) then

			cb(true)

		else

			cb(false)

		end

	end)

end)

RegisterServerEvent('eden_garage:modifystate1') -- FORCES STATE FOR ACTIVE IN WORLD 8.

AddEventHandler('eden_garage:modifystate1', function(plate, stored)

	MySQL.Async.execute("UPDATE owned_vehicles SET `state`='8' WHERE plate=@plate", {['@state'] = state, ['@plate'] = plate})

end)	

RegisterServerEvent('TRP:IMPOUNDSTATE') -- FORCES STATE 0

AddEventHandler('TRP:IMPOUNDSTATE', function(plate, stored)

	MySQL.Async.execute("UPDATE owned_vehicles SET `state`='0' WHERE plate=@plate", {['@state'] = state, ['@plate'] = plate})

end)	

RegisterNetEvent('trp_garage:saveProps')

AddEventHandler('trp_garage:saveProps', function(plate, props)

	local xProps = json.encode(props)

	MySQL.Sync.execute("UPDATE owned_vehicles SET vehicle=@props WHERE plate=@plate", {['@plate'] = plate, ['@props'] = xProps})

end)



