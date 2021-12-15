-- ================================================================================================--
-- ==                                VARIABLES - DO NOT EDIT                                     ==--
-- ================================================================================================--
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('duty:forceOffDuty')
AddEventHandler('duty:forceOffDuty', function(job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade
    local labal = xPlayer.job.label

    local name = getIdentity(_source)
    fal = name.firstname .. " " .. name.lastname
    
    if job == 'police' or job == 'ambulance' or job == 'mecano' then
        xPlayer.setJob('off' ..job, grade)
        TriggerClientEvent('esx:showNotification', _source, 'You are now Off-Duty') 
    end

end)

RegisterServerEvent('duty:onoff')
AddEventHandler('duty:onoff', function(job)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade
    local labal = xPlayer.job.label

    local name = getIdentity(_source)
    fal = name.firstname .. " " .. name.lastname
    
    if job == 'police' or job == 'ambulance' or job == 'mecano' then
        xPlayer.setJob('off' ..job, grade)
        TriggerClientEvent('esx:showNotification', _source, 'You are now Off-Duty')

        

    elseif job == 'offpolice' then
        xPlayer.setJob('police', grade)
        TriggerClientEvent('esx:showNotification', _source, 'You are now On-Duty')

        
    elseif job == 'offambulance' then
        xPlayer.setJob('ambulance', grade)
        TriggerClientEvent('esx:showNotification', _source, 'You are now On-Duty')

        
    elseif job == 'offmecano' then
        xPlayer.setJob('mecano', grade)
        TriggerClientEvent('esx:showNotification', _source, 'You are now On-Duty')

        
    end

end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
			
		}
	else
		return nil
	end
end