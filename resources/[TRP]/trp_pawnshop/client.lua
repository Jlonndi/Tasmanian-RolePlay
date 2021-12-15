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
   
   ESX = nil
   local PlayerData              = {}
   
   Citizen.CreateThread(function()
       while ESX == nil do
           TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
           Citizen.Wait(0)
           PlayerData = ESX.GetPlayerData()
       end
   end)
   RegisterNetEvent('trp-core:pawnshop')
   AddEventHandler('trp-core:pawnshop', function(ItemName)  
   TriggerServerEvent('trp-core:pawnshop', ItemName)
   end)
   
   RegisterNetEvent('esx:playerLoaded')
   AddEventHandler('esx:playerLoaded', function(xPlayer)
       PlayerData = xPlayer
   end)
   
   RegisterNetEvent('esx:setJob')
   AddEventHandler('esx:setJob', function(job)
     PlayerData.job = job
   end)
   
   function hintToDisplay(text)
       SetTextComponentFormat("STRING")
       AddTextComponentString(text)
       DisplayHelpTextFromStringLabel(0, 0, 1, -1)
   end
   
   local blips = {
         {title="Cash Converters", colour=4, id=133, x = 412.31, y = 314.11, z = 103.02}
   }
    
         
   Citizen.CreateThread(function()
       for _, info in pairs(blips) do
         info.blip = AddBlipForCoord(info.x, info.y, info.z)
         SetBlipSprite(info.blip, info.id)
         SetBlipDisplay(info.blip, 4)
         SetBlipScale(info.blip, 1.0)
         SetBlipColour(info.blip, info.colour)
         SetBlipAsShortRange(info.blip, true)
         BeginTextCommandSetBlipName("STRING")
         AddTextComponentString(info.title)
         EndTextCommandSetBlipName(info.blip)
       end
   end)
     
   local gym = {
       {x = 412.31, y = 314.11, z = 103.02}
   }
   
   Citizen.CreateThread(function()
       local sleep = 500
       while true do
           Citizen.Wait(sleep)
           for k in pairs(gym) do
               local plyCoords = GetEntityCoords(PlayerPedId(), false)
               local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, gym[k].x, gym[k].y, gym[k].z)
   
               if dist <= 0.5 then
                   sleep = 0
               DrawMarker(21, gym[k].x, gym[k].y, gym[k].z, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 153, 255, 255, 0, 0, 0, 0)
               else sleep = 500
           end
       end
       end
   end)
   
   Citizen.CreateThread(function()
       sleep = 500
       while true do
           Citizen.Wait(sleep)
   
           for k in pairs(gym) do
           
               local plyCoords = GetEntityCoords(PlayerPedId(), false)
               local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, gym[k].x, gym[k].y, gym[k].z)
   
               if dist <= 0.5 then
                   sleep = 0
                   hintToDisplay('Press E to open the shop')
                   
                   if IsControlJustPressed(0, Keys['E']) then
                       OpenPawnMenu()
                   end	
               else sleep = 500		
               end
           end
       end
   end)
   
   function OpenPawnMenu()
       ESX.UI.Menu.CloseAll()
   
       ESX.UI.Menu.Open(
           'default', GetCurrentResourceName(), 'pawn_menu',
           {
               title    = 'Pawnshop',
               elements = {
                   --{label = 'Buy', value = 'shop'},
                   {label = 'Sell', value = 'sell'},
               }
           },
           function(data, menu)
               if data.current.value == 'shop' then
                   OpenPawnShopMenu()
               elseif data.current.value == 'sell' then
                   OpenSellMenu()
               end
           end,
           function(data, menu)
               menu.close()
           end
       )
   end
   function OpenSellMenu()
       ESX.UI.Menu.CloseAll()
   
       ESX.UI.Menu.Open(
           'default', GetCurrentResourceName(), 'pawn_sell_menu',
           {
               title    = 'Sell an item from the list below!',
               elements = {
                   {label = 'ps5', value = 'ps5'},
                   {label = 'gta5', value = 'gta5'},
                   {label = 'diamondring', value = 'diamondring'},
                   {label = 'macbook', value = 'macbook'},
                   {label = 'cyberpunk', value = 'cyberpunk'},
                   {label = 'gold', value = 'gold'},
                   {label = 'coldwar', value = 'coldwar'},
                   {label = 'thedarknightbluray', value = 'thedarknightbluray'},
                   {label = 'louisvuittonbag', value = 'louisvuittonbag'},
                   {label = 'Nike Airforce one', value = 'airforceone'},
                   {label = 'avengersendgamedvd', value = 'avengersendgamedvd'},
                   {label = 'oxygen_mask', value = 'oxygen_mask'},
                   {label = 'gazbottle', value = 'gazbottle'},
                   {label = 'rolex', value = 'rolex'},
                   {label = 'lowradio', value = 'lowradio'},
   
               }
           },
           function(data, menu)
               if data.current.value == 'ps5' then
                   TriggerServerEvent('esx_pawnshop:sellps5')
               elseif data.current.value == 'gta5' then
                   TriggerServerEvent('esx_pawnshop:sellgta5')
               elseif data.current.value == 'diamondring' then
                   TriggerServerEvent('esx_pawnshop:selldiamondring')
               elseif data.current.value == 'macbook' then
                   TriggerServerEvent('esx_pawnshop:sellmacbook')
               elseif data.current.value == 'cyberpunk' then
                   TriggerServerEvent('esx_pawnshop:sellcyberpunk')
               elseif data.current.value == 'gold' then
                   TriggerServerEvent('esx_pawnshop:sellgold')
               elseif data.current.value == 'coldwar' then
                   TriggerServerEvent('esx_pawnshop:sellcoldwar')
               elseif data.current.value == 'thedarknightbluray' then
                   TriggerServerEvent('esx_pawnshop:sellthedarknightbluray')
               elseif data.current.value == 'louisvuittonbag' then
                   TriggerServerEvent('esx_pawnshop:selllouisvuittonbag')
               elseif data.current.value == 'airforceone' then
                   TriggerServerEvent('esx_pawnshop:airforceones')
               elseif data.current.value == 'avengersendgamedvd' then
                   TriggerServerEvent('esx_pawnshop:sellavengersendgamedvd')
               elseif data.current.value == 'oxygen_mask' then
                   TriggerServerEvent('esx_pawnshop:selloxygen_mask')
               elseif data.current.value == 'rolex' then
                   TriggerServerEvent('esx_pawnshop:sellrolex')
               elseif data.current.value == 'gazbottle' then
                   TriggerServerEvent('esx_pawnshop:sellgazbottle')
               elseif data.current.value == 'lowradio' then
                   TriggerServerEvent('esx_pawnshop:selllowradio')
   
               end
           end,
           function(data, menu)
               menu.close()
           end
       )
   end
   
   
   
   
   
   