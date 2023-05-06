local QBCore = exports['qb-core']:GetCoreObject()



AddEventHandler('onResourceStart', function(resource) --if you restart the resource
    if resource == GetCurrentResourceName() then
        Wait(200)
        PlayerJob = QBCore.Functions.GetPlayerData().job
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)


local teamPlayersEast = 0
local teamPlayersWest = 0
local gameInProgress = false
local inStadium = false
local flagProp = "prop_golfflag"
local flagPropHash = GetHashKey(flagProp)
local flagObjNetId = 0
local isCarryingFlag = false

local function drawStatusHud()
    if not inStadium then return end
    SendNUIMessage({
        app = "status-hud",
        show = false,
        data = {
            show = true,
            title = "Paintball - Match " .. (gameInProgress and "In Progress" or "Pending"),
            values = {
            "East Team: " .. teamPlayersEast .. " player(s)",
            "West Team: " .. teamPlayersWest .. " player(s)",
            },
        },
    })
end

RegisterNetEvent('qb-paintball:getVendor', function()
    exports['qb-menu']:openMenu({
        {
            
            header = "📜 Vendor",
            isMenuHeader = true, -- Set to true to make a nonclickable title
        },
        {
            
            header = "🏴 Join West Team",
            txt = "Paintball Teammates",
            params = {
                event = "qb-paintball:joinWest"
            }
        },
        {
           
            header = "🏴‍☠️ Join East Team",
            txt = "Paintball Teammates",
            params = {
                event = "qb-paintball:joinEast"
            }
        },
        {
           
            header = "⭕ Leave Team",
            txt = "Paintball Teammates",
            params = {
                event = "qb-paintball:leaveTeam"
            }
        },
        {
           
            header = "🏁 Start Game",
            txt = "Paintball Game",
            params = {
                event = "qb-paintball:startGame"
            }
        },
        {
           
            header = "🚩 End Game",
            txt = "Paintball Game",
            params = {
                event = "qb-paintball:endGame"
            }
        },
        {
            
            header = "❌ Close (ESC)",
            isMenuHeader = true, -- Set to true to make a nonclickable title
        },
    })
end)

RegisterNetEvent("qb-paintball:joinWest")
AddEventHandler("qb-paintball:joinWest", function()
    QBCore.Functions.TriggerCallback('qb-paintball:game:action', function() end, 'join', 'west')
    QBCore.Functions.Notify('Joined team West!', 'success')
end)

RegisterNetEvent("qb-paintball:joinEast")
AddEventHandler("qb-paintball:joinEast", function()
    QBCore.Functions.TriggerCallback('qb-paintball:game:action', function() end, 'join', 'east')
    QBCore.Functions.Notify('Joined team East!', 'success')
end)

RegisterNetEvent("qb-paintball:leaveTeam")
AddEventHandler("qb-paintball:leaveTeam", function()
    QBCore.Functions.TriggerCallback('qb-paintball:game:action', function() end, 'leave')
    QBCore.Functions.Notify('Left team!', 'success')
end)

RegisterNetEvent("qb-paintball:startGame")
AddEventHandler("qb-paintball:startGame", function()
    QBCore.Functions.TriggerCallback('qb-paintball:game:action', function() end, 'start')
    QBCore.Functions.Notify('Game Started!', 'success')
    
end)

RegisterNetEvent("qb-paintball:endGame")
AddEventHandler("qb-paintball:endGame", function()
    QBCore.Functions.TriggerCallback('qb-paintball:game:action', function() end, 'end')
    QBCore.Functions.Notify('Game ended!', 'success')
end)

RegisterNetEvent("qb-paintball:game:update")
AddEventHandler("qb-paintball:game:update", function(pCtx)
    if gameInProgress ~= pCtx.gameInProgress then
        removeAttachedProp()
    end
    teamPlayersEast = pCtx.teamPlayersEast
    teamPlayersWest = pCtx.teamPlayersWest
    gameInProgress = pCtx.gameInProgress
    drawStatusHud()
end)

RegisterCommand("enter", function(source, args)
    TriggerEvent("qb-paintball:enterStadium")
    TriggerEvent("qb-paintball:joinEast")
    TriggerEvent("qb-paintball:startGame")
end)

RegisterCommand("end", function(source, args)
    TriggerEvent("qb-paintball:endGame")
    QBCore.Functions.Notify('Game ended!', 'success')
end)

RegisterCommand("flag", function(source)
    TriggerEvent("qb-props:removeProp")
end)

AddEventHandler("qb-paintball:enterStadium", function()
    inStadium = true
    drawStatusHud()
end)
  
AddEventHandler("qb-paintball:leaveStadium", function()
    inStadium = false
    SendNUIMessage({
        app = "status-hud",
        show = false,
        data = { show = false },
    })
end)

RegisterNetEvent("qb-paintball:game:spawnFlag", function(pCoords)
    local flagObj = CreateObject(flagPropHash, pCoords, 1, 1, 0)
    Wait(0)
    TriggerServerEvent("qb-paintball:game:spawnedFlag", NetworkGetNetworkIdFromEntity(flagObj))
end)

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

AddEventHandler("qb-paintball:game:pickupFlag", function()
    loadAnimDict('anim@narcotics@trash')
    TaskPlayAnim(PlayerPedId(),'anim@narcotics@trash', 'drop_front',0.9, -8, 1700, 49, 1.0, 0, 0, 0)
    local success = exports['qb-lock']:StartLockPickCircle(1,3)
    if success then
    isCarryingFlag = true
    TriggerEvent("qb-props:attachProp", flagProp, 24818, -0.25, -0.25, 0.0, 180.0, 90.0, 0.0)
    QBCore.Functions.Notify('Picked up flag.. run!', 'success')
    TriggerServerEvent("qb-paintball:game:pickedUpFlag")
    -- Wait(5000)
    -- removeAttachedProp()
    else end
end)

local isDead = false
AddEventHandler("pd:deathcheck", function()
  isDead = not isDead
  if isDead then
    TriggerEvent("qb-paintball:game:playerDied")
  end
  if not isDead then return end
  if gameInProgress and inStadium then
    TriggerEvent("qb-props:removeProp")
    TriggerEvent("qb-paintball:leaveTeam")
    QBCore.Functions.TriggerCallback("qb-paintball:game:action", function() end, "leave")
    Wait(1)
    TriggerEvent('hospital:client:Revive', PlayerPedId())
  end
  if not isCarryingFlag then return end
  TriggerEvent("qb-props:removeProp")
  local coordsC = GetEntityCoords(PlayerPedId())
  local coords = vector3(coordsC.x - 0.25, coordsC.y + 0.25, coordsC.z - 1.0)
  TriggerServerEvent("qb-paintball:game:diedWithFlag", coords)
end)
