ESX = nil
local count, pickTimer, spawnedPlants, closestDistance = 0, 0, 0, -1
local inMarker, alreadyEntered, hasExited, busy, atPlant, hasPlant, stepAway, dealing = false, false, false, false, false, false, false, false
local currentDrugData, spawnedPlantTable, PlayerData, ticks, drugBlips = {}, {}, {}, {}, {}
local lastDrug, lastZone, currentAction, currentMsg, lastPlant, currentPlant, closestPlant

RegisterNetEvent('TRP-Drugs:getESX')
AddEventHandler('TRP-Drugs:getESX', function()
	TriggerEvent(Config.Strings.trigEv, function(obj) ESX = obj end)
end)
RegisterNetEvent('trp-core:druglog')
AddEventHandler('trp-core:druglog', function(ItemName, amount, price)  
TriggerServerEvent('trp-core:druglog', ItemName, amount, price)
end)
RegisterNetEvent('trp-core:druggatherweed')
AddEventHandler('trp-core:druggatherweed', function(ItemName, amount2)  
TriggerServerEvent('trp-core:druggatherweed', ItemName, amount2)
end)
RegisterNetEvent('trp-core:combinedrug')
AddEventHandler('trp-core:combinedrug', function(name, reward)  
TriggerServerEvent('trp-core:combinedrug', name, reward)
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerServerEvent('TRP-Drugs:giveESX')
		Citizen.Wait(10)
	end
	while not ESX.IsPlayerLoaded() do
		Citizen.Wait(10)
	end
	TriggerServerEvent('TRP-Drugs:giveZones')
	PlayerData = ESX.GetPlayerData()
	if Config.SodyClubs then
		ESX.TriggerServerCallback('TRP-Drugs:getPlayerData', function(xPlayer)
			PlayerData.gang = xPlayer.gang
		end)
		while PlayerData.gang == nil do Citizen.Wait(10) end
	end
	while not HasCollisionLoadedAroundEntity(PlayerPedId()) do Citizen.Wait(10) end
	for k,v in pairs(Config.Drugs) do
		if v.sprite ~= -1 then
			if shouldDraw(v.job) then
				if v.prop ~= nil then
					CreateBlip(v.coords, v.label, v.color, v.sprite, v.alpha, v.scale, v.display, v.zonesize.x)
				else
					CreateBlip(v.coords, v.label, v.color, v.sprite, v.alpha, v.scale, v.display)
				end
			end
		end
		if v.ped ~= nil then
			local model = GetHashKey(v.ped)
			RequestModel(model)
			while not HasModelLoaded(model) do
				Citizen.Wait(1)
			end
			local npc = CreatePed(1, model, v.pedpos.x, v.pedpos.y, v.pedpos.z, v.pedpos.w, false, true)
			SetBlockingOfNonTemporaryEvents(npc, true)
			SetPedDiesWhenInjured(npc, false)
			SetPedCanPlayAmbientAnims(npc, true)
			SetPedCanRagdollFromPlayerImpact(npc, false)
			SetEntityInvincible(npc, true)
			FreezeEntityPosition(npc, true)
			RequestAnimDict(v.dict)
			while not HasAnimDictLoaded(v.dict) do Citizen.Wait(1) end
			TaskPlayAnim(npc, v.dict, v.anim, 8.0, -8.0, -1, 1, 1.0, false, false, false)
			SetPedKeepTask(npc, true)
			RemoveAnimDict(v.dict)
		end
	end
	while true do
		local ped = PlayerPedId()
		sleep = 1000
		if pickTimer ~= 0 then
			if currentAction then
				if currentDrugData.maxSpawn ~= nil then
					currentPos = GetEntityCoords(ped)
					if currentPos == prevPos then
						if pickTimer > 0 then
							sleep = 5
							ESX.ShowHelpNotification(Config.Strings.bloodFlow)
						end
					else
						pickTimer = pickTimer - 1
					end
					prevPos = currentPos
				end
			else
				pickTimer = pickTimer - 1
			end
		end
		for k,v in ipairs(spawnedPlantTable) do
			if not DoesEntityExist(v) then
				table.remove(spawnedPlantTable, k)
			end
		end
		Citizen.Wait(sleep)
	end
end)
local isIncar = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)


		if(IsPedInAnyVehicle(PlayerPedId())) then --isplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), 0))))
							isIncar = true
					--	end
					--end
			
		else
			isIncar = false
		end

	end
end)
Citizen.CreateThread(function()
	while ESX == nil or PlayerData.job == nil do Citizen.Wait(10) end
	local sleep
    while true do
		sleep = 500
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		local currentDrug, currentZone
		inMarker, hasExited = false
		for k,v in pairs(Config.Drugs) do
			if shouldDraw(v.job) then
				if v.coords ~= nil then
					local dis = #(pos - v.coords)
					if dis < v.drawdistance then
						inMarker, atPlant = false, false
						if v.markertype ~= -1 then
							sleep = 5
							DrawMarker(v.markertype, v.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.zonesize.x, v.zonesize.y, v.zonesize.z, v.markercolor.x, v.markercolor.y, v.markercolor.z, v.alpha, false, true, 2, false, false, false, false)
						end
						if dis < v.zonesize.x then
							inMarker, currentDrugData, currentDrug, currentZone = true, v, k, v.coords
						end
						if v.prop ~= nil then
							local object = GetClosestObjectOfType(pos, 3.0, GetHashKey(v.prop), false, false, false)
							if DoesEntityExist(object) then
								local objCoords = GetEntityCoords(object)
								local distance  = #(pos - objCoords)
								closestDistance = -1
								closestPlant = nil
								if closestDistance == -1 or closestDistance > distance then
									closestDistance = distance
									closestPlant   = object
								end
							end
							if closestDistance ~= -1 and closestDistance <= 1.5 then
								atPlant = true
							else
								atPlant = false
							end
						end
					end
				end
			end
		end
		if currentAction then
			sleep = 5
			local text = currentMsg
			if currentDrugData.maxSpawn ~= nil then
				if spawnedPlants < currentDrugData.maxSpawn then
					if currentDrugData.prop ~= nil and currentDrugData.coords ~= nil then
						CreatePlant(currentDrugData.prop, currentDrugData.coords, currentDrugData.zonesize.x)
					end
				end
				if pickTimer > 0 then
					text = Config.Strings.tiredHands:format(secondsToClock(pickTimer))
					DisableControlAction(0, 51)
				else
					text = currentMsg
				end
			end
			DrawGenericTextThisFrame()
			SetTextEntry("STRING")
			AddTextComponentString(text)
			DrawText(0.5, 0.8)
			if IsControlJustReleased(0, 51) and not busy and not isIncar then
				ESX.TriggerServerCallback('TRP-Drugs:areEnoughCopsOn', function(isEnough)
					if isEnough then
							busy = true
						if currentDrugData.maxSpawn ~= nil then
							if currentPlant ~= nil then
								ESX.TriggerServerCallback('TRP-Drugs:getItemAmount', function(amount, canPickUp)
									if canPickUp then
										if currentDrugData.reqitem ~= nil then
											ESX.TriggerServerCallback('TRP-Drugs:getItemAmount', function(amount2, canPickUp2)
												if amount2 > 0 then
													PickPlant(currentPlant)
												else
													Notify(Config.Strings.harvestItem:format(currentDrugData.reqitemname,currentDrugData.label))
													busy = false
												end
											end, currentDrugData.reqitem)
										else
											PickPlant(currentPlant)
										end
									else
										Notify(Config.Strings.cantCarry:format(currentDrugData.label))
										busy = false
									end
								end, currentDrugData.name)
							else
								Notify(Config.Strings.closerTo:format(currentDrugData.label))
								busy = false
							end
						else
							ESX.TriggerServerCallback('TRP-Drugs:getItemAmount', function(amount, canPickUp)
								if canPickUp then
									ESX.TriggerServerCallback('TRP-Drugs:getItemAmount', function(amount2, canPickUp2)
										if amount2 >= currentDrugData.cost then
											if currentDrugData.reqitem ~= nil then
												ESX.TriggerServerCallback('TRP-Drugs:getItemAmount', function(amount3, canPickUp3)
													if amount3 > 0 then
														ConvertTo(ped, currentDrugData.coords, currentDrugData.heading, currentDrugData.shouldTP)
													else
														Notify(Config.Strings.processItem:format(currentDrugData.reqitemname,currentDrugData.label))
														busy = false
													end
												end, currentDrugData.reqitem)
											else
												ConvertTo(ped, currentDrugData.coords, currentDrugData.heading, currentDrugData.shouldTP)
											end
										else
											Notify(Config.Strings.missingLastdrug:format(currentDrugData.cost,Config.Drugs[currentDrugData.lastdrug].label,currentDrugData.label))
											busy = false
										end
									end, currentDrugData.lastdrug)
								else
									Notify(Config.Strings.cantCarry:format(currentDrugData.label))
									busy = false
								end
							end, currentDrugData.name)
						end
					else
						Notify('Non posso eseguirlo adesso')
					end
				end, currentDrug, false)
			end
		end
		if busy then
			sleep = 5
			DisableAllControlActions(0)
			for i = 0,6 do
				EnableControlAction(0, i)
			end
		end
		if inMarker and not alreadyEntered or (inMarker and (lastDrug ~= currentDrug or lastZone ~= currentZone)) then
			alreadyEntered = true
			lastDrug       = currentDrug
			lastZone       = currentZone
			TriggerEvent('TRP-Drugs:hasEnteredMarker')
		end
		if not hasExited and not inMarker and alreadyEntered then
			alreadyEntered = false
			TriggerEvent('TRP-Drugs:hasExitedMarker')
		end
		if atPlant and not hasPlant or (atPlant and lastPlant ~= closestPlant) then
			hasPlant = true
			lastPlant = closestPlant
			TriggerEvent('TRP-Drugs:hasEnteredEntityZone', lastPlant)
		end
		if not stepAway and not atPlant and hasPlant then
			hasPlant = false
			TriggerEvent('TRP-Drugs:hasExitedEntityZone', lastPlant)
		end
        Citizen.Wait(sleep)
    end
end)

hasBlacklistJob = function()
	local worker = false
	for k,v in pairs(Config.Jobs) do
		if Config.JobOptions.BlacklistTables[k] then
			for i = 1,#v do
				if PlayerData.job.name == v[i] then
					worker = true
				end
			end
		end
	end
	return worker
end

hasGangJob = function()
	local worker = false
	for i = 1,#Config.Jobs.Gangs do
		if PlayerData.job.name == Config.Jobs.Gangs[i] then
			worker = true
		elseif Config.SodyClubs then
			if PlayerData.gang == Config.Jobs.Gangs[i] then
				worker = true
			end
		end
	end
	return worker
end

shouldDraw = function(job)
	if not PlayerData.job then
		return
	end
	local needsDraw = true
	if Config.JobOptions.OnlyNamed then
		needsDraw = false
		if job ~= nil then
			if PlayerData.job.name == job then
				needsDraw = true
			elseif PlayerData.gang == job then
				needsDraw = true
			end
		else
			needsDraw = true
			if Config.JobOptions.NotAllowBlacklist then
				if hasBlacklistJob() then
					needsDraw = false
				end
			end
		end
	else
		if Config.JobOptions.NotAllowBlacklist then
			if hasBlacklistJob() then
				needsDraw = false
			end
		end
	end
	return needsDraw
end

Notify = function(text, timer)
	if timer == nil then
		timer = 5000
	end
	-- exports['mythic_notify']:DoCustomHudText('inform', text, timer)
	-- exports.pNotify:SendNotification({layout = 'centerLeft', text = text, type = 'error', timeout = timer})
	ESX.ShowNotification(text)
end

DrawGenericTextThisFrame = function()
	SetTextFont(4)
	SetTextProportional(0)
	SetTextScale(0.0, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)
end

secondsToClock = function(seconds)
	local seconds, hours, mins, secs = tonumber(seconds), 0, 0, 0

	if seconds <= 0 then
		return 0, 0
	else
		local hours = string.format("%02.f", math.floor(seconds / 3600))
		local mins = string.format("%02.f", math.floor(seconds / 60 - (hours * 60)))
		local secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60))

		return mins..':'..secs
	end
end

CreateBlip = function(coords, text, color, sprite, alpha, scale, display, radius)
	local blip
	if radius ~= nil then
		blip = AddBlipForRadius(coords, radius)
		SetBlipHighDetail(blip, true)
		SetBlipColour(blip, color)
		SetBlipDisplay(blip, 5)
		SetBlipAlpha (blip, 128)
		SetBlipAsShortRange(blip, true)
	end
    blip = AddBlipForCoord(coords)

    SetBlipSprite (blip, sprite)
	SetBlipDisplay(blip, display)
	SetBlipScale  (blip, scale)
	SetBlipColour (blip, color)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)
	table.insert(drugBlips, blip)
end

GetCoordZ = function(x, y, z)
	local groundCheckHeights = {}
	for i = 1,10 do
		table.insert(groundCheckHeights, (z + i))
		table.insert(groundCheckHeights, (z - i))
	end

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end
	return z
end

CreatePlant = function(plant, pos, radius)
	local plantCoords
	local plantCoordX, plantCoordY

	local modX = math.random(-20, 20)
	local modY = math.random(-20, 20)
	
	plantCoordX = pos.x + modX
	plantCoordY = pos.y + modY
	
	
	local coordZ = GetCoordZ(plantCoordX, plantCoordY, pos.z)
	while coordZ == nil do
		Citizen.Wait(1)
	end
	plantCoords = vector3(plantCoordX, plantCoordY, coordZ)
	local dis = #(plantCoords - pos)
	if dis > (radius/3) then
		return
	end
	for k, v in ipairs(spawnedPlantTable) do
		local entity = GetEntityCoords(v)
		dis = #(plantCoords - entity)
		if dis < 2 then
			return
		end
	end
	SpawnPlant(plant, plantCoords)
end

SpawnPlant = function(plant, pos)
	Citizen.CreateThread(function()
		ESX.Game.SpawnLocalObject(plant, pos, function(obj)
			while not HasCollisionLoadedAroundEntity(obj) do Citizen.Wait(10) end
			PlaceObjectOnGroundProperly(obj)
			SetEntityCollision(obj, false, false)
			FreezeEntityPosition(obj, true)

			table.insert(spawnedPlantTable, obj)
			spawnedPlants = spawnedPlants + 1
		end)
	end)
end

PickPlant = function(id)
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	local dict = currentDrugData.dict
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
	TaskPlayAnim(ped, dict, currentDrugData.anim, currentDrugData.blendIn, currentDrugData.blendOut, currentDrugData.delay, currentDrugData.animFlag, currentDrugData.playBack, false, false, false)
	Citizen.Wait(currentDrugData.delay)
	math.randomseed(GetGameTimer())
	local roll = math.random(Config.PlantTimer.mini, Config.PlantTimer.maax)
	pickTimer = roll
	TriggerServerEvent('TRP-Drugs:pickedUpPlant', currentDrugData.name, currentDrugData.maxPick)
	RemoveAnimDict(dict)
	NetworkRequestControlOfEntity(id)
	DeleteObject(id)
	spawnedPlants = spawnedPlants - 1
	busy = false
end

ConvertTo = function(ped, pos, hed, shouldTP)
	if shouldTP ~= nil and shouldTP == true then
		SetEntityCoords(ped, pos)
		SetEntityHeading(ped, hed)
	end
	local dict = currentDrugData.dict
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
	TaskPlayAnim(ped, dict, currentDrugData.anim, currentDrugData.blendIn, currentDrugData.blendOut, currentDrugData.delay, currentDrugData.animFlag, currentDrugData.playBack, false, false, false)
	TriggerServerEvent('TRP-Drugs:convertTo', currentDrugData)
	Citizen.Wait(currentDrugData.delay)
	RemoveAnimDict(dict)
	busy = false
end

CraftMeth = function(ped, veh)
	local dict = currentDrugData.dict
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Citizen.Wait(1)
	end
	while not HasNamedPtfxAssetLoaded('core') do
		RequestNamedPtfxAsset('core')
		Citizen.Wait(1)
	end
	SetEntityVisible(ped, false, 0)
	UseParticleFxAsset('core')
	local vanSmoke = StartParticleFxLoopedOnEntity('ent_amb_smoke_foundry', veh, 0.0, -2.0, 0.5, 0.0, 0.0, 0.0, 1.0, 1.0, 0.1, false, false, false)
	SetParticleFxLoopedColour(vanSmoke, 255, 255, 255, 0)
	TaskPlayAnim(ped, dict, currentDrugData.anim, currentDrugData.blendIn, currentDrugData.blendOut, currentDrugData.delay, currentDrugData.animFlag, currentDrugData.playBack, false, false, false)
	TriggerServerEvent('TRP-Drugs:convertTo', currentDrugData)
	Citizen.CreateThread(function()
		local bombTicks = 0
		while not IsEntityVisible(ped) do
			Citizen.Wait(5)
			if IsControlReleased(0, 51) then
				bombTicks = bombTicks + 1
				if bombTicks >= 500 then
					NetworkRequestControlOfEntity(veh)
					NetworkExplodeVehicle(veh, true, false, 0)
					TriggerServerEvent('TRP-Drugs:cancelProcessing')
					break
				end
			end
			DrawGenericTextThisFrame()
			SetTextEntry("STRING")
			AddTextComponentString(currentDrugData.message)
			DrawText(0.5, 0.8)
		end
		StopParticleFxLooped(vanSmoke, 0)
		RemoveAnimDict(dict)
		SetEntityVisible(ped, true, 0)
		busy = false
		currentDrugData = {}
	end)
	Citizen.Wait(currentDrugData.delay)
	StopParticleFxLooped(vanSmoke, 0)
	RemoveAnimDict(dict)
	SetEntityVisible(ped, true, 0)
	busy = false
	currentDrugData = {}
end

CraftCrack = function(ped)
	local dict = currentDrugData.dict
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Citizen.Wait(1)
	end
	local model1 = GetHashKey('prop_ld_flow_bottle')
	local pedHand = GetPedBoneIndex(ped, 58867)
	while not HasModelLoaded(model1) do
		RequestModel(model1)
		Citizen.Wait(1)
	end
	local drugBottle = CreateObjectNoOffset(model1, 0.0, 0.0, 0.0, true, true, false)
	AttachEntityToEntity(drugBottle, ped, pedHand, 0.0, 0.05, 0.0, 0.0, 0.0, 0.0, false, false, false, true, 2, true)
	TriggerServerEvent('TRP-Drugs:convertTo', currentDrugData)
	Citizen.CreateThread(function()
		while IsEntityAttachedToEntity(drugBottle, ped) do
			Citizen.Wait(500)
			TaskPlayAnim(ped, dict, currentDrugData.anim, currentDrugData.blendIn, currentDrugData.blendOut, currentDrugData.delay, currentDrugData.animFlag, currentDrugData.playBack, false, false, false)
			Citizen.Wait(500)
			ClearPedTasks(ped)
		end
	end)
	Citizen.CreateThread(function()
		local bombTicks = 0
		while IsEntityAttachedToEntity(drugBottle, ped) do
			Citizen.Wait(5)
			DrawGenericTextThisFrame()
			SetTextEntry("STRING")
			AddTextComponentString(currentDrugData.message)
			DrawText(0.5, 0.8)
			if IsControlReleased(0, 21) or IsControlReleased(0, 32) then
				bombTicks = bombTicks + 1
				if bombTicks >= 500 then
					Notify(Config.Strings.notEnoughMixxy)
					TriggerServerEvent('TRP-Drugs:cancelProcessing')
					break
				end
			end
		end
		DeleteEntity(drugBottle)
		RemoveAnimDict(dict)
		SetModelAsNoLongerNeeded(model1)
		busy = false
		currentDrugData = {}
	end)
	Citizen.Wait(currentDrugData.delay)
	DeleteEntity(drugBottle)
	RemoveAnimDict(dict)
	SetModelAsNoLongerNeeded(model1)
	busy = false
	currentDrugData = {}
end

ModelIsUsable = function(model)
	local usable = false
	for i = 1,#Config.UsableCraftModels do
		if model == GetHashKey(Config.UsableCraftModels[i]) then
			usable = true
		end
	end
	return usable
end

RollMenu = function()
	ESX.UI.Menu.CloseAll()
	local dTab = Config.Drugs['blunt']
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'rolling', {
		title    = Config.Strings.rollTitle,
		align    = Config.MenuAlign,
		elements = {
			{label = Config.Strings.jointLabel, value = 'joint'},
			{label = Config.Strings.bluntLabel, value = 'blunt'}
		}
	}, function(data, menu)
		local info = {}
		local drug = data.current.value
		local count, druglabel
		if drug == 'joint' then
			count = 2
			druglabel = Config.Strings.jointLabel
		else
			count = 1
			druglabel = Config.Strings.bluntLabel
		end
		table.insert(info, {name = drug, label = druglabel, reward = count, lastdrug = 'marijuana', delay = dTab.delay, cost = 1, reqitem = 'bluntwrap', reqitemname = Config.Strings.wrapLabel, reqitemremove = true})
		local ped = PlayerPedId()
		local dict = dTab.dict
		RequestAnimDict(dict)
		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(1)
		end
		busy = true
		menu.close()
		TaskPlayAnim(ped, dict, dTab.anim, dTab.blendIn, dTab.blendOut, dTab.delay, dTab.animFlag, dTab.playBack, false, false, false)
		TriggerServerEvent('TRP-Drugs:convertTo', info[1])
		Citizen.Wait(20000)
		RemoveAnimDict(dict)
		busy = false
	end, function(data, menu)
		menu.close()
	end)
end

RunDrugDeal = function(ped, drug, pos)
	if dealing == true then
		math.randomseed(GetGameTimer())
		local model = GetHashKey(Config.SellableDrugs[drug.name].peds[math.random(1,#Config.SellableDrugs[drug.name].peds)])
		RequestModel(model)
		while not HasModelLoaded(model) do Citizen.Wait(10) end
		local buyer = CreatePed(2, model, pos.x, pos.y, pos.z, 0.0, true, true)
		local willCall, willRob
		if DoesEntityExist(buyer) then
			TaskGotoEntityOffsetXy(buyer, ped, -1, 3.0, 0.0, 0.0, 1.25, 0)
			ClearPedTasks(ped)
			local blip = AddBlipForEntity(buyer)
			SetBlipDisplay(blip, 5)
			SetBlipScale  (blip, 0.85)
			SetBlipColour (blip, 2)
			SetBlipAsShortRange(blip, false)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Config.Strings.buyerBlipText)
			EndTextCommandSetBlipName(blip)
			while true do
				Citizen.Wait(5)
				local pedSpot, playerSpot = GetEntityCoords(buyer), GetEntityCoords(ped)
				local dis = #(pedSpot - playerSpot)
				currentMsg = Config.Strings.onTheirWayText
				if dis <= 3.0 then
					break
				end
				if IsControlJustReleased(0, 51) then
					DeleteEntity(buyer)
					dealing = false
					break
				end
			end
			if DoesEntityExist(buyer) then
				if Config.SellableDrugs[drug.name].canCall then
					math.randomseed(GetGameTimer())
					local chance = math.random(100)
					if chance <= Config.SellableDrugs[drug.name].callChance then
						willCall = true
					end
				end
				if Config.SellableDrugs[drug.name].canRob then
					math.randomseed(GetGameTimer())
					local chance = math.random(100)
					if chance <= Config.SellableDrugs[drug.name].robChance then
						willRob = true
					end
				end
				if willRob then
					TaskCombatPed(buyer, ped, 0, 16)
					Citizen.Wait(2500)
					SetPedToRagdoll(ped, 4000, 4000, 0, true, true, true)
					DoScreenFadeOut(10)
					ClearPedTasks(buyer)
					SetPedAsNoLongerNeeded(buyer)
					Citizen.Wait(4000)
					DeleteEntity(buyer)
					TriggerServerEvent('TRP-Drugs:soldDrugs', drug, 0, 0, true)
					DoScreenFadeIn(1000)
					Notify(Config.Strings.drugsWereStole:format(drug.label))
					dealing = false
				elseif willCall then
					TaskStartScenarioInPlace(buyer, 'WORLD_HUMAN_STAND_MOBILE', 0, false)
					Citizen.Wait(2000)
					ClearPedTasks(buyer)
					SetPedAsNoLongerNeeded(buyer)
					TriggerServerEvent('TRP-Drugs:copsCalled')
					dealing = false
				end
				if not willCall and not willRob then
					math.randomseed(GetGameTimer())
					local roll = math.random(drug.count)
					if roll > Config.SellableDrugs[drug.name].maxAmount then
						roll = Config.SellableDrugs[drug.name].maxAmount
					end
					local price = math.random(Config.SellableDrugs[drug.name].minPrice, Config.SellableDrugs[drug.name].maxPrice) * roll
					Notify(Config.Strings.buyerWantsDrug:format(roll,drug.label,price))
					Citizen.CreateThread(function()
						while true do
							Citizen.Wait(5)
							if not dealing then
								break
							end
							local plyPos = GetEntityCoords(ped)
							local pedPos = GetEntityCoords(buyer)
							local dis = #(plyPos - pedPos)
							if dis > 3.0 then
								ESX.UI.Menu.CloseAll()
								roll = math.random(5)
								if roll == 5 then
									TaskStartScenarioInPlace(buyer, 'WORLD_HUMAN_STAND_MOBILE', 0, false)
									Citizen.Wait(2000)
									ClearPedTasks(buyer)
									TriggerServerEvent('TRP-Drugs:copsCalled')
								end
								SetPedAsNoLongerNeeded(buyer)
								Notify(Config.Strings.walkedTooFar)
								dealing = false
								break
							end
						end
					end)
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_sale',
					{
						title    = Config.Strings.confirmSale:format(roll,drug.label,price),
						align    = Config.MenuAlign,
						elements = {{label = Config.Strings.acceptSaleText, value = 'yes'}, {label = Config.Strings.declineSaleTxt, value = 'no'}}
					}, function(data, menu)
						if data.current.value == 'yes' then
							menu.close()
							dealing = false
							local lib = 'mp_common'
							local model1 = GetHashKey('prop_coke_block_half_a')
							local model2 = GetHashKey('prop_anim_cash_pile_01')
							local pedHand, buyHand = GetPedBoneIndex(ped, 58867), GetPedBoneIndex(buyer, 58867)
							if not HasAnimDictLoaded(lib) then
								ticks[lib] = 0
								while not HasAnimDictLoaded(lib) do
									ESX.ShowHelpNotification(Config.Strings.requestingAnim)
									DisableAllControlActions(0)
									RequestAnimDict(lib)
									Citizen.Wait(1)
									ticks[lib] = ticks[lib] + 1
									if ticks[lib] >= 500 then
										ticks[lib] = 0
										ESX.ShowHelpNotification(Config.Strings.animFaild2Load:format(lib))
										return
									end
								end
							end
							if not HasModelLoaded(model1) then
								ticks[model1] = 0
								while not HasModelLoaded(model1) do
									ESX.ShowHelpNotification(Config.Strings.requestingModl)
									DisableAllControlActions(0)
									RequestModel(model1)
									Citizen.Wait(1)
									ticks[model1] = ticks[model1] + 1
									if ticks[model1] >= 500 then
										ticks[model1] = 0
										ESX.ShowHelpNotification(Config.Strings.modelFail2Load:format(model1))
										return
									end
								end
							end
							if not HasModelLoaded(model2) then
								ticks[model2] = 0
								while not HasModelLoaded(model2) do
									ESX.ShowHelpNotification(Config.Strings.requestingModl)
									-- DisableAllControlActions(0)
									RequestModel(model2)
									Citizen.Wait(1)
									ticks[model2] = ticks[model2] + 1
									if ticks[model2] >= 500 then
										ticks[model2] = 0
										ESX.ShowHelpNotification(Config.Strings.modelFail2Load:format(model2))
										return
									end
								end
							end
							TaskTurnPedToFaceEntity(ped, buyer, 1500)
							TaskTurnPedToFaceEntity(buyer, ped, 1500)
							Citizen.Wait(1500)
							AttachEntityToEntity(ped, buyer, 0, 0.0, 1.0, 0.0, 0.0, 0.0, 180.0, false, false, false, true, 2, true)
							DetachEntity(ped, true, true)
							local drugBag = CreateObjectNoOffset(model1, pos.x, pos.y, pos.z, true, true, false)
							AttachEntityToEntity(drugBag, ped, pedHand, 0.05, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, true, 2, true)
							local cashStack = CreateObjectNoOffset(model2, 0.0, 0.0, 0.0, true, true, false)
							AttachEntityToEntity(cashStack, buyer, buyHand, 0.05, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
							TaskPlayAnim(ped, lib, 'givetake1_a', 8.0, -8.0, 2000, 1, 0.0, false, false, false)
							TaskPlayAnim(buyer, lib, 'givetake1_a', 8.0, -8.0, 2000, 1, 0.0, false, false, false)
							Citizen.Wait(1000)
							DetachEntity(drugBag)
							DetachEntity(cashStack)
							AttachEntityToEntity(drugBag, buyer, buyHand, 0.05, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
							AttachEntityToEntity(cashStack, ped, pedHand, 0.05, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
							TriggerServerEvent('TRP-Drugs:soldDrugs', drug, roll, price)
							Citizen.Wait(2000)
							DeleteEntity(drugBag)
							DeleteEntity(cashStack)
							SetPedAsNoLongerNeeded(buyer)
							RemoveAnimDict(lib)
							SetModelAsNoLongerNeeded(model1)
							SetModelAsNoLongerNeeded(model2)
						else
							menu.close()
							dealing = false
							roll = math.random(5)
							if roll == 5 then
								TaskStartScenarioInPlace(buyer, 'WORLD_HUMAN_STAND_MOBILE', 0, false)
								Citizen.Wait(2000)
								ClearPedTasks(buyer)
								TriggerServerEvent('TRP-Drugs:copsCalled')
							end
							SetPedAsNoLongerNeeded(buyer)
						end
					end, function(data, menu)
					end)
				end
				RemoveBlip(blip)
			end
		else
			Notify(Config.Strings.creationFailur)
		end
	end
end

AttemptDrugSale = function(ped, drug)
	dealing = true
	currentMsg = Config.Strings.checkForBuyers
	TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_STAND_MOBILE', 0, false)
	Citizen.CreateThread(function()
		while dealing do
			Citizen.Wait(0)
			ESX.ShowHelpNotification(currentMsg)
			if IsControlJustReleased(0, 51) then
				dealing = false
			end
		end
		ClearPedTasks(ped)
	end)
	Citizen.Wait(math.random(5000, 10000))
	if dealing then
		local pos = GetEntityCoords(ped)
		math.randomseed(GetGameTimer())
		local roll, var = math.random(4), math.random(50)
		local x, y = var * 1.0, var * 1.0
		if roll == 1 then
			x = -x
		elseif roll == 2 then
			y = -y
		elseif roll == 3 then
			x = -x
			y = -y
		end
		local pedOffset = GetOffsetFromEntityInWorldCoords(ped, x, y, 0.0)
		local coordZ = GetCoordZ(pedOffset.x, pedOffset.y, pedOffset.z)
		while coordZ == nil do
			Citizen.Wait(1)
		end
		local pedSpot = vector3(pedOffset.x, pedOffset.y, coordZ)
		local dis = #(pos - pedSpot)
		if dis >= 15.0 and dis <= 100.0 then
			RunDrugDeal(ped, drug, pedSpot)
		else
			Notify(Config.Strings.nobodyWantedIt)
			dealing = false
		end
	end
end

InDrugZone = function(drug)
	local inZone = false
	local zoneIn = GetNameOfZone(GetEntityCoords(PlayerPedId()))
	for i = 1,#Config.SellableDrugs[drug].zones do
		if zoneIn == Config.SellableDrugs[drug].zones[i] then
			inZone = true
		end
	end
	return inZone
end

AddEventHandler('TRP-Drugs:hasEnteredMarker', function()
	drug = currentDrugData.name
	label = currentDrugData.label
	currentMsg = currentDrugData.message
	currentAction = currentDrugData.action
end)

AddEventHandler('TRP-Drugs:hasExitedMarker', function()
	ESX.UI.Menu.CloseAll()

	currentAction = nil
	currentMsg	  = nil
	currentDrugData = {}
	for k,v in ipairs(spawnedPlantTable) do
		DeleteObject(v)
		spawnedPlants = spawnedPlants - 1
	end
	hasExited = true
end)

AddEventHandler('TRP-Drugs:hasEnteredEntityZone', function(entity)
	currentPlant = entity
end)

AddEventHandler('TRP-Drugs:hasExitedEntityZone', function(entity)
	currentPlant = nil
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
		while ESX == nil do Citizen.Wait(10) end
        ESX.UI.Menu.CloseAll()
		for k,v in ipairs(spawnedPlantTable) do
			DeleteObject(v)
			spawnedPlants = spawnedPlants - 1
		end
    end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function()
	while ESX == nil do Citizen.Wait(10) end
	PlayerData = ESX.GetPlayerData()
	if Config.SodyClubs then
		ESX.TriggerServerCallback('TRP-Drugs:getPlayerData', function(xPlayer)
			PlayerData.gang = xPlayer.gang
		end)
		while PlayerData.gang == nil do Citizen.Wait(10) end
	end
end)

RegisterNetEvent('TRP-Drugs:getZones')
AddEventHandler('TRP-Drugs:getZones', function(drugs)
	for i = 1,#drugBlips do
		RemoveBlip(drugBlips[i])
	end
	Config.Drugs = drugs
	for k,v in pairs(Config.Drugs) do
		if v.sprite ~= -1 then
			if shouldDraw(v.job) then
				if v.prop ~= nil then
					CreateBlip(v.coords, v.label, v.color, v.sprite, v.alpha, v.scale, v.display, v.zonesize.x)
				else
					CreateBlip(v.coords, v.label, v.color, v.sprite, v.alpha, v.scale, v.display)
				end
			end
		end
		if v.ped ~= nil then
			local model = GetHashKey(v.ped)
			RequestModel(model)
			while not HasModelLoaded(model) do
				Citizen.Wait(1)
			end
			local npc = CreatePed(1, model, v.pedpos.x, v.pedpos.y, v.pedpos.z, v.pedpos.w, false, true)
			SetBlockingOfNonTemporaryEvents(npc, true)
			SetPedDiesWhenInjured(npc, false)
			SetPedCanPlayAmbientAnims(npc, true)
			SetPedCanRagdollFromPlayerImpact(npc, false)
			SetEntityInvincible(npc, true)
			FreezeEntityPosition(npc, true)
			RequestAnimDict(v.dict)
			while not HasAnimDictLoaded(v.dict) do Citizen.Wait(1) end
			TaskPlayAnim(npc, v.dict, v.anim, 8.0, -8.0, -1, 1, 1.0, false, false, false)
			SetPedKeepTask(npc, true)
			RemoveAnimDict(v.dict)
		end
	end
	if currentDrugData.name ~= nil then
		alreadyEntered = false
		TriggerEvent('TRP-Drugs:hasExitedMarker')
	end
end)

RegisterNetEvent('TRP-Drugs:useItem')
AddEventHandler('TRP-Drugs:useItem', function(itemName)
	while ESX == nil do Citizen.Wait(10) end
    ESX.UI.Menu.CloseAll()
    if itemName == 'marijuana' then
		RollMenu()
    end
end)

RegisterNetEvent('TRP-Drugs:callCops')
AddEventHandler('TRP-Drugs:callCops', function(target)
	while ESX == nil do Citizen.Wait(10) end
	local targetPlayer = GetPlayerPed(GetPlayerFromServerId(target))
	local mugshot, mugstring = ESX.Game.GetPedMugshot(targetPlayer)
	ESX.ShowAdvancedNotification(Config.Strings.dealerReport, Config.Strings.descriptAdded, '', mugstring, 1)
	local blip = AddBlipForEntity(targetPlayer)
	SetBlipDisplay(blip, 3)
	SetBlipScale  (blip, 0.85)
	SetBlipColour (blip, 1)
	SetBlipAsShortRange(blip, false)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(Config.Strings.dealerBlipText)
	EndTextCommandSetBlipName(blip)
	Citizen.Wait(60000)
	RemoveBlip(blip)
end)

RegisterCommand(Config.Strings.sellCommand, function(raw)
	while ESX == nil do Citizen.Wait(10) end
	if dealing then
		return
	end
	local ped = PlayerPedId()
	if (not IsPedOnFoot(ped)) or IsPedFalling(ped) or IsPedDeadOrDying(ped) then
		return
	end
	ESX.TriggerServerCallback('TRP-Drugs:getPlayerDrugs', function(drugs)
		if #drugs > 0 then
			local elements = {}
			for k,v in ipairs(drugs) do
				table.insert(elements, {label = v.label, value = v, name = v.name})
			end
			ESX.UI.Menu.CloseAll()
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'choose_drug',
			{
				title = Config.Strings.chooseDrug2Sell,
				align = Config.MenuAlign,
				elements = elements
			}, function(data, menu)
				ESX.TriggerServerCallback('TRP-Drugs:areEnoughCopsOn', function(isEnough)
					if isEnough then
						if Config.SellableDrugs[data.current.name].noJobs then
							if not hasGangJob() and not hasBlacklistJob() then
								local canSell = InDrugZone(data.current.name)
								if canSell then
									menu.close()
									AttemptDrugSale(ped, data.current.value)
								else
									Notify(Config.Strings.notInRightArea)
								end
							else
								Notify(Config.Strings.nobodyWantedIt)
							end
						else
							if not hasBlacklistJob() then
								local canSell = InDrugZone(data.current.name)
								if canSell then
									menu.close()
									AttemptDrugSale(ped, data.current.value)
								else
									Notify(Config.Strings.notInRightArea)
								end
							else
								Notify(Config.Strings.nobodyWantedIt)
							end
						end
					else
						Notify(Config.Strings.nobodyWantedIt)
					end
				end, data.current.name, true)
			end, function(data, menu)
				menu.close()
			end)
		else
			Notify(Config.Strings.youHaveNoDrugs)
		end
	end)
end)

RegisterCommand(Config.Strings.craftMethCommand, function(raw)
	while ESX == nil do Citizen.Wait(10) end
	local ped = PlayerPedId()
	if shouldDraw(Config.Drugs['meth'].job) then
		if IsPedInAnyVehicle(ped, false) then
			local veh = GetVehiclePedIsIn(ped, false)
			if DoesEntityExist(veh) then
				if ModelIsUsable(GetEntityModel(veh)) then
					if GetPedInVehicleSeat(veh, -1) == ped then
						currentDrugData = Config.Drugs['meth']
						ESX.TriggerServerCallback('TRP-Drugs:getItemAmount', function(amount, canPickUp)
							if canPickUp then
								ESX.TriggerServerCallback('TRP-Drugs:getItemAmount', function(amount2, canPickUp2)
									if amount2 >= currentDrugData.cost then
										if currentDrugData.reqitem ~= nil then
											ESX.TriggerServerCallback('TRP-Drugs:getItemAmount', function(amount3, canPickUp3)
												if amount3 > 0 then
													if GetEntitySpeed(veh) <= 0.15 then
														CraftMeth(ped, veh)
													else
														Notify(Config.Strings.moveTooQuickly)
													end
												else
													Notify(Config.Strings.processItem:format(currentDrugData.reqitemname,currentDrugData.label))
													busy = false
													currentDrugData = {}
												end
											end, currentDrugData.reqitem)
										end
									else
										Notify(Config.Strings.missingLastdrug:format(currentDrugData.cost,Config.Drugs[currentDrugData.lastdrug].label,currentDrugData.label))
										busy = false
										currentDrugData = {}
									end
								end, currentDrugData.lastdrug)
							else
								Notify(Config.Strings.cantCarry:format(currentDrugData.label))
								busy = false
								currentDrugData = {}
							end
						end, currentDrugData.name)
					else
						Notify(Config.Strings.uMustBeDriving)
					end
				end
			end
		else
			Notify(Config.Strings.uMustBeDriving)
		end
	else
		Notify(Config.Strings.youCannotDoTht)
	end
end)

RegisterCommand(Config.Strings.craftCrackCommand, function(raw)
	while ESX == nil do Citizen.Wait(10) end
	local ped = PlayerPedId()
	if shouldDraw(Config.Drugs['crack'].job) then
		if IsPedOnFoot(ped) or (not IsPedFalling(ped)) or (not IsPedDeadOrDying(ped)) then
			currentDrugData = Config.Drugs['crack']
			ESX.TriggerServerCallback('TRP-Drugs:getItemAmount', function(amount, canPickUp)
				if canPickUp then
					ESX.TriggerServerCallback('TRP-Drugs:getItemAmount', function(amount2, canPickUp2)
						if amount2 >= currentDrugData.cost then
							if currentDrugData.reqitem ~= nil then
								ESX.TriggerServerCallback('TRP-Drugs:getItemAmount', function(amount3, canPickUp3)
									if amount3 > 0 then
										CraftCrack(ped)
									else
										Notify(Config.Strings.processItem:format(currentDrugData.reqitemname,currentDrugData.label))
										busy = false
										currentDrugData = {}
									end
								end, currentDrugData.reqitem)
							end
						else
							Notify(Config.Strings.missingLastdrug:format(currentDrugData.cost,Config.Drugs[currentDrugData.lastdrug].label,currentDrugData.label))
							busy = false
							currentDrugData = {}
						end
					end, currentDrugData.lastdrug)
				else
					Notify(Config.Strings.cantCarry:format(currentDrugData.label))
					busy = false
					currentDrugData = {}
				end
			end, currentDrugData.name)
		else
			Notify(Config.Strings.uMustBeWalking)
		end
	else
		Notify(Config.Strings.youCannotDoTht)
	end
end)

RegisterKeyMapping(Config.Strings.sellCommand, Config.Strings.commandInfo, 'keyboard', Config.Keys.Deal)