local QBCore = exports['qb-core']:GetCoreObject()

local inArena = false
local isDead = false
local lastHitByPaintball = false

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function TeleportPlayer(pCoords, pHeading)
    local heading = pHeading * 1.0
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local teleportCoords = vector3(pCoords.x, pCoords.y, pCoords.z)

    local time = math.floor((#(teleportCoords - playerCoords) / 50) * 100)
    local entity = IsPedInAnyVehicle(playerPed) and GetVehiclePedIsIn(playerPed) or playerPed

    DoScreenFadeOut(400)

    while IsScreenFadingOut() do
        Wait(0)
    end

    NetworkFadeOutEntity(playerPed, true, true)
    SetPedCoordsKeepVehicle(playerPed, teleportCoords)
    SetEntityHeading(entity, heading)
    SetGameplayCamRelativeHeading(0.0)
    Wait(time)
    NetworkFadeInEntity(playerPed, true)
    DoScreenFadeIn(400)
end

CreateThread(function()
    exports['qb-target']:AddTargetModel("u_m_y_rsranger_01", {
        options = {
            {
                type = 'client',
                event = 'qb-paintball:getItems',
                icon = 'fas fa-gun',
                label = 'Take Items',
            },
        },
        distance = 4.0
    })
    exports['qb-target']:AddTargetModel("mp_m_bogdangoon", {
        options = {
            {
                type = "client",
                event = "qb-paintball:getVendor",
                icon = "fas fa-leaf",
                label = 'Check Vendor',
            },
        },
        distance = 4.0
    })
end)

RegisterNetEvent('qb-paintball:getItems', function()
    exports['qb-menu']:openMenu({
        {
            
            header = "🏹 Gunner",
            isMenuHeader = true, -- Set to true to make a nonclickable title
        },
        {
            
            header = "🔫 Paintball Gun",
            txt = "1x",
            params = {
                event = "qb-paintball:getPaintballGun"
            }
        },
        {
           
            header = "🎱 Paintball Ammo",
            txt = "5x",
            params = {
                event = "qb-paintball:getPaintballAmmo"
            }
        },
        {
           
            header = "💨 Smoke Grenade",
            txt = "1x",
            params = {
                event = "qb-paintball:getPaintballSmoke"
            }
        },
        {
           
            header = "🎫 Enabled Wasteland",
            txt = "Map",
            params = {
                event = "qb-paintball:setArenaType"
            }
        },
        {
            
            header = "❌ Close (ESC)",
            isMenuHeader = true, -- Set to true to make a nonclickable title
        },
    })
end)

RegisterNetEvent("qb-paintball:getPaintballGun", function()
    QBCore.Functions.Notify('Bought Paintball Gun!', 'success')
    TriggerServerEvent("qb-paintball:getPaintballGuns")
end)

RegisterNetEvent("qb-paintball:getPaintballAmmo", function()
    QBCore.Functions.Notify('Bought Ammo!', 'success')
    TriggerServerEvent("qb-paintball:getPaintballAmmos")
end)

RegisterNetEvent("qb-paintball:getPaintballSmoke", function()
    QBCore.Functions.Notify('Bought Smokes', 'success')
    TriggerServerEvent("qb-paintball:getPaintballSmokes")
end)

AddEventHandler("qb-polyzone:enter", function(zone)
    if zone ~= "paintball_arena" then return end
    inArena = true
end)

AddEventHandler("qb-polyzone:exit", function(zone)
    if zone ~= "paintball_arena" then return end
    inArena = false
    lastHitByPaintball = false
end)


RegisterNetEvent("qb-paintball:reviveAfterDown", function()
    if inArena and isDead then
      TriggerEvent("reviveFunction")
      print("revive")
    end
end)

AddEventHandler("pd:deathcheck", function()
    isDead = not isDead
end)

local arenaVariations = {
    ["set_arena_dirt"] = {
      ["wasteland"] = true,
    },
    ["set_npa"] = {
      ["wasteland"] = true,
    },
}

AddEventHandler("qb-paintball:setArenaType", function(pArgs)
    QBCore.Functions.TriggerCallback("qb-paintball:setArenaType")
end)
  
RegisterNetEvent("qb-paintball:changeArenaType", function(pType)
    local cInteriorId = GetInteriorAtCoords(5505.03, 5997.68, 590.0)
    for k, v in pairs(arenaVariations) do
        DeactivateInteriorEntitySet(cInteriorId, k)
    end
    for k, v in pairs(arenaVariations) do
        if v[pType] then
        ActivateInteriorEntitySet(cInteriorId, k)
        end
    end
    RefreshInterior(cInteriorId)
end)

CreateThread(function()
    Wait(60000)
    TriggerServerEvent("qb-paintball:getArenaType")
end)

Enabled = {
    ['Playground_1'] = true,
    ['Terrain_1'] = true,
    ['Vegetation_1'] = true,
}

IPLs = {
    Playground_1 = {
        "gabz_npa_hyperpipe",
    },
    Terrain_1 = {
        "gabz_npa_terrain1",
    },
    Vegetation_1 = {
        "gabz_npa_fern_proc",
        "gabz_npa_grass_mix_proc",
        "gabz_npa_grass_proc",
        "gabz_npa_grass_sm_proc",
        "gabz_npa_grass_xs_proc",
        "gabz_npa_log_proc",
        "gabz_npa_stones_proc",
        "gabz_npa_trees"
    },
}

-- do not touch
CreateThread(function()
    Wait(60000)
    for category, iplName in pairs(IPLs) do
        if Enabled[category] then
        for k,v in pairs(iplName) do 
            RequestIpl(v)
        end
        end
    end
end)