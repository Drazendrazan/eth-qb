--Example

--RegisterNUICallback("qb-ui:test:input", function(data, cb)
--    print("qb-ui:test:input",json.encode(data))
--    SetNuiFocus(false, false)
--    cb("ok")
--end)

--RegisterCommand("testnewkeyboard", function()
--    exports['qb-ui']:openApplication('textbox', {
--        callbackUrl = 'qb-ui:test:input',
--        key = 1,
--        items = {
--            {
--                icon = "fas fa-pencil-alt",
--                label = "Text",
--                name = "text",
--            },
--            {
--                icon = "fas fa-palette",
--                label = "Color (white, red, green, yellow, blue)",
--                name = "color",
--            },
--            {
--                icon = "fas fa-people-arrows",
--                label = "Distance (0.1 - 10)",
--                name = "distance",
--            },
--        },
--    })
--end)

--RegisterCommand("testtaskbar", function()
--    exports["qb-ui"]:sendAppEvent("taskbar", {
--        display = true,
--        duration = 5000,
--        taskID = 1,
--        label = "Test Taskbar",
--    })
--end)