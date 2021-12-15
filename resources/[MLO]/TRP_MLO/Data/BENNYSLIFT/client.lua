
--[[local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
  return coroutine.wrap(function()
    local iter, id = initFunc()
    if not id or id == 0 then
      disposeFunc(iter)
      return
    end
    
    local enum = {handle = iter, destructor = disposeFunc}
    setmetatable(enum, entityEnumerator)
    
    local next = true
    repeat
      coroutine.yield(id)
      next, id = moveFunc(iter)
    until not next
    
    enum.destructor, enum.handle = nil, nil
    disposeFunc(iter)
  end)
end

function EnumerateVehicles()
  return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function GetCliAllVehicles()
	local ret = {}
	for veh in EnumerateVehicles() do
		table.insert(ret, veh)
	end
	return ret
end

function GetVehicleInLift(checkedCoords)
  local vehicles = GetCliAllVehicles()
  local revehicles = {}
  for i = 1, #vehicles do
	local RawPlate = GetVehicleNumberPlateText()
	local curModel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicles[i]))
	local coords = GetEntityCoords(vehicles[i])
	local diffCoords = Vdist(coords,checkedCoords.x,checkedCoords.y,checkedCoords.z)
	
	if diffCoords < 5.0 then
		--print("^2Check of : "..tostring(curModel).." coords:"..tostring(coords).." diif coords: "..tostring(diffCoords))
		table.insert(revehicles, {entity = vehicles[i], netId = NetworkGetNetworkIdFromEntity(vehicles[i])})
	else
	--	print("^1Check of : "..tostring(curModel).." coords:"..tostring(coords).." diif coords: "..tostring(diffCoords))
	end
	
  end
  return revehicles
end

local isReady = false

function DisplayHelpText(text)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentSubstringPlayerName(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

local liftData = {
	["789456"] = {
		code = "789456",
		
		controlup = {x=-230.79672241211,y=-1336.4926757813,z=30.902803421021},
		controldown = {x=-229.9367980957,y=-1336.5185546875,z=18.463350296021}, 
		
		up = {x=-224.9193,y=-1338.261,z=31.28919},
		down = {x=-224.9193,y=-1338.261,z=18.8292},
		
		offsetup = {x=-224.9193,y=-1338.261,z=31.28919-1.396},
		offsetdown = {x=-224.9193,y=-1338.261,z=18.8292-1.396},
		
		controlCabineUp = {x=-228.44960021973,y=-1340.6348876953,z=30.893201828003},
		controlCabineDown = {x=-228.94534301758,y=-1340.9337158203,z=18.523215103149},
		
		Zelevate=31.28919-18.8292,
		
		isUp = true,
		
		isInUse = false,
		
		elevateProps = "patoche_elevatorb",
		rotation = {a=0.0,b=0.0,c=0.0},
		elevateHeading = 90.0,
		elevateID = 0,
		
		downDoorIsOpen = false,
		
		doorDown = "patoche_elevatorb_door",
		doorDownCoords = {x=-229.3393, y=-1338.831, z=17.53319},
		doorDownOpenCoords = {x=-229.3393, y=-1338.831, z=20.05319},
		doorDownHeading = 90.0,
		doorDownID = 0,
		
		upDoorIsOpen = false,
		
		doorUp = "patoche_elevatorb_door",
		doorUpCoords = {x=-229.3393, y=-1338.831, z=30.00321},
		doorUpOpenCoords = {x=-229.3393, y=-1338.831, z=32.48326},
		doorUpHeading = 90.0,
		doorUpID = 0,
		
	}
}

incircle = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if isReady then
			local ped = PlayerPedId()
			local pedCoords = GetEntityCoords(ped)
			local pedDetailedCoords = {}
			pedDetailedCoords.x,pedDetailedCoords.y,pedDetailedCoords.z = table.unpack(pedCoords)
			for k,v in pairs(liftData) do
				if Vdist(pedCoords,v.controldown.x,v.controldown.y,v.controldown.z) < 30.0 or Vdist(pedCoords,v.controlup.x,v.controlup.y,v.controlup.z) < 30.0 then
					
					if not v.isInUse then
						
						local ExistElevator = false
						if DoesEntityExist(v.elevateID) then 
							ExistElevator = true 
							SetEntityVisible(v.elevateID,true)
						end
						
						if not ExistElevator then
							if not v.isUp then
								localElevateId = GetClosestObjectOfType(v.down.x,v.down.y,v.down.z,3.0,GetHashKey(v.elevateProps),false,false,false)
							else
								localElevateId = GetClosestObjectOfType(v.up.x,v.up.y,v.up.z,3.0,GetHashKey(v.elevateProps),false,false,false)
							end
							
							if localElevateId ~= 0 then 
								v.elevateID = localElevateId
							end
						end
						
						local ExistDownDoor = false
						
						if DoesEntityExist(v.doorDownID) then 
							ExistDownDoor = true 
							SetEntityVisible(v.doorDownID,true)
						end
						
						if not downDoorIsOpen then
							if not ExistDownDoor then
								localDownDoor = GetClosestObjectOfType(v.doorDownCoords.x,v.doorDownCoords.y,v.doorDownCoords.z,1.0,GetHashKey(v.doorDown),false,false,false)
								if localDownDoor ~= 0 then 
									v.doorDownID = localDownDoor
								end
							end
						else
							if not ExistDownDoor then
								localDownDoor = GetClosestObjectOfType(v.doorDownOpenCoords.x,v.doorDownOpenCoords.y,v.doorDownOpenCoords.z,1.0,GetHashKey(v.doorDown),false,false,false)
								if localDownDoor ~= 0 then 
									v.doorDownID = localDownDoor
								end
							end
						end
						
						local ExistUpDoor = false
						
						if DoesEntityExist(v.doorUpID) then 
							ExistUpDoor = true 
							SetEntityVisible(v.doorUpID,true)
						end
						
						if not upDoorIsOpen then
							if not ExistUpDoor then
								localUpDoor = GetClosestObjectOfType(v.doorUpCoords.x,v.doorUpCoords.y,v.doorUpCoords.z,1.0,GetHashKey(v.doorUp),false,false,false)
								if localUpDoor ~= 0 then 
									v.doorUpID = localUpDoor
								end
							end
						else
							if not ExistUpDoor then
								localUpDoor = GetClosestObjectOfType(v.doorUpOpenCoords.x,v.doorUpOpenCoords.y,v.doorUpOpenCoords.z,1.0,GetHashKey(v.doorUp),false,false,false)
								if localUpDoor ~= 0 then 
									v.doorUpID = localUpDoor
								end
							end
						end
						
						
						if v.elevateID == 0 then 
							tempmodel = GetHashKey(v.elevateProps)
							RequestModel(tempmodel)
							while not HasModelLoaded(tempmodel) do
								RequestModel(tempmodel)
								Citizen.Wait(0)
							end
							
							if not v.isUp then
								v.elevateID = CreateObject(tempmodel,v.down.x,v.down.y,v.offsetdown.z ,false,false,true)
							else
								v.elevateID = CreateObject(tempmodel,v.up.x,v.up.y,v.offsetup.z ,false,false,true)
							end
							
							FreezeEntityPosition(v.elevateID,true)
							SetEntityRotation(v.elevateID,v.rotation.a,v.rotation.b,v.rotation.c,0,false)
							SetEntityHeading(v.elevateID,v.elevateHeading)
						end
						
						if v.doorDownID == 0 then 
							tempmodel = GetHashKey(v.doorDown)
							RequestModel(tempmodel)
							while not HasModelLoaded(tempmodel) do
								RequestModel(tempmodel)
								Citizen.Wait(0)
							end
							if v.downDoorIsOpen then
								v.doorDownID=CreateObject(tempmodel,v.doorDownOpenCoords.x,v.doorDownOpenCoords.y,v.doorDownOpenCoords.z ,false,false,true)
							else
								v.doorDownID=CreateObject(tempmodel,v.doorDownCoords.x,v.doorDownCoords.y,v.doorDownCoords.z ,false,false,true)
							end
							FreezeEntityPosition(v.doorDownID,true)
							SetEntityHeading(v.doorDownID,v.doorDownHeading)
						end
					
						if v.doorUpID == 0 then 
							tempmodel = GetHashKey(v.doorUp)
							RequestModel(tempmodel)
							while not HasModelLoaded(tempmodel) do
								RequestModel(tempmodel)
								Citizen.Wait(0)
							end
							
							if v.upDoorIsOpen then
								v.doorUpID=CreateObject(tempmodel,v.doorUpOpenCoords.x,v.doorUpOpenCoords.y,v.doorUpOpenCoords.z ,false,false,true)
							else
								v.doorUpID=CreateObject(tempmodel,v.doorUpCoords.x,v.doorUpCoords.y,v.doorUpCoords.z ,false,false,true)
							end
							FreezeEntityPosition(v.doorUpID,true)
							SetEntityHeading(v.doorUpID,v.doorUpHeading)
						end
						
						local allVehInLift = {}
						if Vdist(pedCoords,v.controldown.x,v.controldown.y,v.controldown.z) < 1.0  then
							if (incircle == false) then
								DisplayHelpText("Appuyez sur ~INPUT_CONTEXT~ pour appeler l'ascenseur.")
							end
							incircle = true
							if IsControlJustReleased(1, 51) then
								TriggerServerEvent("bennylift:askDown",v.code)
								if v.isUp then
									allVehInLift = GetVehicleInLift(v.up)
								TriggerServerEvent("bennylift:askVehFreeze",allVehInLift,v.code)
								else
									allVehInLift = GetVehicleInLift(v.down)
								TriggerServerEvent("bennylift:askVehFreeze",allVehInLift,v.code)
								end
							end
							
						elseif Vdist(pedCoords,v.controlup.x,v.controlup.y,v.controlup.z) < 1.0 then
							if (incircle == false) then
								DisplayHelpText("Appuyez sur ~INPUT_CONTEXT~ pour appeler l'ascenseur.")
							end
							incircle = true
							if IsControlJustReleased(1, 51) then
								TriggerServerEvent("bennylift:askUp",v.code)
								if v.isUp then
									allVehInLift = GetVehicleInLift(v.up)
								TriggerServerEvent("bennylift:askVehFreeze",allVehInLift,v.code)
								else
									allVehInLift = GetVehicleInLift(v.down)
								TriggerServerEvent("bennylift:askVehFreeze",allVehInLift,v.code)
								end
							end
							
						elseif Vdist(pedCoords,v.controlCabineDown.x,v.controlCabineDown.y,v.controlCabineDown.z) < 0.7 and not v.isInUse then
							if (incircle == false) then
								DisplayHelpText("Appuyez sur ~INPUT_CONTEXT~ pour monter.")
							end
							incircle = true
							if IsControlJustReleased(1, 51) then
								TriggerServerEvent("bennylift:liftup",v.code,v.Zelevate)
								allVehInLift = GetVehicleInLift(v.down)
								TriggerServerEvent("bennylift:askVehFreeze",allVehInLift,v.code)
							end
							
						elseif Vdist(pedCoords,v.controlCabineUp.x,v.controlCabineUp.y,v.controlCabineUp.z) < 0.7 and not v.isInUse then
							if (incircle == false) then
								DisplayHelpText("Appuyez sur ~INPUT_CONTEXT~ pour descendre.")
							end
							incircle = true
							if IsControlJustReleased(1, 51) then
								TriggerServerEvent("bennylift:liftdown",v.code,v.Zelevate)
								allVehInLift = GetVehicleInLift(v.up)
								TriggerServerEvent("bennylift:askVehFreeze",allVehInLift,v.code)
							end
						else
							incircle = false
						end
					end
				end
			end
		end
	end
end)

RegisterNetEvent("bennylift:openDoorDown")
AddEventHandler('bennylift:openDoorDown', function(code)

	local Door = liftData[code].doorDownID
	
	if not liftData[code].downDoorIsOpen then
		liftData[code].downDoorIsOpen = true
		for i=0,249 do
			Wait(1)
			SetEntityCoords(Door,GetOffsetFromEntityInWorldCoords(Door,0,0,0.01))
		end
		SetEntityCoords(Door,liftData[code].doorDownOpenCoords.x,liftData[code].doorDownOpenCoords.y,liftData[code].doorDownOpenCoords.z)
	end
end)

RegisterNetEvent("bennylift:closeDoorDown")
AddEventHandler('bennylift:closeDoorDown', function(code)

	------------------
	local Door = liftData[code].doorDownID
	
	
	if liftData[code].downDoorIsOpen then
		liftData[code].downDoorIsOpen = false
		for i=0,249 do
			Wait(1)
			SetEntityCoords(Door,GetOffsetFromEntityInWorldCoords(Door,0,0,-0.01))
		end
		SetEntityCoords(Door,liftData[code].doorDownCoords.x,liftData[code].doorDownCoords.y,liftData[code].doorDownCoords.z)
	end
end)

RegisterNetEvent("bennylift:closeDoorDownIfnotBusy")
AddEventHandler('bennylift:closeDoorDownIfnotBusy', function(code)

	if not liftData[code].isInUse then
		local leftDoor = liftData[code].doorDownID
		liftData[code].downDoorIsOpen = false
		
		for i=0,249 do
			Wait(1)
			SetEntityCoords(leftDoor,GetOffsetFromEntityInWorldCoords(leftDoor,0,0,-0.010))
		end
		SetEntityCoords(leftDoor,liftData[code].doorDownCoords.x,liftData[code].doorDownCoords.y,liftData[code].doorDownCoords.z)
	end
end)

RegisterNetEvent("bennylift:openDoorUp")
AddEventHandler('bennylift:openDoorUp', function(code)

	local leftDoor = liftData[code].doorUpID
	
	if not liftData[code].upDoorIsOpen then
		liftData[code].upDoorIsOpen = true
		for i=0,249 do
			Wait(1)
			SetEntityCoords(leftDoor,GetOffsetFromEntityInWorldCoords(leftDoor,0,0,0.01))
		end
		SetEntityCoords(leftDoor,liftData[code].doorUpOpenCoords.x,liftData[code].doorUpOpenCoords.y,liftData[code].doorUpOpenCoords.z)
	end
end)

RegisterNetEvent("bennylift:closeDoorUp")
AddEventHandler('bennylift:closeDoorUp', function(code)

	local leftDoor = liftData[code].doorUpID
	
	if liftData[code].upDoorIsOpen then
		liftData[code].upDoorIsOpen = false
		for i=0,249 do
			Wait(1)
			SetEntityCoords(leftDoor,GetOffsetFromEntityInWorldCoords(leftDoor,0,0,-0.01))
		end
		SetEntityCoords(leftDoor,liftData[code].doorUpCoords.x,liftData[code].doorUpCoords.y,liftData[code].doorUpCoords.z)
	end
end)

RegisterNetEvent("bennylift:closeDoorUpIfnotBusy")
AddEventHandler('bennylift:closeDoorUpIfnotBusy', function(code)

	if not liftData[code].isInUse then
		local leftDoor = liftData[code].doorUpID
		liftData[code].upDoorIsOpen = false
		
		for i=0,249 do
			Wait(1)
			SetEntityCoords(leftDoor,GetOffsetFromEntityInWorldCoords(leftDoor,0,0,-0.01))
		end
		SetEntityCoords(leftDoor,liftData[code].doorUpCoords.x,liftData[code].doorUpCoords.y,liftData[code].doorUpCoords.z)
	end
end)

RegisterNetEvent("bennylift:up")
AddEventHandler('bennylift:up', function(code)

	local ascenseur = liftData[code].elevateID
	
	newCoords = {}
	local elevateHeight = liftData[code].Zelevate
	local nbStep = (elevateHeight * 100)/6
	liftData[code].isUp = true
	liftData[code].isInUse = true
	for i=0,nbStep do
		Wait(1)
		newCoords.x,newCoords.y,newCoords.z = table.unpack(GetEntityCoords(ascenseur))
		SetEntityCoords(ascenseur,newCoords.x,newCoords.y,newCoords.z+0.02)
	end
	SetEntityCoords(ascenseur,liftData[code].up.x,liftData[code].up.y,liftData[code].up.z)
	liftData[code].isInUse = false
end)

RegisterNetEvent("bennylift:down")
AddEventHandler('bennylift:down', function(code)

	local ascenseur = liftData[code].elevateID
	
	newCoords = {}
	local elevateHeight = liftData[code].Zelevate
	local nbStep = (elevateHeight * 100)/6
	liftData[code].isUp = false
	liftData[code].isInUse = true
	
	for i=0,nbStep do
		Wait(1)
		newCoords.x,newCoords.y,newCoords.z = table.unpack(GetEntityCoords(ascenseur))
		SetEntityCoords(ascenseur,newCoords.x,newCoords.y,newCoords.z-0.01)
	end
	SetEntityCoords(ascenseur,liftData[code].down.x,liftData[code].down.y,liftData[code].down.z+0.02)
	liftData[code].isInUse = false
end)

RegisterNetEvent("bennylift:StepUp")
AddEventHandler('bennylift:StepUp', function(code)


	local ascenseur = liftData[code].elevateID
	
	newCoords = {}
	local elevateHeight = liftData[code].Zelevate
	local nbStep = (elevateHeight * 100)/6
	liftData[code].isInUse = true
	for i=0,nbStep do
		Wait(5)
		newCoords.x,newCoords.y,newCoords.z = table.unpack(GetEntityCoords(ascenseur))
		SetEntityCoords(ascenseur,newCoords.x,newCoords.y,newCoords.z+0.01)
	end
end)

RegisterNetEvent("bennylift:upAndDoor")
AddEventHandler('bennylift:upAndDoor', function(code)

	local ascenseur = liftData[code].elevateID
	newCoords = {}
	local elevateHeight = liftData[code].Zelevate
	local nbStep = (elevateHeight * 100)/6
	liftData[code].isUp = true
	liftData[code].isInUse = true
	for i=0,nbStep do
		Wait(1)
		newCoords.x,newCoords.y,newCoords.z = table.unpack(GetEntityCoords(ascenseur))
		SetEntityCoords(ascenseur,newCoords.x,newCoords.y,newCoords.z+0.01)
	end
	
	SetEntityCoords(ascenseur,liftData[code].up.x,liftData[code].up.y,liftData[code].up.z)
	Wait(500)
	TriggerEvent("bennylift:openDoorUp",code)
	allVehInLift = GetVehicleInLift(liftData[code].up)
	TriggerServerEvent("bennylift:askVehUnFreeze",allVehInLift,code)
	Wait(2500)
	liftData[code].isInUse = false
end)

RegisterNetEvent("bennylift:StepUpAndDoor")
AddEventHandler('bennylift:StepUpAndDoor', function(code)

	local ascenseur = liftData[code].elevateID
	newCoords = {}
	local elevateHeight = liftData[code].Zelevate
	local nbStep = (elevateHeight * 100)/6
	liftData[code].isUp = true
	liftData[code].isInUse = true
	for i=0,nbStep do
		Wait(5)
		newCoords.x,newCoords.y,newCoords.z = table.unpack(GetEntityCoords(ascenseur))
		SetEntityCoords(ascenseur,newCoords.x,newCoords.y,newCoords.z+0.01)
	end
	
	SetEntityCoords(ascenseur,liftData[code].up.x,liftData[code].up.y,liftData[code].up.z)
	Wait(500)
	TriggerEvent("bennylift:openDoorUp",code)
	allVehInLift = GetVehicleInLift(liftData[code].up)
	TriggerServerEvent("bennylift:askVehUnFreeze",allVehInLift,code)
	Wait(2500)
	liftData[code].isInUse = false
end)

RegisterNetEvent("bennylift:StepDown")
AddEventHandler('bennylift:StepDown', function(code)

	local ascenseur = liftData[code].elevateID
	
	newCoords = {}
	local elevateHeight = liftData[code].Zelevate
	local nbStep = (elevateHeight * 100)/6
	liftData[code].isInUse = true
	
	for i=0,nbStep do
		Wait(5)
		newCoords.x,newCoords.y,newCoords.z = table.unpack(GetEntityCoords(ascenseur))
		SetEntityCoords(ascenseur,newCoords.x,newCoords.y,newCoords.z-0.01)
	end
end)

RegisterNetEvent("bennylift:downAndDoor")
AddEventHandler('bennylift:downAndDoor', function(code)

	local ascenseur = liftData[code].elevateID
	
	newCoords = {}
	local elevateHeight = liftData[code].Zelevate
	local nbStep = (elevateHeight * 100)/6
	liftData[code].isUp = false
	liftData[code].isInUse = true
	for i=0,nbStep do
		Wait(1)
		newCoords.x,newCoords.y,newCoords.z = table.unpack(GetEntityCoords(ascenseur))
		SetEntityCoords(ascenseur,newCoords.x,newCoords.y,newCoords.z-0.01)
	end
	SetEntityCoords(ascenseur,liftData[code].down.x,liftData[code].down.y,liftData[code].down.z)
	Wait(500)
	TriggerEvent("bennylift:openDoorDown",code)
	allVehInLift = GetVehicleInLift(liftData[code].down)
	TriggerServerEvent("bennylift:askVehUnFreeze",allVehInLift,code)
	Wait(2500)
	liftData[code].isInUse = false
end)

RegisterNetEvent("bennylift:StepDownAndDoor")
AddEventHandler('bennylift:StepDownAndDoor', function(code)

	local ascenseur = liftData[code].elevateID
	
	newCoords = {}
	local elevateHeight = liftData[code].Zelevate
	local nbStep = (elevateHeight * 100)/6
	liftData[code].isUp = false
	liftData[code].isInUse = true
	for i=0,nbStep do
		Wait(5)
		newCoords.x,newCoords.y,newCoords.z = table.unpack(GetEntityCoords(ascenseur))
		SetEntityCoords(ascenseur,newCoords.x,newCoords.y,newCoords.z-0.01)
	end
	SetEntityCoords(ascenseur,liftData[code].down.x,liftData[code].down.y,liftData[code].down.z)
	Wait(500)
	TriggerEvent("bennylift:openDoorDown",code)
	allVehInLift = GetVehicleInLift(liftData[code].down)
	TriggerServerEvent("bennylift:askVehUnFreeze",allVehInLift,code)
	Wait(2500)
	liftData[code].isInUse = false
end)

RegisterNetEvent("bennylift:sendStatus")
AddEventHandler('bennylift:sendStatus', function(data)

	for k,v in pairs(data) do
		for k2,v2 in pairs(liftData) do
			if k==k2 then
				liftData[k].isUp = v.isUp
			end
		end
	end
	isReady = true
end)

AddEventHandler('playerSpawned', function()
	TriggerServerEvent("bennylift:GetStatus")
end)

TriggerServerEvent("bennylift:GetStatus")

function reqControl(veh)
	NetworkRequestControlOfEntity(veh)
	cpt = 0
	--print("Request control : "..tostring(NetworkHasControlOfEntity(veh)))
	while not (NetworkHasControlOfEntity(veh)) do
		Wait(0)
	--	print("Request control : "..tostring(NetworkHasControlOfEntity(veh)))
		NetworkRequestControlOfEntity(veh)
		cpt = cpt +1
		if cpt > 50 then
		break;
		end
	end
end

RegisterNetEvent("bennylift:FreezeVeh")
AddEventHandler('bennylift:FreezeVeh', function(veh,liftcode)
	local plat= {}
	local vehOnplat= {}
	local coordsToAttach = {}
	local curVeh = NetworkGetEntityFromNetworkId(veh)
	local heading = GetEntityHeading(curVeh)
	reqControl(curVeh)
--	print("received freeze veh")
--	print("headingVeh : "..tostring(heading).." heading cabin: "..tostring(liftData[liftcode].elevateHeading))
	if liftData[liftcode].isUp then
		plat.x = liftData[liftcode].up.x
		plat.y = liftData[liftcode].up.y
		plat.z = liftData[liftcode].up.z
	else
		plat.x = liftData[liftcode].down.x
		plat.y = liftData[liftcode].down.y
		plat.z = liftData[liftcode].down.z
	end
	
	vehOnplat.x,vehOnplat.y,vehOnplat.z = table.unpack(GetEntityCoords(curVeh))

	coordsToAttach.x = (vehOnplat.x - plat.x)
	coordsToAttach.y = (vehOnplat.y - plat.y)
	coordsToAttach.z = (vehOnplat.z - plat.z)
	
	distAttach = -math.sqrt((coordsToAttach.x * coordsToAttach.x) + (coordsToAttach.y * coordsToAttach.y))
	AttachEntityToEntity(curVeh,liftData[liftcode].elevateID,0, 0,distAttach,coordsToAttach.z ,0,0,heading-liftData[liftcode].elevateHeading ,0,false,true,false,2,true)
	
end)

RegisterNetEvent("bennylift:UnFreezeVeh")
AddEventHandler('bennylift:UnFreezeVeh', function(veh,liftcode)
	local plat= {}
	local vehOnplat= {}
	local coordsToAttach = {}
	local curVeh = NetworkGetEntityFromNetworkId(veh)
	reqControl(curVeh)
	
	DetachEntity(curVeh,true,true)
end)

---Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(0, 178) then
			allVehInLift = GetVehicleInLift({x=-224.9193,y=-1338.261,z=18.8292})
			TriggerServerEvent("bennylift:askVehFreeze",allVehInLift)
		end	
	end
end)]]