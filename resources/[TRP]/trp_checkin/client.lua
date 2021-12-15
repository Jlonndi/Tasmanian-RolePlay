-- ESX Stuff (DON'T TOUCH!!!)
ESX = nil 

Citizen.CreateThread(function() 
	while ESX == nil do 
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
		Citizen.Wait(1) 
	end 
		PlayerData = ESX.GetPlayerData() 
end) 
 
RegisterNetEvent('esx:playerLoaded') 
AddEventHandler('esx:playerLoaded', function(xPlayer) 
	PlayerData = xPlayer 
end) 
 
RegisterNetEvent('esx:setJob') 
AddEventHandler('esx:setJob', function(job) 
	PlayerData.job = job 
end) 

-- Set Ped 
Citizen.CreateThread(function()
	local hash = GetHashKey('s_m_m_paramedic_01')
	while not HasModelLoaded(hash) do
		RequestModel(hash)
		Wait(20)
	end 

	local ped = CreatePed(21, hash, 306.2, -597.24, 43.28 -1, 0.0, true, true)
	FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_GUARD_STAND', 0, true)
end)

-- Draw 3D text 
Citizen.CreateThread(function ()
	local sleep = 0
	while true do
		Citizen.Wait(sleep)
		local coords = GetEntityCoords(PlayerPedId())
		for k,v in pairs(Config.Locations) do
            if GetDistanceBetweenCoords(coords, v.Coords.x, v.Coords.y, v.Coords.z, true) < Config.TextDrawDistance then
				sleep = 0
                local location = v
                DrawText3D(v.Coords.x, v.Coords.y, v.Coords.z - 1.0, _U('requestCheckIn'))
                if IsControlJustReleased(0, 38) then
                	local ped = PlayerPedId()
                	exports['progressBars']:startUI(5000, 'Checking in to the hospital')
                	TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_CLIPBOARD', 0, true)
					Citizen.Wait(5000)
					TriggerServerEvent('trp_checkin:didhepressthebutton', v.hospital, v.hospital)
					
                end
			else
				sleep = 0
			end
		end
	end
end)

-- 3D text function
function DrawText3D(x,y,z, text)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local p = GetGameplayCamCoords()
	local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
	local scale = (1 / distance) * 2
	local fov = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov
	if onScreen then
		  SetTextScale(0.35, 0.35)
		  SetTextFont(4)
		  SetTextProportional(1)
		  SetTextColour(255, 255, 255, 215)
		  SetTextEntry("STRING")
		  SetTextCentre(1)
		  AddTextComponentString(text)
		  DrawText(_x,_y)
		  local factor = (string.len(text)) / 370
		  DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
	  end
end

-- Revive function 
function RespawnPed(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)
	ClearPedBloodDamage(ped)
	StopScreenEffect('DeathFailOut')
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
	TriggerEvent('mythic_hospital:client:RemoveBleed')
    TriggerEvent('mythic_hospital:client:ResetLimbs')
	TriggerEvent('mythic_hospital:client:RemoveBleed')
    TriggerEvent('mythic_hospital:client:ResetLimbs')

	ESX.UI.Menu.CloseAll()
end

-- Main Event
RegisterNetEvent('trp_checkin:TakeTheCunt')
AddEventHandler('trp_checkin:TakeTheCunt', function(hospital)
	ESX.TriggerServerCallback('trp_checkin:getConnectedEMS', function(amount)
		if amount < 2 then
			if hospital == 'pillbox' then
				print(hospital)
				TriggerEvent('trp_checkin:healPillbox')
			elseif hospital == 'sandy' then
				TriggerEvent('trp_checkin:healSandy')
			elseif hospital == 'paleto' then
				TriggerEvent('trp_checkin:healPaleto')
			end
		else 
			local ped = PlayerPedId()
			notification('error', '<p>You are unable to revive there is too many EMS in the City!.</p>')
			ClearPedTasksImmediately(ped)
			Citizen.Wait(5000)
			notification('success', '<p>Try Calling EMS with your phone.</p>')
		end
	end)
end)

RegisterNetEvent('trp_checkin:healPillbox')
AddEventHandler('trp_checkin:healPillbox', function()
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	local head = GetEntityHeading(ped)
	local chance = math.random(1,8)
	local coords1 = {x = 319.444, y = -581.012, z = 44.2}
	local coords2 = {x = 324.1714, y = -582.7648, z = 44.2}
	local coords3 = {x = 322.5758, y = -586.7209, z = 44.19189}
	local coords4 = {x = 317.8945, y = -585.1121, z = 44.19189}
	local coords5 = {x = 314.7033, y = -583.88, z = 44.2}
	local coords6 = {x = 311.1824, y = -582.58,	z = 44.2}
	local coords7 = {x = 307.9121, y = -581.8154, z = 44.2}
	local coords8 = {x = 313.9912, y = -579.1, z = 44.2}

	-- Bed 1
	if chance == 1 then 
		RespawnPed(ped, coords1, 0.0)
		TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_SUNBATHE_BACK', coords1.x, coords1.y, coords1.z, 360.0, 0, false, true)
		FreezeEntityPosition(ped, true)
		exports['mythic_notify']:SendAlert('inform', _U('notificationText1'), 5000)
		--exports['progressBars']:startUI(5000, 'Scams747 is Treating your wounds right now')
		Citizen.Wait(5000)
		FreezeEntityPosition(ped, false) 
		ClearPedTasksImmediately(ped)
		TriggerServerEvent('trp_checkin:cashmeoutside')
		exports['mythic_notify']:SendAlert('inform', _U('notificationText2'), 4000)
		SetEntityCoords(ped, coords1.x, coords1.y, coords1.z, false, false, false, false)
	end
	-- Bed 2
	if chance == 2 then 
		RespawnPed(ped, coords2, 0.0)
		TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_SUNBATHE_BACK', coords2.x, coords2.y, coords2.z, 360.0, 0, false, true)
		FreezeEntityPosition(ped, true)
		exports['mythic_notify']:SendAlert('inform', _U('notificationText1'), 5000)
		--exports['progressBars']:startUI(5000, 'Scams747 is Treating your wounds right now')
		Citizen.Wait(5000)
		FreezeEntityPosition(ped, false) 
		ClearPedTasksImmediately(ped)
		TriggerServerEvent('trp_checkin:cashmeoutside')
		exports['mythic_notify']:SendAlert('inform', _U('notificationText2'), 4000)
		SetEntityCoords(ped, coords2.x, coords2.y, coords2.z, false, false, false, false)
	end
	-- Bed 3
	if chance == 3 then 
		RespawnPed(ped, coords3, 0.0)
		TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_SUNBATHE_BACK', coords3.x, coords3.y, coords3.z, 360.0, 0, false, true)
		FreezeEntityPosition(ped, true)
		exports['mythic_notify']:SendAlert('inform', _U('notificationText1'), 5000)
		--exports['progressBars']:startUI(5000, 'Scams747 is Treating your wounds right now')
		Citizen.Wait(5000)
		FreezeEntityPosition(ped, false) 
		ClearPedTasksImmediately(ped)
		TriggerServerEvent('trp_checkin:cashmeoutside')
		exports['mythic_notify']:SendAlert('inform', _U('notificationText2'), 4000)
		SetEntityCoords(ped, coords3.x, coords3.y, coords3.z, false, false, false, false)
	end
	-- Bed 4 
	if chance == 4 then 
		RespawnPed(ped, coords4, 0.0)
		TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_SUNBATHE_BACK', coords4.x, coords4.y, coords4.z, 360.0, 0, false, true)
		FreezeEntityPosition(ped, true)
		exports['mythic_notify']:SendAlert('inform', _U('notificationText1'), 5000)
		--exports['progressBars']:startUI(5000, 'Scams747 is Treating your wounds right now')
		Citizen.Wait(5000)
		FreezeEntityPosition(ped, false) 
		ClearPedTasksImmediately(ped)
		TriggerServerEvent('trp_checkin:cashmeoutside')
		exports['mythic_notify']:SendAlert('inform', _U('notificationText2'), 4000)
		SetEntityCoords(ped, coords4.x, coords4.y, coords4.z, false, false, false, false)
	end
	-- Bed 5
	if chance == 5 then 
		RespawnPed(ped, coords5, 0.0)
		TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_SUNBATHE_BACK', coords5.x, coords5.y, coords5.z, 360.0, 0, false, true)
		FreezeEntityPosition(ped, true)
		exports['mythic_notify']:SendAlert('inform', _U('notificationText1'), 5000)
		--exports['progressBars']:startUI(5000, 'Scams747 is Treating your wounds right now')
		Citizen.Wait(5000)
		FreezeEntityPosition(ped, false) 
		ClearPedTasksImmediately(ped)
		TriggerServerEvent('trp_checkin:cashmeoutside')
		exports['mythic_notify']:SendAlert('inform', _U('notificationText2'), 4000)
		SetEntityCoords(ped, coords5.x, coords5.y, coords5.z, false, false, false, false)
	end
	-- Bed 6 
	if chance == 6 then 
		RespawnPed(ped, coords6, 0.0)
		TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_SUNBATHE_BACK', coords6.x, coords6.y, coords6.z, 360.0, 0, false, true)
		FreezeEntityPosition(ped, true)
		exports['mythic_notify']:SendAlert('inform', _U('notificationText1'), 5000)
		--exports['progressBars']:startUI(5000, 'Scams747 is Treating your wounds right now')
		Citizen.Wait(5000)
		FreezeEntityPosition(ped, false) 
		ClearPedTasksImmediately(ped)
		TriggerServerEvent('trp_checkin:cashmeoutside')
		exports['mythic_notify']:SendAlert('inform', _U('notificationText2'), 4000)
		SetEntityCoords(ped, coords6.x, coords6.y, coords6.z, false, false, false, false)
	end
	-- Bed 7 
	if chance == 7 then 
		RespawnPed(ped, coords7, 0.0)
		TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_SUNBATHE_BACK', coords7.x, coords7.y, coords7.z, 360.0, 0, false, true)
		FreezeEntityPosition(ped, true)
		exports['mythic_notify']:SendAlert('inform', _U('notificationText1'), 5000)
		--exports['progressBars']:startUI(5000, 'Scams747 is Treating your wounds right now')
		Citizen.Wait(5000)
		FreezeEntityPosition(ped, false) 
		ClearPedTasksImmediately(ped)
		TriggerServerEvent('trp_checkin:cashmeoutside')
		exports['mythic_notify']:SendAlert('inform', _U('notificationText2'), 4000)
		SetEntityCoords(ped, coords7.x, coords7.y, coords7.z, false, false, false, false)
	end
	-- Bed 8
	if chance == 8 then 
		RespawnPed(ped, coords8, 0.0)
		TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_SUNBATHE_BACK', coords8.x, coords8.y, coords8.z, 360.0, 0, false, true)
		FreezeEntityPosition(ped, true)
		exports['mythic_notify']:SendAlert('inform', _U('notificationText1'), 5000)
		--exports['progressBars']:startUI(5000, 'Scams747 is Treating your wounds right now')
		Citizen.Wait(5000)
		FreezeEntityPosition(ped, false) 
		ClearPedTasksImmediately(ped)
		TriggerServerEvent('trp_checkin:cashmeoutside')
		exports['mythic_notify']:SendAlert('inform', _U('notificationText2'), 4000)
		SetEntityCoords(ped, coords8.x, coords8.y, coords8.z, false, false, false, false)
	end
end)


RegisterNetEvent('trp_checkin:healSandy')
AddEventHandler('trp_checkin:healSandy', function()
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	local head = GetEntityHeading(ped)
	local chance = math.random(1,8)
	local coords1 = {x = 1822.906, y = 3672.224, z = 35.19409}
	local coords2 = {x = 1820.281, y = 3669.89, z = 35.19409}
	local coords3 = {x = 1818.092, y = 3677.895, z = 35.19409}
	local coords4 = {x = 1820.215, y = 3678.62, z = 35.19409}
	local coords5 = {x = 1821.771, y = 3679.635, z = 35.19409}
	local coords6 = {x = 1817.38, y = 3674.901, z = 35.19409}
	local coords7 = {x = 1818.092, y = 3677.895, z = 35.19409}
	local coords8 = {x = 1822.906, y = 3672.224, z = 35.19409}
	-- Bed 1
	if chance == 1 then 
		RespawnPed(ped, coords1, 0.0)
		TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_SUNBATHE_BACK', coords1.x, coords1.y, coords1.z, 360.0, 0, false, true)
		FreezeEntityPosition(ped, true)
		exports['mythic_notify']:SendAlert('inform', _U('notificationText1'), 5000)
		--exports['progressBars']:startUI(5000, 'Scams747 is Treating your wounds right now')
		Citizen.Wait(5000)
		FreezeEntityPosition(ped, false) 
		ClearPedTasksImmediately(ped)
		TriggerServerEvent('trp_checkin:cashmeoutside')
		exports['mythic_notify']:SendAlert('inform', _U('notificationText2'), 4000)
		SetEntityCoords(ped, coords1.x, coords1.y, coords1.z, false, false, false, false)
	end
	-- Bed 2
	if chance == 2 then 
		RespawnPed(ped, coords2, 0.0)
		TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_SUNBATHE_BACK', coords2.x, coords2.y, coords2.z, 360.0, 0, false, true)
		FreezeEntityPosition(ped, true)
		exports['mythic_notify']:SendAlert('inform', _U('notificationText1'), 5000)
		--exports['progressBars']:startUI(5000, 'Scams747 is Treating your wounds right now')
		Citizen.Wait(5000)
		FreezeEntityPosition(ped, false) 
		ClearPedTasksImmediately(ped)
		TriggerServerEvent('trp_checkin:cashmeoutside')
		exports['mythic_notify']:SendAlert('inform', _U('notificationText2'), 4000)
		SetEntityCoords(ped, coords2.x, coords2.y, coords2.z, false, false, false, false)
	end
	-- Bed 3
	if chance == 3 then 
		RespawnPed(ped, coords3, 0.0)
		TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_SUNBATHE_BACK', coords3.x, coords3.y, coords3.z, 360.0, 0, false, true)
		FreezeEntityPosition(ped, true)
		exports['mythic_notify']:SendAlert('inform', _U('notificationText1'), 5000)
		--exports['progressBars']:startUI(5000, 'Scams747 is Treating your wounds right now')
		Citizen.Wait(5000)
		FreezeEntityPosition(ped, false) 
		ClearPedTasksImmediately(ped)
		TriggerServerEvent('trp_checkin:cashmeoutside')
		exports['mythic_notify']:SendAlert('inform', _U('notificationText2'), 4000)
		SetEntityCoords(ped, coords3.x, coords3.y, coords3.z, false, false, false, false)
	end
	-- Bed 4 
	if chance == 4 then 
		RespawnPed(ped, coords4, 0.0)
		TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_SUNBATHE_BACK', coords4.x, coords4.y, coords4.z, 360.0, 0, false, true)
		FreezeEntityPosition(ped, true)
		exports['mythic_notify']:SendAlert('inform', _U('notificationText1'), 5000)
		--exports['progressBars']:startUI(5000, 'Scams747 is Treating your wounds right now')
		Citizen.Wait(5000)
		FreezeEntityPosition(ped, false) 
		ClearPedTasksImmediately(ped)
		TriggerServerEvent('trp_checkin:cashmeoutside')
		exports['mythic_notify']:SendAlert('inform', _U('notificationText2'), 4000)
		SetEntityCoords(ped, coords4.x, coords4.y, coords4.z, false, false, false, false)
	end
	-- Bed 5
	if chance == 5 then 
		RespawnPed(ped, coords5, 0.0)
		TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_SUNBATHE_BACK', coords5.x, coords5.y, coords5.z, 360.0, 0, false, true)
		FreezeEntityPosition(ped, true)
		exports['mythic_notify']:SendAlert('inform', _U('notificationText1'), 5000)
		--exports['progressBars']:startUI(5000, 'Scams747 is Treating your wounds right now')
		Citizen.Wait(5000)
		FreezeEntityPosition(ped, false) 
		ClearPedTasksImmediately(ped)
		TriggerServerEvent('trp_checkin:cashmeoutside')
		exports['mythic_notify']:SendAlert('inform', _U('notificationText2'), 4000)
		SetEntityCoords(ped, coords5.x, coords5.y, coords5.z, false, false, false, false)
	end
	-- Bed 6 
	if chance == 6 then 
		RespawnPed(ped, coords6, 0.0)
		TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_SUNBATHE_BACK', coords6.x, coords6.y, coords6.z, 360.0, 0, false, true)
		FreezeEntityPosition(ped, true)
		exports['mythic_notify']:SendAlert('inform', _U('notificationText1'), 5000)
		--exports['progressBars']:startUI(5000, 'Scams747 is Treating your wounds right now')
		Citizen.Wait(5000)
		FreezeEntityPosition(ped, false) 
		ClearPedTasksImmediately(ped)
		TriggerServerEvent('trp_checkin:cashmeoutside')
		exports['mythic_notify']:SendAlert('inform', _U('notificationText2'), 4000)
		SetEntityCoords(ped, coords6.x, coords6.y, coords6.z, false, false, false, false)
	end
	-- Bed 7 
	if chance == 7 then 
		RespawnPed(ped, coords7, 0.0)
		TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_SUNBATHE_BACK', coords7.x, coords7.y, coords7.z, 360.0, 0, false, true)
		FreezeEntityPosition(ped, true)
		exports['mythic_notify']:SendAlert('inform', _U('notificationText1'), 5000)
		--exports['progressBars']:startUI(5000, 'Scams747 is Treating your wounds right now')
		Citizen.Wait(5000)
		FreezeEntityPosition(ped, false) 
		ClearPedTasksImmediately(ped)
		TriggerServerEvent('trp_checkin:cashmeoutside')
		exports['mythic_notify']:SendAlert('inform', _U('notificationText2'), 4000)
		SetEntityCoords(ped, coords7.x, coords7.y, coords7.z, false, false, false, false)
	end
	-- Bed 8
	if chance == 8 then 
		RespawnPed(ped, coords8, 0.0)
		TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_SUNBATHE_BACK', coords8.x, coords8.y, coords8.z, 360.0, 0, false, true)
		FreezeEntityPosition(ped, true)
		exports['mythic_notify']:SendAlert('inform', _U('notificationText1'), 5000)
		--exports['progressBars']:startUI(5000, 'Scams747 is Treating your wounds right now')
		Citizen.Wait(5000)
		FreezeEntityPosition(ped, false) 
		ClearPedTasksImmediately(ped)
		TriggerServerEvent('trp_checkin:cashmeoutside')
		exports['mythic_notify']:SendAlert('inform', _U('notificationText2'), 4000)
		SetEntityCoords(ped, coords8.x, coords8.y, coords8.z, false, false, false, false)
	end
end)


RegisterNetEvent('trp_checkin:healPaleto')
AddEventHandler('trp_checkin:healPaleto', function()
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	local head = GetEntityHeading(ped)
	local chance = math.random(1,5)
	local coords1 = {x = -257.8022, y = 6321.917, z = 33.3407}
	local coords2 = {x = -260.3077, y = 6324.29, z = 33.3407}
	local coords3 = {x = -256.7473, y = 6327.706, z = 33.3407}
	local coords4 = {x = -258.5934, y = 6330.541, z = 33.3407}
	local coords5 = {x = -262.3121, y = 6326.848, z = 33.3407}
	-- Bed 1
	if chance == 1 then 
		RespawnPed(ped, coords1, 0.0)
		TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_SUNBATHE_BACK', coords1.x, coords1.y, coords1.z, 360.0, 0, false, true)
		FreezeEntityPosition(ped, true)
		exports['mythic_notify']:SendAlert('inform', _U('notificationText1'), 5000)
		--exports['progressBars']:startUI(5000, 'Scams747 is Treating your wounds right now')
		Citizen.Wait(5000)
		FreezeEntityPosition(ped, false) 
		ClearPedTasksImmediately(ped)
		TriggerServerEvent('trp_checkin:cashmeoutside')
		exports['mythic_notify']:SendAlert('inform', _U('notificationText2'), 4000)
		SetEntityCoords(ped, coords1.x, coords1.y, coords1.z, false, false, false, false)
	end
	-- Bed 2
	if chance == 2 then 
		RespawnPed(ped, coords2, 0.0)
		TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_SUNBATHE_BACK', coords2.x, coords2.y, coords2.z, 360.0, 0, false, true)
		FreezeEntityPosition(ped, true)
		exports['mythic_notify']:SendAlert('inform', _U('notificationText1'), 5000)
		--exports['progressBars']:startUI(5000, 'Scams747 is Treating your wounds right now')
		Citizen.Wait(5000)
		FreezeEntityPosition(ped, false) 
		ClearPedTasksImmediately(ped)
		TriggerServerEvent('trp_checkin:cashmeoutside')
		exports['mythic_notify']:SendAlert('inform', _U('notificationText2'), 4000)
		SetEntityCoords(ped, coords2.x, coords2.y, coords2.z, false, false, false, false)
	end
	-- Bed 3
	if chance == 3 then 
		RespawnPed(ped, coords3, 0.0)
		TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_SUNBATHE_BACK', coords3.x, coords3.y, coords3.z, 360.0, 0, false, true)
		FreezeEntityPosition(ped, true)
		exports['mythic_notify']:SendAlert('inform', _U('notificationText1'), 5000)
		--exports['progressBars']:startUI(5000, 'Scams747 is Treating your wounds right now')
		Citizen.Wait(5000)
		FreezeEntityPosition(ped, false) 
		ClearPedTasksImmediately(ped)
		TriggerServerEvent('trp_checkin:cashmeoutside')
		exports['mythic_notify']:SendAlert('inform', _U('notificationText2'), 4000)
		SetEntityCoords(ped, coords3.x, coords3.y, coords3.z, false, false, false, false)
	end
	-- Bed 4 
	if chance == 4 then 
		RespawnPed(ped, coords4, 0.0)
		TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_SUNBATHE_BACK', coords4.x, coords4.y, coords4.z, 360.0, 0, false, true)
		FreezeEntityPosition(ped, true)
		exports['mythic_notify']:SendAlert('inform', _U('notificationText1'), 5000)
		--exports['progressBars']:startUI(5000, 'Scams747 is Treating your wounds right now')
		Citizen.Wait(5000)
		FreezeEntityPosition(ped, false) 
		ClearPedTasksImmediately(ped)
		TriggerServerEvent('trp_checkin:cashmeoutside')
		exports['mythic_notify']:SendAlert('inform', _U('notificationText2'), 4000)
		SetEntityCoords(ped, coords4.x, coords4.y, coords4.z, false, false, false, false)
	end
	-- Bed 5
	if chance == 5 then 
		RespawnPed(ped, coords5, 0.0)
		TaskStartScenarioAtPosition(ped, 'WORLD_HUMAN_SUNBATHE_BACK', coords5.x, coords5.y, coords5.z, 360.0, 0, false, true)
		FreezeEntityPosition(ped, true)
		exports['mythic_notify']:SendAlert('inform', _U('notificationText1'), 5000)
		--exports['progressBars']:startUI(5000, 'Scams747 is Treating your wounds right now')
		Citizen.Wait(5000)
		FreezeEntityPosition(ped, false) 
		ClearPedTasksImmediately(ped)
		TriggerServerEvent('trp_checkin:cashmeoutside')
		exports['mythic_notify']:SendAlert('inform', _U('notificationText2'), 4000)
		SetEntityCoords(ped, coords5.x, coords5.y, coords5.z, false, false, false, false)
	end
end)

function notification(text, type)
	ESX.TriggerServerCallback("trp:core:identifier", function(steamid)
		TriggerEvent("pNotify:SendNotification",{
			text = "<h2>EMS JOB</h2>" .. steamid .. ""..type.."",
			type = text,
	        timeout = (12000),
	        layout = "centerLeft",
	        queue = "global"
        })
	end)
end