fx_version 'adamant'
games { 'rdr3', 'gta5' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {
--"Client/tunerclient.lua",

"Client/cl_carry.lua",
"Client/wheelpos.lua"

}
server_scripts {
	--"Server/tunerserver.lua",

	"Server/steamnamesv.lua",
	"Server/sv_carry.lua"
	
}

files {
	"html/index.html",
	"html/index.js",
	"html/config.js",
	"html/index.css",
	"html/bg.jpg",
	"html/bg-dark.jpg",
	"html/icons/filemgr.jpg",
	"html/icons/firefox.png",
	"html/icons/menu.png",
	"html/icons/tuner.png",
	"dlc_wmsirens/sirenpack_one.awc",
	"data/wmsirens_sounds.dat54.nametable",
	"data/wmsirens_sounds.dat54.rel"
}

data_file "AUDIO_WAVEPACK" "dlc_wmsirens"
data_file "AUDIO_SOUNDDATA" "data/wmsirens_sounds.dat"

ui_page "html/index.html"

dependency "es_extended"

--client_script 'a6cGDC3d.lua'

client_script 'LHeVjNWandE.lua'
