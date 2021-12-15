
CONFIG = {}

CONFIG.allow_fast_limit = false 

CONFIG.allow_quick_start_video = true 

CONFIG.keyDefaults =
{
	remote_control = "f5",

	key_lock = "l",

	front_lock = "numpad8",

	rear_lock = "numpad5",

	plate_front_lock = "numpad9",

	plate_rear_lock = "numpad6"
}

CONFIG.menuDefaults = 
{

	["fastDisplay"] = true, 

	["same"] = 0.6, 
	["opp"] = 0.6, 

	["beep"] = 0.6,

	["voice"] = 0.6,

	["plateAudio"] = 0.6, 

	["speedType"] = "kmh"
}

CONFIG.uiDefaults =
{

	scale =
	{
		radar = 1.0, 
		remote = 1.0, 
		plateReader = 1.0
	}, 

	safezone = 20 
}