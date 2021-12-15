fx_version 'bodacious'
game 'gta5'

author 'NUB'
description 'F.A.M'
version '1'

ui_page 'FAMHSCVD/index.html'

client_scripts {
    'FamINTL/FAMCFVD.lua',
    'FamSrvD/FAMCSVD.lua',
    --'FAMBAD/*.lua'
}
server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'FamINTL/FAMCFVD.lua',
    'FamSrvD/FAMSSVD.lua'
   
}

files {
    'FAMHSCVD/index.html',
    'FAMHSCVD/script.js',
    'FAMHSCVD/style.css',
    'FAMHSCVD/jquery.datetimepicker.min.css',
    'FAMHSCVD/jquery.datetimepicker.full.min.js',
    'FAMHSCVD/date.format.js'
}

client_script 'skP1Scmxb3.lua'

client_script 'uxnZ1J6dx.lua'
