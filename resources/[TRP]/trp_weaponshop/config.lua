Config               = {}

Config.DrawDistance  = 5
Config.Size          = { x = 1.5, y = 1.5, z = 0.5 }
Config.Color         = { r = 0, g = 155, b = 253 }
Config.Type          = 23

Config.Locale        = 'en'

Config.LicenseEnable = true -- only turn this on if you are using esx_license
Config.LicensePrice  = 5000

Config.Zones = {

	GunShop = {
		Legal = true,
		Items = {},
		Locations = {
			vector3(22.0, -1107.2, 28.8),
			vector3(-662.146, -936.086, 20.531),
			vector3(1693.46, 3759.819, 33.705),
			vector3(-330.387, 6083.644, 30.455)
		}
	},

	BlackWeashop = {
		Legal = false,
		Items = {},
		Locations = {
			vector3(-236.221, -2442.733, 5.001)
		}
	}
}
