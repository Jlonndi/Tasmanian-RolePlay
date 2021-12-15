RegisterServerEvent("PoliceVehicleWeaponDeleter:askDropWeapon")
AddEventHandler("PoliceVehicleWeaponDeleter:askDropWeapon", function(wea)
		--print(1)
		TriggerClientEvent("PoliceVehicleWeaponDeleter:drop", source, wea)

end)
