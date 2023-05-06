fx_version 'cerulean'
game 'gta5'

author 'Romoy'

shared_scripts {
    "@qb-lib/server/sv_rpc.lua",
    'shared.lua'
}

client_scripts {
    "@qb-lib/client/cl_rpc.lua",
    'client/cl_main.lua'
}

server_scripts {
    "@qb-lib/server/sv_rpc.lua",
    '@oxmysql/lib/MySQL.lua',
    'server/sv_main.lua'
}