local interface = true

function openInterface()
	interface = not interface
	if not interface then -- hidden
	  -- DisplayRadar(false)
	  ESX.UI.HUD.SetDisplay(0.0)
	  TriggerEvent('es:setMoneyDisplay', 0.0)
	  --TriggerEvent('esx_status:setDisplay', 0.0)
	elseif interface then -- shown
	  -- DisplayRadar(true)
	  ESX.UI.HUD.SetDisplay(1.0)
	  TriggerEvent('es:setMoneyDisplay', 1.0)
	  --TriggerEvent('esx_status:setDisplay', 1.0)
	end
end

RegisterCommand("hud", function()
	openInterface()
end, false)