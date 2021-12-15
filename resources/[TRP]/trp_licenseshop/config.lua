Config = {}
Config.Locale = 'en'

Config.MenuAlign = 'top-left'
Config.DrawDistance = 10

Config.MarkerInfo = {Type = 1, r = 102, g = 102, b = 204, x = 2.0, y = 2.0, z = 1.0}
Config.BlipLicenseShop = {Sprite = 408, Color = 0, Display = 2, Scale = 0.5}

Config.UseBlips = false -- true = Use License Shop Blips
Config.RequireDMV = false -- If true then it will require players to have Drivers Permit to buy other Licenses | false does the Opposite.

Config.AdvancedVehicleShop = false -- Set to true if using esx_advancedvehicleshop
Config.LicenseAircraft = 10000
Config.LicenseBoating = 50

Config.AdvancedWeaponShop = false -- Set to true if using esx_advancedweaponshop
Config.LicenseMelee = 1
Config.LicenseHandgun = 10
Config.LicenseSMG = 100
Config.LicenseShotgun = 50
Config.LicenseAssault = 250
Config.LicenseLMG = 1000
Config.LicenseSniper = 1500

Config.DMVSchool = false -- Set to true if using esx_dmvschool
Config.SellDMV = false -- Set to true if Config.RequireDMV = false & you want players to be able to buy Drivers Permit
Config.LicenseCommercial = 300
Config.LicenseDrivers = 150
Config.LicenseDriversP = 75
Config.LicenseMotocycle = 225

Config.Drugs = false -- Set to true if using esx_drugs
Config.LicenseWeed = 10000

Config.WeaponShop = true -- Set to true if using esx_weaponshop
Config.LicenseWeapon = 5000

Config.AmmoPistol = 1000

Config.Zones = {
	LicenseShops = {
		Coords = {
			vector3(18.976, -1108.917, 28.797),
			vector3(-664.732, -938.647, 20.8),
			vector3(1695.092, 3755.156, 33.705),
			vector3(-329.671, 6079.718, 30.455)
		}
	}
}
