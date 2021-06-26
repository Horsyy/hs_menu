fx_version 'adamant'

game 'gta5'

author 'Horse#0001'
description 'Youtube Menu Created based on xSound'
version '1.0.0'

server_script {
    'server/server.lua'
}

client_scripts {
	'config.lua',
    'client/client.lua'
}

dependency 'xsound'