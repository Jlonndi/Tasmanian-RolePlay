-- ## 3dme : server side

-- Command
RegisterCommand('me', function(source, args)
    local text = "* " .. Languages[Config.language].prefix .. table.concat(args, " ") .. " *"
    TriggerClientEvent('3dme:shareDisplay', -1, text, source)
end)
RegisterNetEvent('showid1234')
AddEventHandler('showid1234', function(Name)
   -- local text = "* " .. Languages[Config.language].prefix .. table.concat(args, " ") .. " *"
    TriggerClientEvent('3dme:shareDisplay', -1, '* Identification: '..Name..' *', source)
end)
