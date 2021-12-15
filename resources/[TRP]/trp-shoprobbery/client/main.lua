ESX = nil

cachedData = {
	["clerks"] = {}
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent("esx:getSharedObject", function(obj) 
			ESX = obj 
		end)

		Citizen.Wait(0)
	end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(response)
	ESX.PlayerData = response

	Initial()
end)

RegisterNetEvent("TRP:core:StoreRobbery:eventHandler")
AddEventHandler("TRP:core:StoreRobbery:eventHandler", function(event, eventData)
	if event == "update_clerks" then
		for clerkIndex, clerkData in ipairs(eventData) do
			if NetworkDoesNetworkIdExist(clerkData["clerk"]) then
				cachedData["clerks"][clerkData["store"]] = NetToPed(clerkData["clerk"])
			end
		end
	elseif event == "create_clerks" then
		CreateClerks()
	print('working?')
	elseif event == "create_bag" then
		BagThread(eventData)
	elseif event == "alert_police" then
		if ESX.PlayerData["job"] and ESX.PlayerData["job"]["name"] == "police" then
			ESX.ShowHelpNotification("Store robbery alarm gone off, gps set.")

			SetNewWaypoint(eventData["coords"]["x"], eventData["coords"]["y"])
		end
	else
		-- print("Wrong event handler.")
	end
end)

Citizen.CreateThread(function()
	Citizen.Wait(100)

	if Config.ShowBlips then
		for clerkStore, clerkCoords in pairs(Config.StoreClerks) do
			local clerkBlip = AddBlipForCoord(clerkCoords)

			SetBlipSprite(clerkBlip, 156)
			SetBlipScale(clerkBlip, 0.8)
			SetBlipColour(clerkBlip, 1)
			SetBlipAsShortRange(clerkBlip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Robbable clerk")
			EndTextCommandSetBlipName(clerkBlip)
		end
	end

	while true do
		local sleepThread = 500
		
		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)
		
		for clerkStore, clerkCoords in pairs(Config.StoreClerks) do
			local dstCheck = #(pedCoords - vector3(clerkCoords["x"], clerkCoords["y"], clerkCoords["z"]))
			
			if dstCheck <= 10.0 then
				sleepThread = 0

				if IsPedArmed(ped, 7) then
					local isAiming, entityFound, entityAimingAt = IsPlayerFreeAiming(PlayerId()), GetEntityPlayerIsFreeAimingAt(PlayerId())

					if isAiming then
						if entityFound and GetEntityModel(entityAimingAt) == Config.ClerkData["model"] then
							if DecorGetBool(entityAimingAt, "isRobbable") then
								StartRobberyThread(entityAimingAt)
							else
								ESX.ShowHelpNotification("Can't rob this clerk right now.")
							end
						end
					end
				end
			end	
		end

	  	Citizen.Wait(sleepThread)
	end
end)

