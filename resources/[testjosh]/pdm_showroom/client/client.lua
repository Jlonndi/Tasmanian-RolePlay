--- action functions
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil


--- esx_vehicleshop funtions
local IsInShopMenu            = false
local Categories              = {}
local Vehicles                = {}
local LastVehicles            = {}
local CurrentVehicleData      = nil

--- esx
local PlayerData              = {}
local GUI = {}
ESX                           = nil
GUI.Time                      = 0
inMenu  = true
local Skrillex = false
local BigDick = true
local ControlPressMessage = 'Press ~INPUT_PICKUP~ To DOSOMETHING ~b~'
local keys = { -- Key Table
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

--===============================================
--==           Base ESX Threading              == 
--===============================================
-- Uncomment if need ESX
Citizen.CreateThread(function()
	while ESX == nil do
	  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	  Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()

    while true do
        Wait(5000)
		local playerPed = PlayerPedId()
        local zcloser = false
		local distance = 100
		local playerCoords = GetEntityCoords(PlayerPedId())

		--for k,v in pairs(Config.ZonesShowroom.EntryLocations) do
			Wait(35)
		--	local showrooms = Showroom
			local distance = GetDistanceBetweenCoords(playerCoords, -53.92088, -1096.721, 26.41541, true)

			if distance < 50 then
				zcloser = true
            end
        --end
		if zcloser then
			closer = true
		else
			closer = false
		end
    end
end)
local location = 1
Citizen.CreateThread(function()
    while true do
    	Citizen.Wait(10)
        if closer then
            local coords = GetEntityCoords(PlayerPedId())
            if GetDistanceBetweenCoords(coords, vector3(-53.92088, -1096.721, 26.41541), true) < 20 then
                FishersShowroom()
                while closer == true do
                    Citizen.Wait(5000)
                end
        	  end
        end
    end
end)

function FishersShowroom()
    ESX.TriggerServerCallback('esx_vehicleshop:getCategories', function (categories)
        Categories = categories
    end)

    ESX.TriggerServerCallback('esx_vehicleshop:getVehicles', function (vehicles)
        Vehicles = vehicles
    end)
end


if BigDick then
	Citizen.CreateThread(function()
		local sleep = 500 
		while true do
			Citizen.Wait(sleep)
			if nearMarker() then
				sleep = 1
				for k,v in ipairs(Config.Marker)do
					DrawMarker(27, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 0, 255, 0, 100, false, true, 2, false, false, false, false)
					DisplayHelpText('Press ~INPUT_PICKUP~ To Open Showroom ~b~')
				if IsControlJustPressed(1, keys[Config.Keys.Open]) then
					OpenShopMenu22222()
					local ped = PlayerPedId()
				    end
				end
			else 
				sleep = 500
			end
		end
	end)
end
--[[Citizen.CreateThread(function()
	if showblips then
	  for k,v in ipairs(Marker)do
	  local blip = AddBlipForCoord(v.x, v.y, v.z)
	  SetBlipSprite(blip, v.id)
	  SetBlipDisplay(blip, 4)
	  SetBlipScale  (blip, 0.9)
	  SetBlipColour (blip, 2)
	  SetBlipAsShortRange(blip, true)
	  BeginTextCommandSetBlipName("STRING")
	  AddTextComponentString(tostring(v.name))
	  EndTextCommandSetBlipName(blip)
	  end
	end
  end)]]
--===============================================
--==            Blip Distance                  ==
--===============================================
function nearMarker()
	local player = PlayerPedId()
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(Config.Marker) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

		if distance <= 3 then
			return true
		end
	end
end

function nearMarker2()
	local player = PlayerPedId()
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(Config.Marker2) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

		if distance <= 2 then
			return true
		end
	end
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


function OpenShopMenu22222()
	IsInShopMenu = true
	ESX.UI.Menu.CloseAll()
  
	local playerPed = PlayerPedId()
  
	FreezeEntityPosition(PlayerPedId(), false)
	--SetEntityVisible(playerPed, false)
	local coords = GetEntityCoords(PlayerPedId())
	  if GetDistanceBetweenCoords(coords, vector3(-50.305, -1089.796, 25.48), true) < 50 then
	  --	print("lol1")
		  location = 1
		  SetEntityCoords(playerPed, -47.96, -1105.1, 12.65)
	  end
  
	local vehiclesByCategory = {}
	local elements           = {}
	local firstVehicleData   = nil
  
	for i=1, #Categories, 1 do
	  vehiclesByCategory[Categories[i].name] = {}
	end
  
	for i=1, #Vehicles, 1 do
	  table.insert(vehiclesByCategory[Vehicles[i].category], Vehicles[i])
	end
  
	for i=1, #Categories, 1 do
	  local category         = Categories[i]
	  local categoryVehicles = vehiclesByCategory[category.name]
	  local options          = {}
  
	  for j=1, #categoryVehicles, 1 do
		local vehicle = categoryVehicles[j]
  
		if i == 1 and j == 1 then
		  firstVehicleData = vehicle
		end
  
		table.insert(options, vehicle.name .. ' ')
	  end
  
	  table.insert(elements, {
		name    = category.name,
		label   = category.label,
		value   = 0,
		type    = 'slider',
		max     = #Categories[i],
		options = options
	  })
	end
  
	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'vehicle_shop_showroom',
	  {
		title    = 'Car Showroom',
		align    = 'bottom-right',
		elements = elements,
	  },
	  function (data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
  
		ESX.UI.Menu.Open(
		  'default', GetCurrentResourceName(), 'shop_confirm_showroom',
		  {
			title = vehicleData.name,
			align    = 'bottom-right',
			elements = {
			  {label = '' .. vehicleData.name .. _U('costs_showroom') .. vehicleData.price * Config.PriceShowroom .. _U('currency_showroom'), value = 'yes'},
			  {label = _U('back_showroom'), value = 'no'},
			},
		  },
		  function (data2, menu2)
			if data2.current.value == 'yes' then
			 --  sendNotification(_U('contact_dealer_showroom') .. vehicleData.price * Config.PriceShowroom .. _U('currency_showroom'), 'warning', 5000)
			 print('talk to a car dealer notify')
			end
  
			if data2.current.value == 'no' then
			   menu2.close()
			end
  
		  end,
		  function (data2, menu2)
			menu2.close()
		  end
		)
  
	  end,
	  function (data, menu)
  
		menu.close()
  
		  DoScreenFadeOut(1000)
		  Citizen.Wait(1000)
		  DoScreenFadeIn(1000)
  
		DeleteKatalogVehicles()
  
		local playerPed = PlayerPedId()
  
		CurrentAction     = 'shop_menu_showroom'
		CurrentActionMsg  = 'shop menu'
		CurrentActionData = {}
  
		FreezeEntityPosition(playerPed, false)
  
	   SetEntityCoords(playerPed, CurrentActionReturn.x, CurrentActionReturn.y, CurrentActionReturn.z)
	   CurrentActionReturn = {}
	   --SetEntityVisible(playerPed, true)
  
		IsInShopMenu = false
  
	  end,
	  function (data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
		local playerPed   = PlayerPedId()
  
		DeleteKatalogVehicles()
  
		if location == 1 then
			  ESX.Game.SpawnLocalVehicle(vehicleData.model, {
			  x = -40.20659,
			  y = -1101.099,
			  z = 26.41541
			}, 0, function(vehicle)
			  table.insert(LastVehicles, vehicle)
			  TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			  FreezeEntityPosition(vehicle, true)
			end)
		end
	  end
	)

	DeleteKatalogVehicles()
  
	  if location == 1 then
		  ESX.Game.SpawnLocalVehicle(firstVehicleData.model, {
			x = -40.20659,
			y = -1101.099,
			z = 26.41541
		  }, 0, function(vehicle)
			  table.insert(LastVehicles, vehicle)
			  TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			  FreezeEntityPosition(vehicle, true)
		   end)
	  end
  
  end

  function DeleteKatalogVehicles ()
	while #LastVehicles > 0 do
	  local vehicle = LastVehicles[1]
	  ESX.Game.DeleteVehicle(vehicle)
	  table.remove(LastVehicles, 1)
	end
  end