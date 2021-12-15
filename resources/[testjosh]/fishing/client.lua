local isFishing = false
local buttons = {'up', 'left', 'right', 'down'}
local fishingRod
local sellCoords = vector3(1536.8, 3797.6, 33.4)

function AttachEntityToPed(prop,bone_ID,x,y,z,RotX,RotY,RotZ)
	local playerPed = PlayerPedId()
	local BoneID = GetPedBoneIndex(playerPed, bone_ID)

	ESX.Game.SpawnObject(prop, {
		x = 1729.7,
		y = 6403.9,
		z = 34.5
	}, function(obj)
		AttachEntityToEntity(obj, playerPed, BoneID, x,y,z, RotX,RotY,RotZ, false, false, false, false, 2, true)

		return obj
	end)
end

RegisterNetEvent('esx_fishing:onEatFish')
AddEventHandler('esx_fishing:onEatFish', function()
	local playerPed = PlayerPedId()
	local health = GetEntityHealth(playerPed) + 25

	SetEntityHealth(playerPed, health)

	ESX.UI.Menu.CloseAll()
end)


Citizen.CreateThread(function()
	local blip = AddBlipForCoord(sellCoords)

	SetBlipSprite(blip, 68)
	SetBlipColour(blip, 15)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Fish Market')
	EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
	local animDict, animName = 'mp_common', 'givetake1_a'

	while true do
		Citizen.Wait(10)
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(playerCoords, sellCoords, true) <= 2 then
			TriggerServerEvent('fishing:startSell')
			Citizen.Wait(5000)

			RequestAnimDict(animDict)
			while not HasAnimDictLoaded(animDict) do
				Citizen.Wait(0)
			end

			TaskPlayAnim(playerPed, animDict, animName, 8.0, -1, -1, 16, 0.0, 0, 0, 0)
		else
			Citizen.Wait(500)
		end
	end
end)


RegisterNetEvent('esx_fishing:startFishing')
AddEventHandler('esx_fishing:startFishing', function()
	if isFishing then
		return
	end

	isFishing = true

	local fishTime, time = 10000, 1500
	local animDict, animName = 'amb@world_human_stand_fishing@base', 'base'
	local playerPed = PlayerPedId()

	if IsPedOnFoot(playerPed) then
		ESX.UI.Menu.CloseAll()

		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Wait(1)
		end

		local ped = PlayerPedId()
		TaskPlayAnim(ped, animDict, animName, 8.0, 1.0, -1, 1, 0, 0, 0, 0)
		fishingRod = AttachEntityToPed('prop_fishing_rod_01', 60309, 0, 0, 0, 0, 0, 0)

		for i=1,fishTime do
			Citizen.Wait(0)

			if not isFishing then
				break
			end

			if math.fmod(i, 200) == 0 then
				local rand = math.random(1, #buttons)
				local delay = math.random(5000, 15000)
				Citizen.Wait(delay)
				TriggerEvent('qte:clientWait', buttons[rand], time)
				time = time - 100
			end
		end

		if isFishing then
			isFishing = false
		end
	else
		ESX.ShowNotification('You must be on foot to do that!')
	end
end)

AddEventHandler('qte:clientClicked', function(button)
	if isFishing then
		TriggerEvent('customNotification', "You have caught a fish!")
		TriggerServerEvent('esx_fishing:caughtFish')
	end
end)

AddEventHandler('qte:clientClickFailed', function(button)
	if isFishing then
		isFishing = false
		ESX.Game.DeleteObject(fishingRod)
		ClearPedTasks(PlayerPedId())
		TriggerEvent('customNotification', "The fish got away!")
		Citizen.Wait(200)
		fishing = false
	end
end)