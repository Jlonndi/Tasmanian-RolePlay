ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)
 
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)


local weapon = {
    -- pistol
    [453432689] = {munitions = '9 mm'},
    
    -- pistol cal.50
    [-1716589765] = {munitions = '9 mm'},
    
    -- combat pistol
    [1593441988] = {munitions = '9 mm'},
-- SNS PISTOL
[-1076751822] = {munitions = '9 mm'},
 -- Heavy Pistol
 [-771403250] = {munitions = '9 mm'},   
    -- Ap pistol
    [0x22D8FE39] = {munitions = '9 mm'},
    
    --smg
    [0x2BE6766B] = {munitions = '.45 ACP'},
    
    -- micro smg
    [0x13532244] = {munitions = '.45 ACP'},
     
    -- assault smg
    [-270015777] = {munitions = '.45 ACP'},
    
    -- assault rifle
    [-1074790547] = {munitions = '7.62 mm'},
    
    -- carabine
    [-2084633992] = {munitions = '7.62 mm'},
    
    -- advanced rifle
    [-1357824103] = {munitions = '7.62 mm'},
    
    -- special carabine
    [-1063057011] = {munitions = '7.62 mm'},
    
    -- shotgun
    [0x1D073A89] = {munitions = '12 mm'},

    -- sniper
    [0x05FC3C11] = {munitions = '7.62 mm'},
}
 
local Anim = false 
local amountBox = 50 -- number of ammo per box
local amountBoxAssault = 60 -- number of ammo per box
local amountBoxSMG = 60 
local amountBoxPistol = 30
local amountBoxShot = 36

function GetAmmoWeapon()

    for k,v in pairs(weapon) do
        local PlayerChoise = GetSelectedPedWeapon(PlayerPedId())

        if PlayerChoise == k then
          ammo = v.munitions
          break
        end 
    end
    return ammo 
end


RegisterNetEvent('TRP_AMMO:AmmoBox')
AddEventHandler('TRP_AMMO:AmmoBox', function(type)
    
    local Ply  = PlayerPedId() 
    local ammo = GetAmmoWeapon()

    if type == '9 mm' then 
        if ammo == type then 
           AddAmmoToPed(Ply, GetSelectedPedWeapon(Ply), amountBoxPistol) 
           ESX.ShowNotification('You have reloaded your weapon with ammunition of type '..type)
        else 
           ESX.ShowNotification('These ammunition are not suitable for this weapon')
           TriggerServerEvent('TRP_AMMO:ReturnIsNotValid', type)
        end   
    elseif type == '.45 ACP' then 
        if ammo == type then 
           AddAmmoToPed(Ply, GetSelectedPedWeapon(Ply), amountBoxSMG)  
           ESX.ShowNotification('You have reloaded your weapon with ammunition of type '..type)
        else 
           ESX.ShowNotification('These ammunition are not suitable for this weapon')
           TriggerServerEvent('TRP_AMMO:ReturnIsNotValid', type)
        end 
    elseif type == '7.62 mm' then 
        if ammo == type then 
           AddAmmoToPed(Ply, GetSelectedPedWeapon(Ply), amountBoxAssault) 
           ESX.ShowNotification('You have reloaded your weapon with ammunition of type '..type)
        else 
           ESX.ShowNotification('These ammunition are not suitable for this weapon')
           TriggerServerEvent('TRP_AMMO:ReturnIsNotValid', type)
        end 
    elseif type == '12 mm' then 
        if ammo == type then 
           AddAmmoToPed(Ply, GetSelectedPedWeapon(Ply), amountBoxShot)  
           ESX.ShowNotification('You have reloaded your weapon with ammunition of type '..type)
        else 
           ESX.ShowNotification('These ammunition are not suitable for this weapon')
           TriggerServerEvent('TRP_AMMO:ReturnIsNotValid', type)
        end     
    end    
end)    

