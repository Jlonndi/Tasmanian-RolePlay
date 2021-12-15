--[[ 
----------TEMPLATE

	zoneXFromOutToIn = {
		x = obviously X,
		y = obviously Y,
		z = obviously Z,
		w = obviously WIDTH,
		h = obviously HEIGHT,		
		visible = true,
		t = obviously TYPE,
		color = {
			r = obviously RED,
			g = obviously GREEN,
			b = obviously BLUE
		}
	},

If you don't want the marker to be visible, you're not obliged to
type more data after it:

	zoneXFromOutToIn = {
		x = obviously X,
		y = obviously Y,
		z = obviously Z,
		w = obviously WIDTH,
		h = obviously HEIGHT,		
		visible = false
	},
]]
-- To get a list of available marker go to https://docs.fivem.net/game-references/markers/

configt = {}

-- C key by default
configt.actionKey = 26

-- markers AKA Teleporters
configt.zones = {
	
	WeedEnter = {           --This is the entrance where you go to enter the weed warehouse
		x = 843.305,
		y = 2192.356,
		z = 52.291,
		w = 2.0,
		h = 1.0,
		visible = false, -- Set this to true to make the marker visible. False to disable it.
		t = 29,          -- This is the marker. You can change it https://docs.fivem.net/game-references/markers
		color = {
			r = 0,
			g = 102,
			b = 0
		}
		
	},
	
	WeedExit = {          --This is the exit where you go to exit the weed warehouse
		x = 1038.863,
		y = -3197.662,
		z = -38.17,
		w = 2.0,
		h = 1.0,
		visible = false,
		t = 29,
		color = {
			r = 0,
			g = 102,
			b = 0
		}
		
	},
	
	MoneyWashEnter = {
		x = 1639.516,
		y = 4879.4,
		z = 42.141,
		w = 2.0,
		h = 1.0,
		visible = true,
		t = 29,
		color = {
			r = 0,
			g = 102,
			b = 0
		}
		
	},
	
	MoneyWashExit = {
		x = 1138.146,
		y = -3199.096,
		z = -39.666,
		w = 2.0,
		h = 1.0,
		visible = false,
		t = 29,
		color = {
			r = 0,
			g = 102,
			b = 0
		}
		
	},

	MethEnter = {
		x = 2854.333,
		y = 1479.968,
		z = 24.736,
		w = 2.0,
		h = 1.0,		
		visible = true,
		t = 1,
		color = {
			r = 102,
			g = 0,
			b = 0
		}
	},
	
	MethExit = {
		x = 997.072,
		y = -3200.898,
		z = -36.394,
		w = 2.0,
		h = 1.0,		
		visible = false,
		t = 1,
		color = {
			r = 102,
			g = 0,
			b = 0
		}
	},

	CokeEnter = {
		x = -1123.112,
		y = -2012.919,
		z = 13.189,
		w = 2.0,
		h = 1.0,		
		visible = true,
		t = 1,
		color = {
			r = 102,
			g = 0,
			b = 0
		}
	},
	
	CokeExit = {
		x = 1088.625,
		y = -3187.562,
		z = -38.993,
		w = 2.0,
		h = 1.0,		
		visible = false,
		t = 1,
		color = {
			r = 102,
			g = 0,
			b = 0
		}
	},
}

-- Landing point, keep the same name as markers
configt.point = {

	WeedEnter = {           --This is where you land when you use the entrance teleport.
		x = 1066.009,
		y = -3183.386,
		z = -39.164
	},
	
	WeedExit = {             --This is where you land when you use the exit teleport.
		x = 828.782,
		y = 2191.398,
		z = 52.35
	},

	MethEnter = {
		x = 1000.064,
		y = -3200.528,
		z = -36.394
	},
	
	MethExit = {
		x = 2854.059,
		y = 1502.48,  
		z = 24.724
	},

	CokeEnter = {
		x = 1088.852,
		y = -3189.844, 
		z = -38.993
	},
	CokeExit = {
		x = -1121.167,
		y = -2010.648, 
		z = 13.184
	},
	
	MoneyWashEnter = {
		x = 1118.405,
		y = -3193.687,
		z = -40.394
	},
	
	MoneyWashExit = {
		x = 1639.008,
		y = 4870.545,
		z = 42.03
	}
}


-- Automatic teleport list (no need to puseh E key in the marker)
configt.auto = {
	'WeedEnter',
	'WeedExit',
	'MoneyWashEnter',
	'MoneyWashExit',
	'CokeEnter',
	'CokeExit',
	'MethEnter',
	'MethExit'
}
