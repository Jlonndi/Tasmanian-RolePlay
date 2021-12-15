
GlobalFunction = function(event, data)
    local options = {
        event = event,
        data = data
    }

    TriggerServerEvent("TRP:core:StoreRobbery:globalEvent", options)
end
local decors = {
    {
        ["decorName"] = "isRobbable",
        ["decorType"] = 2
    }
}

for decorIndex, decorData in ipairs(decors) do
    DecorRegister(decorData["decorName"], decorData["decorType"])
end

Initial = function()
	ESX.TriggerServerCallback("TRP:core:StoreRobbery:createClerks", function(response)
		if type(response) == "table" then
			for clerkIndex, clerkData in ipairs(response) do
				if NetworkDoesNetworkIdExist(clerkData["clerk"]) then
					cachedData["clerks"][clerkData["store"]] = NetToPed(clerkData["clerk"])
				end
			end
		elseif response then
			CreateClerks()
		else
			--wrong player not loaded
		end
	end)
end

CreateClerks = function()
	local clerkData = Config.ClerkData

	if not HasModelLoaded(clerkData["model"]) then
		LoadModels({
			clerkData["model"]
		})
	end

	local networkedClerks = {}

	for store, position in pairs(Config.StoreClerks) do
		local clerk = CreatePed(5, clerkData["model"], position, position["w"], true)

		SetPedCombatAttributes(clerk, 46, true)                     
		SetPedFleeAttributes(clerk, 0, 0)                      
		SetBlockingOfNonTemporaryEvents(clerk, true)
		
		SetEntityAsMissionEntity(clerk, true, true)
		SetNetworkIdCanMigrate(PedToNet(clerk), true)

		table.insert(networkedClerks, {
			["store"] = store,
			["clerk"] = PedToNet(clerk)
		})

		DecorSetBool(clerk, "isRobbable", true)
	end

	CleanupModels({
		clerkData["model"]
	})

	ESX.TriggerServerCallback("TRP:core:StoreRobbery:updateClerks", function(updated)
		if updated then
			-- correctly updated.
		end
	end, networkedClerks)
end

StartRobberyThread = function(pedEntity)
	if IsPedDeadOrDying(pedEntity) then return end

	RequestNetworkControl({
		pedEntity
	})

	DecorSetBool(pedEntity, "isRobbable", false)

	local scaredPercent = 0

	while scaredPercent < 100 do
		Citizen.Wait(0)

		if not IsEntityPlayingAnim(pedEntity, "missheist_agency2ahands_up", "handsup_anxious", 3) then
			PlayAnimation(pedEntity, "missheist_agency2ahands_up", "handsup_anxious", { ["flag"] = 11 })
		end

		if IsPedDeadOrDying(pedEntity) then
			return
		end

		local isAiming, entityFound, entityAimingAt = IsPlayerFreeAiming(PlayerId()), GetEntityPlayerIsFreeAimingAt(PlayerId())

		if isAiming then
			if IsPedShooting(PlayerPedId()) then
				scaredPercent = scaredPercent + 1
			end

			if entityFound and entityAimingAt == clerk then
				scaredPercent = scaredPercent + 0.5
			end

			scaredPercent = scaredPercent + 0.1
		else
			scaredPercent = scaredPercent + 0.05
		end

		DrawTimerBar(scaredPercent > 100 and 100 or scaredPercent)
	end

	SetStreamedTextureDictAsNoLongerNeeded("timerbars")

	RobPed(pedEntity)
end

RobPed = function(pedEntity)
	local closestTill = GetClosestObjectOfType(GetEntityCoords(pedEntity), 4.0, 303280717, false)

	if not DoesEntityExist(closestTill) then
		return
	end

	LoadModels({
		GetHashKey("p_poly_bag_01_s"),
		"mp_am_hold_up"
	})
	
	local cashBag = CreateObject(GetHashKey("p_poly_bag_01_s"), GetEntityCoords(closestTill) - vector3(0.0, 0.0, 5.0), true)

	RequestNetworkControl({
		pedEntity,
		closestTill,
		cashBag
	})

	local scene = NetworkCreateSynchronisedScene(GetEntityCoords(closestTill) - vector3(0.0, 0.0, 0.1), GetEntityRotation(closestTill) + vector3(0.0, 0.0, -180.0), 2, false, false, 1065353216, 0, 1.3)
        
	NetworkAddPedToSynchronisedScene(pedEntity, scene, "mp_am_hold_up", "holdup_victim_20s", 1.5, -4.0, 1, 16, 1148846080, 0)
	NetworkAddEntityToSynchronisedScene(cashBag, scene, "mp_am_hold_up", "holdup_victim_20s_bag", 4.0, -8.0, 1)
	NetworkAddEntityToSynchronisedScene(closestTill, scene, "mp_am_hold_up", "holdup_victim_20s_till", 4.0, -8.0, 1)
	
	NetworkStartSynchronisedScene(scene)

	local started = GetGameTimer()

	while GetGameTimer() - started < 16000 do
		Citizen.Wait(5)

		if IsPedDeadOrDying(pedEntity) then
			DeleteEntity(cashBag)

			return
		end
	end

	GlobalFunction("create_bag", { ["money"] = math.random(Config.ClerkData["money"][1], Config.ClerkData["money"][2]), ["networkedBag"] = ObjToNet(cashBag) })
	
	CleanupModels({
		GetHashKey("p_poly_bag_01_s"),
		"mp_am_hold_up"
	})

	if math.random(3) == 2 then
		local started = GetGameTimer()

		while GetGameTimer() - started < 5000 do
			Citizen.Wait(5)
	
			if IsPedDeadOrDying(pedEntity) then
				-- add ped clear weapon function?????????????????????????????????????????????????????????????????????????????
				RemoveWeaponToPed(pedEntity, GetHashKey("weapon_bat"))
			
				return
			end
		end

		GiveWeaponToPed(pedEntity, GetHashKey("weapon_bat"), 12, false, true)

		TaskCombatPed(pedEntity, PlayerPedId(), 0, 16)

		local clerkCoords = GetEntityCoords(pedEntity)

		GlobalFunction("alert_police", {
			["coords"] = {
				["x"] = clerkCoords["x"],
				["y"] = clerkCoords["y"]
			}
		})
	end
end

BagThread = function(bagData)
	Citizen.CreateThread(function()
		if not NetworkDoesEntityExistWithNetworkId(bagData["networkedBag"]) then return end

		local bagEntity = NetToObj(bagData["networkedBag"])

		while DoesEntityExist(bagEntity) do
			local sleepThread = 500

			local ped = PlayerPedId()
			local pedCoords = GetEntityCoords(ped)

			local bagCoords = GetEntityCoords(bagEntity)

			local distanceCheck = #(pedCoords - bagCoords)

			if distanceCheck <= 1.1 then
				sleepThread = 5

				local displayText = "Press ~INPUT_DETONATE~ to grab $" .. bagData["money"]

				ESX.ShowHelpNotification(displayText)

				if IsControlJustPressed(0, 47) then
					PlayAnimation(PlayerPedId(), "pickup_object", "pickup_low", { ["speed"] = 8.0, ["speedMultiplier"] = 8.0, ["duration"] = -1, ["flag"] = 16 })
					
					Citizen.Wait(500)

					RequestNetworkControl({
						bagEntity
					})

					AttachEntityToEntity(bagEntity, ped, GetPedBoneIndex(ped, 6286), 0.1, -0.11, 0.08, 0.0, -75.0, -75.0, 1, 1, 0, 0, 2, 1)

					Citizen.Wait(900)

					if DoesEntityExist(bagEntity) then
						TriggerServerEvent("TRP:core:StoreRobbery:receiveBagmoney", bagData["money"])

						DeleteObject(bagEntity)
					end
				end
			end

			Citizen.Wait(sleepThread)
		end
	end)
end

DrawButtons = function(buttonsToDraw)
	Citizen.CreateThread(function()
		local instructionScaleform = RequestScaleformMovie("instructional_buttons")
	
		while not HasScaleformMovieLoaded(instructionScaleform) do
			Wait(0)
		end
	
		PushScaleformMovieFunction(instructionScaleform, "CLEAR_ALL")
		PushScaleformMovieFunction(instructionScaleform, "TOGGLE_MOUSE_BUTTONS")
		PushScaleformMovieFunctionParameterBool(0)
		PopScaleformMovieFunctionVoid()
	
		for buttonIndex, buttonValues in ipairs(buttonsToDraw) do
			PushScaleformMovieFunction(instructionScaleform, "SET_DATA_SLOT")
			PushScaleformMovieFunctionParameterInt(buttonIndex - 1)
	
			PushScaleformMovieMethodParameterButtonName(buttonValues["button"])
			PushScaleformMovieFunctionParameterString(buttonValues["label"])
			PopScaleformMovieFunctionVoid()
		end
	
		PushScaleformMovieFunction(instructionScaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
		PushScaleformMovieFunctionParameterInt(-1)
		PopScaleformMovieFunctionVoid()
		DrawScaleformMovieFullscreen(instructionScaleform, 255, 255, 255, 255)
	end)
end

DrawScriptMarker = function(markerData)
    DrawMarker(markerData["type"] or 1, markerData["pos"] or vector3(0.0, 0.0, 0.0), 0.0, 0.0, 0.0, (markerData["type"] == 6 and -90.0 or markerData["rotate"] and -180.0) or 0.0, 0.0, 0.0, markerData["sizeX"] or 1.0, markerData["sizeY"] or 1.0, markerData["sizeZ"] or 1.0, markerData["r"] or 1.0, markerData["g"] or 1.0, markerData["b"] or 1.0, 100, false, true, 2, false, false, false, false)
end

DrawScriptText = function(coords, text)
    local onScreen, _x, _y = World3dToScreen2d(coords["x"], coords["y"], coords["z"])
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)

    local factor = string.len(text) / 370

    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
end

PlayAnimation = function(ped, dict, anim, settings)
	if dict then
        Citizen.CreateThread(function()
            RequestAnimDict(dict)

            while not HasAnimDictLoaded(dict) do
                Citizen.Wait(100)
            end

            if settings == nil then
                TaskPlayAnim(ped, dict, anim, 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
            else 
                local speed = 1.0
                local speedMultiplier = -1.0
                local duration = 1.0
                local flag = 0
                local playbackRate = 0

                if settings["speed"] then
                    speed = settings["speed"]
                end

                if settings["speedMultiplier"] then
                    speedMultiplier = settings["speedMultiplier"]
                end

                if settings["duration"] then
                    duration = settings["duration"]
                end

                if settings["flag"] then
                    flag = settings["flag"]
                end

                if settings["playbackRate"] then
                    playbackRate = settings["playbackRate"]
                end

                TaskPlayAnim(ped, dict, anim, speed, speedMultiplier, duration, flag, playbackRate, 0, 0, 0)
            end
      
            RemoveAnimDict(dict)
		end)
	else
		TaskStartScenarioInPlace(ped, anim, 0, true)
	end
end

LoadModels = function(models)
	for index, model in ipairs(models) do
		if IsModelValid(model) then
			while not HasModelLoaded(model) do
				RequestModel(model)
	
				Citizen.Wait(10)
			end
		else
			while not HasAnimDictLoaded(model) do
				RequestAnimDict(model)
	
				Citizen.Wait(10)
			end    
		end
	end
end

CleanupModels = function(models)
	for index, model in ipairs(models) do
		if IsModelValid(model) then
			SetModelAsNoLongerNeeded(model)
		else
			RemoveAnimDict(model)  
		end
	end
end

RequestNetworkControl = function(entitys)
	for index, entity in ipairs(entitys) do
		while not NetworkHasControlOfEntity(entity) do
			NetworkRequestControlOfEntity(entity)

			Citizen.Wait(0)
		end
	end
end

DrawTimerBar = function(percent)
	if not percent then percent = 0 end

	local correction = ((1.0 - math.floor(GetSafeZoneSize(), 2)) * 100) * 0.005
	local X, Y, W, H = 1.415 - correction, 1.475 - correction, percent * 0.00085, 0.0125
	
	if not HasStreamedTextureDictLoaded("timerbars") then
		RequestStreamedTextureDict("timerbars")

		while not HasStreamedTextureDictLoaded("timerbars") do
			Citizen.Wait(0)
		end
	end
	
	Set_2dLayer(0)
	DrawSprite("timerbars", "all_black_bg", X, Y, 0.15, 0.0325, 0.0, 255, 255, 255, 180)
	
	Set_2dLayer(1)
	DrawRect(X + 0.0275, Y, 0.085, 0.0125, 100, 0, 0, 180)
	
	Set_2dLayer(2)
	DrawRect(X - 0.015 + (W / 2), Y, W, H, 150, 0, 0, 180)
	
	SetTextColour(255, 255, 255, 180)
	SetTextFont(0)
	SetTextScale(0.3, 0.3)
	SetTextCentre(true)
	SetTextEntry("STRING")
	AddTextComponentString("SCARED")
	Set_2dLayer(3)
	DrawText(X - 0.04, Y - 0.012)
end
