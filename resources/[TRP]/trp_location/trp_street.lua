local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }



local trp_hide_hud = false



RegisterNetEvent('trp:core:toggleHud')

AddEventHandler('trp:core:toggleHud', function()

    if not trp_hide_hud then

        trp_hide_hud = true

        SendNUIMessage({type = "togglemenu", status = false})

		SendNUIMessage({type = "inVehicle", status = false})

    else

        local player = PlayerPedId()

		local vehicle = GetVehiclePedIsIn(player, false)

		local vehicleIsOn = GetIsVehicleEngineRunning(vehicle)

        trp_hide_hud = false

		if IsPedInAnyVehicle(player, false) and vehicleIsOn then

            SendNUIMessage({type = "inVehicle", status = true})

            SendNUIMessage({type = "togglemenu", status = true})

        end

    end

end)



Citizen.CreateThread(function()

	while true do

		Citizen.Wait(1000)

		local player = PlayerPedId()

		local position = GetEntityCoords(player)

		local zoneNameFull = zones[GetNameOfZone(position.x, position.y, position.z)]

		local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(position.x, position.y, position.z))

		local heading = GetEntityHeading(PlayerPedId())

		local directions = { [0] = 'North', [45] = 'North-West', [90] = 'West', [135] = 'South-West', [180] = 'South', [225] = 'South-East', [270] = 'East', [315] = 'North-East', [360] = 'North', }

		for k,v in pairs(directions)do

			direction = GetEntityHeading(PlayerPedId())

			if(math.abs(direction - k) < 22.5)then

				direction = v

				break

			end

		end

		local locationMessage = nil

		if zoneNameFull then

			locationMessage = streetName .. ', ' .. zoneNameFull

		else

			locationMessage = streetName

		end

		locationMessage = string.format("<strong><b style='color:#ffa866'>" .. direction .. "</b>, " .. locationMessage)

		SendNUIMessage({type = "updatedata", info1 = locationMessage, info2 = "Penis"})

	end

end)



Citizen.CreateThread(function()

	while true do

		Citizen.Wait(1000)

		local player = PlayerPedId()

		local vehicle = GetVehiclePedIsIn(player, false)

		local vehicleIsOn = GetIsVehicleEngineRunning(vehicle)



		if IsPedInAnyVehicle(player, false) and vehicleIsOn then

			if not trp_hide_hud then

				SendNUIMessage({type = "togglemenu", status = true})

				SendNUIMessage({type = "inVehicle", status = true})

			end

		else

			SendNUIMessage({type = "togglemenu", status = false})

			SendNUIMessage({type = "inVehicle", status = false})

			Citizen.Wait(1000)

		end

	end

end)



toggle = false






