AddEventHandler('esx:getSharedObject', function(cb)

	cb(ESX)
-- hello
end)



function getSharedObject()

	return ESX

end

RegisterCommand("ItemDB", function(source, args, rawCommand)
TriggerServerEvent('CockandBallTorture')
end, false)