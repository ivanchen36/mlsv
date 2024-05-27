ClientEvent = {} --�ͻ��˱����¼�

TalkEvent = {} --���������¼�
GmTalkEvent = {} --gm���������¼�

InitEvent = {} --��ʼ���¼� ֧�� char server battle
DeinitEvent = {} --����ʼ���¼� ֧�� char server battle

CharExpEvent = {}
SkillExpEvent = {}
ProductExpEvent = {}

charInitEvent = {}
serverInitEvent = {}
battleInitEvent = {}
initTable = {
    ["char"] = charInitEvent,
    ["server"]  = serverInitEvent,
    ["battle"] = battleInitEvent,
}

-- ����������metatable
setmetatable(InitEvent, {
    __index = function(t, key)
        logPrint("InitEvent get: " .. key)
        return initTable[key]
    end,
    __newindex = function(t, key, val)
        table.insert(initTable[key], val)
        logPrint("InitEvent set: ", key, #initTable[key])
    end,
})

charDeinitEvent = {}
serverDeinitEvent = {}
battleDeinitEvent = {}
deinitTable = {
    ["char"] = charDeinitEvent,
    ["server"]  = serverDeinitEvent,
    ["battle"] = battleDeinitEvent,
}

-- ����������metatable
setmetatable(DeinitEvent, {
    __index = function(t, key)
        logPrint("DeinitEvent get: " .. key)
        return deinitTable[key]
    end,
    __newindex = function(t, key, val)
        table.insert(deinitTable[key], val)
        logPrint("DeinitEvent set: ", key, #deinitTable[key])
    end,
})

function Event.RegTalkEvent.doTalkEvent(player, msg, color, range, size)
    logPrint("doTalkEvent: ", player, msg)
    local myPlayer = MyPlayer:new(player);
    if rawget(TalkEvent, msg) ~= nil then
        TalkEvent[msg](myPlayer)
        return
    end

    if not myPlayer:isGm() then
        return
    end

    logPrint("doGmTalkEvent: ", player, msg)
    if rawget(GmTalkEvent, msg) ~= nil then
        GmTalkEvent[msg](myPlayer)
        return
    end
end

function Event.RegLoginEvent.doCharInitEvent(player)
    logPrint("doCharInitEvent: ", player)
    local myPlayer = MyPlayer:new(player);
    for i, func in ipairs(charInitEvent) do
        func(myPlayer)
    end
end

function Event.RegAllOutEvent.doCharDeinitEvent(player)
    logPrint("doCharDeinitEvent: ", player)
    local myPlayer = MyPlayer:new(player);
    for i, func in ipairs(charDeinitEvent) do
        func(myPlayer)
    end
end

function doServerInitEvent()
    logPrint("doServerInitEvent")
    math.randomseed(os.time())

    local sql1 = "delete from tbl_lock"
    SQL.Run(sql1)
    for i, func in ipairs(serverInitEvent) do
        logPrint("doServerInitEvent", i)
        func()
    end
end

function Event.RegBattleStartEvent.doBattleInitEvent(battle)
    logPrint("doBattleInitEvent")
    for i, func in ipairs(battleInitEvent) do
        func(battle)
    end
end

function Event.RegBattleOverEvent.doBattleDeinitEvent(battle)
    logPrint("doBattleDeinitEvent")
    for i, func in ipairs(battleDeinitEvent) do
        func(battle)
    end
end

function Event.Recv.clientEvent(player,packet)
    logPrint("Event.Recv.clientEvent: ", player, packet)
    local myPlayer = MyPlayer:new(player);
    local parts = strSplit(packet, "|")
    local command = parts[1]
    local arg = #parts > 1 and parts[2] or ""
    if rawget(ClientEvent, command) ~= nil then
        ClientEvent[command](myPlayer, arg)
        return
    end
end

function Event.RegBattleSkillExpEvent.doSkillExpEvent(index, skill, exp)
    local rate = 100
    for i, func in ipairs(SkillExpEvent) do
        rate = func(index, skill, rate)
    end

    return math.floor(exp * rate / 100)
end

function Event.RegProductSkillExpEvent.doProductExpEvent(index, product, exp)
    local rate = 100
    for i, func in ipairs(ProductExpEvent) do
        rate = func(index, skill, rate)
    end

    return math.floor(exp * rate / 100)
end

GetSysExpRate = nil

function Event.RegGetExpEvent.doCharExpEvent(index, exp)
    local rate = 100

    local myPlayer = MyPlayer:new(index);
    local sysRate = 1

    if GetSysExpRate ~= nil then
        sysRate = GetSysExpRate(myPlayer);
    end

    for i, func in ipairs(CharExpEvent) do
        rate = func(myPlayer, rate)
    end

    return math.floor(exp * sysRate * rate / 100)
end

Delegate.RegInit("doServerInitEvent")
InitEvent["server"] = initTaskHandler
