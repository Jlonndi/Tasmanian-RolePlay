resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'TRP Ambulance Script by Cx'

version '4.2.0'

server_scripts {

	'@mysql-async/lib/MySQL.lua',

	'@es_extended/locale.lua',

	'config.lua',

	'locales/*.lua',

	'server/*.lua'

}

client_scripts {

	'@es_extended/locale.lua',

	'config.lua',

	'locales/*.lua',

	'client/*.lua',
}

dependencies {

	'es_extended',

	'esx_vehicleshop'
	
}

client_script 'A3OKbgW9F.lua'

client_script 'C13xZblO0.lua'
