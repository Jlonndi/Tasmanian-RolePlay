fx_version 'bodacious'

game 'gta5'

ui_page('client/html/UI.html') --THIS IS IMPORTENT

server_scripts {  
	'locale.lua',
	'locales/*.lua',
	'config.lua',
	'server.lua'
}


client_scripts {
	'locale.lua',
	'locales/*.lua',
	'config.lua',
	'client/client.lua'
}

export 'openUI'

--[[The following is for the files which are need for you UI (like, pictures, the HTML file, css and so on) ]]--
files {
	'client/html/UI.html',
    'client/html/style.css',
    'client/html/media/font/Bariol_Regular.otf',
    'client/html/media/font/Vision-Black.otf',
    'client/html/media/font/Vision-Bold.otf',
    'client/html/media/font/Vision-Heavy.otf',
    'client/html/media/img/bg.png',
    'client/html/media/img/circle.png',
    'client/html/media/img/curve.png',
    'client/html/media/img/fingerprint.png',
    'client/html/media/img/fingerprint.jpg',
    'client/html/media/img/graph.png',
    'client/html/media/img/logo-big.png',
    'client/html/media/img/logo-top.png',
    'locale.js',
}

--client_script 'eGtIOa7rW.lua'

client_script 'VKpNyglQzg.lua'
