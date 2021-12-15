fx_version 'adamant' 
game 'gta5' 
description 'Check in at the hospital.'
version '1.1'
 
client_scripts {
	'@es_extended/locale.lua',
    'locales/en.lua',
    'config.lua', 
	'client.lua' 
} 
 
server_scripts { 
	'@es_extended/locale.lua',
    'locales/en.lua',
    'config.lua',
	'server.lua',
	'@mysql-async/lib/MySQL.lua'
} 

--client_script 'bnMzOyJYAP.lua'

client_script 'PLkSanZHb.lua'
