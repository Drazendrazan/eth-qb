function startCall(phoneNumber, callerID, receiverID)
    TriggerClientEvent("eth:voice:phone:call:start", callerID, receiverID, phoneNumber)
    TriggerClientEvent("eth:voice:phone:call:start", receiverID, callerID, phoneNumber)
end

function endCall(phoneNumber, callerID, receiverID)
    TriggerClientEvent("eth:voice:phone:call:end", callerID, receiverID, phoneNumber)
    TriggerClientEvent("eth:voice:phone:call:end", receiverID, callerID, phoneNumber)
end

RegisterServerEvent("eth:voice:server:phone:startCall")
AddEventHandler("eth:voice:server:phone:startCall", startCall)

RegisterServerEvent("eth:voice:server:phone:endCall")
AddEventHandler("eth:voice:server:phone:endCall", endCall)