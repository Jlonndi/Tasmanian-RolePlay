local coordsVisible = false

function DrawTxt(text, x, y)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextScale(0.0, 0.4)
	SetTextDropshadow(1, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

Citizen.CreateThread(function()
    while true do
		if coordsVisible then
			Citizen.Wait(0)
            DisplayXYZ() -- loops this function while true
        else
            Citizen.Wait(500)
		end
	end
end)


ToggleCoords = function()
	coordsVisible = not coordsVisible
end

--[[RegisterCommand("coords", function()
    ToggleCoords()
end)
]]
RegisterNetEvent('TRP:COORDS')
AddEventHandler('TRP:COORDS', function()
    ToggleCoords()
end)
function DisplayXYZ()
    local entity = IsPedInAnyVehicle(PlayerPedId()) and GetVehiclePedIsIn(PlayerPedId(), false) or PlayerPedId()
    local pos = GetEntityCoords(entity, true)
    DrawTxt("~r~X:~s~ "..tonumber(string.format("%.2f", pos.x)), 0.32, 0.00)
    DrawTxt("~r~Y:~s~ "..tonumber(string.format("%.2f", pos.y)), 0.38, 0.00)
    DrawTxt("~r~Z:~s~ "..tonumber(string.format("%.2f", pos.z)), 0.445, 0.00)
    heading = GetEntityHeading(entity)
    DrawTxt("~r~H:~s~ "..tonumber(string.format("%.2f", heading)), 0.50, 0.00)
    local rx,ry,rz = table.unpack(GetEntityRotation(PlayerPedId(), 1))
    DrawTxt("~r~RX:~s~ "..tonumber(string.format("%.2f", rx)), 0.38, 0.03)
    DrawTxt("~r~RY:~s~ "..tonumber(string.format("%.2f", ry)), 0.44, 0.03)
    DrawTxt("~r~RZ:~s~ "..tonumber(string.format("%.2f", rz)), 0.495, 0.03)
    DrawTxt("~r~Player Speed: ~s~"..tonumber(string.format("%.2f", GetEntitySpeed(PlayerPedId()))), 0.40, 0.92)
    DrawTxt("~r~Player Health: ~s~"..GetEntityHealth(PlayerPedId()), 0.40, 0.95)
    DrawTxt("~r~CR X: ~s~"..tonumber(string.format("%.2f", GetGameplayCamRot().x)), 0.36, 0.88)
    DrawTxt("~r~CR Y: ~s~"..tonumber(string.format("%.2f", GetGameplayCamRot().y)), 0.44, 0.88)
    DrawTxt("~r~CR Z: ~s~"..tonumber(string.format("%.2f", GetGameplayCamRot().z)), 0.51, 0.88)
    if IsPedInAnyVehicle(PlayerPedId(), 1) then
        DrawTxt("~r~Engine Health: ~s~"..tonumber(string.format("%.2f", GetVehicleEngineHealth(GetVehiclePedIsUsing(PlayerPedId())))), 0.015, 0.76)
        DrawTxt("~r~Body Health: ~s~"..tonumber(string.format("%.2f", GetVehicleBodyHealth(GetVehiclePedIsUsing(PlayerPedId())))), 0.015, 0.73)
        DrawTxt("~r~Vehicle Fuel: ~s~"..tonumber(string.format("%.2f", GetVehicleFuelLevel(GetVehiclePedIsUsing(PlayerPedId())))), 0.015, 0.70)
    end
end