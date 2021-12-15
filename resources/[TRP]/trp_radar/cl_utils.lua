
UTIL = {}

function UTIL:Round( num, numDecimalPlaces )
	return tonumber( string.format( "%." .. ( numDecimalPlaces or 0 ) .. "f", num ) )
end 

function UTIL:FormatSpeed( speed )
	if ( speed < 0 or speed > 999 ) then return "Err" end 

	local text = tostring( speed )
	local pipes = ""

	for i = 1, 3 - string.len( text ) do 
		pipes = pipes .. "¦"
	end 
	
	return pipes .. text
end 

function UTIL:Clamp( val, min, max )
	if ( val < min ) then 
		return min 
	elseif ( val > max ) then 
		return max 
	end 

	return val 
end 

function UTIL:IsTableEmpty( t )
	local c = 0 

	for _ in pairs( t ) do c = c + 1 end 

	return c == 0
end 

function UTIL:Values( xs )
	local i = 0

	return function()
		i = i + 1
		return xs[i]
	end
end

function UTIL:GetVehicleInDirection( entFrom, coordFrom, coordTo )
	local rayHandle = StartShapeTestCapsule( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 5.0, 10, entFrom, 7 )
	local _, _, _, _, vehicle = GetShapeTestResult( rayHandle )
	return vehicle
end

function UTIL:GetEntityRelativeDirection( myAng, tarAng )
	local angleDiff = math.abs( ( myAng - tarAng + 180 ) % 360 - 180 )

	if ( angleDiff < 45 ) then 
		return 1
	elseif ( angleDiff > 135 ) then 
		return 2
	end 

	return 0
end

function UTIL:Notify( text )
	SetNotificationTextEntry( "STRING" )
	AddTextComponentSubstringPlayerName( text )
	DrawNotification( false, true )
end

function UTIL:Log( msg )
	print( "[TRP Radar]: " .. msg )
end 

function UTIL:DrawDebugText( x, y, scale, centre, text )
	SetTextFont( 4 )
	SetTextProportional( 0 )
	SetTextScale( scale, scale )
	SetTextColour( 255, 255, 255, 255 )
	SetTextDropShadow( 0, 0, 0, 0, 255 )
	SetTextEdge( 2, 0, 0, 0, 255 )
	SetTextCentre( centre )
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry( "STRING" )
	AddTextComponentString( text )
	DrawText( x, y )
end

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
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

function UTIL:EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end