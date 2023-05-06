const registeredd = [];

function RegisterInterfaceCallback(name, cb) {
    AddEventHandler(`_apx_uiReq:${name}`, cb);

    if (GetResourceState('qb-interface') === 'started') exports['qb-interface'].RegisterIntefaceEvent(name);

    registeredd.push(name);
}

function SendInterfaceMessage(data) {
    exports['qb-interface'].SendInterfaceMessage(data);
}

function SetInterfaceFocus(hasFocus, hasCursor) {
    exports['qb-interface'].SetInterfaceFocus(hasFocus, hasCursor);
}

function GetInterfaceFocus() {
    return exports['qb-interface'].GetInterfaceFocus();
}

AddEventHandler('_apx_uiReady', () => {
    registeredd.forEach((eventName) => exports['qb-interface'].RegisterIntefaceEvent(eventName));
});