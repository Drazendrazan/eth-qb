local registeredd = {}

function RegisterInterfaceCallback(name, cb)
  local function interceptCb(data, innerCb)
    cb(data, function(result)
      if result.meta.ok then
        result.meta.message = "done"
      end
      innerCb(result)
    end)
  end
  AddEventHandler(('_apx_uiReq:%s'):format(name), interceptCb)

  if (GetResourceState("qb-interface") == "started") then 
    exports["qb-interface"]:RegisterIntefaceEvent(name) 
  end

  registeredd[#registeredd + 1] = name
end

function SendInterfaceMessage(data)
  exports["qb-interface"]:SendInterfaceMessage(data)
end

function SetInterfaceFocus(hasFocus, hasCursor)
  exports["qb-interface"]:SetInterfaceFocus(hasFocus, hasCursor)
end

function GetInterfaceFocus()
  return exports["qb-interface"]:GetInterfaceFocus()
end

AddEventHandler("_apx_uiReady", function()
  for _, eventName in ipairs(registeredd) do
    exports["qb-interface"]:RegisterIntefaceEvent(eventName)
  end
end)