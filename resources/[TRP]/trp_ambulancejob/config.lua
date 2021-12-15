Config                            = {}

Config.DrawDistance               = 100.0

Config.Marker                     = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }

Config.ReviveReward               = 700  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = false -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'en'

local second = 1000
local minute = 60 * second

Config.EarlyRespawnTimer          = 5 * minute  -- Time til respawn is available
Config.BleedoutTimer              = 10 * minute -- Time til the player bleeds out

Config.EnablePlayerManagement     = true

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = false
Config.EarlyRespawnFineAmount     = 5000

Config.RespawnPoint = { coords = vector3(246.5934, -571.1605, 43.2821), heading = 48.5 }

Config.Hospitals = {
	SandyEMS = {
		Blip = {
			coords = vector3(1828.378, 3677.618, 34.26746),
			sprite = 61,
			scale  = 1.2,
			color  = 2
		},
		AmbulanceActions = {
			vector3(1825.451, 3675.706, 34.26746 -1 )-- sandy shores
		},
		Pharmacies = {
			vector3(1825.846, 3673.925, 34.26746 - 1) -- sandy shores
		},
		Vehicles = {
		
		},

		Helicopters = {

		},
		FastTravels = { -- Teleports
		
		},

		FastTravelsPrompt = {
	
		}


	},
	
	PaletoEMS = {
		Blip = {
			coords = vector3(-248.6505, 6325.53, 32.8689),
			sprite = 61,
			scale  = 1.2,
			color  = 2
		},
		AmbulanceActions = {
			vector3(-256.8132, 6306.435, 32.41394 - 1) -- paleto bay
		},
		Pharmacies = {
			vector3(-251.1165, 6312.369, 32.41394 - 1)-- Paleto bay
		},
		Vehicles = {
		
		},

		Helicopters = {

		},
		FastTravels = { -- Teleports
		
		},

		FastTravelsPrompt = {
	
		}


	},
	CentralLosSantos = {

		Blip = {
			coords = vector3(322.2462, -590.0044, 43.98975),
			sprite = 61,
			scale  = 1.2,
			color  = 2
		},
		

		AmbulanceActions = {
			vector3(301.4176, -600.0, 42.2) --pillbox
			
		},

		Pharmacies = {
			vector3(357.0418, -594.522, 42.2821), -- dr office 373
			vector3(344.558, -592.5703, 42.2821), -- back treatment room opposite dr office373
			vector3(324.0527, -573.8637, 43.2821 - 1), -- surgery room 3 ward b
			vector3(317.5077, -572.558, 43.2821 - 1), -- surgery room 2 ward b
			vector3(315.1649, -571.6117, 43.2821 - 1),-- surgery room 1 ward b
			vector3(309.1385, -562.378, 43.2821 - 1),-- labrotory ward b
			
		},

		Vehicles = {
		--	{
			--[[	Spawner = vector3(325.3187, -574.6682, 28.79126) ,
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(325.3187, -574.6682, 27.79126), heading = 227.6, radius = 4.0 },
				}]]
			--}
		},
		

		Helicopters = {
			{
				Spawner = vector3(350.9275, -587.9736, 74.15088),
				InsideShop = vector3(305.6, -1419.7, 41.5),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(350.9275, -587.9736, 74.15088), heading = 142.7, radius = 10.0 },
				}
			}
		},

		FastTravels = { -- Teleports
		

			{
				From = vector3(275.3, -1361, 23.5),
				To = { coords = vector3(295.8, -1446.5, 28.9), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(247.3, -1371.5, 23.5),
				To = { coords = vector3(333.1, -1434.9, 45.5), heading = 138.6 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(335.5, -1432.0, 45.50),
				To = { coords = vector3(249.1, -1369.6, 23.5), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(234.5, -1373.7, 20.9),
				To = { coords = vector3(320.9, -1478.6, 28.8), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(317.9, -1476.1, 28.9),
				To = { coords = vector3(238.6, -1368.4, 23.5), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false }
			}
		},

		FastTravelsPrompt = {
			{
				From = vector3(339.811, -584.8615, 27.79126),
				To = { coords = vector3(331.833, -595.8461, 42.2821), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }, -- Garage to pillbox level 2
				Prompt = ('press ~INPUT_CONTEXT~ for Level 2 Pillbox.')
			},
			{
				From = vector3(331.833, -595.8461, 42.2821),
				To = { coords = vector3(337.4506, -580.8264, 27.79126), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }, -- pillbox level 2 to Garage 
				Prompt = ('press ~INPUT_CONTEXT~ for The Ground Level.')
			},
			{
				From = vector3(340.9846, -580.9846, 27.79126), 
				To = { coords = vector3(342.1319, -584.8351, 73.15088), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }, -- Garage to Heli Pad
				Prompt = ('press ~INPUT_CONTEXT~ for Roof Level Pillbox.')
			},
			{
				From = vector3(329.9604, -601.2264, 42.2821), 
				To = { coords = vector3(342.1319, -584.8351, 73.15088), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }, -- pillbox level 2 to Heli pad
				Prompt = ('press ~INPUT_CONTEXT~ for Roof Level Pillbox.')
			},
			{
				From = vector3(339.8374, -584.1099, 73.15088), 
				To = { coords = vector3(329.4198, -598.1934, 43.2821), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }, -- Heli Pad to Level 2 Pillbox
				Prompt = ('press ~INPUT_CONTEXT~ to go bottom Level.')
			},
		}

	}
}

Config.AuthorizedVehicles = {

	ambulance = {
		{ model = 'ambulance', label = 'Ambulance Van', price = 5000}
	},

	doctor = {
		{ model = 'ambulance', label = 'Ambulance Van', price = 4500}
	},

	chief_doctor = {
		{ model = 'ambulance', label = 'Ambulance Van', price = 3000}
	},

	boss = {
		{ model = 'ambulance', label = 'Ambulance Van', price = 2000}
	}

}

Config.AuthorizedHelicopters = {

	ambulance = {},

	doctor = {
		{ model = 'buzzard2', label = 'Nagasaki Buzzard', price = 150000 }
	},

	chief_doctor = {
		{ model = 'buzzard2', label = 'Nagasaki Buzzard', price = 150000 },
		{ model = 'seasparrow', label = 'Sea Sparrow', price = 300000 }
	},

	boss = {
		{ model = 'buzzard2', label = 'Nagasaki Buzzard', price = 10000 },
		{ model = 'seasparrow', label = 'Sea Sparrow', price = 250000 }
	}

}

Config.Zones = {
	LosSantosSpawn = {
		Name = "LosSantosSpawn",
		Pos	= vector3(282.31, -580.58, 43.27),
		Type = -1
	},

	SandySpawn = {
		Name = "SandySpawn",
		Pos	= vector3(1827.38, 3693.75, 34.22),
		Type = -1
	},

	BlaineSpawn = {
		Name = "BlaineSpawn",
		Pos	= vector3(-247.41, 6331.16, 32.43),
		Type = -1
	},
}