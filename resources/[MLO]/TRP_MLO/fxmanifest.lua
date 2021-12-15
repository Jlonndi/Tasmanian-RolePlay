fx_version 'cerulean'
game 'gta5'

author 'TRP'
description 'MLOS'
version '1.0.0'

this_is_a_map 'yes'

------------------------------
data_file 'TIMECYCLEMOD_FILE' 'Data/GABZMRPD/gabz_mrpd_timecycle.xml'
data_file 'INTERIOR_PROXY_ORDER_FILE' 'Data/GABZMRPD/interiorproxies.meta'
data_file 'TIMECYCLEMOD_FILE' 'Data/GABZPILLBOXV2/gabz_timecycle_mods_1.xml'
data_file 'DLC_ITYP_REQUEST' 'Data/BIGBENNYS/patoche_elevatorb1.ytyp'

files {
	'Data/GABZMRPD/gabz_mrpd_timecycle.xml',
    'Data/GABZMRPD/interiorproxies.meta',
    'Data/GABZPILLBOXV2/gabz_timecycle_mods_1.xml',
}

client_scripts {
    "Data/GABZMRPD/gabz_mrpd_entitysets.lua",
    "Data/GABZPILLBOXV2/main.lua",
    "Data/TRP_SANDY_PD/main.lua",
    "Data/BENNYSLIFT/client.lua",
}

server_scripts {
    "Data/BENNYSLIFT/server.lua",
}

--client_script 'yPBTZ1xkv36.lua'

client_script 'Q0jL8Ah0j.lua'
