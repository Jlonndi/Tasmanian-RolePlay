fx_version 'bodacious'

game 'gta5'

author 'TassieRP'

description 'Custom Drug Script'

mod 'trp-drugs'

version '4.2.0.6969'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/avail.lua',
	'server/trpdrugs.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'client/*.lua'
}

shared_script 'config.lua'

dependencies {
	'es_extended'
}


--client_script "AntiDumper.lua"

--client_script '4m8XFjftWg.lua'

--client_script 'E9xNSUBY17.lua'
