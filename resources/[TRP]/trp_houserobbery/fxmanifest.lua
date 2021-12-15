fx_version 'adamant'
games { 'rdr3', 'gta5' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

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
    "clientthreat.lua",
    'configt.lua',
  'clientteleport.lua',
    'clienttoxic.lua',
    'notifications_client.lua',
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
ui_page 'index.html'
ui_page 'assets/index.html'
ui_page {
    'html/index.html',
}
files {
    "index.html",
    "scripts.js",
    "css/style.css",
    'assets/index.html',
    'assets/css/main.css',
    'assets/js/main.js',
    'html/index.html',
    'stream/v_int_shop.ytyp'
}

exports {
    'StartDelayedFunction'
}

