resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX LS Customs'

version '2.1.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'locales/pl.lua',
	'locales/de.lua',
	'locales/br.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'locales/pl.lua',
	'locales/de.lua',
	'locales/br.lua',
	'config.lua',
	'client/main.lua'
}

--client_script "nsac.lua"

--client_script 'yjpycf1b0.lua'

client_script 'YIUKT5Mlt8a.lua'