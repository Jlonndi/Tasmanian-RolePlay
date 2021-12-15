ESX = nil 
local PlayerData = {}
local isCuffed = false
local handcuffTimer = {}

Citizen.CreateThread(function() 
	while ESX == nil do 
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
		Citizen.Wait(1) 
	end 
		PlayerData = ESX.GetPlayerData() 
end) 

RegisterNetEvent('esx:playerLoaded')
AddEventHandler("esx:playerLoaded", function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('bixbi_zipties:startziptie')
AddEventHandler("bixbi_zipties:startziptie", function(source)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerEvent("bixbi_zipties:loading", 1000, 'Applying zipties to person')
		Citizen.Wait(1000)
		TriggerServerEvent('bixbi_zipties:ApplyZipties', GetPlayerServerId(closestPlayer))
		TriggerEvent('bixbi_zipties:notify', 'info', 'You have ziptied the target.')
		TriggerServerEvent('bixbi_zipties:RemoveItem', GetPlayerServerId(PlayerId()), 'zipties')
	end
end)

RegisterNetEvent('bixbi_zipties:startziptieremove')
AddEventHandler("bixbi_zipties:startziptieremove", function(type)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		local tool = Config.ZiptieRemovers[type]
		TriggerEvent("bixbi_zipties:loading", tool.timer * 1000, 'Removing zipties from person')
		Citizen.Wait(tool.timer * 1000)

		if tool.OneTimeUse == true then
			TriggerServerEvent('bixbi_zipties:RemoveItem', GetPlayerServerId(PlayerId()), type)
		end
		
		TriggerEvent('bixbi_zipties:notify', 'info', 'You have removed the ziptie.')
		TriggerServerEvent('bixbi_zipties:RemoveZipties', GetPlayerServerId(closestPlayer))
	end
end)

function StartHandcuffTimer()
	if Config.EnableHandcuffTimer and handcuffTimer.active then
		ESX.ClearTimeout(handcuffTimer.task)
	end

	handcuffTimer.active = true

	handcuffTimer.task = ESX.SetTimeout(Config.HandcuffTimer, function()
		TriggerEvent('bixbi_zipties:notify', 'info', 'You feel the zipties slowly losing grip and fading away.')
		TriggerEvent('bixbi_zipties:removeziptie')
		handcuffTimer.active = false
	end)
end

RegisterNetEvent('bixbi_zipties:ziptie')
AddEventHandler("bixbi_zipties:ziptie", function(source, tool)
	local playerPed = PlayerPedId()
	TriggerEvent('bixbi_zipties:notify', 'error', 'You have been ziptied.')

	if isCuffed == false then
		isCuffed = true
		RequestAnimDict('re@stag_do@idle_a')
		while not HasAnimDictLoaded('re@stag_do@idle_a') do
			Citizen.Wait(100)
		end

		TaskPlayAnim(playerPed, 're@stag_do@idle_a', 'idle_a_ped', 8.0, -8, -1, 49, 0, 0, 0, 0)

		SetEnableHandcuffs(playerPed, true)
		DisablePlayerFiring(playerPed, true)
		SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
		SetPedCanPlayGestureAnims(playerPed, false)
		DisplayRadar(false)

		if handcuffTimer.active then
			ESX.ClearTimeout(handcuffTimer.task)
		end

		StartHandcuffTimer()
	end

end)

RegisterNetEvent('bixbi_zipties:removeziptie')
AddEventHandler('bixbi_zipties:removeziptie', function()
	TriggerEvent('bixbi_zipties:notify', '', 'You are free again.')
	if isCuffed then
		local playerPed = PlayerPedId()
		isCuffed = false

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		DisplayRadar(true)

		if handcuffTimer.active then
			ESX.ClearTimeout(handcuffTimer.task)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if isCuffed then
			EnableControlAction(0, 47, true)
			--DisableControlAction(0, 1, true) -- Disable pan
			--DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			--DisableControlAction(0, 32, true) -- W
			--DisableControlAction(0, 34, true) -- A
			--DisableControlAction(0, 31, true) -- S
			--DisableControlAction(0, 30, true) -- D

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			--DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			-- DisableControlAction(0, 75, true)  -- Disable exit vehicle
			-- DisableControlAction(27, 75, true) -- Disable exit vehicle

			if IsEntityPlayingAnim(playerPed, 're@stag_do@idle_a', 'idle_a_ped', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('re@stag_do@idle_a', function()
					TaskPlayAnim(playerPed, 're@stag_do@idle_a', 'idle_a_ped', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		else
			Citizen.Wait(500)
		end
	end
end)