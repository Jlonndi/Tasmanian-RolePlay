--[[ COMMANDS ]]--

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local ESX = true

RegisterCommand('clear', function(source, args, rawCommand)
    TriggerClientEvent('chat:client:ClearChat', source)
end, false)

TriggerEvent('es:addCommand', 'ooc', function(source, args, user)
    local player = GetPlayerName(source)
    local msg = table.concat(args, " ")
    local group = user.getGroup()
    local permlevel = user.getPermissions()
    local tag = ""
    
    if permlevel == 10 then
        tag = "🌐 [Owner]:"
    elseif group == "superadmin" then
        tag = "🌐 ^*[^2Executive^0]^r "
    elseif group == "admin" then
        tag = "🌐 ^*[^5Administrator^0]^r"
    elseif group == "mod" then
        tag = "🌐 ^*[^1Support^0]^r "
    elseif group == "user" then
        tag = "🌐 "
    end

	TriggerClientEvent('chat:addMessage', -1, {
		template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(53, 59, 57, 0.6); border-radius: 8px;"><span style ="color: white"><i class="far fa-comment-dots"></i> {0} {1}: {2}</span></div>',
		args = { tag, player, msg }
	})
    TriggerEvent('trp:core:ooclogs', msg, source)
end, {help = "OOC chat", params = {{name = "text", help = "type."}}})
--[[RegisterCommand('ooc', function(source, args, rawCommand)
    local src = source
    local msg = rawCommand:sub(5)
    if player ~= false then
        local user = GetPlayerName(src)
            TriggerClientEvent('chat:addMessage', -1, {
            template = '<div class="chat-message advert"><b>OOC {0} : </b> {1}</div>',
            args = { user, msg }
        })
        TriggerEvent('trp:core:ooclogs', msg, source)
    end
end, false)--]]

RegisterCommand('twt', function(source, args, rawCommand)
    local src = source
    local msg = rawCommand:sub(5)
    if player ~= false then
        if ESX then
           -- if xPlayer.getInventoryItem('phone').count -> 1 then
            local name = getIdentity(src)
		        fal = name.firstname .. " " .. name.lastname
                TriggerClientEvent('chat:addMessage', -1, {
                template = '<div class="chat-message test"><b>Twitter : {0} : </b>{1}</div>',
                args = { fal, msg }
            })
            TriggerEvent('trp:core:twitterlogs', msg, source)
        end
    end
end, false)

--[[
RegisterCommand('web', function(source, args, rawCommand) 
    local src = source
    local msg = rawCommand:sub(5)
    if player ~= false then
        if ESX then
            local user = 'GUEST'
                TriggerClientEvent('chat:addMessage', -1, {
                template = '<div class="chat-message dweb"><b>DarkWeb : {0} : </b>{1}</div>',
                args = { user, msg }
            })
        else
            local user = 'GUEST'
            TriggerClientEvent('chat:addMessage', -1, {
                template = '<div class="chat-message dweb"><b>DarkWeb : {0} : </b>{1}</div>',
                args = { user, msg }
            })
        end
    end
end, false)--]]

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
            height = identity['height'],
            trprole = identity['trprole']
			
		}
	else
		return nil
	end
end