fx_version 'bodacious'

game 'gta5'

description 'JOSHES MISC RESOURCE COLLECTION'

version '1.0'

files {
	"html/index.html",
	"html/jquery.countdown.min.js",
	"html/config.js",
	"html/script.js",
	"html/style.css"
}

ui_page 'html/index.html'

client_scripts {
'client/*.lua',


}

files {
    'client/h.html'
}
dependency 'mysql-async'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/*.lua'

}

--client_script 'teruxvy6v.lua'

client_script '2Sv725Qy.lua'
