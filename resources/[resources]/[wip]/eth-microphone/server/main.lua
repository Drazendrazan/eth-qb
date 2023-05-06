local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("megaphone", function(source, item)
    TriggerClientEvent("eth-megaphone:megaphone", source)
end)
 