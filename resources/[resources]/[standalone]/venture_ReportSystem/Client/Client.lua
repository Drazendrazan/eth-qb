RegisterNUICallback("exit" , function(data, cb)
    SetNuiFocus(false, false)
    cb(200)
end)


RegisterNetEvent('venture_ReportSystem:openUI')
AddEventHandler('venture_ReportSystem:openUI', function(name, ava)
        SetNuiFocus(true, true)
        SendNUIMessage({
            trans = true;
            name = name;
            ava = ava;
        })
end)

RegisterNUICallback('submit', function(data, cb)
    SetNuiFocus(false, false)
    TriggerServerEvent('venture_ReportSystem:SendReportToDiscord', data)
    cb(200)
end)


RegisterCommand('takepic', function(data, cb)
    local url = nil
    exports['screenshot-basic']:requestScreenshotUpload('https://discord.com/api/webhooks/1093596913019932682/RORsdt5zbh77WOZq46vpNP-zdv8T7-fXoX79mq60EJGvDDMsd5ITdEjfYEgg_dunE3hn', "files[]", function(data)
        local image = json.decode(data)
        url = image.attachments[1].url
        SendNUIMessage({
            imagen = true;
            img = url;
        })
    end)
end)


RegisterCommand("ceyhuntest", function(data)
    exports['screenshot-basic']:requestScreenshotUpload('https://discord.com/api/webhooks/1093596913019932682/RORsdt5zbh77WOZq46vpNP-zdv8T7-fXoX79mq60EJGvDDMsd5ITdEjfYEgg_dunE3hn', 'files[]', function(data)
        local resp = json.decode(data)
        TriggerEvent('chat:addMessage', { template = '<img src="{0}" style="max-width: 300px;" />', args = { resp.files[1].url } })
    end)
end)