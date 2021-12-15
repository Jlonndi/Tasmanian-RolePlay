Config = {}
Config.Locale = 'en'
Config.DoorList = {
--══════════════════ஜ۩۞۩ஜ═< Bottom Pillbox >═ஜ۩۞۩ஜ══════════════════--
-- Garage Door 1
	{
		objName = GetHashKey('gabz_pillbox_dlc_gate'),
		objCoords  = vector3(338.93, -564.93, 30),
		textCoords = vector3(338.93, -564.93, 30),
		authorizedJobs = { 'offambulance', 'ambulance' },
		locked = true,
		distance = 9,
		size = 1
	},
-- Garage Door 2
	{
		objName = GetHashKey('gabz_pillbox_dlc_gate'),
		objCoords  = vector3(328.57, -561.16, 30),
		textCoords = vector3(328.57, -561.16, 30),
		authorizedJobs = { 'offambulance', 'ambulance' },
		locked = true,
		distance = 9,
		size = 1
	},
-- Garage Door 3
	{
		textCoords = vector3(319.42, -560.71, 29),
		authorizedJobs = { 'offambulance', 'ambulance' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = -1421582160,
				objYaw = 25.47,
				objCoords  = vector3(319.42, -560.71, 29),
			},

			{
				objName = 1248599813,
				objYaw = 204.5,
				objCoords  = vector3(319.42, -560.71, 29),
			}
		}
	},


-- Ambulance Bay
	-- pilbox lower hallway (double doors)
	{
		textCoords = vector3(338.82, -588.79, 29),
		authorizedJobs = { 'offambulance', 'ambulance' },
		locked = true,
		distance = 2,
		doors = {
			{
				objName = -1700911976,
				objYaw = 70.418502807617,
				objCoords  = vector3(339.3266, -587.6345, 28.94709),
			},

			{
				objName = -434783486,
				objYaw = 69.881393432617,
				objCoords  = vector3(338.4467, -590.053, 28.94709),
			}
		}
	},

--══════════════════ஜ۩۞۩ஜ═< Top Pillbox >═ஜ۩۞۩ஜ══════════════════--
-- Closet
	{
	objName = 854291622,
	objYaw = -290.00003051758,
	objCoords  = vector3(304.42, -571.7, 44),
	textCoords = vector3(304.42, -571.7, 44),
	authorizedJobs = { 'offambulance', 'ambulance' },
	locked = true,
	distance = 1,
	size = 1
	},

-- Surgery 1
	{
	textCoords = vector3(313.12, -571.8, 44),
	authorizedJobs = { 'offambulance', 'ambulance' },
	locked = true,
	distance = 1,
	doors = {
		{
			objName = -434783486,
			objYaw = -20.418502807617,
			objCoords  = vector3(313.12, -571.8, 44),
		},

		{
			objName = -1700911976,
			objYaw = -18.881393432617,
			objCoords  = vector3(313.12, -571.8, 44),
		}
	}
	},

-- Surgery 2
	{
	textCoords = vector3(318.93, -573.97, 44),
	authorizedJobs = { 'offambulance', 'ambulance' },
	locked = true,
	distance = 1,
	doors = {
		{
			objName = -434783486,
			objYaw = -20.418502807617,
			objCoords  = vector3(318.93, -573.97, 44),
		},

		{
			objName = -1700911976,
			objYaw = -18.881393432617,
			objCoords  = vector3(318.93, -573.97, 44),
		}
	}
	},

-- Surgery 3
	{
	textCoords = vector3(324.39, -575.78, 44),
	authorizedJobs = { 'offambulance', 'ambulance' },
	locked = true,
	distance = 1,
	doors = {
		{
			objName = -434783486,
			objYaw = -20.418502807617,
			objCoords  = vector3(324.39, -575.78, 44),
		},

		{
			objName = -1700911976,
			objYaw = -18.881393432617,
			objCoords  = vector3(324.39, -575.78, 44),
		}
	}
	},

-- MRI 
	{
	objName = 854291622,
	objYaw = -20.418502807617,
	objCoords  = vector3(337.02, -580.56, 44),
	textCoords = vector3(337.02, -580.56, 44),
	authorizedJobs = { 'offambulance', 'ambulance' },
	locked = true,
	distance = 1,
	size = 1
	},

-- Diagnostics
	{
	objName = 854291622,
	objYaw = -20.418502807617,
	objCoords  = vector3(341.71, -582.04, 44),
	textCoords = vector3(341.71, -582.04, 44),
	authorizedJobs = { 'offambulance', 'ambulance' },
	locked = true,
	distance = 1,
	size = 1
	},

-- X-ray
	{
	objName = 854291622,
	objYaw = -20.418502807617,
	objCoords  = vector3(347.62, -584.29, 44),
	textCoords = vector3(347.62, -584.29, 44),
	authorizedJobs = { 'offambulance', 'ambulance' },
	locked = true,
	distance = 1,
	size = 1
	},

-- Labratory
	{
		objName = 854291622,
		objYaw = 340.00003051758,
		objCoords  = vector3(307.99, -569.95, 44),
		textCoords = vector3(307.99, -569.95, 44),
		authorizedJobs = { 'offambulance', 'ambulance' },
		locked = true,
		distance = 1,
		size = 1
	},

-- Administration
	{
	objName = 854291622,
	objYaw = -20.418502807617,
	objCoords  = vector3(339.89, -587.05, 44),
	textCoords = vector3(339.89, -587.05, 44),
	authorizedJobs = { 'offambulance', 'ambulance' },
	locked = true,
	distance = 1,
	size = 1
	},

-- Director Office
	{
		objName = 854291622,
		objYaw = 339.71200561523,
		objCoords  = vector3(337.75, -592.91, 44),
		textCoords = vector3(337.75, -592.91, 44),
		authorizedJobs = { 'offambulance', 'ambulance' },
		locked = true,
		distance = 1,
		size = 10
	},

-- Kitchen
	{
	objName = 854291622,
	objYaw = -198.881393432617,
	objCoords  = vector3(308.24, -597.47, 44),
	textCoords = vector3(308.24, -597.47, 44),
	authorizedJobs = { 'offambulance', 'ambulance' },
	locked = true,
	distance = 1,
	size = 1
	},

--══════════════════ஜ۩۞۩ஜ═< Mission Row Police Dept >═ஜ۩۞۩ஜ══════════════════--
-- Front Glass Door

	{
		textCoords = vector3(434.74, -981.82, 31),
		authorizedJobs = { 'police', 'offpolice'},
		locked = false,
		distance = 1,
		doors = {
			{
				objName = -1547307588,
				objYaw = 90.11881393432617,
				objCoords  = vector3(434.69, -982.49, 31),
			},

			{
				objName = -1547307588,
				objYaw = -90.11881393432617,
				objCoords  = vector3(434.82, -981.23, 31),
			}
		}
	},

-- Side Glass Door 1

	{
		textCoords = vector3(457, -972.26, 31),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		distance = 1,
		doors = {
			{
				objName = -1547307588,
				objYaw = 0.11881393432617,
				objCoords  = vector3(456.5, -972.37, 31),
			},

			{
				objName = -1547307588,
				objYaw = -180.11881393432617,
				objCoords  = vector3(457.58, -972.19, 31),
			}
		}
	},

-- Side Glass Door 2

	{
		textCoords = vector3(441.93, -998.62, 31),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		distance = 1,
		doors = {
			{
				objName = -1547307588,
				objYaw = -180.11881393432617,
				objCoords  = vector3(442.41, -998.72, 31),
			},

			{
				objName = -1547307588,
				objYaw = 0.11881393432617,
				objCoords  = vector3(441.36, -998.72, 31),
			}
		}
	},

-- Evidence 1
	{
		objName = -692649124,
		objYaw = 135.00003051758,
		objCoords  = vector3(474.94, -989.65, 26.61),
		textCoords = vector3(474.94, -989.65, 26.61),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		distance = 1,
		size = 1
		},

-- Evidence 2
	{
		objName = -1258679973,
		objYaw = 0.00003051758,
		objCoords  = vector3(474.47, -991.93, 26.66471),
		textCoords = vector3(474.47, -991.93, 26.66471),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		distance = 1,
		size = 1
		},

-- Garage 1
	{
	objName = 2130672747,
	objCoords  = vector3(452.31, -1001.04, 27),
	textCoords = vector3(452.31, -1001.04, 27),
	authorizedJobs = { 'police', 'offpolice', 'ambulance' },
	locked = true,
	distance = 9,
	size = 1
	},

-- Garage 2
	{
	objName = 2130672747,
	objCoords  = vector3(431.48, -1000.81, 27),
	textCoords = vector3(431.48, -1000.81, 27),
	authorizedJobs = { 'police', 'offpolice', 'ambulance' },
	locked = true,
	distance = 9,
	size = 1
	},

-- Interrogation 1
	{
	objName = -1406685646,
	objYaw = -90.00003051758,
	objCoords  = vector3(482.68, -988.69, 26.61),
	textCoords = vector3(482.68, -988.69, 26.61),
	authorizedJobs = { 'police', 'offpolice', 'ambulance' },
	locked = true,
	distance = 1,
	size = 1
	},

-- Interrogation 2
	{
	objName = -1406685646,
	objYaw = -90.00003051758,
	objCoords  = vector3(482.59, -996.71, 26.61),
	textCoords = vector3(482.59, -996.71, 26.61),
	authorizedJobs = { 'police', 'offpolice', 'ambulance' },
	locked = true,
	distance = 1,
	size = 1
	},

-- Heli Pad
	{
		objName = -692649124,
		objYaw = -270.00003051758,
		objCoords  = vector3(464.36, -983.41, 44),
		textCoords = vector3(464.36, -983.41, 44),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		distance = 1,
		size = 1
		},

-- Line up
	{
	objName = -288803980,
	objYaw = -270.00003051758,
	objCoords  = vector3(479.1, -1002.16, 26.61),
	textCoords = vector3(479.1, -1002.16, 26.61),
	authorizedJobs = { 'police', 'offpolice', 'ambulance' },
	locked = true,
	distance = 1,
	size = 1
	},
	

-- Cell Corridore 1
	{
	objName = -53345114,
	objYaw = -90.00003051758,
	objCoords  = vector3(476.54, -1007.78, 26.61),
	textCoords = vector3(476.54, -1007.78, 26.61),
	authorizedJobs = { 'police', 'offpolice', 'ambulance' },
	locked = true,
	distance = 1,
	size = 1
	},

-- Cell Corridore 2
	{
	objName = -53345114,
	objYaw = 180.00003051758,
	objCoords  = vector3(482.04, -1004.15, 26.61),
	textCoords = vector3(482.04, -1004.15, 26.61),
	authorizedJobs = { 'police', 'offpolice', 'ambulance' },
	locked = true,
	distance = 1,
	size = 1
	},

-- Cell 1
	{
		objName = -53345114,
		objYaw = 0.00003051758,
		objCoords  = vector3(476.72, -1012.22, 26.61),
		textCoords = vector3(476.72, -1012.22, 26.61),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		distance = 1,
		size = 1
		},

-- Cell 2
	{
		objName = -53345114,
		objYaw = 0.00003051758,
		objCoords  = vector3(479.7, -1012.29, 26.61),
		textCoords = vector3(479.7, -1012.29, 26.61),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		distance = 1,
		size = 1
		},

-- Cell 3
	{
		objName = -53345114,
		objYaw = 0.00003051758,
		objCoords  = vector3(482.83, -1012.17, 26.61),
		textCoords = vector3(482.83, -1012.17, 26.61),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		distance = 1,
		size = 1
		},

-- Cell 4
	{
		objName = -53345114,
		objYaw = 0.00003051758,
		objCoords  = vector3(485.8, -1012.29, 26.61),
		textCoords = vector3(485.8, -1012.29, 26.61),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		distance = 1,
		size = 1
		},

-- Cell 5
	{
	objName = -53345114,
	objYaw = 180.00003051758,
	objCoords  = vector3(485.35, -1007.68, 26.61),
	textCoords = vector3(485.35, -1007.68, 26.61),
	authorizedJobs = { 'police', 'offpolice', 'ambulance' },
	locked = true,
	distance = 1,
	size = 1
	},

-- Back Door
	{
		textCoords = vector3(468.63, -1014.29, 27),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		distance = 2,
		doors = {
			{
				objName = -692649124,
				objYaw = 0.11881393432617,
				objCoords  = vector3(467.91, -1014.33, 27),
			},

			{
				objName = -692649124,
				objYaw = 180.11881393432617,
				objCoords  = vector3(469.53, -1014.08, 27),
			},
		}
	},

	

-- Back Gate
	{
		objName = -1603817716,
		objYaw = -271.00003051758,
		objCoords  = vector3(488.84, -1017.62, 29),
		textCoords = vector3(488.75, -1019.87, 29),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		distance = 10,
		size = 1
	},

-- Parking Garage 1
	{
		objName = 1830360419,
		objYaw = -91.00003051758,
		objCoords  = vector3(464.15, -975.46, 27),
		textCoords = vector3(464.15, -975.46, 27),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		distance = 1,
		size = 1
	},

-- Parking Garage 2
	{
		objName = 1830360419,
		objYaw = -271.00003051758,
		objCoords  = vector3(464.17, -996.72, 27),
		textCoords = vector3(464.17, -996.72, 27),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		distance = 1,
		size = 1
	},

-- Captians Office
	{
		objName = -96679321,
		objYaw = -90.00003051758,
		objCoords  = vector3(458.73, -989.32, 31),
		textCoords = vector3(458.73, -989.32, 31),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		distance = 1,
		size = 1
		},

-- Reception

	{
		objName = -1406685646,
		objYaw = -270.00003051758,
		objCoords  = vector3(445.46, -982.96, 31),
		textCoords = vector3(445.46, -982.96, 31),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		distance = 1,
		size = 1
		},



-- Lobby Door 1

	{
		objName = -1406685646,
		objYaw = 0.00003051758,
		objCoords  = vector3(441.52, -977.43, 31),
		textCoords = vector3(441.52, -977.43, 31),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		distance = 1,
		size = 1
		},

-- lobby Door 2


	{
		objName = -96679321,
		objYaw = -180.00003051758,
		objCoords  = vector3(441.31, -986.21, 31),
		textCoords = vector3(441.31, -986.21, 31),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		distance = 1,
		size = 1
		},

-- Armoury 1


	{
		objName = -692649124,
		objYaw = -180.00003051758,
		objCoords  = vector3(486.73, -1000.17, 31),
		textCoords = vector3(486.73, -1000.17, 31),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		distance = 1,
		size = 1
		},

-- Armoury 2


	{
		objName = -692649124,
		objYaw = -270.00003051758,
		objCoords  = vector3(479.7, -998.84, 31),
		textCoords = vector3(479.7, -998.84, 31),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		distance = 1,
		size = 1
		},

--══════════════════ஜ۩۞۩ஜ═< Boilingbroke Prison >═ஜ۩۞۩ஜ══════════════════--
-- Gate 1

	{
		objName = GetHashKey('prop_gate_prison_01'),
		objYaw = 90.00003051758,
		objCoords  = vector3(1844.97, 2603.74, 45.59),
		textCoords = vector3(1844.89, 2608.34, 48),
		authorizedJobs = { 'police', 'ambulance'},
		locked = true,
		distance = 12,
		size = 1
		},


-- Gate 2

	{
		objName = GetHashKey('prop_gate_prison_01'),
		objYaw = 90.00003051758,
		objCoords  = vector3(1818.57, 2601.74, 45.57),
		textCoords = vector3(1818.92, 2608.35, 48),
		authorizedJobs = { 'police', 'ambulance'},
		locked = true,
		distance = 12,
		size = 1
		},

-- Gate 3

	{
		objName = GetHashKey('prop_gate_prison_01'),
		objYaw = -180.00003051758,
		objCoords  = vector3(1800.52, 2617.23, 45.72),
		textCoords = vector3(1795.28, 2617, 48),
		authorizedJobs = { 'police', 'ambulance'},
		locked = true,
		distance = 12,
		size = 1
		},


-- Walking Gate 1
	{
	objName = -1156020871,
	objYaw = -180.0000305,
	objCoords  = vector3(1797.16, 2596.57, 46),
	textCoords = vector3(1796.48, 2596.64, 46),
	authorizedJobs = { 'police', 'ambulance'},
	locked = true,
	distance = 1,
	size = 1
	},

-- Walking Gate 2
	{
	objName = -1156020871,
	objYaw = -180.0000305,
	objCoords  = vector3(1797.3, 2591.65, 46),
	textCoords = vector3(1797.3, 2591.65, 46),
	authorizedJobs = { 'police', 'ambulance'},
	locked = true,
	distance = 1,
	size = 1
	},

--══════════════════ஜ۩۞۩ஜ═< Sandyshores Sheriff Station >═ஜ۩۞۩ஜ══════════════════--
-- Front Door
	{
		objName = -1765048490,
		objYaw = 300.00003051758,
		objCoords  = vector3(1859.04, 3688.71, 35),
		textCoords = vector3(1859.04, 3688.71, 35),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		distance = 1,
		size = 1
		},

-- Sheriff Office
	{
		objName = -1765048490,
		objYaw = 30.00003051758,
		objCoords  = vector3(1854.94, 3683.35, 35),
		textCoords = vector3(1854.94, 3683.35, 35),
		authorizedJobs = { 'police', 'offpolice'},
		locked = false,
		distance = 1,
		size = 1
		},

-- Rear Door
	{
		objName = 452874391,
		objYaw = 210.00003051758,
		objCoords  = vector3(1855.03, 3700.57, 35),
		textCoords = vector3(1855.03, 3700.57, 35),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		distance = 1,
		size = 1
		},

-- Armoury
	{
		objName = -519068795,
		objYaw = 300.00003051758,
		objCoords  = vector3(1844.5, 3693.22, 35),
		textCoords = vector3(1844.5, 3693.22, 35),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		distance = 1,
		size = 1
		},

-- Cell Corridore
	{
		objName = -2023754432,
		objYaw = 300.00003051758,
		objCoords  = vector3(1850.98, 3682.48, 35),
		textCoords = vector3(1850.98, 3682.48, 35),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		distance = 1,
		size = 1
		},

-- Cell 1
	{
		objName = 631614199,
		objYaw = 120.00003051758,
		objCoords  = vector3(1845.44, 3687.71, 35),
		textCoords = vector3(1845.44, 3687.71, 35),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		distance = 1,
		size = 1
		},

-- Cell 2
	{
		objName = 631614199,
		objYaw = 120.00003051758,
		objCoords  = vector3(1847.2, 3684.71, 35),
		textCoords = vector3(1847.2, 3684.71, 35),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		distance = 1,
		size = 1
		},

-- Lobby Door 1
	{
		objName = -2023754432,
		objYaw = 210.00003051758,
		objCoords  = vector3(1856.65, 3689.52, 35),
		textCoords = vector3(1856.65, 3689.52, 35),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		distance = 1,
		size = 1
		},

-- Lobby Door 2
	{
		objName = -2023754432,
		objYaw = 210.00003051758,
		objCoords  = vector3(1848.02, 3690.42, 35),
		textCoords = vector3(1848.02, 3690.42, 35),
		authorizedJobs = { 'police', 'offpolice'},
		locked = true,
		distance = 1,
		size = 1
		},


--══════════════════ஜ۩۞۩ஜ═< Sandyshores Medical Centre >═ஜ۩۞۩ஜ══════════════════--
-- Chief Doctor
	{
		objName = -770740285,
		objYaw = -149.0000305,
		objCoords  = vector3(1841.46, 3682.26, 35),
		textCoords = vector3(1841.46, 3682.26, 35),
		authorizedJobs = { 'police', 'offambulance', 'ambulance' },	
		locked = true,
		distance = 1,
		size = 2
		},

-- Locker Room
	{
		objName = -770740285,
		objYaw = -239.0000305,
		objCoords  = vector3(1827.37, 3675.64, 35),
		textCoords = vector3(1827.37, 3675.64, 35),
		authorizedJobs = { 'police', 'offambulance', 'ambulance' },	
		locked = true,
		distance = 1,
		size = 1
		},

-- Hallway

	{
		textCoords = vector3(1834.48, 3681.08, 35),
		authorizedJobs = { 'police', 'offambulance', 'ambulance' },		
		locked = true,		
		distance = 5,
		doors = {
			{
				objName = -1143010057,
				objYaw = 30.11881393432617,
				objCoords  = vector3(1835.22, 3681.48, 35),
			},

			{
				objName = -1143010057,
				objYaw = 210.11881393432617,
				objCoords  = vector3(1834.03, 3680.53, 35),
			}
		}
	},


-- Hallway 2

	{
		textCoords = vector3(1825.29, 3679.18, 35),
		authorizedJobs = { 'police', 'offambulance', 'ambulance' },		
		locked = true,
		distance = 2,
		doors = {
			{
				objName = -1143010057,
				objYaw = 120.11881393432617,
				objCoords  = vector3(1824.84, 3679.78, 35),
			},

			{
				objName = -1143010057,
				objYaw = -60.11881393432617,
				objCoords  = vector3(1825.84, 3678.28, 35),
			}
		}
	},






--══════════════════ஜ۩۞۩ஜ═< Paleto Medical Centre >═ஜ۩۞۩ஜ══════════════════--
-- Rear Door 

	{
		textCoords = vector3(-262.59, 6310.93, 33),
		authorizedJobs = { 'police', 'offambulance', 'ambulance' },
		locked = true,
		distance = 5,
		doors = {
			{
				objName = 613848716,
				objYaw = -45.11881393432617,
				objCoords  = vector3(-262.18, 6310.58, 33),
			},

			{
				objName = 613848716,
				objYaw = 135.11881393432617,
				objCoords  = vector3(-263.16, 6311.38, 33),
			}
		}
	},

-- Surgery 

	{
		textCoords = vector3(-251.65, 6319.04, 33),
		authorizedJobs ={ 'police', 'offambulance', 'ambulance' },
		locked = true,
		distance = 2,
		doors = {
			{
				objName = 1415151278,
				objYaw = 225.11881393432617,
				objCoords  = vector3(-251.09, 6319.44, 33),
			},

			{
				objName = 1415151278,
				objYaw = -316.11881393432617,
				objCoords  = vector3(-252.19, 6318.45, 33),
			}
		}
	},

-- Chief Doctor
	{
		objName = -770740285,
		objYaw = 45.0000305,
		objCoords  = vector3(-257.16, 6313.62, 33),
		textCoords = vector3(-257.16, 6313.62, 33),
		authorizedJobs = { 'police', 'offambulance', 'ambulance' },
		locked = true,
		distance = 1,
		size = 2
		},


}
