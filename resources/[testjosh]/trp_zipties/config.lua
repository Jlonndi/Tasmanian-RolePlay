Config = {}

Config.NotifyType = "esx" -- Options = t-notify, esx, feedm, mythic_notify
Config.LoadingType = "mythic" -- Options = mythic, pogress, none
Config.HandcuffTimer = 10 * 60000 -- 10 minutes.

Config.ZiptieRemovers = {
	pliers = { -- Name of item.
		timer = 5, -- How long it takes to remove zipties.
		OneTimeUse = true -- Remove after use? or allowed to use again.
	},
--
}

RegisterNetEvent('bixbi_zipties:notify')
AddEventHandler("bixbi_zipties:notify", function(type, msg)

	if Config.NotifyType == "t-notify" then
		if type == '' or type == nil then type = 'info' end
		exports['t-notify']:Alert({style = type, message = msg})
	elseif Config.NotifyType == "feedm" then
		if type == '' or type == nil then type = 'primary' end
		TriggerEvent("FeedM:showNotification", msg, 2500, type)
	elseif Config.NotifyType == "mythic_notify" then
		if type == '' or type == nil then type = 'inform' end
		exports['mythic_notify']:DoCustomHudText(type, msg, 2500)
	else
		ESX.ShowNotification(msg)
	end
end)

RegisterNetEvent('bixbi_zipties:loading')
AddEventHandler("bixbi_zipties:loading", function(time, text)
	
	if Config.LoadingType == "pogress" then
		exports['pogressBar']:drawBar(time, text)
	elseif Config.LoadingType == "mythic" then
		exports['mythic_progbar']:Progress({
			name = string.gsub(text, "%s+", ""),
			duration = time,
			label = text,
			controlDisables = {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			},
		}, function()
		end)
	else
		-- Do nothing.
	end
end)