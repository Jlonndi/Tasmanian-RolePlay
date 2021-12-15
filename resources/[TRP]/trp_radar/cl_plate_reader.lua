READER = {}

READER.vars = 
{
	displayed = false,

	hidden = false,
	boloPlate = "", 
	
	cams = {
		["front"] = {
			plate = "",     
			index = "",     
			locked = false  
		}, 

		["rear"] = {
			plate = "",     
			index = "",     
			locked = false  
		}
	}
}

function READER:GetDisplayState()
	return self.vars.displayed
end 

function READER:ToggleDisplayState()
	self.vars.displayed = not self.vars.displayed 
 
	SendNUIMessage( { _type = "setReaderDisplayState", state = self:GetDisplayState() } )
end 

function READER:SetDisplayHidden( state )
	self.vars.hidden = state 
end 

function READER:GetDisplayHidden()
	return self.vars.hidden 
end

function READER:GetPlate( cam )
	return self.vars.cams[cam].plate 
end 
 
function READER:SetPlate( cam, plate )
	self.vars.cams[cam].plate = plate 
end 

function READER:GetIndex( cam )
	return self.vars.cams[cam].index
end 

function READER:SetIndex( cam, index )
	self.vars.cams[cam].index = index 
end 

function READER:GetBoloPlate()
	return self.vars.boloPlate
end 

function READER:SetBoloPlate( plate )
	self.vars.boloPlate = plate
	UTIL:Notify( "BOLO plate set to: " .. plate )
end 

function READER:GetCamLocked( cam )
	return self.vars.cams[cam].locked
end 

function READER:LockCam( cam, playBeep, isBolo )
	if ( PLY:VehicleStateValid() and self:CanPerformMainTask() ) then 
		self.vars.cams[cam].locked = not self.vars.cams[cam].locked

		SendNUIMessage( { _type = "lockPlate", cam = cam, state = self:GetCamLocked( cam ), isBolo = isBolo } )

		if ( self:GetCamLocked( cam ) ) then 
			if ( playBeep ) then 
				SendNUIMessage( { _type = "audio", name = "beep", vol = RADAR:GetSettingValue( "plateAudio" ) } )
			end 

			if ( isBolo ) then 
				SendNUIMessage( { _type = "audio", name = "plate_hit", vol = RADAR:GetSettingValue( "plateAudio" ) } )
			end  
			
			TriggerServerEvent( "trp:onPlateLocked", cam, self:GetPlate( cam ), self:GetIndex( cam ) )
		end 
	end 
end 

function READER:CanPerformMainTask()
	return self.vars.displayed and not self.vars.hidden
end 

function READER:GetCamFromNum( relPos )
	if ( relPos == 1 ) then 
		return "front"
	elseif ( relPos == -1 ) then 
		return "rear"
	end 
end 

RegisterNetEvent( "trp:togglePlateLock" )
AddEventHandler( "trp:togglePlateLock", function( cam, beep, bolo )
	READER:LockCam( cam, beep, bolo )
end )

RegisterNUICallback( "togglePlateReaderDisplay", function( data, cb )
	READER:ToggleDisplayState()
	cb('ok')
end )

RegisterNUICallback( "setBoloPlate", function( plate, cb )
	READER:SetBoloPlate( plate )
	cb('ok')
end )

function READER:Main()
	if ( PLY:VehicleStateValid() and self:CanPerformMainTask() ) then 
		for i = 1, -1, -2 do 
			local pos = GetEntityCoords( PLY.veh )

			local start = GetOffsetFromEntityInWorldCoords( PLY.veh, 0.0, ( 5.0 * i ), 0.0 )

			local offset = GetOffsetFromEntityInWorldCoords( PLY.veh, -2.5, ( 50.0 * i ), 0.0 )

			local veh = UTIL:GetVehicleInDirection( PLY.veh, start, offset )

			local cam = self:GetCamFromNum( i )
			
			if ( DoesEntityExist( veh ) and IsEntityAVehicle( veh ) and not self:GetCamLocked( cam ) ) then 
				local ownH = UTIL:Round( GetEntityHeading( PLY.veh ), 0 )
				local tarH = UTIL:Round( GetEntityHeading( veh ), 0 )

				local dir = UTIL:GetEntityRelativeDirection( ownH, tarH )

				if ( dir > 0 ) then 
					local plate = GetVehicleNumberPlateText( veh )

					local index = GetVehicleNumberPlateTextIndex( veh )

					if ( self:GetPlate( cam ) ~= plate ) then 
						self:SetPlate( cam, plate )

						self:SetIndex( cam, index )

						if ( plate == self:GetBoloPlate() ) then 
							self:LockCam( cam, false, true )
						end 

						SendNUIMessage( { _type = "changePlate", cam = cam, plate = plate, index = index } )

						TriggerServerEvent( "trp:onPlateScanned", cam, plate, index )
					end 
				end 
			end 
		end 
	end 
end 

Citizen.CreateThread( function()
	while ( true ) do
		READER:Main()

		Citizen.Wait( 500 )
	end 
end )

function READER:RunDisplayValidationCheck()
	if ( ( ( PLY.veh == 0 or ( PLY.veh > 0 and not PLY.vehClassValid ) ) and self:GetDisplayState() and not self:GetDisplayHidden() ) or IsPauseMenuActive() and self:GetDisplayState() ) then
		self:SetDisplayHidden( true ) 
		SendNUIMessage( { _type = "setReaderDisplayState", state = false } )
	elseif ( PLY.veh > 0 and PLY.vehClassValid and PLY.inDriverSeat and self:GetDisplayState() and self:GetDisplayHidden() ) then 
		self:SetDisplayHidden( false ) 
		SendNUIMessage( { _type = "setReaderDisplayState", state = true } )
	end 
end

Citizen.CreateThread( function() 
	Citizen.Wait( 100 )

	while ( true ) do 
		READER:RunDisplayValidationCheck()

		Citizen.Wait( 500 )
	end 
end )