local next = next 
local dot = dot 
local table = table 
local type = type
local tostring = tostring
local math = math 
local pairs = pairs 

Citizen.SetTimeout( 1000, function()
	local name = string.lower( GetCurrentResourceName() )

	UTIL:Log( "Sending resource name (" .. name .. ") to JavaScript side." )

	SendNUIMessage( { _type = "updatePathName", pathName = name } )
end )


local spawned = false 

AddEventHandler( "playerSpawned", function()
	if ( not spawned ) then 
		UTIL:Log( "Attempting to load saved UI settings data." )

		local uiData = GetResourceKvpString( "wk_wars2x_ui_data" )

		if ( uiData ~= nil ) then 
			SendNUIMessage( { _type = "loadUiSettings", data = json.decode( uiData ) } )
			
			UTIL:Log( "Saved UI settings data loaded!" )
		else 
			SendNUIMessage( { _type = "setUiDefaults", data = CONFIG.uiDefaults } )

			UTIL:Log( "Could not find any saved UI settings data." )
		end 

		spawned = true
	end 
end )


PLY = 
{
	ped = PlayerPedId(),
	veh = nil,
	inDriverSeat = false,
	vehClassValid = false
}

function PLY:VehicleStateValid()
	return DoesEntityExist( self.veh ) and self.veh > 0 and self.inDriverSeat and self.vehClassValid
end 

Citizen.CreateThread( function()
	while ( true ) do 
		PLY.ped = PlayerPedId()
		PLY.veh = GetVehiclePedIsIn( PLY.ped, false )
		PLY.inDriverSeat = GetPedInVehicleSeat( PLY.veh, -1 ) == PLY.ped 
		PLY.vehClassValid = GetVehicleClass( PLY.veh ) == 18

		Citizen.Wait( 500 )
	end 
end )


RADAR = {}
RADAR.vars = 
{
	displayed = false,

	power = false, 
	poweringUp = false, 

	hidden = false,

	settings = {
		["fastDisplay"] = CONFIG.menuDefaults["fastDisplay"], 

		["same"] = CONFIG.menuDefaults["same"], 
		["opp"] = CONFIG.menuDefaults["opp"], 

		["beep"] = CONFIG.menuDefaults["beep"],
		
		["voice"] = CONFIG.menuDefaults["voice"],
		
		["plateAudio"] = CONFIG.menuDefaults["plateAudio"], 

		["speedType"] = CONFIG.menuDefaults["speedType"]
	},

	menuActive = false, 
	currentOptionIndex = 1, 
	menuOptions = {
		{ displayText = { "¦¦¦", "FAS" }, optionsText = { "On¦", "Off" }, options = { true, false }, optionIndex = -1, settingText = "fastDisplay" },
		{ displayText = { "¦SL", "SEn" }, optionsText = { "¦1¦", "¦2¦", "¦3¦", "¦4¦", "¦5¦" }, options = { 0.2, 0.4, 0.6, 0.8, 1.0 }, optionIndex = -1, settingText = "same" },
		{ displayText = { "¦OP", "SEn" }, optionsText = { "¦1¦", "¦2¦", "¦3¦", "¦4¦", "¦5¦" }, options = { 0.2, 0.4, 0.6, 0.8, 1.0 }, optionIndex = -1, settingText = "opp" },
		{ displayText = { "bEE", "P¦¦" }, optionsText = { "Off", "¦1¦", "¦2¦", "¦3¦", "¦4¦", "¦5¦" }, options = { 0.0, 0.2, 0.4, 0.6, 0.8, 1.0 }, optionIndex = -1, settingText = "beep" },
		{ displayText = { "VOI", "CE¦" }, optionsText = { "Off", "¦1¦", "¦2¦", "¦3¦", "¦4¦", "¦5¦" }, options = { 0.0, 0.2, 0.4, 0.6, 0.8, 1.0 }, optionIndex = -1, settingText = "voice" },
		{ displayText = { "PLt", "AUd" }, optionsText = { "Off", "¦1¦", "¦2¦", "¦3¦", "¦4¦", "¦5¦" }, options = { 0.0, 0.2, 0.4, 0.6, 0.8, 1.0 }, optionIndex = -1, settingText = "plateAudio" },
		{ displayText = { "Uni", "tS¦" }, optionsText = { "USA", "INT" }, options = { "mph", "kmh" }, optionIndex = -1, settingText = "speedType" }
	},

	patrolSpeed = 0,

	antennas = {
		[ "front" ] = {
			xmit = false,			
			mode = 0,				
			speed = 0,				
			dir = nil, 				
			fastSpeed = 0, 			
			fastDir = nil, 			
			speedLocked = false, 	
			lockedSpeed = nil, 		
			lockedDir = nil, 			
			lockedType = nil        
		}, 

		[ "rear" ] = {
			xmit = false,			
			mode = 0,				
			speed = 0,				
			dir = nil, 				
			fastSpeed = 0, 			
			fastDir = nil, 			
			speedLocked = false,	
			lockedSpeed = nil,		
			lockedDir = nil,			
			lockedType = nil        
		}
	}, 

	maxCheckDist = 350.0,

	sphereSizes = {}, 

	capturedVehicles = {},


	validVehicles = {}, 

	activeVehicles = {},
 
	vehiclePool = {}, 

	rayTraceState = 0,

	numberOfRays = 0,

	threadWaitTime = 500, 
	
	keyLock = false
}

RADAR.speedConversions = { ["mph"] = 2.236936, ["kmh"] = 3.6 }

RADAR.rayTraces = {
	{ startVec = { x = 0.0 }, endVec = { x = 0.0, y = 0.0 }, rayType = "same" },
	{ startVec = { x = -5.0 }, endVec = { x = -5.0, y = 0.0 }, rayType = "same" },
	{ startVec = { x = 5.0 }, endVec = { x = 5.0, y = 0.0 }, rayType = "same" },
	{ startVec = { x = -10.0 }, endVec = { x = -10.0, y = 0.0 }, rayType = "opp" },
	{ startVec = { x = -17.0 }, endVec = { x = -17.0, y = 0.0 }, rayType = "opp" }
}

RADAR.sorting = {
	strongest = function( a, b ) return a.size > b.size end, 
	fastest = function( a, b ) return a.speed > b.speed end
}


function RADAR:IsPowerOn()
	return self.vars.power 
end 

function RADAR:IsPoweringUp()
	return self.vars.poweringUp
end 

function RADAR:SetPoweringUpState( state )
	self.vars.poweringUp = state 
end 

function RADAR:TogglePower()
	self.vars.power = not self.vars.power 
	
	SendNUIMessage( { _type = "radarPower", state = self:IsPowerOn() } )

	if ( self:IsPowerOn() ) then 
		self:SetMenuState( false )
		
		self:SetPoweringUpState( true )

		Citizen.SetTimeout( 2000, function()
			self:SetPoweringUpState( false )

			SendNUIMessage( { _type = "poweredUp" } )
		end )
	else 
		self:ResetAntenna( "front" )
		self:ResetAntenna( "rear" )
	end
end

function RADAR:ToggleDisplayState()
	self.vars.displayed = not self.vars.displayed 

	SendNUIMessage( { _type = "setRadarDisplayState", state = self:GetDisplayState() } )
end 

function RADAR:GetDisplayState()
	return self.vars.displayed
end 

function RADAR:SetSettingValue( setting, value )
	if ( value ~= nil ) then 
		self.vars.settings[setting] = value 

		if ( setting == "same" or setting == "opp" ) then 
			self:UpdateRayEndCoords()
		end 
	end 
end 

function RADAR:GetSettingValue( setting )
	return self.vars.settings[setting]
end

function RADAR:IsFastDisplayEnabled()
	return self.vars.settings["fastDisplay"]
end 
 
function RADAR:IsEitherAntennaOn()
	return self:IsAntennaTransmitting( "front" ) or self:IsAntennaTransmitting( "rear" )
end 

function RADAR:SendSettingUpdate()
	local antennas = {}

	for ant in UTIL:Values( { "front", "rear" } ) do 
		antennas[ant] = {}
		antennas[ant].xmit = self:IsAntennaTransmitting( ant )
		antennas[ant].mode = self:GetAntennaMode( ant )
		antennas[ant].speedLocked = self:IsAntennaSpeedLocked( ant )
		antennas[ant].fast = self:ShouldFastBeDisplayed( ant )
	end 

	SendNUIMessage( { _type = "settingUpdate", antennaData = antennas } )
end 

function RADAR:CanPerformMainTask()
	return self:IsPowerOn() and not self:IsPoweringUp() and not self:IsMenuOpen()
end 

function RADAR:GetThreadWaitTime()
	return self.vars.threadWaitTime
end 

function RADAR:SetThreadWaitTime( time )
	self.vars.threadWaitTime = time 
end 
 
function RADAR:SetDisplayHidden( state )
	self.vars.hidden = state 
end 

function RADAR:GetDisplayHidden()
	return self.vars.hidden 
end

function RADAR:OpenRemote()
	if ( not IsPauseMenuActive() and PLY:VehicleStateValid() ) then 
		SendNUIMessage( { _type = "openRemote" } )

		if ( CONFIG.allow_quick_start_video ) then 
			local show = GetResourceKvpInt( "wk_wars2x_new_user" )

			if ( show == 0 ) then 
				SendNUIMessage( { _type = "showNewUser" } )
			end 
		end 

		SetNuiFocus( true, true )
	end
end 

RegisterNetEvent( "trp:openRemote" )
AddEventHandler( "trp:openRemote", function()
	RADAR:OpenRemote()
end )

function RADAR:IsFastLimitAllowed()
	return CONFIG.allow_fast_limit
end

if ( RADAR:IsFastLimitAllowed() ) then
	function RADAR:CreateFastLimitConfig()
		local fastOptions = 
		{
			{ displayText = { "FAS", "Loc" }, optionsText = { "On¦", "Off" }, options = { true, false }, optionIndex = 2, settingText = "fastLock" },
			{ displayText = { "FAS", "SPd" }, optionsText = {}, options = {}, optionIndex = 12, settingText = "fastLimit" }
		}
 
		for i = 5, 200, 5 do
			local text = UTIL:FormatSpeed( i )

			table.insert( fastOptions[2].optionsText, text )
			table.insert( fastOptions[2].options, i )
		end 

		self:SetSettingValue( "fastLock", false )
		self:SetSettingValue( "fastLimit", 60 )
 
		table.insert( self.vars.menuOptions, fastOptions[1] )
		table.insert( self.vars.menuOptions, fastOptions[2] )
	end 

	function RADAR:GetFastLimit()
		return self.vars.settings["fastLimit"]
	end 

	function RADAR:IsFastLockEnabled()
		return self.vars.settings["fastLock"]
	end 
end 

function RADAR:ToggleKeyLock()
	if ( PLY:VehicleStateValid() ) then 
		self.vars.keyLock = not self.vars.keyLock

		SendNUIMessage( { _type = "displayKeyLock", state = self:GetKeyLockState() } )
	end
end 

function RADAR:GetKeyLockState()
	return self.vars.keyLock
end 


function RADAR:SetMenuState( state )
	if ( self:IsPowerOn() ) then 
		self.vars.menuActive = state

		if ( state ) then 
			self.vars.currentOptionIndex = 1
		end
	end
end 

function RADAR:IsMenuOpen()
	return self.vars.menuActive
end 

function RADAR:ChangeMenuIndex()
	local temp = self.vars.currentOptionIndex + 1

	if ( temp > #self.vars.menuOptions ) then 
		temp = 1 
	end 

	self.vars.currentOptionIndex = temp

	self:SendMenuUpdate()
end 

function RADAR:GetMenuOptionTable()
	return self.vars.menuOptions[self.vars.currentOptionIndex]
end 

function RADAR:SetMenuOptionIndex( index )
	self.vars.menuOptions[self.vars.currentOptionIndex].optionIndex = index
end 

function RADAR:GetMenuOptionValue()
	local opt = self:GetMenuOptionTable()
	local index = opt.optionIndex

	return opt.options[index]
end 

function RADAR:ChangeMenuOption( dir )
	local opt = self:GetMenuOptionTable()

	local index = opt.optionIndex

	local size = #opt.options

	if ( dir == "front" ) then 
		index = index + 1
		if ( index > size ) then index = 1 end 
	elseif ( dir == "rear" ) then 
		index = index - 1
		if ( index < 1 ) then index = size end 
	end

	self:SetMenuOptionIndex( index )

	self:SetSettingValue( opt.settingText, self:GetMenuOptionValue() )

	self:SendMenuUpdate()
end 

function RADAR:GetMenuOptionDisplayText()
	return self:GetMenuOptionTable().displayText
end 

function RADAR:GetMenuOptionText()
	local opt = self:GetMenuOptionTable()

	return opt.optionsText[opt.optionIndex]
end 

function RADAR:SendMenuUpdate()
	SendNUIMessage( { _type = "menu", text = self:GetMenuOptionDisplayText(), option = self:GetMenuOptionText() } )
end 

function RADAR:LoadOMData()
	UTIL:Log( "Attempting to load saved operator menu data." )

	local rawData = GetResourceKvpString( "wk_wars2x_om_data" )

	if ( rawData ~= nil ) then 
		local omData = json.decode( rawData )
		self.vars.settings = omData

		UTIL:Log( "Saved operator menu data loaded!" )
	else 
		UTIL:Log( "Could not find any saved operator menu data." )
	end 
end 

function RADAR:UpdateOptionIndexes()
	self:LoadOMData()

	for k, v in pairs( self.vars.settings ) do     
		for i, t in pairs( self.vars.menuOptions ) do 
			if ( t.settingText == k ) then 
				for oi, ov in pairs( t.options ) do 
					if ( v == ov ) then 
						t.optionIndex = oi
					end 
				end 
			end 
		end 
	end 
end 


function RADAR:GetPatrolSpeed()	
	return self.vars.patrolSpeed
end 

function RADAR:GetVehiclePool()
	return self.vars.vehiclePool
end 

function RADAR:GetMaxCheckDist()
	return self.vars.maxCheckDist
end 

function RADAR:GetStrongestSortFunc()
	return self.sorting.strongest 
end 

function RADAR:GetFastestSortFunc()
	return self.sorting.fastest
end 

function RADAR:SetPatrolSpeed( speed )
	if ( type( speed ) == "number" ) then 
		self.vars.patrolSpeed = self:GetVehSpeedConverted( speed )
	end
end

function RADAR:SetVehiclePool( pool )
	if ( type( pool ) == "table" ) then 
		self.vars.vehiclePool = pool 
	end
end 


function RADAR:GetRayTraceState()
	return self.vars.rayTraceState
end

function RADAR:CacheNumRays()
	self.vars.numberOfRays = #self.rayTraces
end 

function RADAR:GetNumOfRays()
	return self.vars.numberOfRays
end

function RADAR:IncreaseRayTraceState()
	self.vars.rayTraceState = self.vars.rayTraceState + 1
end 

function RADAR:ResetRayTraceState()
	self.vars.rayTraceState = 0
end 

function RADAR:GetIntersectedVehIsFrontOrRear( t )
	if ( t > 8.0 ) then 
		return 1 
	elseif ( t < -8.0 ) then 
		return -1 
	end 

	return 0 
end 

function RADAR:GetLineHitsSphereAndDir( c, radius, rs, re )
	local rayStart = vector2( rs.x, rs.y )
	local rayEnd = vector2( re.x, re.y )
	local centre = vector2( c.x, c.y )

	local rayNorm = norm( rayEnd - rayStart )

	local rayToCentre = centre - rayStart

	local tProj = dot( rayToCentre, rayNorm )
	local oppLenSqr = dot( rayToCentre, rayToCentre ) - ( tProj * tProj )

	local radiusSqr = radius * radius 

	local rayDist = #( rayEnd - rayStart )
	local distToCentre = #( rayStart - centre ) - ( radius * 2 )

	if ( oppLenSqr < radiusSqr and not ( distToCentre > rayDist ) ) then 
		return true, self:GetIntersectedVehIsFrontOrRear( tProj )
	end

	return false, nil 
end 

function RADAR:IsVehicleInTraffic( tgtVeh, relPos )
	local tgtHdg = GetEntityHeading( tgtVeh )
	local plyHdg = GetEntityHeading( PLY.veh )

	local hdgDiff = math.abs( ( plyHdg - tgtHdg + 180 ) % 360 - 180 )

	if ( relPos == 1 and hdgDiff > 45 and hdgDiff < 135 ) then
		return false
	elseif ( relPos == -1 and hdgDiff > 45 and ( hdgDiff < 135 or hdgDiff > 215 ) ) then
		return false
	end

	return true
end

function RADAR:ShootCustomRay( plyVeh, veh, s, e )
	local pos = GetEntityCoords( veh )

	local dist = #( pos - s )

	if ( DoesEntityExist( veh ) and veh ~= plyVeh and dist < self:GetMaxCheckDist() ) then 
		local entSpeed = GetEntitySpeed( veh )

		local visible = HasEntityClearLosToEntity( plyVeh, veh, 15 )
		
		local pitch = GetEntityPitch( plyVeh )

		if ( entSpeed > 0.1 and ( pitch > -35 and pitch < 35 ) and visible ) then 
			local radius, size = self:GetDynamicRadius( veh )

			local hit, relPos = self:GetLineHitsSphereAndDir( pos, radius, s, e )

			if ( hit and self:IsVehicleInTraffic( veh, relPos ) ) then 
				return true, relPos, dist, entSpeed, size
			end 
		end
	end 

	return false, nil, nil, nil, nil
end 

function RADAR:GetVehsHitByRay( ownVeh, vehs, s, e )
	local caughtVehs = {}

	local hasData = false 

	for _, veh in pairs( vehs ) do 
		local hit, relativePos, distance, speed, size = self:ShootCustomRay( ownVeh, veh, s, e )

		if ( hit ) then 
			local vehData = {}
			vehData.veh = veh 
			vehData.relPos = relativePos
			vehData.dist = distance
			vehData.speed = speed
			vehData.size = size

			table.insert( caughtVehs, vehData )

			hasData = true 
		end 
	end 

	if ( hasData ) then return caughtVehs end
end 

function RADAR:CreateRayThread( vehs, from, startX, endX, endY, rayType )
	local startPoint = GetOffsetFromEntityInWorldCoords( from, startX, 0.0, 0.0 )
	local endPoint = GetOffsetFromEntityInWorldCoords( from, endX, endY, 0.0 )

	local hitVehs = self:GetVehsHitByRay( from, vehs, startPoint, endPoint )

	self:InsertCapturedVehicleData( hitVehs, rayType )

	self:IncreaseRayTraceState()
end 

function RADAR:CreateRayThreads( ownVeh, vehicles )
	for _, v in pairs( self.rayTraces ) do 
		self:CreateRayThread( vehicles, ownVeh, v.startVec.x, v.endVec.x, v.endVec.y, v.rayType )
	end 
end 

function RADAR:UpdateRayEndCoords()
	for _, v in pairs( self.rayTraces ) do 
		local endY = self:GetSettingValue( v.rayType ) * self:GetMaxCheckDist()
		
		v.endVec.y = endY
	end 	
end 


function RADAR:ToggleAntenna( ant, cb )
	if ( self:IsPowerOn() ) then 
		self.vars.antennas[ant].xmit = not self.vars.antennas[ant].xmit 

		if ( cb ) then cb() end 
	end 
end 

function RADAR:IsAntennaTransmitting( ant )
	return self.vars.antennas[ant].xmit 
end 

function RADAR:GetAntennaTextFromNum( relPos )
	if ( relPos == 1 ) then 
		return "front"
	elseif ( relPos == -1 ) then 
		return "rear"
	end 
end 

function RADAR:GetAntennaMode( ant )
	return self.vars.antennas[ant].mode 
end 

function RADAR:SetAntennaMode( ant, mode, cb )
	if ( type( mode ) == "number" ) then 
		if ( mode >= 0 and mode <= 3 and self:IsPowerOn() ) then 
			self.vars.antennas[ant].mode = mode 

			if ( cb ) then cb() end 
		end 
	end 
end 

function RADAR:GetAntennaSpeed( ant )
	return self.vars.antennas[ant].speed 
end 

function RADAR:SetAntennaSpeed( ant, speed ) 
	self.vars.antennas[ant].speed = speed
end 

function RADAR:GetAntennaDir( ant )
	return self.vars.antennas[ant].dir 
end 
 
function RADAR:SetAntennaDir( ant, dir )
	self.vars.antennas[ant].dir = dir 
end  

function RADAR:SetAntennaData( ant, speed, dir )
	self:SetAntennaSpeed( ant, speed )
	self:SetAntennaDir( ant, dir )
end

function RADAR:GetAntennaFastSpeed( ant )
	return self.vars.antennas[ant].fastSpeed 
end 

function RADAR:SetAntennaFastSpeed( ant, speed ) 
	self.vars.antennas[ant].fastSpeed = speed
end 

function RADAR:GetAntennaFastDir( ant )
	return self.vars.antennas[ant].fastDir
end 

function RADAR:SetAntennaFastDir( ant, dir )
	self.vars.antennas[ant].fastDir = dir 
end 

function RADAR:SetAntennaFastData( ant, speed, dir )
	self:SetAntennaFastSpeed( ant, speed )
	self:SetAntennaFastDir( ant, dir )
end

function RADAR:DoesAntennaHaveValidData( ant )
	return self:GetAntennaSpeed( ant ) ~= nil 
end 

function RADAR:DoesAntennaHaveValidFastData( ant )
	return self:GetAntennaFastSpeed( ant ) ~= nil 
end 

function RADAR:ShouldFastBeDisplayed( ant )
	if ( self:IsAntennaSpeedLocked( ant ) ) then 
		return self:GetAntennaLockedType( ant ) == 2 
	else 
		return self:IsFastDisplayEnabled()
	end
end 

function RADAR:IsAntennaSpeedLocked( ant )
	return self.vars.antennas[ant].speedLocked
end

function RADAR:SetAntennaSpeedIsLocked( ant, state )
	self.vars.antennas[ant].speedLocked = state
end 

function RADAR:SetAntennaSpeedLock( ant, speed, dir, lockType )
	if ( speed ~= nil and dir ~= nil and lockType ~= nil ) then 
		self.vars.antennas[ant].lockedSpeed = speed 
		self.vars.antennas[ant].lockedDir = dir 
		self.vars.antennas[ant].lockedType = lockType
		
		self:SetAntennaSpeedIsLocked( ant, true )

		SendNUIMessage( { _type = "audio", name = "beep", vol = self:GetSettingValue( "beep" ) } )
		
		SendNUIMessage( { _type = "lockAudio", ant = ant, dir = dir, vol = self:GetSettingValue( "voice" ) } )
		
		if ( speed == "¦88" and self:GetSettingValue( "speedType" ) == "mph" ) then 
			math.randomseed( GetGameTimer() )

			local chance = math.random()
			
			if ( chance <= 0.15 ) then 
				SendNUIMessage( { _type = "audio", name = "speed_alert", vol = self:GetSettingValue( "beep" ) } )
			end 
		end 
	end
end 

function RADAR:GetAntennaLockedSpeed( ant )
	return self.vars.antennas[ant].lockedSpeed
end 

function RADAR:GetAntennaLockedDir( ant )
	return self.vars.antennas[ant].lockedDir
end 

function RADAR:GetAntennaLockedType( ant )
	return self.vars.antennas[ant].lockedType 
end 

function RADAR:ResetAntennaSpeedLock( ant )
	self.vars.antennas[ant].lockedSpeed = nil 
	self.vars.antennas[ant].lockedDir = nil  
	self.vars.antennas[ant].lockedType = nil
	
	self:SetAntennaSpeedIsLocked( ant, false )
end

function RADAR:LockAntennaSpeed( ant )
	if ( self:IsPowerOn() and self:GetDisplayState() and not self:GetDisplayHidden() and self:IsAntennaTransmitting( ant ) ) then 
		if ( not self:IsAntennaSpeedLocked( ant ) ) then 
			local data = { nil, nil, nil }

			if ( self:IsFastDisplayEnabled() and self:DoesAntennaHaveValidFastData( ant ) ) then 
				data[1] = self:GetAntennaFastSpeed( ant ) 
				data[2] = self:GetAntennaFastDir( ant )	
				data[3] = 2
			else 
				data[1] = self:GetAntennaSpeed( ant ) 
				data[2] = self:GetAntennaDir( ant ) 
				data[3] = 1
			end

			self:SetAntennaSpeedLock( ant, data[1], data[2], data[3] )
		else 
			self:ResetAntennaSpeedLock( ant )
		end 

		SendNUIMessage( { _type = "antennaLock", ant = ant, state = self:IsAntennaSpeedLocked( ant ) } )
		SendNUIMessage( { _type = "antennaFast", ant = ant, state = self:ShouldFastBeDisplayed( ant ) } )
	end 
end 

function RADAR:ResetAntenna( ant )
	self.vars.antennas[ant].xmit = false 
	self.vars.antennas[ant].mode = 0

	self:ResetAntennaSpeedLock( ant )
end 


function RADAR:GetCapturedVehicles()
	return self.vars.capturedVehicles
end

function RADAR:ResetCapturedVehicles()
	self.vars.capturedVehicles = {}
end

function RADAR:InsertCapturedVehicleData( t, rt )
	if ( type( t ) == "table" and not UTIL:IsTableEmpty( t ) ) then 
		for _, v in pairs( t ) do
			v.rayType = rt 
			
			table.insert( self.vars.capturedVehicles, v )
		end
	end 
end 


function RADAR:GetDynamicDataValue( key )
	return self.vars.sphereSizes[key]
end 

function RADAR:DoesDynamicRadiusDataExist( key )
	return self:GetDynamicDataValue( key ) ~= nil 
end

function RADAR:SetDynamicRadiusKey( key, t )
	self.vars.sphereSizes[key] = t
end 

function RADAR:InsertDynamicRadiusData( key, radius, actualSize )
	if ( self:GetDynamicDataValue( key ) == nil ) then 
		local data = {}

		data.radius = radius 
		data.actualSize = actualSize

		self:SetDynamicRadiusKey( key, data )
	end 
end 

function RADAR:GetRadiusData( key )
	return self.vars.sphereSizes[key].radius, self.vars.sphereSizes[key].actualSize
end 

function RADAR:GetDynamicRadius( veh )
	local mdl = GetEntityModel( veh )
	
	local key = tostring( mdl )
	
	local dataExists = self:DoesDynamicRadiusDataExist( key )
	
	if ( not dataExists ) then 
		local min, max = GetModelDimensions( mdl )
		
		local size = max - min 
		
		local numericSize = size.x + size.y + size.z 
		
		local dynamicRadius = UTIL:Clamp( ( numericSize * numericSize ) / 12, 5.0, 11.0 )

		self:InsertDynamicRadiusData( key, dynamicRadius, numericSize )

		return dynamicRadius, numericSize
	end 

	return self:GetRadiusData( key )
end


function RADAR:GetVehSpeedConverted( speed )
	local unit = self:GetSettingValue( "speedType" )

	return UTIL:Round( speed * self.speedConversions[unit], 0 )
end 

function RADAR:GetVehicleValidity( key )
	return self.vars.validVehicles[key]
end 

function RADAR:SetVehicleValidity( key, validity )
	self.vars.validVehicles[key] = validity 
end 

function RADAR:DoesVehicleValidityExist( key )
	return self:GetVehicleValidity( key ) ~= nil 
end 

function RADAR:IsVehicleValid( veh )
	local mdl = GetEntityModel( veh )
	
	local key = tostring( mdl )

	local valid = self:GetVehicleValidity( key )

	if ( valid == nil ) then 
		if ( IsThisModelABoat( mdl ) or IsThisModelAHeli( mdl ) or IsThisModelAPlane( mdl ) ) then 
			self:SetVehicleValidity( key, false )
			return false 
		else 
			self:SetVehicleValidity( key, true ) 
			return true 
		end 
	end 

	return valid 
end 

function RADAR:GetAllVehicles()
	local t = {}

	for v in UTIL:EnumerateVehicles() do
		if ( self:IsVehicleValid( v ) ) then 
			table.insert( t, v )
		end 
	end 

	return t
end 

function RADAR:CheckVehicleDataFitsMode( ant, rt )
	local mode = self:GetAntennaMode( ant )

	if ( ( mode == 3 ) or ( mode == 1 and rt == "same" ) or ( mode == 2 and rt == "opp" ) ) then return true end 

	return false  
end

function RADAR:GetVehiclesForAntenna()
	local vehs = { ["front"] = {}, ["rear"] = {} }
	
	local results = { ["front"] = { nil, nil }, ["rear"] = { nil, nil } }

	for ant in UTIL:Values( { "front", "rear" } ) do 
		if ( self:IsAntennaTransmitting( ant ) ) then 
			for k, v in pairs( self:GetCapturedVehicles() ) do 
				local antText = self:GetAntennaTextFromNum( v.relPos )

				if ( ant == antText ) then 
					table.insert( vehs[ant], v )
				end 
			end 

			table.sort( vehs[ant], self:GetStrongestSortFunc() )
		end
	end 

	for ant in UTIL:Values( { "front", "rear" } ) do 
		if ( not UTIL:IsTableEmpty( vehs[ant] ) ) then
			for k, v in pairs( vehs[ant] ) do 
				if ( self:CheckVehicleDataFitsMode( ant, v.rayType ) ) then 
					results[ant][1] = v
					break
				end 
			end 

			if ( self:IsFastDisplayEnabled() ) then 
				table.sort( vehs[ant], self:GetFastestSortFunc() )

				local temp = results[ant][1]

				for k, v in pairs( vehs[ant] ) do 
					if ( self:CheckVehicleDataFitsMode( ant, v.rayType ) and v.veh ~= temp.veh and v.size < temp.size and v.speed > temp.speed + 1.0 ) then 
						results[ant][2] = v 
						break
					end 
				end 
			end
		end 
	end

	return { ["front"] = { results["front"][1], results["front"][2] }, ["rear"] = { results["rear"][1], results["rear"][2] } }
end 


RegisterNUICallback( "toggleRadarDisplay", function( data, cb )
	RADAR:ToggleDisplayState()
	cb('ok')
end )

RegisterNUICallback( "togglePower", function( data, cb )
	RADAR:TogglePower()
	cb('ok')
end )

RegisterNUICallback( "closeRemote", function( data, cb )
	SetNuiFocus( false, false )
	cb('ok')
end )

RegisterNUICallback( "setAntennaMode", function( data, cb ) 
	if ( RADAR:IsPowerOn() and not RADAR:IsPoweringUp() ) then 
		if ( RADAR:IsMenuOpen() ) then 
			RADAR:SetMenuState( false )
			
			RADAR:SendSettingUpdate()
			
			SendNUIMessage( { _type = "audio", name = "done", vol = RADAR:GetSettingValue( "beep" ) } )

			local omData = json.encode( RADAR.vars.settings )
			SetResourceKvp( "wk_wars2x_om_data", omData )
		else
			RADAR:SetAntennaMode( data.value, tonumber( data.mode ), function()
				SendNUIMessage( { _type = "antennaMode", ant = data.value, mode = tonumber( data.mode ) } )
				
				SendNUIMessage( { _type = "audio", name = "beep", vol = RADAR:GetSettingValue( "beep" ) } )
			end )
		end 
	end
	cb('ok') 
end )

RegisterNUICallback( "toggleAntenna", function( data, cb ) 
	if ( RADAR:IsPowerOn() and not RADAR:IsPoweringUp() ) then
		if ( RADAR:IsMenuOpen() ) then 
			RADAR:ChangeMenuOption( data.value )
			
			SendNUIMessage( { _type = "audio", name = "beep", vol = RADAR:GetSettingValue( "beep" ) } )
		else
			RADAR:ToggleAntenna( data.value, function()
				SendNUIMessage( { _type = "antennaXmit", ant = data.value, on = RADAR:IsAntennaTransmitting( data.value ) } )
				
				SendNUIMessage( { _type = "audio", name = RADAR:IsAntennaTransmitting( data.value ) and "xmit_on" or "xmit_off", vol = RADAR:GetSettingValue( "beep" ) } )
			end )
		end 
	end
	cb('ok') 
end )

RegisterNUICallback( "menu", function( data, cb )
	if ( RADAR:IsPowerOn() and not RADAR:IsPoweringUp() ) then 
		if ( RADAR:IsMenuOpen() ) then 
			RADAR:ChangeMenuIndex()
		else 
			RADAR:SetMenuState( true )
			
			RADAR:SendMenuUpdate()
		end

		SendNUIMessage( { _type = "audio", name = "beep", vol = RADAR:GetSettingValue( "beep" ) } )
	end
	cb('ok') 
end )

RegisterNUICallback( "saveUiData", function( data, cb )
	UTIL:Log( "Saving updated UI settings data." )
	SetResourceKvp( "wk_wars2x_ui_data", json.encode( data ) )
	cb('ok')
end )

RegisterNUICallback( "qsvWatched", function( data, cb )
	SetResourceKvpInt( "wk_wars2x_new_user", 1 )
	cb('ok')
end )


function RADAR:RunDynamicThreadWaitCheck()
	local speed = self:GetPatrolSpeed()

	if ( speed < 0.1 ) then 
		self:SetThreadWaitTime( 200 )
	else 
		self:SetThreadWaitTime( 500 )
	end 
end 

Citizen.CreateThread( function()
	while ( true ) do 
		RADAR:RunDynamicThreadWaitCheck()

		Citizen.Wait( 2000 )
	end 
end )

function RADAR:RunThreads()
	if ( PLY:VehicleStateValid() and self:CanPerformMainTask() and self:IsEitherAntennaOn() ) then 
		if ( self:GetRayTraceState() == 0 ) then 
			local vehs = self:GetVehiclePool()

			self:ResetCapturedVehicles()
			
			self:CreateRayThreads( PLY.veh, vehs )

			Citizen.Wait( self:GetThreadWaitTime() )
			
		elseif ( self:GetRayTraceState() == self:GetNumOfRays() ) then 
			self:ResetRayTraceState()
		end
	end 
end 

Citizen.CreateThread( function()
	while ( true ) do 
		-- Run the function
		RADAR:RunThreads()

		Citizen.Wait( 0 )
	end 
end )

function RADAR:Main()
	if ( PLY:VehicleStateValid() and self:CanPerformMainTask() ) then 
		local data = {} 

		local entSpeed = GetEntitySpeed( PLY.veh )
		
		self:SetPatrolSpeed( entSpeed )

		if ( entSpeed == 0 ) then 
			data.patrolSpeed = "¦[]"
		else 
			local speed = self:GetVehSpeedConverted( entSpeed )
			data.patrolSpeed = UTIL:FormatSpeed( speed )
		end 

		local av = self:GetVehiclesForAntenna()
		data.antennas = { ["front"] = nil, ["rear"] = nil }

		for ant in UTIL:Values( { "front", "rear" } ) do 
			if ( self:IsAntennaTransmitting( ant ) ) then
				data.antennas[ant] = {}

				for i = 1, 2 do 
					data.antennas[ant][i] = { speed = "¦¦¦", dir = 0 }

					if ( i == 2 and self:IsAntennaSpeedLocked( ant ) ) then 
						data.antennas[ant][i].speed = self:GetAntennaLockedSpeed( ant )
						data.antennas[ant][i].dir = self:GetAntennaLockedDir( ant )
						
					else 
						if ( av[ant][i] ~= nil ) then 
							local vehSpeed = GetEntitySpeed( av[ant][i].veh )
							local convertedSpeed = self:GetVehSpeedConverted( vehSpeed )
							data.antennas[ant][i].speed = UTIL:FormatSpeed( convertedSpeed ) 

							local ownH = UTIL:Round( GetEntityHeading( PLY.veh ), 0 )
							local tarH = UTIL:Round( GetEntityHeading( av[ant][i].veh ), 0 )
							data.antennas[ant][i].dir = UTIL:GetEntityRelativeDirection( ownH, tarH )

							if ( i % 2 == 0 ) then 
								self:SetAntennaFastData( ant, data.antennas[ant][i].speed, data.antennas[ant][i].dir )
							else 
								self:SetAntennaData( ant, data.antennas[ant][i].speed, data.antennas[ant][i].dir )
							end
							
							if ( self:IsFastLimitAllowed() ) then 
								if ( self:IsFastLockEnabled() and convertedSpeed > self:GetFastLimit() and not self:IsAntennaSpeedLocked( ant ) ) then 
									self:LockAntennaSpeed( ant )
								end 
							end 
						else 
							if ( i % 2 == 0 ) then 
								self:SetAntennaFastData( ant, nil, nil )
							else 
								self:SetAntennaData( ant, nil, nil )
							end
						end 
					end 
				end 
			end 
		end 

		SendNUIMessage( { _type = "update", speed = data.patrolSpeed, antennas = data.antennas } )
	end 
end 

Citizen.CreateThread( function()
	SetNuiFocus( false, false )

	RADAR:CacheNumRays()
	
	RADAR:UpdateRayEndCoords()
	
	RADAR:UpdateOptionIndexes()

	if ( RADAR:IsFastLimitAllowed() ) then 
		RADAR:CreateFastLimitConfig()
	end 

	while ( true ) do
		RADAR:Main()

		Citizen.Wait( 100 )
	end
end )

function RADAR:RunDisplayValidationCheck()
	if ( ( ( PLY.veh == 0 or ( PLY.veh > 0 and not PLY.vehClassValid ) ) and self:GetDisplayState() and not self:GetDisplayHidden() ) or IsPauseMenuActive() and self:GetDisplayState() ) then
		self:SetDisplayHidden( true ) 
		SendNUIMessage( { _type = "setRadarDisplayState", state = false } )
	elseif ( PLY.veh > 0 and PLY.vehClassValid and PLY.inDriverSeat and self:GetDisplayState() and self:GetDisplayHidden() ) then 
		self:SetDisplayHidden( false ) 
		SendNUIMessage( { _type = "setRadarDisplayState", state = true } )
	end 
end

Citizen.CreateThread( function() 
	Citizen.Wait( 100 )

	while ( true ) do 
		RADAR:RunDisplayValidationCheck()

		Citizen.Wait( 500 )
	end 
end )

function RADAR:UpdateVehiclePool() 
	if ( PLY:VehicleStateValid() and self:CanPerformMainTask() and self:IsEitherAntennaOn() ) then 
		local vehs = self:GetAllVehicles()
		
		self:SetVehiclePool( vehs )
	end 
end 

Citizen.CreateThread( function() 
	while ( true ) do
		RADAR:UpdateVehiclePool()

		Citizen.Wait( 3000 )
	end 
end )

Citizen.CreateThread( function()
	Citizen.Wait( 3000 )
	
	RegisterCommand( "radar_remote", function()
		if ( not RADAR:GetKeyLockState() ) then
			RADAR:OpenRemote()
		end
	end )
	RegisterKeyMapping( "radar_remote", "Open Remote Control", "keyboard", CONFIG.keyDefaults.remote_control )

	RegisterCommand( "radar_fr_ant", function()
		if ( not RADAR:GetKeyLockState() ) then
			RADAR:LockAntennaSpeed( "front" )
		end
	end )
	RegisterKeyMapping( "radar_fr_ant", "Front Antenna Lock/Unlock", "keyboard", CONFIG.keyDefaults.front_lock )

	RegisterCommand( "radar_bk_ant", function()
		if ( not RADAR:GetKeyLockState() ) then
			RADAR:LockAntennaSpeed( "rear" )
		end
	end )
	RegisterKeyMapping( "radar_bk_ant", "Rear Antenna Lock/Unlock", "keyboard", CONFIG.keyDefaults.rear_lock )

	RegisterCommand( "radar_fr_cam", function()
		if ( not RADAR:GetKeyLockState() ) then
			READER:LockCam( "front", true, false )
		end
	end )
	RegisterKeyMapping( "radar_fr_cam", "Front Plate Reader Lock/Unlock", "keyboard", CONFIG.keyDefaults.plate_front_lock )

	RegisterCommand( "radar_bk_cam", function()
		if ( not RADAR:GetKeyLockState() ) then
			READER:LockCam( "rear", true, false )
		end
	end )
	RegisterKeyMapping( "radar_bk_cam", "Rear Plate Reader Lock/Unlock", "keyboard", CONFIG.keyDefaults.plate_rear_lock )

	RegisterCommand( "radar_key_lock", function()
		RADAR:ToggleKeyLock()
	end )
	RegisterKeyMapping( "radar_key_lock", "Toggle Keybind Lock", "keyboard", CONFIG.keyDefaults.key_lock )

	RegisterCommand( "reset_radar_data", function()
		DeleteResourceKvp( "wk_wars2x_ui_data" )
		DeleteResourceKvp( "wk_wars2x_om_data" )
		DeleteResourceKvp( "wk_wars2x_new_user" )
	end, false )
end )