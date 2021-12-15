-- Esx Start
ESX = nil
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

local x = Config.password
Citizen.CreateThread(function()

    while ESX == nil do

        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

        Citizen.Wait(0)

while ESX.GetPlayerData().job == nil do
    Citizen.Wait(100) -- checks job every 100 ms
end

PlayerData = ESX.GetPlayerData()
end
end)

--TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_barista', 'Bean Machine', 59) PLACEHOLDER SOCIETY?>
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
Citizen.Wait(10) 
PlayerData = ESX.GetPlayerData()
if PlayerData.job.name == "barista" then
    PlayerData.job = job 
else
    print('Barista Nub patch 2.0')
end

end)

--Blips Function Start
local blips = { 
    {title="Coffee Machine", colour=4, id=131, x = 279.5736, y = -974.5187, z = 29.41467},
    {title="Coffee Pot", colour=5, id=132, x = 281.011, y = -974.5714, z = 29.41467}
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

--Blips Function End
--isMakingCoffee = false 


--Sample Animation Lockpick End

--Coffee Machine Data Start


Citizen.CreateThread(function()
    exports['trp-LookAround']:AddBoxZone("CoffeeMachine", vector3(279.555, -974.8615, 30.91431-1.5), 0.8, 0.8, {
        name="CoffeeMachine",
        heading=91,
        debugPoly=false,
        minZ=30.01-0.3,
        maxZ=30.20
        }, {
            options = {
                {
                    event = "OpenCoffeeMachine",
                    icon = "fas fa-coffee",
                    label = "Operate Coffee Machine",
                },
                {
                    event = "GroundCoffee",
                    icon = "fas fa-shower",
                    label = "Ground Coffee",
                },
                {
                    event = "CleanCoffeeMachine",
                    icon = "fas fa-shower",
                    label = "Clean Machine",
                },
                {
                    event = "CleanCoffeeMachine",
                    icon = "fas fa-tint",
                    label = "Clean Hopper",
                },
                {
                    event = "CleanCoffeeMachine",
                    icon = "fas fa-hammer",
                    label = "Repair Machine",
                },
            },
            job = {"barista"},
            distance = 0.5
        })
end)
AddEventHandler('OpenCoffeeMachine', function()-- this is the event = that trp_lookaround calls to.
    OpenCoffeeMachine()
end)
AddEventHandler('GroundCoffee', function()
    isMakingCoffee = true 
    TriggerEvent('CoffeeMakeAnimation')
    TRPBaristaUI(10000, "Grounding Coffee") 
    TriggerServerEvent('barista:groundcoffee') 
    Citizen.Wait(10000)
    isMakingCoffee = false
end)
Citizen.CreateThread(function()
    exports['trp-LookAround']:AddBoxZone("CoffeeStorage", vector3(279.5077, -971.9604, 29.41467), 0.8, 0.8, {
        name="CoffeeStorage",
        heading=91,
        debugPoly=false,
        minZ=30.01-0.3,
        maxZ=30.20
        }, {
            options = {
                {
                    event = "OpenCoffeeStorage",
                    icon = "fas fa-coffee",
                    label = "Open Fridge",
                },
                {
                    event = "RobFridge",
                    icon = "fab fa-keycdn",
                    label = "Steal From Fridge",
                },
    
            },
            job = {"barista"},
            distance = 1.5
        })
end)

AddEventHandler('OpenCoffeeStorage', function()
    OpenCoffeeStorage()  
end)
local canrob = true 
AddEventHandler('RobFridge', function()
    if canrob then  
    TriggerServerEvent('Barista:RobFridge')
    canrob = false
    print('Waiting 5 minutes')
    Citizen.Wait(500000)
    end
end)
Citizen.CreateThread(function()
    exports['trp-LookAround']:AddBoxZone("FrothMachine", vector3(279.1121, -974.5319, 30.67834-0.2), 0.8, 0.8, {
        name="FrothMachine",
        heading=91,
        debugPoly=false,
        minZ=30.01-0.3,
        maxZ=30.20
        }, {
            options = {
                {
                    event = "frothMilk",
                    icon = "fas fa-blender",
                    label = "Froth Milk",
                },
            },
            job = {"barista"},
            distance = 1.5
        })
end)

AddEventHandler('frothMilk', function() 
    if not isMakingCoffee then 
    isMakingCoffee = true 
    TriggerEvent('CoffeeMakeAnimation')
    TRPBaristaUI(10000, "frothmilk") 
    TriggerServerEvent('frothmilk') 
    Citizen.Wait(10000)
    isMakingCoffee = false
    end
end)
AddEventHandler('BaristaSociety', function()
   if PlayerData.job.grade_name == 'boss' then
    OpenBossActionsMenu()
    --end
end
end)

--Open Coffee Machine Menu Function
Citizen.CreateThread(function()
    exports['trp-LookAround']:AddBoxZone("FrothMachine2", vector3(284.8484, -978.8307, 30.39197), 0.8, 0.8, {
        name="FrothMachine2",
        heading=91,
        debugPoly=false,
        minZ=28.01,
        maxZ=30.20
        }, {
            options = {
                {
                    event = "ordershipment",
                    icon = "fas fa-blender",
                    label = "Order Shipment",
                },
                {
                    event = "BaristaSociety",
                    icon = "fas fa-blender",
                    label = "Boss Actions",
                },
                {
                    event = "Check Stock-Market",
                    icon = "fas fa-blender",
                    label = "Check Stock-Market",
                },
                {
                    event = "Close",
                    icon = "fas fa-blender",
                    label = "Close",
                },
            },
            job = {"barista"},
            distance = 3
        })
end)
AddEventHandler('ordershipment', function()
    isorderingshipment = true 
    TriggerServerEvent('ordershipment')
    Citizen.Wait(1000000)
    isorderingshipment = false
end)
AddEventHandler('placeholder', function()
    isMakingCoffee = true 
    TriggerEvent('CoffeeMakeAnimation')
    TRPBaristaUI(10000, "frothmilk") 
    TriggerServerEvent('frothmilk') 
    Citizen.Wait(10000)
    isMakingCoffee = false
end)
Citizen.CreateThread(function()
    exports['trp-LookAround']:AddBoxZone("OfficeSafe", vector3(283.5956, -976.6285, 29.41467), 0.8, 0.8, {
        name="OfficeSafe",
        heading=91,
        debugPoly=false,
        minZ=29,
        maxZ=30.20
        }, {
            options = {
                {
                    event = "Crack Safe",
                    icon = "fas fa-blender",
                    label = "Crack Safe",
                },
                {
                    event = "Put items in safe",
                    icon = "fas fa-blender",
                    label = "Put items into safe",
                },
            },
            job = {"all"},
            distance = 1.5
        })
end)




function OpenCoffeeMachine()
  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'Coffee_Machine_Menu',
      {
          title    = 'Coffee_Machine_Menu', 
          elements = {
              {label = 'Open Coffee Selection', value = 'OpenCoffeeMenu', password = Config.password},
            --  {label = 'Start Coffee Making', value = 'Start Making Coffee', password = Config.password},
            --  {label = 'Finish Coffee', value = 'Finish Coffee', password = Config.password},
              {label = 'Coffee Machine Options', value = 'CoffeeMachineOptions', password = Config.password}
            }
      },
      function(data, menu)
     if data.current.value == 'OpenCoffeeStorage' then
        OpenCoffeeStorage()
    
     elseif data.current.value == 'OpenCoffeeMenu' then 
        OpenCoffeeMenu()
     elseif data.current.value == 'CoffeeMachineOptions' then 
        OpenCoffeeMachineOptions()
    
    
    elseif data.current.value == 'Start Making Coffee' and data.current.password == Config.password then
        isMakingCoffee = true 
        TriggerEvent('CoffeeMakeAnimation', Config.password)
        print(Config.password)
        TRPBaristaUI(30000, "Making Coffee", Config.password)
        Citizen.Wait(30000) 
        TriggerServerEvent('barista:makeHalfMade', Config.password) 
        isMakingCoffee = false 


            
    elseif data.current.value == 'Finish Coffee' and data.current.password == Config.password then
        isMakingCoffee = true 
        TriggerEvent('CoffeeMakeAnimation', Config.password)
        print(Config.password)
        TRPBaristaUI(10000, "frothmilk", Config.password) 
        TriggerServerEvent('Barista:MakeCoffee', Config.password) 
        Citizen.Wait(10000)
        isMakingCoffee = false
    end
    end, 
      function(data, menu)
          menu.close()
      end
  )
end
--Open CoffeeMachine Menu End
--cofeemachineoption start
 --coffeemachineoption end
  
 
 --Coffee Stroage Function Start
function OpenCoffeeStorage()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'OpenCoffeeStorage',
        {
            title    = 'Grab the items to make coffee Below!',
            elements = {
                {label = '1x Milk Costs: 150', value = 'Milk', password = Config.password},
                {label = '1x Sugar Costs: 100', value = 'Sugar', password = Config.password},
                {label = '1x Water Jug Costs: 75', value = 'Water Jug', password = Config.password},
                {label = '1x Coffee Beans Costs: 200', value = 'Coffee Beans', password = Config.password},
                {label = '1x Ice Costs: 50', value = 'Ice', password = Config.password}
            }
        },
        function(data, menu)
            if data.current.value == 'Milk' then    --Add storage function so they dont just get free milk... and coffee and shit
            TriggerServerEvent('Barista:GiveMilkFromStorage')
            
            elseif data.current.value == 'Sugar' and data.current.password == Config.password then
                TriggerServerEvent('Barista:GiveSugarFromStorage', Config.password)
                print(data.current.password)
            elseif data.current.value == 'Water Jug' and data.current.password == Config.password then
                TriggerServerEvent('Barista:GiveWaterFromStorage', Config.password)
                print(data.current.password)
            elseif data.current.value == 'Water Jug' and data.current.password == Config.password then
                TriggerServerEvent('Barista:GiveWaterFromStorage', Config.password)
                print(data.current.password)
            elseif data.current.value == 'Coffee Beans' and data.current.password == Config.password then
                TriggerServerEvent('Barista:GiveCoffeeBeansFromStorage', Config.password)
                print(data.current.password)
            elseif data.current.value == 'Ice' and data.current.password == Config.password then
                TriggerServerEvent('Barista:GiveIceFromStorage', Config.password)
                else 
                    print('Put ban event here theres a relay from ice water jug coffee beans and you fucker modded it line 243')
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end

function OpenCoffeeMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'OpenCoffeeMenu',
        {
            title    = 'Coffee Menu!',
            elements = {
                {label = 'Black Coffee', value = 'Black_Coffee'},
                {label = 'White Coffee', value = 'White_Coffee'},
                {label = 'ESPRESSO', value = 'ESPRESSO'},
                {label = 'CAPPUCCINO', value = 'CAPPUCCINO'},
                {label = 'FLAT WHITE', value = 'FLAT WHITE'},
                {label = 'FRAPPÉ', value = 'FRAPPÉ'},
                {label = 'IRISH COFFEE', value = 'IRISH COFFEE'},
                {label = 'CAFÈ AU LAIT', value = 'CAFÈ AU LAIT'},
                {label = 'DOUBLEESPRESSO', value = 'DOUBLEESPRESSO'},

            }
        },
        function(data, menu)
            if data.current.value == 'Black_Coffee' then    --Add storage function so they dont just get free milk... and coffee and shit
                MakeBlackCoffee()
            
            elseif data.current.value == 'White_Coffee' then
                MakeWhiteCoffee() 
            
            elseif data.current.value == 'ESPRESSO' then
                MakeESPRESSO() 
            elseif data.current.value == 'CAPPUCCINO' then
                MakeCAPPUCCINO()
            elseif data.current.value == 'FLAT WHITE' then
                MakeFLATWHITE()
            elseif data.current.value == 'FRAPPÉ' then
                MakeFRAPPE()
            elseif data.current.value == 'IRISH COFFEE' then
                MakeIRISHCOFFEE()
            elseif data.current.value == 'CAFÈ AU LAIT' then
                MakeLatte()
            elseif data.current.value == 'DOUBLEESPRESSO' then
                MakeDOUBLEESPRESSO()

                end
        end,
        function(data, menu)
            OpenCoffeeMachine()
        end
    )
end
--Coffee Storage End
--Society Function
function OpenBossActionsMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'trp_BaristaJob',{
        title    = 'Barista Owner',
        align    = 'top-left',
        elements = {
            {label = 'boss_actions', value = 'boss_actions'},
    }}, function(data, menu)
        if data.current.value == 'boss_actions' then
            TriggerEvent('esx_society:openBossMenu', 'barista', function(data2, menu2)
                menu2.close()
            end)
                menu2.close()
        end

    end, function(data, menu)
        menu.close()

        CurrentAction     = 'boss_actions_menu'
        CurrentActionMsg  = _U('shop_menu')
        CurrentActionData = {}
    end)
end
-- Society end
--Make BlackCoffee Start
function MakeBlackCoffee()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'MakeBlackCoffee',
        {
            title    = 'Make Black Coffee!',
            elements = {
                {label = 'Make Black Coffee', value = 'MakeBlackCoffee', password = Config.password},
                {label = 'Items Required Below:', value = 'NoValueNeeded', password = Config.password},
                {label = '1x Coffee Grounds', value = 'NoValueNeeded', password = Config.password},
                {label = '1x WaterJug', value = 'NoValueNeeded', password = Config.password},
            }
        },
        function(data, menu)
            if data.current.value == 'MakeBlackCoffee' and data.current.password == Config.password and not isMakingCoffee then   --Add storage function so they dont just get free milk... and coffee and shit
                print(data.current.password)
                TRPBaristaUI(10000, "Making Black Coffee", Config.password)
                isMakingCoffee = true 
                TriggerServerEvent('Barista:MakeBlack_Coffee', Config.password)
                TriggerEvent('CoffeeMakeAnimation', Config.password)
                Citizen.Wait(10000)
                isMakingCoffee = false 
                else
                    print('Put ban event here player modding line 326')
            --end
        end
        end,
        function(data, menu)
            OpenCoffeeMenu()
        end
    )
end
--Make BlackCoffee End

--Make WhiteCoffee Start
function MakeWhiteCoffee()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'MakeWhiteCoffee',
        {
            title    = 'Make White Coffee',
            elements = {
                {label = 'Make White Coffee', value = 'MakeWhiteCoffee', password = Config.password},
                {label = 'Items Required Below', value = 'filler', password = Config.password},
                {label = '1x WaterJug', value = 'filler', password = Config.password},
                {label = '1x Coffee Grounds', value = 'filler', password = Config.password},
                {label = '1x fresh milk', value = 'filler', password = Config.password},
            }
        },
        function(data, menu)
            if data.current.value == 'MakeWhiteCoffee' and data.current.password == Config.password and not isMakingCoffee then   --Add storage function so they dont just get free milk... and coffee and shit
                print(data.current.password)
                TRPBaristaUI(15000, "Making White Coffee", Config.password)
                isMakingCoffee = true
                TriggerServerEvent('Barista:MakeWhite_Coffee', Config.password)
                TriggerEvent('CoffeeMakeAnimation', Config.password)
                Citizen.Wait(15000)
                isMakingCoffee = false 
                else
                    print('Put a ban event here line 356 player modding')   
            --end
        end
        end,
        function(data, menu)
            OpenCoffeeMenu()
        end
    )
end
--Make WhiteCoffee End

--Make Espresso Start
function MakeESPRESSO()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'MakeESPRESSO',
        {
            title    = 'Make Espresso',
            elements = {
                {label = 'MakeESPRESSO', value = 'MakeESPRESSO', password = Config.password},
                {label = 'Items Required Below:', value = '1', password = Config.password},
                {label = '2x Coffee Grounds', value = '2', password = Config.password},
                {label = '1x WaterJug', value = '3', password = Config.password},
            }
        },
        function(data, menu)
            if data.current.value == 'MakeESPRESSO' and data.current.password == Config.password and not isMakingCoffee then
                TRPBaristaUI(15000, "Making Espresso", Config.password)
                isMakingCoffee = true
                print(data.current.password)
                TriggerServerEvent('Barista:MakeESPRESSO', Config.password)
                TriggerEvent('CoffeeMakeAnimation', Config.password)
                Citizen.Wait(15000)
                isMakingCoffee = false 
                else 
                    print('Player modding put ban event here 384')
            --end
        end
        end,
        function(data, menu)
            OpenCoffeeMenu()
        end
    )
end
--Make Espresso End

--Make Cappuccino Start
function MakeCAPPUCCINO()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'MakeCAPPUCCINO',
        {
            title    = 'Make Cappuccino',
            elements = {
                {label = 'MakeCAPPUCCINO', value = 'MakeCAPPUCCINO', password = Config.password},
                {label = 'Items Required Below:', value = '1', password = Config.password},
                {label = '1x Coffee Grounds', value = '2', password = Config.password},
                {label = '1x WaterJug', value = '3', password = Config.password},
                {label = '1x Frothed Milk', value = '4', password = Config.password},
            }
        },
        function(data, menu)
            if data.current.value == 'MakeCAPPUCCINO' and data.current.password == Config.password and not isMakingCoffee then--Add storage function so they dont just get free milk... and coffee and shit
                TRPBaristaUI(15000, "Making Cappuccino", Config.password)
                isMakingCoffee = true
                print(data.current.password)
                TriggerServerEvent('Barista:MakeCAPPUCCINO', Config.password)
                TriggerEvent('CoffeeMakeAnimation', Config.password)
                Citizen.Wait(15000)
                isMakingCoffee = false 
                else 
                    print('Player modding Put a ban event here line 412')
         --end
        end
    end,
    function(data, menu)
        OpenCoffeeMenu()
    end
)
end
--Make Cappuccino End

--Make FlatWhite Start
function MakeFLATWHITE()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'MakeFLATWHITE',
        {
            title    = 'Make Flat White',
            elements = {
                {label = 'Make FLAT WHITE', value = 'MakeFLATWHITE', password = Config.password },
                {label = 'Items Required Below:', value = '1', password = Config.password},
                {label = '1x Espresso', value = '2', password = Config.password},
                {label = '1x Frothed Milk', value = '3', password = Config.password},
            }
        },
        function(data, menu)
            if data.current.value == 'MakeFLATWHITE' and data.current.password == Config.password and not isMakingCoffee then --Add storage function so they dont just get free milk... and coffee and shit
                TRPBaristaUI(15000, "Making FlatWhite")
                isMakingCoffee = true
                --print(password)
                print(data.current.password)
                TriggerServerEvent('Barista:MakeFLATWHITE', Config.password)
                TriggerEvent('CoffeeMakeAnimation', Config.password)
                Citizen.Wait(15000)
                isMakingCoffee = false 
                else 
                print('put a ban event here because its impossible to be here without modding')
            --end
            end
            end,
        function(data, menu)
            OpenCoffeeMenu()
        end
    )
end
--Make FlatWhite End

--Make Frappe Start
function MakeFRAPPE()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'MakeFRAPPE',
        {
            title    = 'Make Frappe',
            elements = {
                {label = 'Make FRAPPÉ', value = 'MakeFRAPPE', password = Config.password},
                {label = 'Items Required Below:', value = '1', password = Config.password},
                {label = '2x Espresso', value = '2', password = Config.password},
                {label = '2x Frothed Milk', value = '3', password = Config.password},
                {label = '2x Sugar', value = '4', password = Config.password},
                {label = '2x Ice', value = '5', password = Config.password},
            }
        },
        function(data, menu)
            if data.current.value == 'MakeFRAPPE' and data.current.password == Config.password and not isMakingCoffee then
                print(data.current.password)
                TRPBaristaUI(15000, "Making Frappe", Config.password)
                isMakingCoffee = true
                if data.current.password == Config.password then 
                TriggerServerEvent('Barista:MakeFRAPPÉ', Config.password)
                TriggerEvent('CoffeeMakeAnimation', Config.password)
                Citizen.Wait(15000)
                isMakingCoffee = false 
                else 
                    print('Someone had just modded please put a ban event here.')
            end
        end
        end,
        function(data, menu)
            OpenCoffeeMenu()
        end
    )
end
--Make Frappe End

--Make Irish Coffee Start
function MakeIRISHCOFFEE()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'MakeIRISHCOFFEE',
        {
            title    = 'Make Irish Coffee',
            elements = {
                {label = 'MakeIRISHCOFFEE', value = 'MakeIRISHCOFFEE', password = Config.password},
                {label = 'Items Required Below:', value = '1', password = Config.password},
                {label = '1x Black Coffee', value = '2', password = Config.password},
                {label = '1x Sugar', value = '3', password = Config.password},
                {label = '1x Irish Whisky', value = '4', password = Config.password},
                {label = '1x Frothed Milk', value = '5', password = Config.password},
                {label = '1x Fresh Milk', value = '6', password = Config.password},
                
            }
        },
        function(data, menu)
            if data.current.value == 'MakeIRISHCOFFEE' and data.current.password == Config.password and not isMakingCoffee then
                print(data.current.password)
                TRPBaristaUI(15000, "Making Irish Coffee", Config.password)
                isMakingCoffee = true
                if data.current.password == Config.password then
                TriggerServerEvent('Barista:MakeIRISHCOFFEE', Config.password)
                TriggerEvent('CoffeeMakeAnimation', Config.password)
                Citizen.Wait(15000)
                isMakingCoffee = false
                else 
                    print('Someone is modding.... Please put a ban event here')
               end
            end
            end,
        function(data, menu)
            OpenCoffeeMenu()
        end
    )
end
--Make Irish Coffee End

--Make Latte Start
function MakeLatte()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'MakeLatte',
        {
            title    = 'Make Latte',
            elements = {
                {label = 'MakeLatte', value = 'MakeLatte', password = Config.password},
                {label = 'Items Required Below:', value = '1', password = Config.password},
                {label = '3x Coffee Grounds', value = '2', password = Config.password},
                {label = '1x Fresh Milk', value = '3', password = Config.password},
            }
        },
        function(data, menu)
            if data.current.value == 'MakeLatte' and data.current.password == Config.password and not isMakingCoffee then
                print(data.current.password)
                TRPBaristaUI(15000, "Making Latte", Config.password)
                isMakingCoffee = true
                if data.current.password == Config.password then
                TriggerEvent('CoffeeMakeAnimation', Config.password)
                TriggerServerEvent('Barista:MakeLatte', Config.password)
                Citizen.Wait(15000)
                isMakingCoffee = false 
                else
                    print('Somoene is modding Please put a ban event here')
                end
                end
        end,
        function(data, menu)
            OpenCoffeeMenu()
        end
    )
end
--Make Latte End
RegisterNetEvent('ConfirmDeny')
AddEventHandler('ConfirmDeny', function()  
print('success?')
ConfirmDeny()
end)
--Make DoubleEspresso Start
function ConfirmDeny()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'ConfirmDeny',
        {
            title    = 'Confirm Deny Option',
            elements = {
                {label = 'This Shipment Will Cost 2500', value = 'NillValue', password = Config.password},
                {label = 'Confirm', value = 'Confirm', password = Config.password},
                {label = 'Deny', value = 'Deny', password = Config.password},

            }
        },
        function(data, menu)
            if data.current.value == 'Confirm' then    --Add storage function so they dont just get free milk... and coffee and shit
                print(data.current.password)
                if data.current.password == Config.password then
                TriggerServerEvent('ordershipment1', Config.password)
                Citizen.Wait(300000)
                isMakingCoffee = false 
            elseif data.current.value == 'Deny' and data.current.password == Config.password then
                menu.close() 
            end
        end
        end,
        function(data, menu)
            menu.close()
        end
    )
end
function MakeDOUBLEESPRESSO()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'MakeDOUBLEESPRESSO',
        {
            title    = 'Make DOUBLEESPRESSO',
            elements = {
                {label = 'Make DOUBLE ESPRESSO', value = 'MakeDOUBLEESPRESSO', password = Config.password},
                {label = 'Items Required Below:', value = '1', password = Config.password},
                {label = '3x Coffee Grounds', value = '2', password = Config.password},
                {label = '1x WaterJug', value = '3', password = Config.password},
            }
        },
        function(data, menu)
            if data.current.value == 'MakeDOUBLEESPRESSO' and data.current.password == Config.password and not isMakingCoffee then
                print(data.current.password)
                TRPBaristaUI(15000, "Making Double Espresso", Config.password)
                isMakingCoffee = true 
                if data.current.password == Config.password then
                TriggerEvent('CoffeeMakeAnimation', Config.password)
                TriggerServerEvent('Barista:MakeDOUBLEESPRESSO', Config.password)
                Citizen.Wait(15000)
                isMakingCoffee = false 
                else
                    print('Modder detected please put ban event here')   
            end
        end
        end,
        function(data, menu)
            OpenCoffeeMenu()
        end
    )
end
--Make DoubleEspresso End

function TRPBaristaUI(time, text) 
	SendNUIMessage({
		type = "TRPBaristaUI",
		display = true,
		time = time,
		text = text
	})
end
----- ON DUTY OFF DUTY SUB FUNCTION LEAVE HERE FOR INDIVIDUAL USAGE SO THE SCRIPT CAN REMAIN STAND ALONE....
--PUT BACK HERE

--Sample Animation Lockpick Start
RegisterNetEvent('CoffeeMakeAnimation')
AddEventHandler('CoffeeMakeAnimation', function()
    isMakingCoffee = false 
    isMakingCoffee = true
    loadAnimDict('anim@amb@nightclub@mini@drinking@drinking_shots@ped_a@normal')
    controlDisables = {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = true,
        disableCombat = true,
    }
    while isMakingCoffee do
     if not IsEntityPlayingAnim(PlayerPedId(), 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_a@normal', 'pour_one', 8.0, -8,3750, 2, 0, 0, 0, 0) then
      TaskPlayAnim(PlayerPedId(), 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_a@normal', 'pour_one', 8.0, -8,3750, 2, 0, 0, 0, 0)
      Citizen.Wait(3500)
      ClearPedTasks(PlayerPedId())
     end
     Citizen.Wait(1)
    end
    ClearPedTasks(PlayerPedId())
   end)
   
   function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
     Citizen.Wait(5)
    end
   end
--HintToDisplayText
   function hintToDisplay(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
function Draw3DText(x, y, z, text, scale)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoord())
    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(true)
    SetTextColour(255, 255, 255, 215)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 700
    DrawRect(_x, _y + 0.0150, 0.10 + factor, 0.03, 41, 11, 41, 100)
end
