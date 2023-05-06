-- CLOSE APP
function SetInterfaceFocus(hasKeyboard, hasMouse)
  SetNuiFocus(hasKeyboard, hasMouse)
end

exports('SetInterfaceFocus', SetInterfaceFocus)

RegisterNUICallback("qb-interface:closeApp", function(data, cb)
    SetInterfaceFocus(false, false)
    cb({data = {}, meta = {ok = true, message = 'done'}})
    Wait(800)
    TriggerEvent("attachedItems:block",false)
end)

RegisterNUICallback("qb-interface:applicationClosed", function(data, cb)
    TriggerEvent("qb-interface:application-closed", data.name, data)
    cb({data = {}, meta = {ok = true, message = 'done'}})
end)

-- FORCE CLOSE
RegisterCommand("qb-interface:force-close", function()
    SendInterfaceMessage({source = "qb-nui", app = "", show = false});
    SetInterfaceFocus(false, false)
end, false)

-- SMALL MAP
RegisterCommand("qb-interface:small-map", function()
  SetRadarBigmapEnabled(false, false)
end, false)

local function restartUI(withMsg)
  SendInterfaceMessage({ source = "qb-nui", app = "main", action = "restart" });
  if withMsg then
    TriggerEvent("DoLongHudText", "You can also use 'ui-r' as a shorter version to restart!")
  end
  Wait(5000)
  TriggerEvent("qb-interface:restarted")
  SendInterfaceMessage({ app = "hud", data = { display = true }, source = "qb-nui" })
  local cj = exports["police"]:getCurrentJob()
end
RegisterCommand("qb-interface:restart", function() restartUI(true) end, false)
RegisterCommand("ui-r", function() restartUI() end, false)
RegisterNetEvent("qb-interface:server-restart")
AddEventHandler("qb-interface:server-restart", restartUI)

RegisterCommand("qb-interface:debug:show", function()
    SendInterfaceMessage({ source = "qb-nui", app = "debuglogs", data = { display = true } });
end, false)

RegisterCommand("qb-interface:debug:hide", function()
    SendInterfaceMessage({ source = "qb-nui", app = "debuglogs", data = { display = false } });
end, false)

RegisterNUICallback("qb-interface:resetApp", function(data, cb)
    SetInterfaceFocus(false, false)
    cb({data = {}, meta = {ok = true, message = 'done'}})
    --sendCharacterData()
end)

RegisterNetEvent("qb-interface:server-relay")
AddEventHandler("qb-interface:server-relay", function(data)
    SendInterfaceMessage(data)
end)