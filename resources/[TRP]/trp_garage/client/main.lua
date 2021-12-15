local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local garage = {} -- stores data for later in the chain :D
ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(100) -- checks job every 100 ms
    end

    PlayerData = ESX.GetPlayerData()
end)

local impounds = {

{vector3(-234.91, 6199.07, 31.94), vector3(-232.59, 6193.18, 31.49), 138.18},
{vector3(481.5561, -1316.967, 29.19556), vector3(489.5868, -1313.723, 29.24609), 140.00}

}
local garages = {
    {vector3(226.7209, -794.3077, 30.64465), vector3(228.7121, -803.1165, 30.54358), 163.46},
    {vector3(-23.61758, 6398.954, 31.48718), vector3(-19.51648, 6395.552, 31.47034), 278.77},
    {vector3(1496.796, 3761.42, 33.91357), vector3(1507.43, 3759.28, 33.98), 199.08},
    --{vector3(-234.91, 6199.07, 31.94), vector3(-232.59, 6193.18, 31.49), 138.18}
    }

local enableField = false

function AddCar(plate, modelname, state)
   -- local garage = 1 
    SendNUIMessage({
        action = 'add',
        plate = plate,
        model = modelname,
        state = state,
        garage = garage
    }) 
end

function toggleField(enable)
    SetNuiFocus(enable, enable)
    enableField = enable

    if enable then
        SendNUIMessage({
            action = 'open'
        }) 
    else
        SendNUIMessage({
            action = 'close'
        }) 
    end
end

AddEventHandler('onResourceStart', function(name)
    if GetCurrentResourceName() ~= name then
        return
    end

    toggleField(false)


end)

RegisterNUICallback('escape', function(data, cb)
    toggleField(false)
    SetNuiFocus(false, false)

    cb('ok')
end)

RegisterNUICallback('caractive', function(data, cb) -- if car active in world print notify
    notification('Vehicle Active in World', 'error', data.plate)
    toggleField(false)
    SetNuiFocus(false, false)
end)
RegisterNUICallback('cargarage', function(data, cb) -- if car active in world print notify
    notification('Vehicle in Garage', 'error', data.plate)
    toggleField(false)
    SetNuiFocus(false, false)

    
end)
RegisterNUICallback('carimp', function(data, cb) -- if car active in world print notify
    notification('Vehicle in impound', 'error', data.plate)
    toggleField(false)
    SetNuiFocus(false, false)

    
end)
RegisterNUICallback('enable-parkout', function(data, cb) -- calls vehicles and populates table of impound
    
    ESX.TriggerServerCallback('trp_garage:loadVehicles', function(vehicles)
        for _,v in pairs(vehicles) do
            local hashVehicule = v.vehicle.model
    		local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)             
            print("Car: " .. vehicleName ..' = '.. tostring(v.state))
            AddCar(v.plate, vehicleName, v.state)
                
         
        end
    end)
    
    cb('ok')
end) 


local usedGarage

RegisterNUICallback('park-out', function(data, cb) -- impound event redo for garage
    ESX.TriggerServerCallback('trp_garage:canYouPay', function(haveMoney)
    if haveMoney then
    
        takeoutdavehicle(data)

        else
    notification('Not Enough Money To Retrieve Cost $500 Cash', 'error', data.plate)
        end
    end)
end)

RegisterNUICallback('park-outGarage', function(data, cb) -- impound event redo for garage   
        takeoutdavehiclegarage(data)
end)

function takeoutdavehicle(data)
    ESX.TriggerServerCallback('trp_garage:loadVehicle', function(vehicle)
      

        local x,y,z = table.unpack(impounds[usedGarage][2])
        local props = json.decode(vehicle[1].vehicle)

    local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(PlayerPedId()), 25.0)

    for key, value in pairs(vehicles) do
        if GetVehicleNumberPlateText(value) == data.plate then
            ESX.Game.DeleteVehicle(value)
        end
    end



        ESX.Game.SpawnVehicle(props.model, {
            x = x,
            y = y,
            z = z + 1
        }, impounds[usedGarage][3], function(callback_vehicle)
            ESX.Game.SetVehicleProperties(callback_vehicle, props)
            SetVehRadioStation(callback_vehicle, "OFF")
            TaskWarpPedIntoVehicle(PlayerPedId(), callback_vehicle, -1)
	    TriggerEvent('persistent-vehicles/register-vehicle', callback_vehicle) -- defines it in game
        end)

    end, data.plate)

    TriggerServerEvent('eden_garage:modifystate1', data.plate, 8)

  notification('$500 Paid to Return', 'success', data.plate)

end

function takeoutdavehiclegarage(data)
    ESX.TriggerServerCallback('trp_garage:loadVehicle', function(vehicle)
      

        local x,y,z = table.unpack(garages[usedGarage][2])
        local props = json.decode(vehicle[1].vehicle)

    local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(PlayerPedId()), 25.0)

    for key, value in pairs(vehicles) do
        if GetVehicleNumberPlateText(value) == data.plate then
            ESX.Game.DeleteVehicle(value)
        end
    end



        ESX.Game.SpawnVehicle(props.model, {
            x = x,
            y = y,
            z = z + 1
        }, garages[usedGarage][3], function(callback_vehicle)
            ESX.Game.SetVehicleProperties(callback_vehicle, props)
            SetVehRadioStation(callback_vehicle, "OFF")
            TaskWarpPedIntoVehicle(PlayerPedId(), callback_vehicle, -1)
	    TriggerEvent('persistent-vehicles/register-vehicle', callback_vehicle) -- defines it in game
        end)

    end, data.plate)

    TriggerServerEvent('eden_garage:modifystate1', data.plate, 8)

  notification('Vehicle Retrieved From Garage', 'success', data.plate)

end
-----------------------------------------------------------------------
-- Admin Notifications Global Client
-----------------------------------------------------------------------

function notification(type, text, data)
	print(data)
		TriggerEvent("pNotify:SendNotification",{
			text = "<h2>Garage Notification</h2>".. data .. "<br><br>"..type.."",
			type = text,
	        timeout = (6000),
	        layout = "centerLeft",
	        queue = "global"
        })

end

Citizen.CreateThread(function()
    local sleep = 500
    while true do
        Citizen.Wait(sleep)

        for key, value in pairs(garages) do
            local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), value[1])
            
            if dist <= 4.0 then
                sleep = 0
                ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ To Open The Garage")
           
                if IsControlJustReleased(0, 38) then
                    toggleField(true)
                    garage = 1 
                    usedGarage = key
                 
                end
            end 
        end
     end
end)

Citizen.CreateThread(function()
    local sleep = 500
    while true do
        Wait(sleep)

        for key, value in pairs(impounds) do
            local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), value[1])

            if dist <= 2.0 then
                sleep = 0
                ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ To Open The Impound")
            
          
  
                if IsControlJustReleased(0, 38) then
                    toggleField(true)
                    garage = 0 
                    usedGarage = key
                end 
               
            end
        end
    end
end)

local coordinate = {
    { 408.1, -1625.15, 29.29, nil, 225.00, nil, -1176698112}, --bennys impound
    --{ -174.9, -1273.35, 32.57, nil, 445.00, nil, 68070371},
    --{ 1508.39, 3768.63, 34.14, nil, 286.16, nil, 68070371},
   -- { -234.91, 6199.07, 31.94, nil, 245.0, nil, 68070371}                      
}

--[[Citizen.CreateThread(function()

    for _, v in pairs(coordinate) do
        RequestModel(v[7])
        while not HasModelLoaded(v[7]) do
            Wait(1)
        end

        ped = CreatePed(4, v[7], v[1], v[2], v[3] - 1, 3374176, false, true)
        SetEntityHeading(ped, v[5])
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)

        SetBlockingOfNonTemporaryEvents(ped, true)
    end

end)]]

Citizen.CreateThread(function()
    for _, coords in pairs(garages) do
        local blip = AddBlipForCoord(coords[1])

        SetBlipSprite(blip, 67)
        SetBlipScale(blip, 0.9)
        SetBlipColour(blip, 2)
        SetBlipDisplay(blip, 4)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Garage")
        EndTextCommandSetBlipName(blip)
    end
end)

Citizen.CreateThread(function()
    for _, coords in pairs(impounds) do
        local blip = AddBlipForCoord(coords[1])

        SetBlipSprite(blip, 67)
        SetBlipScale(blip, 0.9)
        SetBlipColour(blip, 0)
        SetBlipDisplay(blip, 4)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Impound")
        EndTextCommandSetBlipName(blip)
    end
end)
