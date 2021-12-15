hasWeapons = true
RegisterNetEvent('ldt:cop')
AddEventHandler('ldt:cop', function()
	local player = PlayerPedId()
		Citizen.CreateThread(function()
			if hasWeapons == false then
				hasWeapons = true
				local pistol = GetHashKey("WEAPON_COMBATPISTOL")
				local taser = GetHashKey("WEAPON_STUNGUN")
				local baton = GetHashKey("WEAPON_NIGHTSTICK")
				local torch = GetHashKey("WEAPON_FLASHLIGHT")
				GiveWeaponToPed(player, pistol, 1000, 0, 1)
				GiveWeaponComponentToPed(player, pistol, GetHashKey("COMPONENT_AT_PI_FLSH"))
				GiveWeaponToPed(player, taser, 1000, 0, 0)
				GiveWeaponToPed(player, baton, 1000, 0, 0)
				GiveWeaponToPed(player, torch, 1000, 0, 0)
				ShowNotification("Loadout Equiped.")
			else
				RemoveAllPedWeapons(player,true)
				hasWeapons = false
				ShowNotification("Loadout Reset.")
			end
		end)
end)

RegisterNetEvent('ldt:carbine')
AddEventHandler('ldt:carbine', function()
	local player = PlayerPedId()
	local rifle = GetHashKey('WEAPON_CARBINERIFLE')
	local hascarbine = HasPedGotWeapon(player, rifle, false)
	local isinpolveh = IsPedInAnyPoliceVehicle(player)
		Citizen.CreateThread(function()
		if isinpolveh and (hascarbine == false) then
			GiveWeaponToPed(player, rifle, 50, 0, true)
			ShowNotification("You unlocked your carbine.")
		elseif isinpolveh and (hascarbine == 1) then
			RemoveWeaponFromPed(player, rifle)
			ShowNotification("You stowed your carbine.")
		else
			ShowNotification("~r~You must be in a police vehicle!")
		end
	end)
end)

RegisterNetEvent('ldt:shotgun')
AddEventHandler('ldt:shotgun', function()
	local player = PlayerPedId()
	local rifle = GetHashKey('WEAPON_PUMPSHOTGUN')
	local hascarbine = HasPedGotWeapon(player, rifle, false)
	local isinpolveh = IsPedInAnyPoliceVehicle(player)
		Citizen.CreateThread(function()
		if isinpolveh and (hascarbine == false) then
			GiveWeaponToPed(player, rifle, 50, 0, true)
			ShowNotification("You unlocked your shotgun.")
		elseif isinpolveh and (hascarbine == 1) then
			RemoveWeaponFromPed(player, rifle)
			ShowNotification("You stowed your shotgun.")
		else
			ShowNotification("~r~You must be in a police vehicle!")
		end
	end)
end)

RegisterNetEvent('drop')
AddEventHandler('drop', function()
	pos = GetEntityCoords(PlayerPedId())
	SetPedDropsInventoryWeapon(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), pos.x, pos.y, pos.z, 0)
end)

--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		--if HasPedGotWeapon(PlayerPedId(), GetHashKey('WEAPON_CARBINERIFLE'), false) and not GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_CARBINERIFLE') then
			SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_CARBINERIFLE'), true)
		--end
	end
end)]]
