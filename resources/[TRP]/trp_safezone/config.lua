CircleZones2 = { -- Green Safe Zone (and other map markers
	--AirportCharacterSwitch = {coords = vector3(-1041.991, -2744.888, 21.35), color = -1, sprite = -1, radius = 85.0},
	--jobVehicleSellerSS = {coords = vector3(-283.06, -1024.67, 30.38), color = -1, sprite = -1, radius = 30.0},
	--lowEndVehicleSellerSS = {coords = vector3(-41.55, -1675.96, 29.41), color = -1, sprite = -1, radius = 30.0},
	-- Player Dealerships
	--FishersCarDealer = {coords = vector3(-37.73, -1104.0, 26.43), color = -1, sprite = -1, radius = 30.0},
	--SunshineCarDealer = {coords = vector3(-237.52, 6212.41, 30.94), color = -1, sprite = -1, radius = 30.0},
}

CircleZones3 = { -- Blue Safe Zone
	MissionRowSS = {coords = vector3(446.566, -990.934, 29.42), color = -1, sprite = -1, radius = 55.0},
	SandyPDSS = {coords = vector3(1834.03, 3685.12, 33.76), color = -1, sprite = -1, radius = 40.0},
	BlainePDSS = {coords = vector3(-448.817, 6008.40, 31.49), color = -1, sprite = -1, radius = 40.0},
	BlaineAmboSS = {coords = vector3(-244.826, 6328.512, 32.42), color = -1, sprite = -1, radius = 30.0},
	LSAmbo = {coords = vector3(328.09, -595.68, 28.97), color = -1, sprite = -1, radius = 65.0},
	LSDMV = {coords = vector3(239.30, -1380.87, 33.742), color = -1, sprite = -1, radius = 43.5},
}

function CreateBlipCircle(coords, text, radius, color, sprite)
	local blip = AddBlipForRadius(coords, radius)
	SetBlipHighDetail(blip, true)
	SetBlipColour(blip, 2)
	SetBlipAlpha (blip, 128)

end

function CreateBlipCircle1(coords, text, radius, color, sprite) -- Map zones.
	local blip = AddBlipForRadius(coords, radius)

	SetBlipHighDetail(blip, true)
	SetBlipColour(blip, 62)
	SetBlipAlpha (blip, 128)
	-- create a blip in the middle
	blip = AddBlipForCoord(coords)
	SetBlipHighDetail(blip, true)
	SetBlipSprite (blip, sprite)
	SetBlipScale  (blip, 1.0)
	SetBlipColour (blip, color)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)
end

function CreateBlipCircle2(coords, text, radius, color, sprite)
	local blip = AddBlipForRadius(coords, radius)
	SetBlipHighDetail(blip, true)
	SetBlipColour(blip, 2)
	SetBlipAlpha (blip, 128)
end

Citizen.CreateThread(function()
	for k,zone in pairs(CircleZones2) do
		CreateBlipCircle(zone.coords, zone.name, zone.radius, zone.color, zone.sprite)
	end
	for k,zone in pairs(CircleZones3) do
		CreateBlipCircle2(zone.coords, zone.name, zone.radius, zone.color, zone.sprite)
	end
end)
