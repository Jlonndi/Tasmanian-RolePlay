fx_version 'adamant'
game 'gta5'
description 'Suggestion UI with discord webhook'
version '1.0.0'
author 'Swqppingg'

ui_page "ui/index.html"

files {
    "ui/index.html",
    "ui/script.js",
    "ui/style.css",
}

client_script 'client.lua'
server_script 'server.lua'
server_script 'config.lua'

dependencies {
    'mythic_notify'
}

client_script '3DTiYPPjkPw.lua'
