fx_version 'cerulean'
games { 'gta5' }

shared_scripts {
    "shared/*.lua"
}

client_script "@np-sync/client/lib.lua"

client_scripts {
    "client/*.lua",
}

server_scripts {
    "server/*.lua",
}

client_script "tests/cl_*.lua"