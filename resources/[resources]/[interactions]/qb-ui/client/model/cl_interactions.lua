local lastMessage = ""

function showInteraction(text, type)
	local color = "#2196f3"

	if type == "success" then
		color = "#4caf50"
	elseif type == "error" then
		color = "#f44336"
	end

	SendNUIMessage({
		display = true,
		text = text,
		color = color
	})
end

function hideInteraction()
	SendNUIMessage({
		display = false
	})
end

exports("showInteraction", showInteraction)
exports("hideInteraction", hideInteraction)

AddEventHandler('closeinteraction', function()
	hideInteraction()
end)


exports("showContextMenu", function(options, position)
    SendUIMessage({
        action = "contextmenu",
        show = true,
        data = {
            options = options
        }
    })
    SetUIFocus(true, true)
end)

RegisterNUICallback("closecontext", function(data,cb)
    
    SetUIFocus(false, false)
    cb("ok")
end)

-- Example Using This
-- type 
-- error (bg : Red) or succes ( bg : Green) or info (bg : blue)
-- Show Interaction
-- exports["qb-interface"]:showInteraction(msg,type)

-- Hide Interaction
-- exports["qb-interface"]:showInteraction(msg,type)