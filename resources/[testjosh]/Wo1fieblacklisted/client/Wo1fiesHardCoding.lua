local spawnedVehicles = {}
local Config = {} 
local PlayerData				= {}
local ESX = nil
local thisisnotcustomcode = 'LuaInjectorsCanSuckMyDickLMAO'
blacklistedeveryone = {
    'dump',
    'barracks',
    'barracks2',
    'crusader',
    'rhino',
    'titan',
    'blimp',
    'blimp2',
    'jet',
    'cargoplane',
    'buzzard',
    'cargobob',
    'cargobob2',
    'cargobob3',
    'dozer',
    'cutter',
    'handler',
    'besra',
    'dodo',
    'duster',
    'luxor',
    'luxor2',
    'mallard',
    'mammatus',
    'milijet',
    'lazer',
    'shamai',
    'velum',
    'vestra',
    'swift',
    'swift2',
    'frogger',
    'frogger2',
    'subersible',
    'submersible2',
    'tractor',
    'liberator',
    'oppressor',
    'oppressor2',
    'shotaro',
    'apc',
    'barrage',
    'chernobog',
    'thruster',
    'khanjali',
    'nightshark',
    'menacer',
    'marshall',
    'technical',
    'technical2',
    'technical3',
    'bombushka',
    'avenger',
    'hydra',
    'starling',
    'mogul',
    'nokota',
    'pyro',
    'rogue',
    'tula',
    'molotok',
    'volatol',
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX = ESX.GetPlayerData()
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.job = job

	Citizen.Wait(5000)
end)

-- Vehicle Blacklist start
Citizen.CreateThread(function()

	while true do

		Wait(1000)

		if IsPedInAnyVehicle(PlayerPedId()) then

			v = GetVehiclePedIsIn(playerPed, false)

		end

		playerPed = PlayerPedId()


			if GetPedInVehicleSeat(v, -1) == playerPed then

				checkCar(GetVehiclePedIsIn(playerPed, false))


		end
	end

end)

-- Vehicle Blacklist end
function checkCar(car)

	if car then

		carModel = GetEntityModel(car)
		carName = GetDisplayNameFromVehicleModel(carModel)

		if isBlacked(carModel) then
            Citizen.Wait(300)
            exports['mythic_notify']:SendAlert('[WBL]', 'This is a blacklisted vehicle', 8000, { ['background-color'] = '#ffffff', ['color'] = '#000000' })
			ClearPedTasksImmediately(playerPed) -- If The Players enter a blacklisted vehicle this will notify them and also force screenshot
			TriggerServerEvent('apotatoflewaroundmyroom')
		end

	end

end

function isBlacked(model)

	for _, blacklistedCar in pairs(blacklistedeveryone) do

		if model == GetHashKey(blacklistedCar) then

			return true

		end

	end

	return false

end

RegisterNetEvent("AC:SCREENSHOT")
AddEventHandler("AC:SCREENSHOT", function(id, reason)
	local playerid = id
screenshot = true
exports['screenshot-basic']:requestScreenshotUpload(Config.webhook, 'files[]', function(data2)
   -- local resp = json.decode(data2)
    --print(data2)
end)
end)