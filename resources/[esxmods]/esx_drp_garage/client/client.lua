local CurrentAction = nil
local GUI = {}
GUI.Time = 0
local HasAlreadyEnteredMarker = false
local LastZone = nil
local CurrentActionMsg = ''
local CurrentActionData = {}
local times = 0
local this_Garage = {}
-- Init ESX
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)

        Citizen.Wait(0)
    end
end)

--- Blips Management
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    --PlayerData = xPlayer
    --TriggerServerEvent('esx_jobs:giveBackCautionInCaseOfDrop')
   -- refreshBlips()
end)



--[[function refreshBlips()
    local zones = {}
    local blipInfo = {}

    for zoneKey, zoneValues in pairs(Config.Garages) do
        local blip = AddBlipForCoord(zoneValues.Pos.x, zoneValues.Pos.y, zoneValues.Pos.z)
        SetBlipSprite(blip, Config.BlipInfos.Sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.7)
        SetBlipColour(blip, Config.BlipInfos.Color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(zoneKey)
        EndTextCommandSetBlipName(blip)
       --[[local blip = AddBlipForCoord(zoneValues.MunicipalPoundPoint.Pos.x, zoneValues.MunicipalPoundPoint.Pos.y, zoneValues.MunicipalPoundPoint.Pos.z)
        SetBlipSprite(blip, Config.BlipPound.Sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.7)
        SetBlipColour(blip, Config.BlipPound.Color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(_U('impound_yard'))
        EndTextCommandSetBlipName(blip)]]
  --  end
--end--]]

--Menu function
function OpenMenuGarage(PointType)
    ESX.UI.Menu.CloseAll()
    local elements = {}

  --[[  if PointType == 'spawn' then
        table.insert(elements, {
            label = _U('list_vehicles'),
            value = 'list_vehicles'
        })
    end]]

    if PointType == 'delete' then
        table.insert(elements, {
            label = _U('stock_vehicle'),
            value = 'stock_vehicle'
        })
    end

    if PointType == 'pound' then
        table.insert(elements, {
            label = _U('return_vehicle', Config.Price),
            value = 'return_vehicle'
        })
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'garage_menu', {
        title = _U('garage'),
        align = 'right',
        elements = elements
    }, function(data, menu)
        menu.close()

        if (data.current.value == 'list_vehicles') then
            ListVehiclesMenu()
        end

        if (data.current.value == 'stock_vehicle') then
            StockVehicleMenu()
        end

        if (data.current.value == 'return_vehicle') then
            ReturnVehicleMenu()
        end

        local playerPed = PlayerPedId()
        SpawnVehicle(data.current.value)
    end, function(data, menu)
        menu.close()
    end)
end

-- View Vehicle Listings
function ListVehiclesMenu()
	local elements = {}

	ESX.TriggerServerCallback('eden_garage:getVehicles', function(vehicles)

		for _,v in pairs(vehicles) do

			local hashVehicule = v.vehicle.model
    		local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
    		local labelvehicle
			local plate = v.plate

    		if (v.state) then
    		labelvehicle = vehicleName.. ' (' .. plate .. ') ' .._U('garage')
            table.insert(elements, {label =labelvehicle , value = v})--shows ingarage vehicles
            else
                labelvehicle = vehicleName.. ' (' .. plate .. ') ' .._U('municipal_pound')
                table.insert(elements, {label =labelvehicle , value = v})--shows ingarage vehicles
                if (v.state== 8) then
                    labelvehicle = vehicleName.. ' (' .. plate .. ') ' .._U('active')
                    table.insert(elements, {label =labelvehicle , value = v})--shows ingarage vehicles
            end
        end

            --[[else
    		labelvehicle = vehicleName.. ' (' .. plate .. ') ' .._U('municipal_pound')
            table.insert(elements, {label =labelvehicle , value = v}) -- displays the impounded vehicles lol
            end	]]
			--table.insert(elements, {label =labelvehicle , value = v})
     
        end
		local c = 0
		for _,a in pairs(vehicles) do
			if (a.state) then
				c = c + 1
			else
				c = c - 1
			end
		end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_vehicle', {
            title = _U('garage'), 
            align = 'right',
            elements = elements
        }, function(data, menu)
            if (data.current.value.state) then
                menu.close()
                SpawnVehicle(data.current.value.vehicle)
            else
                exports.pNotify:SendNotification({
                    text = _U('notif_car_impounded'),
                    queue = 'right',
                    timeout = 400,
                    layout = 'centerLeft'
                })
            end
        end, function(data, menu)
            menu.close()
        end)
    end)
    --CurrentAction = 'open_garage_action'
end

--[[function reparation(prix, vehicle, vehicleProps)
    ESX.UI.Menu.CloseAll()

    local elements = {
        {
            label = _U('reparation_yes', prix),
            value = 'yes'
        },
        {
            label = _U('reparation_no', prix),
            value = 'no'
        }
    }

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'delete_menu', {
        title = _U('reparation'),
        align = 'right',
        elements = elements
    }, function(data, menu)
        menu.close()

        if (data.current.value == 'yes') then
            vehicleProps.health = 1000.0
            TriggerServerEvent('eden_garage:payhealth', prix)
            ranger(vehicle, vehicleProps)
        end

        if (data.current.value == 'no') then
            ESX.ShowNotification(_U('reparation_no_notif'))
        end
    end, function(data, menu)
        menu.close()
    end)
end]]

function reparation(prix,vehicle,vehicleProps, health)



	ESX.UI.Menu.CloseAll()

	local vhealth = health

	if vhealth < 900 and vhealth >= 800 then

		amount = math.random(100, 300)

	elseif vhealth <= 799 and vhealth > 700 then

		amount = math.random(300, 500)

	elseif vhealth <= 699 and vhealth > 600 then

		amount = math.random(600, 800)

	elseif vhealth <= 599 and vhealth > 500 then

		amount = math.random(700, 1000)

	elseif vhealth <= 499 and vhealth > 400 then

		amount = math.random(1000, 1200)

	elseif vhealth <= 399 and vhealth > 300 then

		amount = math.random(1300, 1400)

	elseif vhealth <= 299 and vhealth > 200 then

		amount = math.random(1600, 2000)

	elseif vhealth < 200 then

		amount = 300

	else

		amount = 300

	end



	local elements = {

		{label = "Repair your vehicle ($" .. ESX.Math.GroupDigits(amount) .. ").", value = 'yes'},

		{label = "Store the vehicle anyway (No Cost)", value = 'no'},

	}

	ESX.UI.Menu.Open(

		'default', GetCurrentResourceName(), 'delete_menu',

		{

			title    = "Your Vehicle is Damaged",

			align    = 'bottom-right',

			elements = elements,

		},

		function(data, menu)



			menu.close()

			if(data.current.value == 'yes') then



				ESX.TriggerServerCallback('eden_garage:checkMoney', function(hasEnoughMoney)



					if hasEnoughMoney then

						vehicleProps.health = 1000.0

						ESX.TriggerServerCallback('eden_garage:stockv',function(valid)
                            TriggerEvent('persistent-vehicles/forget-vehicle', vehicle)
                            TriggerServerEvent('eden_garage:payhealth', amount)
                            SetVehicleEngineHealth(vehicle, 1000) -- force heals engine 
							ranger(vehicle,vehicleProps, vehicleProps.plate)

						end, vehicleProps)

					else

						TriggerEvent("pNotify:SendNotification",{

		                    text = "<h2>Notification</h2>" .. "<h1>GARAGE:</h1>" .. "<p>You do not have enough money to pay the rip off mechanic.</p>",

		                    type = "success",

		                    timeout = (6000),

		                    layout = "centerLeft",

		                    queue = "global"

		                })

					end

				end, amount)

			end





			if(data.current.value == 'no') then



			   ranger(vehicle,vehicleProps, vehicleProps.plate)
               TriggerEvent('persistent-vehicles/forget-vehicle', vehicle)


			end



		end,



		function(data, menu)



			menu.close()



		end

	)

end


RegisterNetEvent('eden_garage:deletevehicle_cl')

AddEventHandler('eden_garage:deletevehicle_cl', function(plate)
    local _plate = plate:gsub('^%s*(.-)%s*$', '%1')
    local playerPed = PlayerPedId()

    if IsPedInAnyVehicle(playerPed, false) then
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
        local usedPlate = vehicleProps.plate:gsub('^%s*(.-)%s*$', '%1')

        if usedPlate == _plate then
            
            ESX.Game.DeleteVehicle(vehicle)
        end
    end
end)

function ranger(vehicle, vehicleProps)
    TriggerEvent('persistent-vehicles/forget-vehicle', vehicle)
    ESX.Game.DeleteVehicle(vehicle)
    TriggerServerEvent('eden_garage:modifystate', vehicleProps, 1) -- 1 return vehicle
TriggerServerEvent('esx_truck_inventory:RemoveVehicleList', plate)
    exports.pNotify:SendNotification({
        text = _U('ranger'),
        queue = 'right',
        timeout = 400,
        layout = 'centerLeft'
    })
end

-- Function that allows player to enter a vehicle
function StockVehicleMenu()
    local playerPed = PlayerPedId()

    if IsPedInAnyVehicle(playerPed, false) then
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
        local current = GetPlayersLastVehicle(PlayerPedId(), true)
        local engineHealth = GetVehicleEngineHealth(current)

        ESX.TriggerServerCallback('eden_garage:stockv', function(valid)
            if (valid) then
                ESX.TriggerServerCallback('eden_garage:getVehicles', function(vehicules)
                    local plate = vehicleProps.plate:gsub('^%s*(.-)%s*$', '%1')
                    local owned = false

                    for _, v in pairs(vehicules) do
                        if plate == v.plate then
                            owned = true
                            TriggerServerEvent('eden_garage:debug', 'vehicle plate returned to the garage: ' .. vehicleProps.plate)
                            TriggerServerEvent('eden_garage:logging', 'vehicle returned to the garage: ' .. engineHealth)

                            if engineHealth < 1000 then
                                local fraisRep = math.floor((1000 - engineHealth) * Config.RepairMultiplier)
                                reparation(fraisRep,vehicle,vehicleProps, engineHealth)
                                
                            else
                                ranger(vehicle, vehicleProps)
                            end
                        end
                    end

                    if owned == false then
                        exports.pNotify:SendNotification({
                            text = _U('stockv_not_owned'),
                            queue = 'right',
                            timeout = 400,
                            layout = 'centerLeft'
                        })
                    end
                end)
            else
                exports.pNotify:SendNotification({
                    text = _U('stockv_not_owned'),
                    queue = 'right',
                    timeout = 400,
                    layout = 'centerLeft'
                })
            end
        end, vehicleProps)
    else
        exports.pNotify:SendNotification({
            text = _U('stockv_not_in_veh'),
            queue = 'right',
            timeout = 400,
            layout = 'centerLeft'
        })
    end
end

--Function for spawning vehicle
function SpawnVehicle(vehicle)
    ESX.Game.SpawnVehicle(vehicle.model, {
        x = this_Garage.SpawnPoint.Pos.x,
        y = this_Garage.SpawnPoint.Pos.y,
        z = this_Garage.SpawnPoint.Pos.z + 1
    }, this_Garage.SpawnPoint.Heading, function(callback_vehicle)
        ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
        SetVehRadioStation(callback_vehicle, 'OFF')
        TaskWarpPedIntoVehicle(PlayerPedId(), callback_vehicle, -1)
        local plate = GetVehicleNumberPlateText(callback_vehicle)
        TriggerServerEvent('ls:mainCheck', plate, callback_vehicle, true)

        local vehNet = NetworkGetNetworkIdFromEntity(callback_vehicle)
        local plate = GetVehicleNumberPlateText(callback_vehicle)
        TriggerServerEvent("SOSAY_Locking:GiveKeys", vehNet, plate)
    end)

    TriggerServerEvent('eden_garage:modifystate', vehicle, 8) -- 0 for pound 8 for world
end

--Function for spawning vehicle
--[[function SpawnPoundedVehicle(vehicle)
    ESX.Game.SpawnVehicle(vehicle.model, {
        x = this_Garage.SpawnMunicipalPoundPoint.Pos.x,
        y = this_Garage.SpawnMunicipalPoundPoint.Pos.y,
        z = this_Garage.SpawnMunicipalPoundPoint.Pos.z + 1
    }, 180, function(callback_vehicle)
        ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
        local plate = GetVehicleNumberPlateText(callback_vehicle)
        TriggerServerEvent('ls:mainCheck', plate, callback_vehicle, true)

        local vehNet = NetworkGetNetworkIdFromEntity(callback_vehicle)
        local plate = GetVehicleNumberPlateText(callback_vehicle)
        TriggerServerEvent("SOSAY_Locking:GiveKeys", vehNet, plate)
    end)

    TriggerServerEvent('eden_garage:modifystate', vehicle, true)

    ESX.SetTimeout(10000, function()
        TriggerServerEvent('eden_garage:modifystate', vehicle, 8) -- 0 pound 8 world
    end)
end
[[]]
-- Marker actions
AddEventHandler('eden_garage:hasEnteredMarker', function(zone)
    --[[if zone == 'spawn' then
        CurrentAction = 'spawn'
        CurrentActionMsg = _U('spawn')
        CurrentActionData = {}
    end]]

    if zone == 'delete' then
        CurrentAction = 'delete'
        CurrentActionMsg = _U('delete')
        CurrentActionData = {}
    end

    --[[if zone == 'pound' then
        CurrentAction = 'pound_action_menu'
        CurrentActionMsg = _U('pound_action_menu')
        CurrentActionData = {}
    end]]
end)

AddEventHandler('eden_garage:hasExitedMarker', function(zone)
    ESX.UI.Menu.CloseAll()
    CurrentAction = nil
end)

function ReturnVehicleMenu()
    ESX.TriggerServerCallback('eden_garage:getOutVehicles', function(vehicles)
        local elements = {}

        for _, v in pairs(vehicles) do
            local hashVehicule = v.model
            local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
            local labelvehicle
            labelvehicle = _U('impound_list', GetLabelText(vehicleName))

            table.insert(elements, {
                label = labelvehicle,
                value = v
            })
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_vehicle', {
            title = _U('impound_yard'),
            align = 'right',
            elements = elements
        }, function(data, menu)
            ESX.TriggerServerCallback('eden_garage:checkMoney', function(hasEnoughMoney)
                if hasEnoughMoney then
                    if times == 0 then
                        TriggerServerEvent('eden_garage:pay')
                        SpawnPoundedVehicle(data.current.value)
                        times = times + 1
                    elseif times > 0 then
                        ESX.SetTimeout(60000, function()
                            times = 0
                        end)
                    end
                else
                    exports.pNotify:SendNotification({
                        text = _U('impound_not_enough_money'),
                        queue = 'right',
                        timeout = 400,
                        layout = 'centerLeft'
                    })
                end
            end)
        end, function(data, menu)
            menu.close()
        end)
    end)
    --CurrentAction = 'open_garage_action'
end

-- Display markers 
Citizen.CreateThread(function()
   local sleep = 500 
    while true do
        local ingarage = false
        Wait(sleep)
        local coords = GetEntityCoords(PlayerPedId())
        for k, v in pairs(Config.Garages) do
            if (GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 10) then
                ingarage = true
                sleep = 0
                DrawMarker(v.SpawnPoint.Marker, v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.SpawnPoint.Size.x, v.SpawnPoint.Size.y, v.SpawnPoint.Size.z, v.SpawnPoint.Color.r, v.SpawnPoint.Color.g, v.SpawnPoint.Color.b, 100, false, true, 2, false, false, false, false)
                DrawMarker(v.DeletePoint.Marker, v.DeletePoint.Pos.x, v.DeletePoint.Pos.y, v.DeletePoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.DeletePoint.Size.x, v.DeletePoint.Size.y, v.DeletePoint.Size.z, v.DeletePoint.Color.r, v.DeletePoint.Color.g, v.DeletePoint.Color.b, 100, false, true, 2, false, false, false, false)
            end
            if not ingarage then 
                sleep = 500
            end
        end
    end
   
end)

-- Open/close menus
Citizen.CreateThread(function()
    local currentZone = 'garage'
local sleep = 500
    while true do
        Wait(sleep)
        local coords = GetEntityCoords(PlayerPedId())
        local isInMarker = false

        for _, v in pairs(Config.Garages) do
            if (GetDistanceBetweenCoords(coords, v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z, true) < v.Size.x) then
                sleep = 0
                isInMarker = true
                this_Garage = v
                currentZone = 'spawn'
            end

            if (GetDistanceBetweenCoords(coords, v.DeletePoint.Pos.x, v.DeletePoint.Pos.y, v.DeletePoint.Pos.z, true) < v.Size.x) then
                sleep = 0
                isInMarker = true
                this_Garage = v
                currentZone = 'delete'
            end

          --[[  if (GetDistanceBetweenCoords(coords, v.MunicipalPoundPoint.Pos.x, v.MunicipalPoundPoint.Pos.y, v.MunicipalPoundPoint.Pos.z, true) < v.MunicipalPoundPoint.Size.x) then
                isInMarker = true
                this_Garage = v
                currentZone = 'pound'
            end]]
        end

        if isInMarker and not hasAlreadyEnteredMarker then
            sleep = 500
            hasAlreadyEnteredMarker = true
            LastZone = currentZone
            TriggerEvent('eden_garage:hasEnteredMarker', currentZone)
        end

        if not isInMarker and hasAlreadyEnteredMarker then
            sleep = 500
            hasAlreadyEnteredMarker = false
            TriggerEvent('eden_garage:hasExitedMarker', LastZone)
        end
        sleep = 500
    end
end)

-- Button press
Citizen.CreateThread(function()
    local sleep = 0
    while true do
        Citizen.Wait(sleep)

        if CurrentAction ~= nil then
            SetTextComponentFormat('STRING')
            AddTextComponentString(CurrentActionMsg)
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)

            if IsControlPressed(0, 38) and (GetGameTimer() - GUI.Time) > 150 then
                if CurrentAction == 'pound_action_menu' then
                    sleep = 500
                    OpenMenuGarage('pound')
                end

               --[[ if CurrentAction == 'spawn' then
                    OpenMenuGarage('spawn')
                end]]

                if CurrentAction == 'delete' then
                    sleep = 500
                    OpenMenuGarage('delete')
                end

                CurrentAction = nil
                GUI.Time = GetGameTimer()
            end
        end
    end
end)
-- Fin controle touche