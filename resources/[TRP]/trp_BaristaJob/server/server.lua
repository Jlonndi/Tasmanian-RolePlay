ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

function Message(Chat, Player)
	TriggerClientEvent('esx:showNotification', Player.source, Chat)
end
TriggerEvent('esx_phone:registerNumber', 'barista', 'barista', false, false)
TriggerEvent('esx_society:registerSociety', 'barista', 'barista', 'society_barista', 'society_barista', 'society_barista', {type = 'private'})
--Make HalfMadeCoffee Function Start
RegisterServerEvent('barista:makeHalfMade')
AddEventHandler('barista:makeHalfMade', function()
   local _source = source
   local xPlayer = ESX.GetPlayerFromId(_source)
   print('|Barista| this is Working 2')
   print(source)
   xPlayer.getInventoryItem('Coffee_Grounds')
   if xPlayer.getInventoryItem('Coffee_Grounds', 1) and xPlayer.getInventoryItem('Coffee_Grounds').count > 0 then
      print('|Barista| this is working3')
      Citizen.Wait(30000)
      xPlayer.addInventoryItem('Half_Made_Coffee', 1) 
      xPlayer.removeInventoryItem('Coffee_Grounds', 1)         
   end
   if xPlayer.getInventoryItem('Coffee_Grounds', 1) and xPlayer.getInventoryItem('Coffee_Grounds').count < 1 then
      print('|Barista| you don\'t have enough Coffee Beans')
   end
end)
--Make HalfMadeCoffee Function End

--Make Coffee Function Start
RegisterServerEvent('Barista:MakeCoffee')
AddEventHandler('Barista:MakeCoffee', function()
   local _source = source
   local xPlayer = ESX.GetPlayerFromId(_source)
   print('|Barista| this is Working 1')
   print(source)
   xPlayer.getInventoryItem('Half_Made_Coffee')
   if xPlayer.getInventoryItem('Half_Made_Coffee', 1) and xPlayer.getInventoryItem('Half_Made_Coffee').count > 0 and xPlayer.getInventoryItem('Milk').count > 0 then
      Message('|Barista| this is working', xPlayer)
      Citizen.Wait(13000)
      xPlayer.removeInventoryItem('Milk', 1)
      xPlayer.removeInventoryItem('Half_Made_Coffee', 1)        
      xPlayer.addInventoryItem('coffee', 1) 
   Message('You made a to go Coffee', xPlayer)
   else 
      Message('You dont have Half Made Coffee Or Milk', xPlayer)
   end
   end)
--Make Coffee Function End

--Give Milk Storage Start
RegisterServerEvent('Barista:GiveMilkFromStorage')
AddEventHandler('Barista:GiveMilkFromStorage', function()
local _source = source 
local xPlayer = ESX.GetPlayerFromId(_source)
Message('|Barista| Giving Milk Please Wait 5 Seconds..', xPlayer)
print('|Barista| Waiting 5 seconds before getting milk')
Citizen.Wait(5000)
print('|Barista| Giving Player milk!')
xPlayer.addInventoryItem('Milk', 1)
Message('|Barista| You have succesfully Been Given Milk', xPlayer)
print('|Barista| Player successfully got milk!')
end) 
--Give Milk Storage End

--Give WaterJug Storage Start
RegisterServerEvent('Barista:GiveWaterFromStorage')
AddEventHandler('Barista:GiveWaterFromStorage', function()
local _source = source 
local xPlayer = ESX.GetPlayerFromId(_source)
Message('|Barista| Giving Water Please Wait 5 Seconds..', xPlayer)
Citizen.Wait(5000)
xPlayer.addInventoryItem('WaterJug', 1)
Message('|Barista|You have succesfully Been Given Water', xPlayer)
print('|Barista| Player successfully got Water!')
end) 
--Give WaterJug Storage End

--Give Ice Storage Start
RegisterServerEvent('Barista:GiveIceFromStorage')
AddEventHandler('Barista:GiveIceFromStorage', function()
local _source = source 
local xPlayer = ESX.GetPlayerFromId(_source)
Message('|Barista|Giving Ice Please Wait 5 Seconds...', xPlayer)
Citizen.Wait(5000)
print('|Barista| Giving Player Ice!')
xPlayer.addInventoryItem('Ice', 1)
Message('|Barista|Player Successfully Given Ice', xPlayer)
print('|Barista| Player successfully got Ice!')
end) 
--Give Ice Storage End

--Give Coffee Bean Storage Function Start
RegisterServerEvent('Barista:GiveCoffeeBeansFromStorage')
AddEventHandler('Barista:GiveCoffeeBeansFromStorage', function()
local _source = source 
local xPlayer = ESX.GetPlayerFromId(_source)
Message('|Barista|Giving Coffee Beans Please Wait 5 Seconds...', xPlayer)
Citizen.Wait(5000)
print('|Barista| Giving Player CoffeeBeans!')
xPlayer.addInventoryItem('Coffee_Beans', 1)
Message('|Barista|Player Successfully Given Coffee Beans', xPlayer)
print('|Barista| Player successfully got CoffeeBeans!')

end) 
--Give Coffee Bean Storage Function End

--Give Sugar Storage Function Start
RegisterServerEvent('Barista:GiveSugarFromStorage')
AddEventHandler('Barista:GiveSugarFromStorage', function()
local _source = source 
local xPlayer = ESX.GetPlayerFromId(_source)
Message('|Barista|Giving Sugar Please Wait 5 Seconds...', xPlayer)
Citizen.Wait(5000)
print('|Barista| Giving Player Sugar!')
xPlayer.addInventoryItem('Sugar', 1)
Message('|Barista| Player Successfully Given Sugar', xPlayer)
print('|Barista| Player successfully got Sugar!')
end) 
--Give Sugar Storage Function End
local frothmilk = false
--Frothing Milk Function Start
RegisterServerEvent('frothmilk')
AddEventHandler('frothmilk', function()
local _source = source 
local xPlayer = ESX.GetPlayerFromId(_source)
--if frothmilk == true then 
if xPlayer.getInventoryItem('Milk').count > 0 then -- Love you nubby
xPlayer.removeInventoryItem('Milk', 1)
Citizen.Wait(10000)
xPlayer.addInventoryItem('frothedmilk', 1)
Message('You have been Given Frothed Milk', xPlayer)
print('|Barista| Player successfully Made Frothed Milk', xPlayer)
else 
   print('you dont have milk')
end 
--end
end) 
--Frothing Milk Function End

--Clean Hopper Function Start
RegisterServerEvent('CleanCoffeeHopper')
AddEventHandler('CleanCoffeeHopper', function()
local _source = source 
local xPlayer = ESX.GetPlayerFromId(_source)
local Randomizer = math.random(1, 10000)
local Randomizer1 = math.random(1, 10000)
  
if Randomizer > 500 then
   print('|Barista| check randomizer 500')    
   if xPlayer.getInventoryItem('cloth').count > 0 then 
        print('Succesfully Cleaned First Step')
        Message("Succesfully Cleaned First Step!", xPlayer)
       if Randomizer1 > 500 then
       print('|Barista| check < Randomizer1 500')
         if xPlayer.getInventoryItem('WaterJug').count > 0 then
      xPlayer.removeInventoryItem('WaterJug', 1)
      xPlayer.addInventoryItem('EmptyJug', 1)
      end
      if Randomizer1 < 200 then
      print('|Barista| Check Randomizer1 < 100')
         xPlayer.removeInventoryItem('cloth', 1)
      xPlayer.addInventoryItem('dirtycloth', 1)
      end
   end
   end
      end
    if Randomizer < 200 then 
      print('check < Randomizer 200')     
        if xPlayer.getInventoryItem('cloth').count > 0 then 
          xPlayer.removeInventoryItem('cloth', 1)
          xPlayer.addInventoryItem('dirtycloth', 1)
          --triggerClientEvent(Barista:SetCoffeeMachineDirty)
          Message('|Barista| Your cloth is dirty and', xPlayer)
          Message('|Barista| You failed to clean the machine', xPlayer)  
          print('|Barista| Cloth Dirty')
         print('|Barista| Player Failed to Clean the Machine', xPlayer)
        end
    end
end)
-- Clean Hopper Function End

--Making Black Coffee Function Start
RegisterServerEvent('Barista:MakeBlack_Coffee')
AddEventHandler('Barista:MakeBlack_Coffee', function()
local _source = source 
local xPlayer = ESX.GetPlayerFromId(_source)
      if xPlayer.getInventoryItem('WaterJug').count > 0 and xPlayer.getInventoryItem('Coffee_Grounds').count > 0 then
            xPlayer.removeInventoryItem('WaterJug', 1)
            xPlayer.removeInventoryItem('Coffee_Grounds', 1)
            Citizen.Wait(10000)
            xPlayer.addInventoryItem('Black_Coffee', 1)
            Message('Player successfully Made Black Coffee', xPlayer)
         else 
         Message('|Barista|You don/t have coffee beans or Jug of Water', xPlayer)
         end
      end) 
--Making Black Coffee Function End     

--Making White Coffee Function Start
RegisterServerEvent('Barista:MakeWhite_Coffee')
AddEventHandler('Barista:MakeWhite_Coffee', function()
local _source = source 
local xPlayer = ESX.GetPlayerFromId(_source)
   if xPlayer.getInventoryItem('WaterJug').count > 0 and xPlayer.getInventoryItem('Milk').count > 0 and xPlayer.getInventoryItem('Coffee_Grounds').count >0 then 
      Message('|Barista|User get Inventory WaterJug, Milk, Coffee_Grounds', xPlayer)
      xPlayer.removeInventoryItem('WaterJug', 1)
      xPlayer.removeInventoryItem('Milk', 1)
      xPlayer.removeInventoryItem('Coffee_Grounds', 1)
      Citizen.Wait(15000)
      xPlayer.addInventoryItem('White_Coffee', 1)
   else 
      Message("|Barista| Your Missing Either a WaterJug Coffee Beans Or Milk!", xPlayer)
      Message("|Barista| Please get these items and try again!", xPlayer)
      Citizen.Wait(2000)
      Message('You Need 1x Waterjug 1x Milk and 1x Coffee Beans', xPlayer)
   end
end) 
--Making White Coffee Function End

--Making Espresso Function Start
RegisterServerEvent('Barista:MakeESPRESSO')
AddEventHandler('Barista:MakeESPRESSO', function()
local _source = source 
local xPlayer = ESX.GetPlayerFromId(_source)
   if xPlayer.getInventoryItem('Coffee_Grounds').count > 1 and xPlayer.getInventoryItem('WaterJug').count > 0 then 
         xPlayer.removeInventoryItem('Coffee_Grounds', 2)
         xPlayer.removeInventoryItem('WaterJug', 1)
         Message('Player Making Espresso!', xPlayer)
         Citizen.Wait(15000)
         xPlayer.addInventoryItem('Espresso', 1) 
      Message('Player Successfully Made Espresso!', xPlayer)
      else
         Message('Your missing Either a WaterJug, Coffee_Grounds or Espresso', xPlayer)
         Citizen.Wait(1000)
         Message('Please get these items and try again', xPlayer)
         Citizen.Wait(2000)
         Message('You Need 2x Coffee Beans 1x waterjug and 1x Espresso!', xPlayer)
   end
end) 
--Making Espresso Function End

--Making Cappuccino Function Start
RegisterServerEvent('Barista:MakeCAPPUCCINO')
AddEventHandler('Barista:MakeCAPPUCCINO', function()
local _source = source 
local xPlayer = ESX.GetPlayerFromId(_source)
if xPlayer.getInventoryItem('Coffee_Grounds').count > 0 and xPlayer.getInventoryItem('WaterJug').count > 0 and xPlayer.getInventoryItem('frothedmilk').count > 0 then 
      xPlayer.removeInventoryItem('Coffee_Grounds', 1)
      xPlayer.removeInventoryItem('WaterJug', 1)
      xPlayer.removeInventoryItem('frothedmilk', 1)
      Message('Player Making Cappuccino!', xPlayer)
      Citizen.Wait(15000)
      xPlayer.addInventoryItem('Cappuccino', 1)
      Message('Player Successfully Made Cappuccino', xPlayer)
     else
      Message('Your Missing Either FrothedMilk, Coffee Beans, WaterJug,', xPlayer)
      Message('Please get these items and try again', xPlayer)
      Citizen.Wait(2000)
      Message('You need 1x Coffee Beans 1x WaterJug 1x FrothedMilk', xPlayer)
     end
end)
--Making Cuppuccino Function End

--Making Flat White Function Start
RegisterServerEvent('Barista:MakeFLATWHITE')
AddEventHandler('Barista:MakeFLATWHITE', function()
local _source = source 
local xPlayer = ESX.GetPlayerFromId(_source)
      if xPlayer.getInventoryItem('Espresso').count > 0 and xPlayer.getInventoryItem('frothedmilk').count > 0 then
          xPlayer.removeInventoryItem('Espresso', 1)
          xPlayer.removeInventoryItem('frothedmilk', 1)
          Message('Player Making Flat White!', xPlayer)
          Citizen.Wait(15000)
          xPlayer.addInventoryItem('FlatWhite', 1)
          Message('Player Successfully Made Flat White', xPlayer)
         else 
            Message('Your Missing Either frothedmilk or Espresso', xPlayer)
            Message('Please get these items and try again', xPlayer)
            Citizen.Wait(2000)
            Message('You need 1x FrothedMilk And 1x Espresso', xPlayer)
         end
         end) 
-- Making Flat White Function End

-- Making Frappe Function Start
RegisterServerEvent('Barista:MakeFRAPPÉ')
AddEventHandler('Barista:MakeFRAPPÉ', function()
local _source = source 
local xPlayer = ESX.GetPlayerFromId(_source)
if xPlayer.getInventoryItem('Espresso').count > 1 and xPlayer.getInventoryItem('frothedmilk').count > 1 and xPlayer.getInventoryItem('Sugar').count > 1 and xPlayer.getInventoryItem('Ice').count > 1 then
            xPlayer.removeInventoryItem('Espresso', 2)
            xPlayer.removeInventoryItem('frothedmilk', 2)
            xPlayer.removeInventoryItem('Sugar', 2)
            xPlayer.removeInventoryItem('Ice', 2)
            Message('Player Making Frappe!', xPlayer)
            Citizen.Wait(15000)
            xPlayer.addInventoryItem('Frappe', 1)
            Message('Player Succesfully Made Frappe', xPlayer)
         else
            Message('Your Missing Either frothedmilk, Ice, Sugar, or Espresso', xPlayer)
            Message('Please get these items and try again', xPlayer)
            Citizen.Wait(2000)
            Message('You Need 2x Espresso 2x frothedmilk 2x Sugar 2x Ice', xPlayer)
   end   
end) 
--Making Frappe Function End

-- Making Irish Coffee Function Start
RegisterServerEvent('Barista:MakeIRISHCOFFEE')
AddEventHandler('Barista:MakeIRISHCOFFEE', function()
local _source = source 
local xPlayer = ESX.GetPlayerFromId(_source)
if xPlayer.getInventoryItem('Black_Coffee').count > 0 and xPlayer.getInventoryItem('sugar').count > 0 and xPlayer.getInventoryItem('Milk').count > 0 and xPlayer.getinventoryitem('frothedmilk').count > 0 then
               xPlayer.removeInventoryItem('Black_Coffee', 1)
               xPlayer.removeInventoryItem('sugar', 1)
               xPlayer.removeInventoryItem('irishwhisky', 1)
               xPlayer.removeInventoryItem('frothedmilk', 1)
               xPlayer.removeInventoryItem('Milk', 1)
               Message('Player Making Irish Coffee!', xPlayer)
               Citizen.Wait(15000)
               xPlayer.addInventoryItem('IrishCoffee', 1)
               Message('Player Succesfully Made Irish Coffee', xPlayer)
            else 
               Message('Your Missing Either Black Coffee, Sugar, IrishWhisky, frothedmilk, or Milk', xPlayer)
               Message('Please get these items and try again', xPlayer)
               Citizen.Wait(2000)
               Message('You Need 1x Black Coffe 1x Sugar 1x IrishWhisky 1x FrothedMilk 1x Milk', xPlayer)
          
   end
end)  
--Making Irish Coffee Function End

-- Making Latte Function Start
RegisterServerEvent('Barista:MakeLatte')
AddEventHandler('Barista:MakeLatte', function()
local _source = source 
local xPlayer = ESX.GetPlayerFromId(_source)
   if xPlayer.getInventoryItem('Milk').count > 0 and xPlayer.getInventoryItem('Coffee_Grounds').count > 2 then -- 1 milk and 3 coffee beans
      xPlayer.removeInventoryItem('Coffee_Grounds', 3)
      xPlayer.removeInventoryItem('Milk', 1)
      Message('Player Making Latte', xPlayer)
      Citizen.Wait(15000)
      xPlayer.addInventoryItem('Latte', 1)
      Message('Player Succesfully Made Latte', xPlayer)
   else
      Message('Your Missing Either Coffee Beans Or Milk', xPlayer)
      Message('Please get these items and try again', xPlayer)
      Citizen.Wait(2000)
      Message('You Need 3x Coffee Beans 1x Milk', xPlayer)
   end
end)  
--Making Latte Function End

--- Making Espresso Function Start
RegisterServerEvent('Barista:MakeDOUBLEESPRESSO')
AddEventHandler('Barista:MakeDOUBLEESPRESSO', function()
local _source = source 
local xPlayer = ESX.GetPlayerFromId(_source)
   if xPlayer.getInventoryItem('Coffee_Grounds').count > 2 and xPlayer.getInventoryItem('WaterJug').count > 0 then
      xPlayer.removeInventoryItem('Coffee_Grounds', 3)
      xPlayer.removeInventoryItem('WaterJug', 1)
      Message('Player Making Double Espresso!', xPlayer)
      Citizen.Wait(15000)
      xPlayer.addInventoryItem('DbleEspresso', 1)
      Message('Player Succesfully Made Double Espresso', xPlayer)
   else 
      Message('Your Missing Either Coffee Beans Or WaterJug', xPlayer)
      Message('Please get these items and try again', xPlayer)
      Citizen.Wait(2000)
      Message('You Need 3x Coffee_Grounds 1x WaterJug', xPlayer)
   end
end)  
--grounding coffee function--
RegisterServerEvent('barista:groundcoffee')
AddEventHandler('barista:groundcoffee', function()
   local _source = source 
   local xPlayer = ESX.GetPlayerFromId(_source)
   if xPlayer.getInventoryItem('Coffee_Beans').count > 0 then
   Message('Grounding Coffee! Please wait!', xPlayer)
xPlayer.removeInventoryItem('Coffee_Beans', 1)
Citizen.Wait(10000)
xPlayer.addInventoryItem('Coffee_Grounds', 2) 
Message('Successfully Grounded coffee!', xPlayer)
   else 
      Message('You Need Coffee Beans to ground', xPlayer)
   end
end)

--- Useable Item Functions Start--- 
ESX.RegisterUsableItem('Milk', function(playerId)
   local xPlayer = ESX.GetPlayerFromId(playerId)
   xPlayer.removeInventoryItem('Milk', 1)
   Message('Moo, moo moo MOO MOO Moo', xPlayer)
   Citizen.Wait(1000)
   Message('Translation: You Drink the Milk', xPlayer)
end)

ESX.RegisterUsableItem('Latte', function(playerId)
   local xPlayer = ESX.GetPlayerFromId(playerId)
   xPlayer.removeInventoryItem('Latte', 1)
   Message('You Drink the Latte', xPlayer)
end)

ESX.RegisterUsableItem('IrishCoffee', function(playerId)
   local xPlayer = ESX.GetPlayerFromId(playerId)
   xPlayer.removeInventoryItem('IrishCoffee', 1)
   Message('You Drink the Irish Coffee', xPlayer)
end)

ESX.RegisterUsableItem('Black_Coffee', function(playerId)
   local xPlayer = ESX.GetPlayerFromId(playerId)
   xPlayer.removeInventoryItem('Black_Coffee', 1)
   Message('You Drink the Black Coffee', xPlayer)
end)

ESX.RegisterUsableItem('Frappe', function(playerId)
   local xPlayer = ESX.GetPlayerFromId(playerId)
   xPlayer.removeInventoryItem('Frappe', 1)
   Message('You Drink the Frappe', xPlayer)
end)

ESX.RegisterUsableItem('Espresso', function(playerId)
   local xPlayer = ESX.GetPlayerFromId(playerId)
   xPlayer.removeInventoryItem('Espresso', 1)
   Message('You Drink the Espresso', xPlayer)
end)

ESX.RegisterUsableItem('Cappuccino', function(playerId)
   local xPlayer = ESX.GetPlayerFromId(playerId)
   xPlayer.removeInventoryItem('Cappuccino', 1)
   Message('You Drink the Cappuccino', xPlayer)
end)

ESX.RegisterUsableItem('FlatWhite', function(playerId)
   local xPlayer = ESX.GetPlayerFromId(playerId)
   xPlayer.removeInventoryItem('FlatWhite', 1)
   Message('You Drink the Flat White', xPlayer)
end)

--ESX.RegisterUsableItem('White_Coffee', function(playerId)
 --  local xPlayer = ESX.GetPlayerFromId(playerId)
  -- xPlayer.removeInventoryItem('White_Coffee', 1)
   --Message('You Drink the White Coffee', xPlayer)
--end)

ESX.RegisterUsableItem('White_Coffee', function(playerId)
   local xPlayer = ESX.GetPlayerFromId(playerId)
   if xPlayer.getInventoryItem('White_Coffee').count > 0 and xPlayer.getInventoryItem('emptycoffeecup2').count > 0 then 
   xPlayer.removeInventoryItem('White_Coffee', 1)
   xPlayer.removeInventoryItem('emptycoffeecup', 1)
   xPlayer.addInventoryItem('whitecoffee2go', 1)
   Message('You Make a White Coffee To Go!', xPlayer)
   else 
      if xPlayer.getInventoryItem('White_Coffee').count > 0 and xPlayer.getInventoryItem('coke').count > 0 then 
         xPlayer.removeInventoryItem('White_Coffee', 1)
         xPlayer.removeInventoryItem('coke', 1)
         Message('You start pouring cocaine into your coffee', xPlayer)
         Citizen.Wait(1500)
         xPlayer.addInventoryItem('cocainewhitecoffee', 1)
         Message('You\'ve Poured all your Cocaine into the cup', xPlayer)
      --else   need to make new registerableItem here....
        -- if xPlayer.getInventoryItem('White_Coffee2go').count > 0 and xPlayer.getInventoryItem('coke').count > 0 then 
           -- removeInventoryItem('White_Coffee2go', 1)
           -- removeInventoryItem('coke', 1)
            --Message('You start pouring cocaine into your coffee', xPlayer)
            --Citizen.Wait(1500)
            --addInventoryItem('cocaineWhite_Coffee2go')
            --Message('You\'ve Poured all your Cocaine into the cup', xPlayer)
      else 
      if xPlayer.getInventoryItem('White_Coffee', 1) then 
      xPlayer.removeInventoryItem('White_Coffee', 1)
      Message('You drink the White Coffee', xPlayer)
      end
  --end
   end
end
   end)
ESX.RegisterUsableItem('coffee', function(playerId)
   local xPlayer = ESX.GetPlayerFromId(playerId)
   if xPlayer.getInventoryItem('coffee').count > 0 and xPlayer.getInventoryItem('cocaine').count > 0 then 
   xPlayer.removeInventoryItem('cocaine', 1)
   xPlayer.removeInventoryItem('coffee', 1)
   Message('you mix the cocaine with the coffee', xPlayer)
   xPlayer.addInventoryItem('cocainecoffee', 1)
   else if xPlayer.getInventoryItem('coffee').count > 0 then 
      xPlayer.removeInventoryItem('coffee', 1)
      Message('You drinky the drinky winky', xPlayer)
   end
   end
end)
-----Usable items end
RegisterServerEvent('ordershipment')
AddEventHandler('ordershipment', function()
   local _source = source 
   local xPlayer = ESX.GetPlayerFromId(_source)
   TriggerClientEvent('ConfirmDeny', _source)
end)

RegisterServerEvent('ordershipment1')
AddEventHandler('ordershipment1', function()
   local _source = source 
   local xPlayer = ESX.GetPlayerFromId(_source)
 local timer5 = math.random(180000,300000)
if xPlayer.getInventoryItem('money').count > 2499 then  
Message('Ordering Shipment', xPlayer)
Message('It Will arrive in approximently 3-5 minutes', xPlayer)
xPlayer.removeInventoryItem('money', 2500)
Citizen.Wait(timer5)
xPlayer.addInventoryItem('Coffee_Beans', 10)
xPlayer.addInventoryItem('Milk', 15)
xPlayer.addInventoryItem('Ice', 15)
xPlayer.addInventoryItem('Sugar', 15)
xPlayer.addInventoryItem('WaterJug', 15)
else 
   Message('You Dont Have the Required Funds On You', xPlayer)
   Message('Please get the funds and try again', xPlayer)
--Making Espresso Function End
end
end)
RegisterServerEvent('Barista:RobFridge')
AddEventHandler('Barista:RobFridge', function()
   local _source = source 
   local xPlayer = ESX.GetPlayerFromId(_source)
 local amount = math.random(1, 5)
 local timer = math.random (13000, 20000)
 local FindSomething = math.random(1, 1000)
 if FindSomething < 500 then 
  --if xPlayer.getInventoryItem('advancedlockpick').count > 0 then
Message('Stealing From Fridge', xPlayer)
 Citizen.Wait(timer)
 xPlayer.addInventoryItem('Frappe', amount)
Message('You can try again in 5 minutes', xPlayer)
else 
     if FindSomething > 500 then 
      Message('You didn\'t find anything of interest', xPlayer)
      Message('You can try again in 5 minutes', xPlayer)
   end     
end
end)
RegisterServerEvent('BaristaRobRegister')
AddEventHandler('BaristaRobRegister', function()
   local _source = source 
   local xPlayer = ESX.GetPlayerFromId(_source)
 local amount = math.random(200, 650)
 local timer = math.random (13000, 20000)
 Message('Robbing Register!', xPlayer)
 Citizen.Wait(timer)
 xPlayer.addInventoryItem('money', amount)
Message('You must wait 5 minutes before you can rob this again', xPlayer)
end)
--Useable Items Function End


