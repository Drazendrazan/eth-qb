CreateThread(function()
    exports["qb-polyzone"]:AddBoxZone("paintball_arena", vector3(2341.91, 2558.8, 46.66), 150, 120, {
        heading=0,
        debugPoly = false,
        minZ=43.06,
        maxZ=73.06
    })
end)

RegisterNetEvent("qb-paintball:enterArea",function(args)
    local ped = PlayerPedId()
    local finished = exports["qb-taskbar"]:taskBar(4000,"Elevator...",false,false,playerVeh)
    DoScreenFadeOut(1500)
    TeleportPlayer(vector3(5504.9, 5979.94, 590.01),0)
    TriggerEvent("qb-paintball:enterStadium")
end)

RegisterNetEvent("qb-paintball:exitArea",function(args)
    local ped = PlayerPedId()
    local finished = exports["qb-taskbar"]:taskBar(4000,"Elevator...",false,false,playerVeh)
    DoScreenFadeOut(1500)
    while not IsScreenFadedOut() do
        Wait(10)
    end 
    SetEntityCoords(ped, -282.46, -2031.57, 30.15, false, false, false, true)
    DoScreenFadeIn(1500)
    TriggerEvent("qb-paintball:leaveStadium")
    TriggerEvent("qb-props:removeProp")
    TriggerEvent("qb-paintball:removePaintballs")
end)

RegisterNetEvent("qb-paintball:enterVip",function(args)
    local ped = PlayerPedId()
    if exports['qb-inventory']:HasItem("casino_vip") then
        local finished = exports["qb-taskbar"]:taskBar(4000,"Elevator...",false,false,playerVeh)
        DoScreenFadeOut(1500)
        TeleportPlayer(vector3(5518.1142, 5964.6147, 635.83526),0)
        TriggerEvent("qb-paintball:enterStadium")
    else
        QBCore.Functions.Notify("You need a VIP ticket to enter the VIP area", "error", 5000)
    end
end)

exports["qb-target"]:AddCircleZone("Paintball Elevator Enter", vector3(-282.4173, -2031.692, 30.145576), 2.0, {
    name = "Paintball Elevator",
    useZ = true,
    debugPoly=true
    }, {
    options = {
        {
            type = "client",
            event = "qb-paintball:enterArea",
            icon = "fas fa-dungeon",
            label = "Enter Arena"
        },
        {
            type = "client",
            event = "qb-paintball:enterVip",
            icon = "fas fa-ticket",
            label = "VIP"
        },
    },
    distance = 2.0
})

exports["qb-target"]:AddCircleZone("Paintball Elevator Exit", vector3(5505.0385, 5979.8886, 590.00036), 2.0, {
    name = "Paintball Elevator",
    useZ = true,
    debugPoly=false
    }, {
    options = {
        {
            type = "client",
            event = "qb-paintball:exitArea",
            icon = "fas fa-dungeon",
            label = "Exit Arena"
        },
    },
    distance = 2.0
})

exports["qb-target"]:AddCircleZone("Paintball Elevator Exit VIP", vector3(5518.0292, 5965.0673, 635.83526), 2.0, {
    name = "Paintball Elevator",
    useZ = true,
    debugPoly=false
    }, {
    options = {
        {
            type = "client",
            event = "qb-paintball:exitArea",
            icon = "fas fa-dungeon",
            label = "Exit Arena"
        },
    },
    distance = 2.0
})

CreateThread(function()
    exports['qb-target']:AddTargetModel("xs_prop_arena_telescope_01", {
        options = {
            {
                type = "client",
                event = "telescope:Toggle",
                icon = "fas fa-binoculars",
                label = "Use Telescope",
            },
        },
        distance = 4.0
    })
end)

CreateThread(function()
    exports["qb-polyzone"]:AddBoxZone("paintball_arena_win_east", vector3(5565.9907, 6083.8979, 590.35937), 15, 12, {
        heading=85,
        debugPoly = false,
        minZ=43.06,
        maxZ=73.06
    })
end)