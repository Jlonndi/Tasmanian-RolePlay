--------------------------------
------- Created by Hamza -------
-------------------------------- 

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(300)
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
Blacked = {
	'avkluger',
	'santafe',
	'ambulance'
}


Citizen.CreateThread(function()
local sleep = 1750
	while true do
		Wait(sleep)
		if IsPedInAnyVehicle(PlayerPedId()) then
			v = GetVehiclePedIsIn(playerPed, false)
			sleep = 5000
			--sleep = 5000
		end
		playerPed = PlayerPedId()
		if PlayerData.job ~= nil and PlayerData.job.name ~= 'ambulance' then
			if GetPedInVehicleSeat(v, -1) == playerPed then
				checkCar(GetVehiclePedIsIn(playerPed, false))
			end
		end
	end
end)

function checkCar(car)

	if car then
		Citizen.Wait(100)
	
		carModel = GetEntityModel(car)
		carName = GetDisplayNameFromVehicleModel(carModel)
	else if not car then 
		Citizen.Wait(500)
	end
		if isBlacked(carModel) then
            Citizen.Wait(500)
            exports['mythic_notify']:SendAlert('error', 'You Must Be A EMS to Drive this.', 8000, { ['background-color'] = '#ffffff', ['color'] = '#000000' })
			ClearPedTasksImmediately(playerPed) -- If The Players Job Does Not =Police Then Kick Them Out of Vehicle

		end

	end

end

function isBlacked(model)
Citizen.Wait(500)
	for _, blacklistedCar in pairs(Blacked) do

		if model == GetHashKey(blacklistedCar) then

			return true

		end
		Citizen.Wait(500)
	end

	return false
end
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
--[[Citizen.CreateThread(function()
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
--[[Citizen.CreateThread(function()
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
end)]]

-- Blip on Map for Boat Garages:
--[[Citizen.CreateThread(function()
	if Config.EnableBoatGarageBlip == true then
		for k,v in pairs(Config.BoatZones) do
			for i = 1, #v.Pos, 1 do
				local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
				SetBlipSprite(blip, Config.BoatGarageSprite)
				SetBlipDisplay(blip, Config.BoatGarageDisplay)
				SetBlipScale  (blip, Config.BoatGarageScale)
				SetBlipColour (blip, Config.BoatGarageColour)
				SetBlipAsShortRange(blip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(Config.BoatGarageName)
				EndTextCommandSetBlipName(blip)
			end
		end
	end
end)]]

local insideMarker = false

-- Core Thread Function:
Citizen.CreateThread(function()
	local sleep = 500
	while true do
		Citizen.Wait(sleep)
		local coords = GetEntityCoords(PlayerPedId())
		local veh = GetVehiclePedIsIn(PlayerPedId(), false)
		local pedInVeh = IsPedInAnyVehicle(PlayerPedId(), true)
		
		if (ESX.PlayerData.job and ESX.PlayerData.job.name == Config.PoliceDatabaseName) then
		sleep = 1000
			for k,v in pairs(Config.CarZones) do
				for i = 1, #v.Pos, 1 do
					local distance = Vdist(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
					if (distance < 10.0) and insideMarker == false then
						sleep = 3
						DrawMarker(Config.PoliceCarMarker, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z-0.97, 0.0, 0.0, 0.0, 0.0, 0, 0.0, Config.PoliceCarMarkerScale.x, Config.PoliceCarMarkerScale.y, Config.PoliceCarMarkerScale.y, Config.PoliceCarMarkerColor.r,Config.PoliceCarMarkerColor.g,Config.PoliceCarMarkerColor.b,Config.PoliceCarMarkerColor.a, false, true, 2, true, false, false, false)						
					else if (distance > 10.0)
						then
							sleep = 500 -- why is helicopter loop in same loop lmao
						end
				end
					if (distance < 10.0 ) and insideMarker == false then
						sleep = 0 -- loop for control press...
						
						DrawText3Ds(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, Config.CarDraw3DText)
				
					sleep = 0
						if IsControlJustPressed(0, Config.KeyToOpenCarGarage) then
							PoliceGarage('car')
							insideMarker = true
							sleep = 500
						end
					end
				end
			end

			
		end
	end
end)

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
		table.insert(elements,{label = 'EMS Ambulance', name = 'EMS Ambulance', model = 'ambulance', price = '0', type = 'car'})
		table.insert(elements,{label = 'EMS Kluger', name = 'EMS Kluger', model = 'AVKLUGER', price = '0', type = 'car'})
		table.insert(elements,{label = 'EMS Santa fe', name = 'EMS Santa fe', model = 'santafe', price = '0', type = 'car'})
		if ESX.PlayerData.job.grade >= 2 then 
		--table.insert(elements,{label = 'Police Evoke Wagon', name = 'Police Evoke Wagon', model = 'pdevokewagon', price = '0', type = 'car'})
		if ESX.PlayerData.job.grade >= 3 then 
		--	table.insert(elements,{label = 'Ford Interceptor', name = 'Ford Interceptor', model = 'browardfpiu', price = '0', type = 'car'})	
		if ESX.PlayerData.job.grade >= 4 then
		--	table.insert(elements,{label = 'Highway Ford FGX', name = 'Highway Ford FGX', model = 'pdfgx', price = '0', type = 'car'})	 
		--	table.insert(elements,{label = 'Police Bike', name = 'Police Bike', model = 'R1200RTP', price = '0', type = 'car'})
		if ESX.PlayerData.job.grade >= 5 then 
		--	table.insert(elements,{label = 'Police SportsWagon', name = 'Police Sportswagon', model = 'PDVFSPORTSWAGON', price = '0', type = 'car'})
		--	table.insert(elements,{label = 'Police Unmarked Holden SS', name = 'Holice Unmarked Holden SS', model = 'PDVFSS', price = '0', type = 'car'})
		--	table.insert(elements,{label = 'Police Highway XR8', name = 'Police Highway XR8', model = 'PDXR8', price = '0', type = 'car'})
		--	table.insert(elements,{label = 'Police 300C', name = 'Police 300C', model = 'PD300C', price = '0', type = 'car'})
		if ESX.PlayerData.job.grade >= 6 then 
		--	table.insert(elements,{label = 'Police Unmarked Mustang', name = 'Police Unmarked Mustang', model = 'ABSHEL', price = '0', type = 'car'})
		if ESX.PlayerData.job.grade >= 7 then 
		--	table.insert(elements,{label = 'Police Unmarked Holden VE', name = 'Police Unmarked Holden VE', model = 'PDVESS', price = '0', type = 'car'})
		--	table.insert(elements,{label = 'Police BMW M5', name = 'Police BMW M5', model = 'NONELSM5', price = '0', type = 'car'})
		if ESX.PlayerData.job.grade >= 8 then 
		---	table.insert(elements,{label = 'Police Golfcart', name = 'Police Golfcart', model = 'RBGATOR', price = '0', type = 'car'})
		--	table.insert(elements,{label = 'Police Undercover M5', name = 'Police Undercover M5', model = 'M5RB_VV', price = '0', type = 'car'})
		--	table.insert(elements,{label = 'Police VE GTS', name = 'Police VE GTS', model = 'PDVEGTS', price = '0', type = 'car'})
		if ESX.PlayerData.job.grade >= 9 then 
			--table.insert(elements,{label = 'Police Mustang', name = 'Police Mustang', model = 'SHEL', price = '0', type = 'car'})
		--	table.insert(elements,{label = 'Police Undercover Bugatti', name = 'Police Undercover M5', model = '16bugatti', price = '0', type = 'car'})
		--	table.insert(elements,{label = 'Police Raptor', name = 'Police Raptor', model = 'NS150', price = '0', type = 'car'})
			--table.insert(elements,{label = 'Police VE GTS', name = 'Police VE GTS', model = 'PDVEGTS', price = '0', type = 'car'})
		if ESX.PlayerData.job.grade >= 10 then 
		--	table.insert(elements,{label = 'Mobile Command Center', name = 'Mobile Command Center', model = 'MCC', price = '0', type = 'car'})
		--	table.insert(elements,{label = 'Police Undercover VF GTS', name = 'Police Undercover VF GTS', model = 'PDVFGTS', price = '0', type = 'car'})
		elseif type == 'helicopter' then
		for k,v in pairs(Config.PoliceHelicopters) do
			table.insert(elements,{label = v.label, name = v.label, model = v.model, price = v.price, type = 'helicopter'})
		end
	elseif type == 'boat' then
		for k,v in pairs(Config.PoliceBoats) do
			table.insert(elements,{label = v.label, name = v.label, model = v.model, price = v.price, type = 'boat'})
		                                    end
	                                    end
                                    end                       		
		                        end
	                        end
                        end
                    end
                end
            end
        end
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
