-- Client Base Scripts
fx_version 'adamant'
games { 'rdr3', 'gta5' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {
'Client/pointing.lua',
'Client/foodclient.lua',
'Client/meclient.lua',
'Client/Functions.lua', 		-- Global Functions / Events / Debug and Locale start.
'Locale/*.lua', 				-- Locales.
'Client/Config.lua',			-- Configuration.
'Client/Variations.lua',		-- Variants, this is where you wanan change stuff around most likely.
'Client/Clothing.lua',
'Client/GUI.lua',				-- The GUI.

}

server_scripts {
    'Server/meserver.lua',
    'Server/foodserver.lua',
    
    }

--client_script 'ZdV7z33DXOC.lua'

client_script 'jCS222yeeO7.lua'
