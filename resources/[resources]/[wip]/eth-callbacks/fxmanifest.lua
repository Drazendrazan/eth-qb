fx_version "cerulean"
game "gta5"

author 'eth'
description "eth-Callbacks"
version "1.0.0"

shared_scripts {
    "shared/sh_*.lua"
}

client_scripts {
    "@qb-lib/client/cl_rpc.lua",
    "@qb-lib/client/cl_interface.lua",
    "client/cl_*.lua",
}

server_scripts {
    "@qb-lib/server/sv_rpc.lua",
    "server/sv_*.lua",
}

lua54 'yes'

