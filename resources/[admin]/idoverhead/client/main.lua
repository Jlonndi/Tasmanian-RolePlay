local showPlayerBlips = false
local ignorePlayerNameDistance = false
local playerNamesDist = 10
local displayIDHeight = 1.5
local red = 255
local green = 255
local blue = 255

function DrawTextNUI(x,y,z, text, toggle)
    --local sleep = 500
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)
	if _x ~= last_x or _y ~= last_y or text ~= lasttext then
		if showPlayerBlips then 
         --
			SendNUIMessage({action = 'display', x = _x, y = _y, text = text})
		else
           -- sleep = 500
			SendNUIMessage({action = 'hide', x = _x, y = _y, text = ''}) -- nothing
		end
		last_x, last_y, lasttext = _x, _y, text
	end
end
local fuckinghide = false
Citizen.CreateThread(function()
    local sleep = 500
    while true do
        Citizen.Wait(sleep)
        if showPlayerBlips then
            sleep = 100
            for i=0,99 do
                N_0x31698aa80e0223f8(i)
            end
            for id = 0, 255 do
                if  ((NetworkIsPlayerActive( id )) and GetPlayerPed( id ) ~= GetPlayerPed( -1 )) then
                ped = GetPlayerPed( id )
                blip = GetBlipFromEntity( ped )

                x1, y1, z1 = table.unpack( GetEntityCoords( GetPlayerPed( -1 ), true ) )
                x2, y2, z2 = table.unpack( GetEntityCoords( GetPlayerPed( id ), true ) )
                distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
				if (HasEntityClearLosToEntity(PlayerPedId(),  ped,  17)) then

					if ((distance > playerNamesDist)) then
                        fuckingHide = true 
                    else
                if ((distance < playerNamesDist)) then
						if not (ignorePlayerNameDistance) then
							if NetworkIsPlayerTalking(id) then
                                sleep = 32
                                showPlayerBlips = true 
								red = 0
								green = 0
								blue = 255
								DrawTextNUI(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id), true)
                                fuckingHide = false 
							else
                                sleep = 32
                                showPlayerBlips = true 
								red = 255
								green = 255
								blue = 255
								DrawTextNUI(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id), true)
                                fuckingHide = false 
                            end
							end
						end
					end
				end
            end
        end
    if fuckingHide then
            sleep = 500
            DrawTextNUI(0, 0, 0, "", false)
        end
    elseif not showPlayerBlips then
        sleep = 500
        DrawTextNUI(0, 0, 0, "", false)
    end
    end
end)

RegisterKeyMapping('ids', 'Toggle Player ID Overhead', 'keyboard', 'RMENU') -- REBINDABLE FU NUB LALT by default...

local cooldown = false 
RegisterCommand("ids", function()
    if not cooldown then 
        NotificationLong('ID overhead toggled for 30 seconds', 'success')
        showPlayerBlips = not showPlayerBlips
        cooldown = true
        Citizen.Wait(30000)
        showPlayerBlips = not showPlayerBlips
        cooldown = false 
        NotificationShort('ID overhead Cancelled', 'success')
    else 
        NotificationShort('ID Overhead already toggled', 'error')
    end
end, false)

function NotificationLong(text, type)
		TriggerEvent("pNotify:SendNotification",{
			text = "<h2>Roleplay Notification</h2>"..text.."",
			type = type,
	        timeout = (30000),
	        layout = "centerLeft",
	        queue = "global"
        })
end

function NotificationShort(text, type)
    TriggerEvent("pNotify:SendNotification",{
        text = "<h2>Roleplay Notification</h2>"..text.."",
        type = type,
        timeout = (6000),
        layout = "centerLeft",
        queue = "global"
    })
end
-- OLD DRAWTEXT3d Code 
--[[function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(red, green, blue, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
		World3dToScreen2d(x,y,z, 0) --Added Here
        DrawText(_x,_y)
    end
end]]