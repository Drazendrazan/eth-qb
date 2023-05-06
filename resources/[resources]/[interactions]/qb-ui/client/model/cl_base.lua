-- CLOSE APP
function SetUIFocus(hasKeyboard, hasMouse)
    --  HasNuiFocus = hasKeyboard or hasMouse
    
      SetNuiFocus(hasKeyboard, hasMouse)
    
      -- TriggerEvent("qb-voice:focus:set", HasNuiFocus, hasKeyboard, hasMouse)
      -- TriggerEvent("qb-binds:should-execute", not HasNuiFocus)
    end
    
    exports('SetUIFocus', SetUIFocus)
    
    RegisterNUICallback("qb-ui:closeApp", function(data, cb)
        SetUIFocus(false, false)
        cb({data = {}, meta = {ok = true, message = 'done'}})
        Wait(800)
        TriggerEvent("attachedItems:block",false)
    end)
    
    RegisterNUICallback("qb-ui:applicationClosed", function(data, cb)
        TriggerEvent("qb-ui:application-closed", data.name, data)
        cb({data = {}, meta = {ok = true, message = 'done'}})
    end)
    
    -- FORCE CLOSE
    RegisterCommand("qb-ui:force-close", function()
        SendUIMessage({source = "qb-nui", app = "", show = false});
        SetUIFocus(false, false)
    end, false)
    
    -- SMALL MAP
    RegisterCommand("qb-ui:small-map", function()
      SetRadarBigmapEnabled(false, false)
    end, false)
    
    local function restartUI(withMsg)
      SendUIMessage({ source = "qb-nui", app = "main", action = "restart" });
      if withMsg then
        TriggerEvent("DoLongHudText", "You can also use 'ui-r' as a shorter version to restart!")
      end
      Wait(5000)
      TriggerEvent("qb-ui:restarted")
      SendUIMessage({ app = "hud", data = { display = true }, source = "qb-nui" })
      local cj = exports["police"]:getCurrentJob()
      if cj ~= "unemployed" then
        TriggerEvent("qb-jobmanager:playerBecameJob", cj)
        TriggerServerEvent("qb-jobmanager:fixPaychecks", cj)
      end
      loadPublicData()
    end
    RegisterCommand("qb-ui:restart", function() restartUI(true) end, false)
    RegisterCommand("ui-r", function() restartUI() end, false)
    RegisterNetEvent("qb-ui:server-restart")
    AddEventHandler("qb-ui:server-restart", restartUI)
    
    RegisterCommand("qb-ui:debug:show", function()
        SendUIMessage({ source = "qb-nui", app = "debuglogs", data = { display = true } });
    end, false)
    
    RegisterCommand("qb-ui:debug:hide", function()
        SendUIMessage({ source = "qb-nui", app = "debuglogs", data = { display = false } });
    end, false)
    
    RegisterNUICallback("qb-ui:resetApp", function(data, cb)
        SetUIFocus(false, false)
        cb({data = {}, meta = {ok = true, message = 'done'}})
        sendCharacterData()
    end)
    
    RegisterNetEvent("qb-ui:server-relay")
    AddEventHandler("qb-ui:server-relay", function(data)
        SendUIMessage(data)
    end)
    
    RegisterNetEvent("isJudge")
    AddEventHandler("isJudge", function()
      sendAppEvent("character", { job = "judge" })
    end)
    
    RegisterNetEvent("isJudgeOff")
    AddEventHandler("isJudgeOff", function()
      sendAppEvent("character", { job = "unemployed" })
    end)
    
    RegisterNetEvent("qb-jobmanager:playerBecameJob")
    AddEventHandler("qb-jobmanager:playerBecameJob", function(job)
      sendAppEvent("character", { job = job })
    end)
    