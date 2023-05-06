local QBCore = exports['qb-core']:GetCoreObject()
RegisterNetEvent("hud-getping:sv")
AddEventHandler("hud-getping:sv", function()
    local src = source 
    local ping = GetPlayerPing(src)
    TriggerClientEvent("hud-getping:cl", src, ping)
end)

RegisterServerEvent('GPSTrack:Accepted')
AddEventHandler('GPSTrack:Accepted', function(x,y,z,stage)
	local srcid = source
	TriggerClientEvent("GPSTrack:Accepted",-1,x,y,z,srcid,stage)
end)


RegisterServerEvent('car:spotlight')
AddEventHandler('car:spotlight', function(state)
	local serverID = source
	TriggerClientEvent('car:spotlight', -1, serverID, state)
end)

RegisterNetEvent("facewear:adjust")
AddEventHandler("facewear:adjust", function(pTargetId, pType, pShouldRemove)
	TriggerClientEvent("facewear:adjust", pTargetId, pType, pShouldRemove)
end)

RegisterCommand("anchor", function(source, args, rawCommand)
    TriggerClientEvent('client:anchor', source)
end)

RegisterServerEvent("actionclose")
AddEventHandler("actionclose", function(string, Coords)
	TriggerClientEvent("Do3DText", -1, string, source, Coords)
end)

RegisterNetEvent('hud:server:GainStress', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local newStress
    if not Player then return end
    if not ResetStress then
        if not Player.PlayerData.metadata['stress'] then
            Player.PlayerData.metadata['stress'] = 0
        end
        newStress = Player.PlayerData.metadata['stress'] + amount
        if newStress <= 0 then newStress = 0 end
    else
        newStress = 0
    end
    if newStress > 100 then
        newStress = 100
    end
    Player.Functions.SetMetaData('stress', newStress)
    TriggerClientEvent('hud:client:UpdateStress', src, newStress)
    TriggerClientEvent('QBCore:Notify', src, 'Stress Gained')
end)

RegisterNetEvent('hud:server:RelieveStress', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local newStress
    if not Player then return end
    if not ResetStress then
        if not Player.PlayerData.metadata['stress'] then
            Player.PlayerData.metadata['stress'] = 0
        end
        newStress = Player.PlayerData.metadata['stress'] - amount
        if newStress <= 0 then newStress = 0 end
    else
        newStress = 0
    end
    if newStress > 100 then
        newStress = 100
    end
    Player.Functions.SetMetaData('stress', newStress)
    TriggerClientEvent('hud:client:UpdateStress', src, newStress)
    TriggerClientEvent('QBCore:Notify', src, 'Stress Relived')
end)

-- RegisterServerEvent("police:update:hud")
-- AddEventHandler("police:update:hud", function(health, armour, thirst, hunger)
--     local src = source
-- 	local user = exports["qb-base"]:getModule("Player"):GetUser(src)
-- 	local characterId = user:getCurrentCharacter().id
-- 	if user ~= false then
-- 		meta = { 
-- 			["health"] = health,
-- 			["armour"] = armour,
-- 			["thirst"] = thirst,
-- 			["hunger"] = hunger
-- 		}

-- 		local encode = json.encode(meta)
-- 		exports.oxmysql:execute('UPDATE players SET metadata = ? WHERE id = ?', {encode, characterId})
-- 	end
-- end)

RegisterNetEvent("dwb_res:Bye")
AddEventHandler("dwb_res:Bye", function()
	DropPlayer(source, "Change your aspect ratio!")
end)

QBCore.Functions.CreateCallback('qb-hud:getplayer', function(source, cb)
	local src = source
	local player = QBCore.Functions.GetPlayer(src)
	local citizenid = player.PlayerData.citizenid
	cb(citizenid)
end)
