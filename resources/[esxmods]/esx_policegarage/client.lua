--------------------------------
------- Created by Hamza -------
-------------------------------- 

ESX = nil
local beatyoshit = true
local PlayerData              = {}
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


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

local jobs = {
	'police',
}
-- Function for 3D text:
function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end

-- Blip on Map for Car Garages:
Citizen.CreateThread(function()
	if Config.EnableCarGarageBlip == true then	
		for k,v in pairs(Config.CarZones) do
			for i = 1, #v.Pos, 1 do
				local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
				SetBlipSprite(blip, Config.CarGarageSprite)
				SetBlipDisplay(blip, Config.CarGarageDisplay)
				SetBlipScale  (blip, Config.CarGarageScale)
				SetBlipColour (blip, Config.CarGarageColour)
				SetBlipAsShortRange(blip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(Config.CarGarageName)
				EndTextCommandSetBlipName(blip)
			end
		end
	end	
end)

-- Blip on Map for Heli Garages:
Citizen.CreateThread(function()
	if Config.EnableHeliGarageBlip == true then
		for k,v in pairs(Config.HeliZones) do
			for i = 1, #v.Pos, 1 do
				local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
				SetBlipSprite(blip, Config.HeliGarageSprite)
				SetBlipDisplay(blip, Config.HeliGarageDisplay)
				SetBlipScale  (blip, Config.HeliGarageScale)
				SetBlipColour (blip, Config.HeliGarageColour)
				SetBlipAsShortRange(blip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(Config.HeliGarageName)
				EndTextCommandSetBlipName(blip)
			end
		end
	end
end)


local insideMarker = false

-- Core Thread Function:
--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local coords = GetEntityCoords(PlayerPedId())
		local veh = GetVehiclePedIsIn(PlayerPedId(), false)
		local pedInVeh = IsPedInAnyVehicle(PlayerPedId(), true)
		
		if (ESX.PlayerData.job and ESX.PlayerData.job.name == Config.PoliceDatabaseName) then
			for k,v in pairs(Config.CarZones) do
				for i = 1, #v.Pos, 1 do
					local distance = Vdist(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
					if (distance < 10.0) and insideMarker == false then
						DrawMarker(Config.PoliceCarMarker, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z-0.97, 0.0, 0.0, 0.0, 0.0, 0, 0.0, Config.PoliceCarMarkerScale.x, Config.PoliceCarMarkerScale.y, Config.PoliceCarMarkerScale.y, Config.PoliceCarMarkerColor.r,Config.PoliceCarMarkerColor.g,Config.PoliceCarMarkerColor.b,Config.PoliceCarMarkerColor.a, false, true, 2, true, false, false, false)						
					end
					if (distance < 2.5 ) and insideMarker == false then
						DrawText3Ds(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, Config.CarDraw3DText)
						if IsControlJustPressed(0, Config.KeyToOpenCarGarage) then
							PoliceGarage('car')
							insideMarker = true
							Citizen.Wait(500)
						end
					end
				end
			end

			for k,v in pairs(Config.HeliZones) do
				for i = 1, #v.Pos, 1 do
					local distance = Vdist(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
					if (distance < 10.0) and insideMarker == false then
						DrawMarker(Config.PoliceHeliMarker, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z-0.95, 0.0, 0.0, 0.0, 0.0, 0, 0.0, Config.PoliceHeliMarkerScale.x, Config.PoliceHeliMarkerScale.y, Config.PoliceHeliMarkerScale.z, Config.PoliceHeliMarkerColor.r,Config.PoliceHeliMarkerColor.g,Config.PoliceHeliMarkerColor.b,Config.PoliceHeliMarkerColor.a, false, true, 2, true, false, false, false)						
					end
					if (distance < 3.0 ) and insideMarker == false then
						DrawText3Ds(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, Config.HeliDraw3DText)
						if IsControlJustPressed(0, Config.KeyToOpenHeliGarage) then
							PoliceGarage('helicopter')
							insideMarker = true
							Citizen.Wait(500)
						end
					end
				end
			end

			for k,v in pairs(Config.BoatZones) do
				for i = 1, #v.Pos, 1 do
					local distance = Vdist(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
					if (distance < 20.0) and insideMarker == false then
						DrawMarker(Config.PoliceBoatMarker, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, 0.0, 0.0, 0.0, 0.0, 0, 0.0, Config.PoliceBoatMarkerScale.x, Config.PoliceBoatMarkerScale.y, Config.PoliceBoatMarkerScale.z, Config.PoliceBoatMarkerColor.r,Config.PoliceBoatMarkerColor.g,Config.PoliceBoatMarkerColor.b,Config.PoliceBoatMarkerColor.a, false, true, 2, true, false, false, false)						
					end
					if (distance < 3.0 ) and insideMarker == false then
						DrawText3Ds(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, Config.BoatDraw3DText)
						if IsControlJustPressed(0, Config.KeyToOpenBoatGarage) then
							PoliceGarage('boat')
							insideMarker = true
							Citizen.Wait(500)
						end
					end
				end
			end

			for k,v in pairs(Config.ExtraZones) do
				for i = 1, #v.Pos, 1 do
					local distance = Vdist(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
					
					if (distance < 10.0) and insideMarker == false and pedInVeh then
						DrawMarker(Config.PoliceExtraMarker, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z-0.97, 0.0, 0.0, 0.0, 0.0, 0, 0.0, Config.PoliceExtraMarkerScale.x, Config.PoliceExtraMarkerScale.y, Config.PoliceExtraMarkerScale.z, Config.PoliceExtraMarkerColor.r,Config.PoliceExtraMarkerColor.g,Config.PoliceExtraMarkerColor.b,Config.PoliceExtraMarkerColor.a, false, true, 2, true, false, false, false)
					end
					if (distance < 2.5 ) and insideMarker == false and pedInVeh then
						DrawText3Ds(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, Config.ExtraDraw3DText)
						if IsControlJustPressed(0, Config.KeyToOpenExtraGarage) and GetVehicleClass(veh) == 18 then
							OpenMainMenu()
							insideMarker = true
							Citizen.Wait(500)
						end
					end
				end
			end
		end
	end
end)]]
local menuopen = false
if beatyoshit then
	Citizen.CreateThread(function()
		local sleep = 500 
		while true do
			Citizen.Wait(sleep)
			if nearMarker() then 
				sleep = 1
				for k,v in ipairs(Config.Marker)do
				DrawMarker(27, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 0, 255, 0, 100, false, true, 2, false, false, false, false)
			end
			if inMarker() then
				
				for k,v in pairs(jobs) do
				if ESX.PlayerData.job.name == 'police' then
				
				--Pointer Marker 
				    --DrawMarker(2, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.1, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
				--Circle Marker	
					
					DisplayHelpText('Press ~INPUT_PICKUP~ To Open Police Garage ~b~')
				
				if IsControlJustPressed(1, keys[Config.Keys.Open]) then
                    PoliceGarage('car')
					local ped = PlayerPedId()
					menuopen = true
				end        
				end
				    end
				end
			else 
				sleep = 500
				if menuopen then 
					ESX.UI.Menu.CloseAll()
					menuopen = false
				end
			end
		end
	end)
end
local helimenuopen = false
if beatyoshit then
	Citizen.CreateThread(function()
		local sleep = 500 
		while true do
			Citizen.Wait(sleep)
			if nearMarker2() then 
				sleep = 1
				for k,v in ipairs(Config.Marker2)do
				DrawMarker(27, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 0, 255, 0, 100, false, true, 2, false, false, false, false)
			end
			if inMarker2() then
				
				for k,v in pairs(jobs) do
				if ESX.PlayerData.job.name == 'police'  then
				
				--Pointer Marker 
				    --DrawMarker(2, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.1, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
				--Circle Marker	
					
					DisplayHelpText('Press ~INPUT_PICKUP~ To Open Police Helicopter Garage ~b~')
				
				if IsControlJustPressed(1, keys[Config.Keys.Open]) then
                    PoliceGarage('helicopter')
					local ped = PlayerPedId()
					helimenuopen = true
				end        
				end
				    end
				end
			else 
				sleep = 500
				if helimenuopen then 
					--fidde
					ESX.UI.Menu.CloseAll()
					helimenuopen = false
				end
			end
		end
	end)
end
function nearMarker()
	local player = PlayerPedId()
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(Config.Marker) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

		if distance <= 7 then
			return true
		end
	end
end
function nearMarker2()
	local player = PlayerPedId()
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(Config.Marker2) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

		if distance <= 7 then
			return true
		end
	end
end
function inMarker()
	local player = PlayerPedId()
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(Config.Marker) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

		if distance <= 2 then
			return true
		end
	end
end
function inMarker2()
	local player = PlayerPedId()
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(Config.Marker2) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

		if distance <= 2 then
			return true
		end
	end
end
--[[function nearMarker2()
	local player = PlayerPedId()
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(Config.Marker2) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

		if distance <= 2 then
			return true
		end
	end
end]]
-- Police Garage Menu:
PoliceGarage = function(type)
	local elements = {
		{ label = Config.LabelStoreVeh, action = "store_vehicle" },
		{ label = Config.LabelGetVeh, action = "get_vehicle" },
	}
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "esx_policeGarage_menu",
		{
			title    = Config.TitlePoliceGarage,
			align    = "center",
			elements = elements
		},
	function(data, menu)
		menu.close()
		local action = data.current.action
		if action == "get_vehicle" then
			if type == 'car' then
				VehicleMenu('car')
			elseif type == 'helicopter' then
				VehicleMenu('helicopter')
			elseif type == 'boat' then
				VehicleMenu('boat')
			end
		elseif data.current.action == 'store_vehicle' then
			local veh,dist = ESX.Game.GetClosestVehicle(playerCoords)
			if dist < 3 then
				DeleteEntity(veh)
				ESX.ShowNotification(Config.VehicleParked)
			else
				ESX.ShowNotification(Config.NoVehicleNearby)
			end
			insideMarker = false
		end
	end, function(data, menu)
		menu.close()
		insideMarker = false
	end, function(data, menu)
	end)
end

-- Vehicle Spawn Menu:
VehicleMenu = function(type)
	local storage = nil
	local elements = {}
	local ped = PlayerPedId()
	local playerPed = PlayerPedId()
	local pos = GetEntityCoords(ped)
	
	if type == 'car' then
		if ESX.PlayerData.job.grade >= 1 then 
		    table.insert(elements,{label = 'Police Evoke Sedan', name = 'Police Evoke Sedan', model = 'pdevoke', price = '0', type = 'car'})
		    table.insert(elements,{label = 'Police Evoke Wagon', name = 'Police Evoke Wagon', model = 'pdevokewagon', price = '0', type = 'car'})
		end
		if ESX.PlayerData.job.grade >= 2 then 
		    table.insert(elements,{label = 'Police Territory', name = 'Police Territory', model = 'pdterritory', price = '0', type = 'car'})
		end
		if ESX.PlayerData.job.grade >= 3 then 
			table.insert(elements,{label = 'Ford Interceptor', name = 'Ford Interceptor', model = 'browardfpiu', price = '0', type = 'car'})	
		end
		if ESX.PlayerData.job.grade >= 4 then
			--table.insert(elements,{label = 'Highway Ford FGX', name = 'Highway Ford FGX', model = 'pdfgx', price = '0', type = 'car'})	 
			table.insert(elements,{label = 'Police Bike', name = 'Police Bike', model = 'R1200RTP', price = '0', type = 'car'})
			table.insert(elements,{label = 'Police SportsWagon', name = 'Police Sportswagon', model = 'PDVFSPORTSWAGON', price = '0', type = 'car'})
		end
		if ESX.PlayerData.job.grade >= 5 then 
			table.insert(elements,{label = 'Police Unmarked Holden SS', name = 'Holice Unmarked Holden SS', model = 'PDVFSS', price = '0', type = 'car'})
			--table.insert(elements,{label = 'Police Highway XR8', name = 'Police Highway XR8', model = 'PDXR8', price = '0', type = 'car'})
			table.insert(elements,{label = 'Police 300C', name = 'Police 300C', model = 'PD300C', price = '0', type = 'car'})
		end
		if ESX.PlayerData.job.grade >= 6 then 
			table.insert(elements,{label = 'Police Unmarked Mustang', name = 'Police Unmarked Mustang', model = 'ABSHEL', price = '0', type = 'car'})
		end
		if ESX.PlayerData.job.grade >= 7 then 
			table.insert(elements,{label = 'Police Unmarked Holden VE', name = 'Police Unmarked Holden VE', model = 'PDVESS', price = '0', type = 'car'})
		end
		if ESX.PlayerData.job.grade >= 8 then 
			table.insert(elements,{label = 'Police Undercover M5', name = 'Police Undercover M5', model = 'M5RB_VV', price = '0', type = 'car'})
			table.insert(elements,{label = 'Police VE GTS', name = 'Police VE GTS', model = 'PDVEGTS', price = '0', type = 'car'})
		end
	
		if ESX.PlayerData.job.grade >= 9 then 
			table.insert(elements,{label = 'Police Mustang', name = 'Police Mustang', model = 'SHEL', price = '0', type = 'car'})
			table.insert(elements,{label = 'Police Raptor', name = 'Police Raptor', model = 'NS150', price = '0', type = 'car'})
			--table.insert(elements,{label = 'Police VE GTS', name = 'Police VE GTS', model = 'PDVEGTS', price = '0', type = 'car'})
		end
		if ESX.PlayerData.job.grade >= 10 then 
			table.insert(elements,{label = 'Mobile Command Center', name = 'Mobile Command Center', model = 'MCC', price = '0', type = 'car'})
			table.insert(elements,{label = 'Police Undercover VF GTS', name = 'Police Undercover VF GTS', model = 'PDVFGTS', price = '0', type = 'car'})
		end
		elseif type == 'helicopter' then
		--for k,v in pairs(Config.PoliceHelicopters) do
		if ESX.PlayerData.job.grade >= 4 then
			table.insert(elements,{label = 'Police Helicopter', name = 'Police Helicopter', model = 'POLAIR', price = '0', type = 'helicopter'})
		end
	elseif type == 'boat' then
		for k,v in pairs(Config.PoliceBoats) do
			table.insert(elements,{label = v.label, name = v.label, model = v.model, price = v.price, type = 'boat'})	                                       -- end
    end
end
		
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "esx_policeGarage_vehicle_garage",
		{
			title    = Config.TitlePoliceGarage,
			align    = "center",
			elements = elements
		},
	function(data, menu)
		menu.close()
		insideMarker = false
		local plate = exports['esx_vehicleshop']:GeneratePlate()
		VehicleLoadTimer(data.current.model)
		local veh = CreateVehicle(data.current.model,pos.x,pos.y,pos.z,GetEntityHeading(playerPed),true,false)
		SetPedIntoVehicle(PlayerPedId(),veh,-1)
		SetVehicleNumberPlateText(veh,plate)
		
		if type == 'car' then
			ESX.ShowNotification(Config.CarOutFromPolGar)
		elseif type == 'helicopter' then
			ESX.ShowNotification(Config.HeliOutFromPolGar)
		elseif type == 'boat' then
			ESX.ShowNotification(Config.BoatOutFromPolGar)
		end
		
		TriggerEvent("fuel:setFuel",veh,100.0)
		SetVehicleDirtLevel(veh, 0.1)		
	end, function(data, menu)
		menu.close()
		insideMarker = false
	end, function(data, menu)
	end)
end

-- Load Timer Function for Vehicle Spawn:
function VehicleLoadTimer(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(0)
			DisableAllControlActions(0)

			drawLoadingText(Config.VehicleLoadText, 255, 255, 255, 255)
		end
	end
end

-- Loading Text for Vehicles Function:
function drawLoadingText(text, red, green, blue, alpha)
	SetTextFont(4)
	SetTextScale(0.0, 0.5)
	SetTextColour(red, green, blue, alpha)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)

	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.5, 0.5)
end

-- Fix Police Vehicle Command:
--[[RegisterCommand(Config.RepairCommand, function(source, args)
	if ESX.PlayerData.job and (ESX.PlayerData.job.name == Config.PoliceDatabaseName) then
		policeFix()
	end
end,false)

-- Fix Police Vehicle Function:
function policeFix()
	local ped = PlayerPedId()
	for k,v in pairs(Config.CarZones) do
		for i = 1, #v.Pos, 1 do
			if IsPedInAnyVehicle(ped, true) then
				local veh = GetVehiclePedIsIn(ped, false)
				if GetDistanceBetweenCoords(GetEntityCoords(ped), v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) <= Config.Distance then
					ESX.ShowNotification(Config.VehRepNotify)
					FreezeEntityPosition(veh, true)
					exports['progressBars']:startUI((Config.RepairTime * 1000), Config.Progress1)
					Citizen.Wait((Config.RepairTime * 1000))
					ESX.ShowNotification(Config.VehRepDoneNotify)
					SetVehicleFixed(veh)
					FreezeEntityPosition(veh, false)
				end
			end
		end	
	end
end]]

-- Police Extra Menu:
function OpenExtraMenu()
	local elements = {}
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	for id=0, 12 do
		if DoesExtraExist(vehicle, id) then
			local state = IsVehicleExtraTurnedOn(vehicle, id) 

			if state then
				table.insert(elements, {
					label = "Extra: "..id.." | "..('<span style="color:green;">%s</span>'):format("On"),
					value = id,
					state = not state
				})
			else
				table.insert(elements, {
					label = "Extra: "..id.." | "..('<span style="color:red;">%s</span>'):format("Off"),
					value = id,
					state = not state
				})
			end
		end
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'extra_actions', {
		title    = Config.TitlePoliceExtra,
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		SetVehicleExtra(vehicle, data.current.value, not data.current.state)
		local newData = data.current
		if data.current.state then
			newData.label = "Extra: "..data.current.value.." | "..('<span style="color:green;">%s</span>'):format("On")
		else
			newData.label = "Extra: "..data.current.value.." | "..('<span style="color:red;">%s</span>'):format("Off")
		end
		newData.state = not data.current.state

		menu.update({value = data.current.value}, newData)
		menu.refresh()
	end, function(data, menu)
		menu.close()
	end)
end

-- Police Livery Menu:
function OpenLiveryMenu()
	local elements = {}
	
	local vehicle = GetVehiclePedIsIn(PlayerPedId())
	local liveryCount = GetVehicleLiveryCount(vehicle)
			
	for i = 1, liveryCount do
		local state = GetVehicleLivery(vehicle) 
		local text
		
		if state == i then
			text = "Livery: "..i.." | "..('<span style="color:green;">%s</span>'):format("On")
		else
			text = "Livery: "..i.." | "..('<span style="color:red;">%s</span>'):format("Off")
		end
		
		table.insert(elements, {
			label = text,
			value = i,
			state = not state
		}) 
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'livery_menu', {
		title    = Config.TitlePoliceLivery,
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		SetVehicleLivery(vehicle, data.current.value, not data.current.state)
		local newData = data.current
		if data.current.state then
			newData.label = "Livery: "..data.current.value.." | "..('<span style="color:green;">%s</span>'):format("On")
		else
			newData.label = "Livery: "..data.current.value.." | "..('<span style="color:red;">%s</span>'):format("Off")
		end
		newData.state = not data.current.state
		menu.update({value = data.current.value}, newData)
		menu.refresh()
		menu.close()	
	end, function(data, menu)
		menu.close()		
	end)
end

-- Police Extra Main Menu:
function OpenMainMenu()
	local elements = {
		{label = Config.LabelPrimaryCol,value = 'primary'},
		{label = Config.LabelSecondaryCol,value = 'secondary'},
		{label = Config.LabelExtra,value = 'extra'},
		{label = Config.LabelLivery,value = 'livery'}
	}
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'color_menu', {
		title    = Config.TitlePoliceExtra,
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'extra' then
			OpenExtraMenu()
		elseif data.current.value == 'livery' then
			OpenLiveryMenu()
		elseif data.current.value == 'primary' then
			OpenMainColorMenu('primary')
		elseif data.current.value == 'secondary' then
			OpenMainColorMenu('secondary')
		end
	end, function(data, menu)
		menu.close()
		insideMarker = false
	end)
end

-- Police Color Main Menu:
function OpenMainColorMenu(colortype)
	local elements = {}
	for k,v in pairs(Config.Colors) do
		table.insert(elements, {
			label = v.label,
			value = v.value
		})
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'main_color_menu', {
		title    = Config.TitleColorType,
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		OpenColorMenu(data.current.type, data.current.value, colortype)
	end, function(data, menu)
		menu.close()
	end)
end

-- Police Color Menu:
function OpenColorMenu(type, value, colortype)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'extra_actions', {
		title    = Config.TitleValues,
		align    = 'top-left',
		elements = GetColors(value)
	}, function(data, menu)
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		local pr,sec = GetVehicleColours(vehicle)
		if colortype == 'primary' then
			SetVehicleColours(vehicle, data.current.index, sec)
		elseif colortype == 'secondary' then
			SetVehicleColours(vehicle, pr, data.current.index)
		end
		
	end, function(data, menu)
		menu.close()
	end)
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
