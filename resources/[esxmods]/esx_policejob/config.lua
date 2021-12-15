Config                            = {}

Config.DrawDistance               = 5.0
Config.MarkerType                 = 1
Config.MarkerSize                 = {x = 1.5, y = 1.5, z = 0.5}
Config.MarkerColor                = {r = 50, g = 50, b = 204}

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.EnableHandcuffTimer        = true -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 15 * 60000 -- 15 mins

Config.EnableJobBlip              = true -- enable blips for cops on duty, requires esx_society
Config.EnableCustomPeds           = false -- enable custom peds in cloak room? See Config.CustomPeds below to customize peds

Config.EnableESXService           = true -- enable esx service?
Config.MaxInService               = 30

Config.Locale                     = 'en'

Blacked = {
'16bugatti',
'ABSHEL',
'browardfpiu',
'M5RB_VV',
'MCC',
'NONELSM5',
'NS150',
'PD300C',
'PDEVOKE',
'PDEVOKEWAGON',
'PDFGX',
'PDTERRITORY',
'PDVEGTS',
'PDVESS',
'PDVFGTS',
'PDVFSPORTSWAGON',
'PDVFSS',
'PDXR8',
'POLAIR',
'R1200RTP',
'RBGATOR',
'SHEL',
'firetruk',
'police',
'police2',
'police3',
'police4',
'fbi',
'fbi2',
'sheriff',
'policeb',

	-- old cars

}
Config.PoliceStations = {

	LSPD = {

		Blip = {
			Coords  = vector3(425.1, -979.5, 30.7),
			Sprite  = 60,
			Display = 4,
			Scale   = 0.7,
			Colour  = 29
		},

		Cloakrooms = {
			vector3(462.2374, -996.7516, 30.67834),--mrpd
			vector3(1849.306, 3696.33, 34.25061)
		},

		Armories = {
			vector3(460.7, -980.1, 30.6)
		},

		BossActions = {
			vector3(460.6549, -985.6484, 30.71204),
			vector3(1862.519, 3690.646, 34.25061)
		}

	}

}

Config.AuthorizedWeapons = {
	recruit = {
		{weapon = 'WEAPON_APPISTOL', components = {0, 0, 1000, 4000, nil}, price = 10000},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 1500},
		{weapon = 'WEAPON_FLASHLIGHT', price = 80}
	},

	officer = {
		{weapon = 'WEAPON_APPISTOL', components = {0, 0, 1000, 4000, nil}, price = 10000},
		{weapon = 'WEAPON_ADVANCEDRIFLE', components = {0, 6000, 1000, 4000, 8000, nil}, price = 50000},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 500},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0}
	},

	sergeant = {
		{weapon = 'WEAPON_APPISTOL', components = {0, 0, 1000, 4000, nil}, price = 10000},
		{weapon = 'WEAPON_ADVANCEDRIFLE', components = {0, 6000, 1000, 4000, 8000, nil}, price = 50000},
		{weapon = 'WEAPON_PUMPSHOTGUN', components = {2000, 6000, nil}, price = 70000},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 500},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0}
	},

	lieutenant = {
		{weapon = 'WEAPON_APPISTOL', components = {0, 0, 1000, 4000, nil}, price = 10000},
		{weapon = 'WEAPON_ADVANCEDRIFLE', components = {0, 6000, 1000, 4000, 8000, nil}, price = 50000},
		{weapon = 'WEAPON_PUMPSHOTGUN', components = {2000, 6000, nil}, price = 70000},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 500},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0}
	},

	boss = {
		{weapon = 'WEAPON_APPISTOL', components = {0, 0, 1000, 4000, nil}, price = 10000},
		{weapon = 'WEAPON_ADVANCEDRIFLE', components = {0, 6000, 1000, 4000, 8000, nil}, price = 50000},
		{weapon = 'WEAPON_PUMPSHOTGUN', components = {2000, 6000, nil}, price = 70000},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 500},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0}
	}
}



Config.AuthorizedHelicopters = {
	recruit = {},

	officer = {},

	sergeant = {},

	intendent = {},

	lieutenant = {
	--	{ model = 'polmav', label = 'Police Maverick', livery = 0, price = 400 }
	},

	chef = {
	--	{ model = 'polmav', label = 'Police Maverick', livery = 0, price = 400 }
	},

	boss = {
	--	{ model = 'polmav', label = 'Police Maverick', livery = 0, price = 400 }
	}
}

Config.CustomPeds = {
	shared = {
		--{label = 'CUSTOM PEDSLOL', maleModel = 's_m_y_hwaycop_01', femaleModel = 's_m_y_hwaycop_01'},
	},

	recruit = {},

	officer = {},

	sergeant = {},

	lieutenant = {},

	boss = {}
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements
Config.Uniforms = {
	recruit = {
		male = {
			torso_1 = 190,   torso_2 = 0,
			tshirt_1 = 42,  tshirt_2 = 0,
			arms = 30,
			pants_1 = 52,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 10,  helmet_2 = 6,
			chain_1 = 1,    chain_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	constable = {
		male = {
			torso_1 = 190,   torso_2 = 1,
			tshirt_1 = 42,  tshirt_2 = 0,
			arms = 30,
			pants_1 = 52,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 10,  helmet_2 = 6,
			chain_1 = 1,    chain_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	first_class_const = {
		male = {
			torso_1 = 190,   torso_2 = 2,
			tshirt_1 = 42,  tshirt_2 = 0,
			arms = 30,
			pants_1 = 52,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 10,  helmet_2 = 6,
			chain_1 = 1,    chain_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	senior_const = {
		male = {
			torso_1 = 190,   torso_2 = 3,
			tshirt_1 = 42,  tshirt_2 = 0,
			arms = 30,
			pants_1 = 52,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 10,  helmet_2 = 6,
			chain_1 = 1,    chain_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	leading_senior_const = {
		male = {
			torso_1 = 190,   torso_2 = 4,
			tshirt_1 = 42,  tshirt_2 = 0,
			arms = 30,
			pants_1 = 52,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 10,  helmet_2 = 6,
			chain_1 = 1,    chain_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	sergeant = {
		male = {
			torso_1 = 190,   torso_2 = 5,
			tshirt_1 = 42,  tshirt_2 = 0,
			arms = 30,
			pants_1 = 52,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 10,  helmet_2 = 6,
			chain_1 = 1,    chain_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	senior_seargeant = {
		male = {
			torso_1 = 190,   torso_2 = 6,
			tshirt_1 = 42,  tshirt_2 = 0,
			arms = 30,
			pants_1 = 52,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 10,  helmet_2 = 6,
			chain_1 = 1,    chain_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	second_senior_sergeant = {
		male = {
			torso_1 = 190,   torso_2 = 7,
			tshirt_1 = 42,  tshirt_2 = 0,
			arms = 30,
			pants_1 = 52,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 10,  helmet_2 = 6,
			chain_1 = 1,    chain_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	inspector = {
		male = {
			torso_1 = 190,   torso_2 = 8,
			tshirt_1 = 42,  tshirt_2 = 0,
			arms = 30,
			pants_1 = 52,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 10,  helmet_2 = 6,
			chain_1 = 1,    chain_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	senior_inspector = {
		male = {
			torso_1 = 190,   torso_2 = 9,
			tshirt_1 = 42,  tshirt_2 = 0,
			arms = 30,
			pants_1 = 52,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 10,  helmet_2 = 6,
			chain_1 = 1,    chain_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	chief_inspector = {
		male = {
			torso_1 = 190,   torso_2 = 10,
			tshirt_1 = 42,  tshirt_2 = 0,
			arms = 30,
			pants_1 = 52,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 10,  helmet_2 = 6,
			chain_1 = 1,    chain_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	superintendant = {
		male = {
			torso_1 = 190,   torso_2 = 11,
			tshirt_1 = 42,  tshirt_2 = 0,
			arms = 30,
			pants_1 = 52,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 10,  helmet_2 = 6,
			chain_1 = 1,    chain_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	chief_superintendant = {
		male = {
			torso_1 = 190,   torso_2 = 12,
			tshirt_1 = 42,  tshirt_2 = 0,
			arms = 30,
			pants_1 = 52,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 10,  helmet_2 = 6,
			chain_1 = 1,    chain_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	assistant_commissioner = {
		male = {
			torso_1 = 190,   torso_2 = 13,
			tshirt_1 = 42,  tshirt_2 = 0,
			arms = 30,
			pants_1 = 52,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 10,  helmet_2 = 6,
			chain_1 = 1,    chain_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	deputy_commissioner = {
		male = {
			torso_1 = 190,   torso_2 = 14,
			tshirt_1 = 42,  tshirt_2 = 0,
			arms = 30,
			pants_1 = 52,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 10,  helmet_2 = 6,
			chain_1 = 1,    chain_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	boss = {
		male = {
			torso_1 = 190,   torso_2 = 15,
			tshirt_1 = 42,  tshirt_2 = 0,
			arms = 30,
			pants_1 = 52,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 10,  helmet_2 = 6,
			chain_1 = 1,    chain_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	supervisor = {
		male = {
			torso_1 = 35,   torso_2 = 0,
			tshirt_1 = 10,  tshirt_2 = 0,
			arms = 38,
			pants_1 = 52,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 10,  helmet_2 = 6,
			chain_1 = 1,    chain_2 = 0
		},
		female = {
			torso_1 = 48,   torso_2 = 0
		}
	},

	bullet_wear = {
		male = {
			bproof_1 = 2,  bproof_2 = 0,
		},
		female = {
			bproof_1 = 13,  bproof_2 = 1
		}
	},

	gilet_wear = {
		male = {
			torso_1 = 193,   torso_2 = 0,
			tshirt_1 = 42,  tshirt_2 = 0,
			arms = 20
		},
		female = {
			torso_1 = 35,   torso_2 = 0
		}
	}
}
