--TrunkIN/OUT Done by CX and NUB  for TRP
ESX = nil
local IsInBoot = false
local InVehicle = nil
local vehiclePlate = nil
print(label)

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

function notification(text, type) -- general notification
            TriggerEvent("pNotify:SendNotification",{
                text = "<h2>Boot Notification</h2>"..text.."",
                type = type,
                timeout = (3000),
                layout = "centerLeft",
                queue = "global"
            })
    
    end 
RegisterNetEvent('trp:Trunk:getInTrunk')
AddEventHandler('trp:Trunk:getInTrunk', function()
    local vehicle, closestDistance = ESX.Game.GetClosestVehicle()
    local vehiclePlate = GetVehicleNumberPlateText(vehicle)
    local locked = GetVehicleDoorLockStatus(vehicle)
    local playerPed = PlayerPedId()

    if closestDistance > 4.0 or IsPedInAnyVehicle(playerPed) then
        return
    end

    if not DoesVehicleHaveDoor(vehicle, 5) then
        notification('error', 'This vehicle does not have a boot.')
        return
    end

    if locked ~= 1 then
        notification('error', 'This vehicle is locked.')
        return
    end

    if IsBigVehicle(vehicle) then
        notification('error', 'You cannot do this.')
        return
    end

    if DoesEntityExist(vehicle) then
        SetEntityVisible(playerPed, false)
        SetEntityCollision(playerPed, false, false)
        IsInBoot = true
        InVehicle = vehicle
        TriggerBootAnimation()
    end
    PlayerInBoot()
    print('This was Nubs favorite thing to do!')
end)

function TriggerBootAnimation()
    Citizen.CreateThread(function()
        SetVehicleDoorOpen(InVehicle, 5, false, false)
        Citizen.Wait(1000)
        SetVehicleDoorShut(InVehicle, 5, false)
    end)
end

function GetOutOfBoot()
    local vehicle, closestDistance = ESX.Game.GetClosestVehicle()
    local locked = GetVehicleDoorLockStatus(vehicle)

    if not IsInBoot then
        notification('error', 'You are not in a boot.')
        return
    end

    if locked ~= 1 then
        notification('error', 'This vehicle is locked.')
        return
    end

    local vehiclePlate = GetVehicleNumberPlateText(vehicle)

    if DoesEntityExist(InVehicle) then
        local playerPed = PlayerPedId()
        local coords = GetOffsetFromEntityInWorldCoords(InVehicle, 0.0, -4.0, 0.0)
        SetEntityVisible(playerPed, true)
        SetEntityCoords(playerPed, coords)
        SetEntityCollision(playerPed, true, true)
        IsInBoot = false
        InVehicle = false
        TriggerBootAnimation()
    end
end

function PlayerInBoot()
    print('Have fun hiding in the boot')
    while IsInBoot do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        if IsInBoot then
            DisableAllControlActions(0)
            EnableControlAction(0, 1)
            EnableControlAction(0, 2)
            EnableControlAction(0, 245)
            EnableControlAction(0, 249)
            AttachEntityToEntity(playerPed, InVehicle, -1, 0.0, -2.2, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
            SetEntityInvincible(PlayerPedId(),true)
        else
            DetachEntity(playerPed, true, true)
            SetEntityInvincible(PlayerPedId(),false)
        end
    end
end

RegisterCommand("trunk", function(src, args, raw) 
         if args[1] == 'in' and not IsInBoot then 
             TriggerEvent('trp:Trunk:getInTrunk')
                notification('You\'ve climbed into the boot',"error")
            end
         if args[1] == 'out' and IsInBoot then
            TriggerBootAnimation()
            Citizen.Wait(1100) 
            GetOutOfBoot()
             notification('You\'ve climbed out of the boot',"error")
       end
 end)
