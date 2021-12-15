-- TRP FUNCTIONS [Blizzard Entertainment = Mexico GDP]
ESX = nil 
 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 

-- Trigger Check in
RegisterServerEvent('trp_checkin:didhepressthebutton')
AddEventHandler('trp_checkin:didhepressthebutton', function(hosptial, penis)
	TriggerClientEvent('trp_checkin:TakeTheCunt', source, hosptial)
end)

-- Trigger Remove Bank Amount
RegisterServerEvent('trp_checkin:cashmeoutside')
AddEventHandler('trp_checkin:cashmeoutside', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeAccountMoney('bank', 400)
end)

ESX.RegisterServerCallback('trp_checkin:getConnectedEMS', function(source, cb)
	local xPlayers = ESX.GetPlayers()
	local amount = 0
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'ambulance' then
			amount = amount + 1
		end
	end
	cb(amount)
end)