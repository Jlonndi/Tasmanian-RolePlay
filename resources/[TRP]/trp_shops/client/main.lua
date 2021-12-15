ESX = nil
local hasAlreadyEnteredMarker, lastZone
local currentAction, currentActionMsg, currentActionData = nil, nil, {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	if NetworkIsSessionStarted() then
		Citizen.Wait(15000)
		ESX.TriggerServerCallback('trp_shops:requestDBItems', function(ShopItems)
			for k,v in pairs(ShopItems) do
				Config.Zones[k].Items = v
			end
		end)
	end
end)

function OpenShopMenu(zone)
	local elements = {}
	
	SetNuiFocus(true, true)

	SendNUIMessage({
		display = true,
	})

	for i=1, #Config.Zones[zone].Items, 1 do
		local item = Config.Zones[zone].Items[i]

		SendNUIMessage({
			itemLabel = item.label,
			item = item.item,
			price = item.price,
			imglink = item.imglink,
			zone = zone
		})
	end
end

AddEventHandler('trp_shops:hasEnteredMarker', function(zone)
	currentAction     = 'shop_menu'
	currentActionMsg  = _U('press_menu')
	currentActionData = {zone = zone}
end)

AddEventHandler('trp_shops:hasExitedMarker', function(zone)
	SendNUIMessage({
		display = false,
		clear = true
	})

	currentAction = false

	SetNuiFocus(false, false)
end)

--[[Citizen.CreateThread(function()
	local sleep = 500
	while true do
		sleep = 0
		Citizen.Wait(sleep)
		if IsControlJustReleased(1, 177) then
			SendNUIMessage({
				display = false,
				clear = true
			})
sleep = 500
			SetNuiFocus(false, false)
		end
	end
end)]]
-- Create Blips
Citizen.CreateThread(function()
	for k,v in pairs(Config.Zones) do
		for i = 1, #v.Pos, 1 do
			local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)

			SetBlipSprite (blip, 59)
			SetBlipScale  (blip, 0.7)
			SetBlipColour (blip, 2)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName('STRING')
			AddTextComponentSubstringPlayerName(_U('shops'))
			EndTextCommandSetBlipName(blip)
		end
	end
end)



-- Enter / Exit marker events
Citizen.CreateThread(function()
	local sleep = 1000
	while true do
		Citizen.Wait(sleep)
		local playerCoords = GetEntityCoords(PlayerPedId())
		local isInMarker, letSleep, currentZone = false, false

		for k,v in pairs(Config.Zones) do
			for i = 1, #v.Pos, 1 do
				local distance = GetDistanceBetweenCoords(playerCoords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true)

				if distance < Config.DrawDistance then
					sleep = 1000 

					if distance < Config.Size.x then
						sleep = 0
						isInMarker  = true
						currentZone = k
						lastZone    = k
					end
				end
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			TriggerEvent('trp_shops:hasEnteredMarker', currentZone)
			sleep = 500
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('trp_shops:hasExitedMarker', lastZone)
			sleep = 500
		end

		if letSleep then
			sleep = 1000
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	local sleep = 500
	while true do
		Citizen.Wait(sleep)

		if currentAction then
			ESX.ShowHelpNotification(currentActionMsg)
sleep = 0
			if IsControlJustReleased(0, 38) and not IsControlPressed(0, 19) then
				if currentAction == 'shop_menu' then
					OpenShopMenu(currentActionData.zone)
				end

				currentAction = nil
			end
		else
			sleep = 500
		end
	end
end)

RegisterNUICallback('buyItem', function(data, cb)
	TriggerServerEvent('trp_shops:buyItem', data.item, 1, data.zone)
end)

RegisterNUICallback('focusOff', function(data, cb)
	SetNuiFocus(false, false)
end)