ClientEvent = {} --客户端报文事件

TalkEvent = {} --聊天命令事件
GmTalkEvent = {} --gm聊天命令事件
local otherTalkName = {}
local otherTalkEvent = {} --其他聊天命令事件

InitEvent = {} --初始化事件 支持 char server battle
DeinitEvent = {} --反初始化事件 支持 char server battle

CharExpEvent = {}
SkillExpEvent = {}
ProductExpEvent = {}

DamageEvent = {}
local otherDamageName = {}
local otherDamageEvent = {}
SkillDamageEvent = {}

personAddDamage = {}
petAddDamage = {}
personSubDamage = {}
petSubDamage = {}
personDefSubDamage = {}
petDefSubDamage = {}
damageTable = {
    [1] = personAddDamage,
    [3]  = petAddDamage,
    [11] = personSubDamage,
    [13]  = petSubDamage,
    [21] = personDefSubDamage,
    [23]  = petDefSubDamage,
}

local function getFuncName(func)
    for key, val in pairs(_G) do
        if val == func then
            return key
        end
    end
end

-- 创建并设置metatable
setmetatable(DamageEvent, {
    __index = function(t, key)
        logPrint("DamageEvent get: " .. key)
        return damageTable[key]
    end,
    __newindex = function(t, key, val)
        local funcName = getFuncName(val)
        damageTable[key][funcName] = val
        logPrint("DamageEvent set: ", funcName)
    end,
})

charInitEvent = {}
serverInitEvent = {}
battleInitEvent = {}
initTable = {
    ["char"] = charInitEvent,
    ["server"]  = serverInitEvent,
    ["battle"] = battleInitEvent,
}

-- 创建并设置metatable
setmetatable(InitEvent, {
    __index = function(t, key)
        logPrint("InitEvent get: " .. key)
        return initTable[key]
    end,
    __newindex = function(t, key, val)
        local funcName = getFuncName(val)
        initTable[key][funcName] = val
        logPrint("InitEvent set: ", funcName)
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

-- 创建并设置metatable
setmetatable(DeinitEvent, {
    __index = function(t, key)
        logPrint("DeinitEvent get: " .. key)
        return deinitTable[key]
    end,
    __newindex = function(t, key, val)
        local funcName = getFuncName(val)
        deinitTable[key][funcName] = val
        logPrint("DeinitEvent set: ", funcName)
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
    for funcName, func in pairs(charInitEvent) do
        logPrint("char init ", funcName)
        func(myPlayer)
    end
end

function Event.RegAllOutEvent.doCharDeinitEvent(player)
    logPrint("doCharDeinitEvent: ", player)
    local myPlayer = MyPlayer:new(player);
    for funcName, func in pairs(charDeinitEvent) do
        logPrint("char deinit ", funcName)
        func(myPlayer)
    end
end

function doServerInitEvent()
    logPrint("doServerInitEvent")
    math.randomseed(os.time())

    local sql1 = "delete from tbl_lock"
    SQL.Run(sql1)
    for funcName, func in pairs(serverInitEvent) do
        logPrint("doServerInitEvent", funcName)
        func()
    end

    for i, v in ipairs(otherDamageName) do
        if rawget(_G, v) ~= nil then
            logPrint("insert otherDamageEvent: ", v, _G[v])
            table.insert(otherDamageEvent, _G[v])
        end
    end
    local deleteFunc = {}
    for k, v in pairs(Event.RegDamageCalculateEvent) do
        if k ~= "doDamageEvent" then
            logPrint("insert otherDamageEvent: ", k, v)
            table.insert(otherDamageEvent, v)
            table.insert(deleteFunc, k)
        else
            logPrint("doDamageEvent")
        end
    end
    for i, v in ipairs(deleteFunc) do
        Event.RegDamageCalculateEvent[v] = nil
    end

    for i, v in ipairs(otherTalkName) do
        if rawget(_G, v) ~= nil then
            logPrint("insert otherTalkEvent: ", v, _G[v])
            table.insert(otherTalkEvent, _G[v])
        end
    end
    local deleteFunc = {}
    for k, v in pairs(Event.RegTalkEvent) do
        if k ~= "doTalkEvent" then
            logPrint("insert otherDamageEvent: ", k, v)
            table.insert(otherTalkEvent, v)
            table.insert(deleteFunc, k)
        else
            logPrint("doTalkEvent")
        end
    end

    for i, v in ipairs(deleteFunc) do
        Event.RegTalkEvent[v] = nil
    end
end

function Event.RegShutDownEvent.doServerDeinitEvent()
    logPrint("doServerDeinitEvent")

    for funcName, func in pairs(serverDeinitEvent) do
        logPrint("doServerDeinitEvent", funcName)
        func()
    end
end

function NL.RegDamageCalculateEvent(Dofile, FuncName)
    table.insert(otherDamageName, FuncName)
end

function Event.RegBattleStartEvent.doBattleInitEvent(battle)
    logPrint("doBattleInitEvent")
    for funcName, func in pairs(battleInitEvent) do
        logPrint("doBattleInitEvent", funcName)
        func(battle)
    end
    logPrint("doBattleInitEvent1")
end

function Event.RegBattleOverEvent.doBattleDeinitEvent(battle)
    logPrint("doBattleDeinitEvent")
    for funcName, func in pairs(battleDeinitEvent) do
        logPrint("battleDeinitEvent", funcName)
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
    local sysRate = 4
    for i, func in pairs(SkillExpEvent) do
        rate = func(index, skill, rate)
    end

    return math.floor(exp * sysRate * rate / 100)
end

function Event.RegProductSkillExpEvent.doProductExpEvent(index, skill, exp)
    local rate = 100
    local sysRate = 4
    for i, func in pairs(ProductExpEvent) do
        rate = func(index, skill, rate)
    end

    return math.floor(exp * sysRate * rate / 100)
end

GetSysExpRate = nil

function Event.RegGetExpEvent.doCharExpEvent(index, exp)
    local rate = 100
    local myPlayer = MyPlayer:new(index);
    if exp <= 0 then
        return exp
    end
    local sysRate = 1
    if GetSysExpRate ~= nil then
        sysRate = GetSysExpRate(myPlayer);
    end

    for i, func in pairs(CharExpEvent) do
        rate = func(myPlayer, rate)
    end
    logPrint("doCharExpEvent: ", rate)
    return math.floor(exp * sysRate * rate / 100)
end

-- 1 人 3 宠
function Event.RegDamageCalculateEvent.doDamageEvent(CharIndex, DefCharIndex, OriDamage, Damage, BattleIndex, Com1, Com2, Com3, DefCom1, DefCom2, DefCom3, Flg)
    logPrint("OriDamage ", OriDamage, Damage)
    local atkRate = 100
    local defRate = 100
    local atkType =  Char.GetData(CharIndex, 0)
    if atkType ~= 2 then
        local skillId = math.floor(Com3 / 10)
        local level = math.fmod(Com3,  10) + 1
        if rawget(SkillDamageEvent, skillId) ~= nil then
            Damage = SkillDamageEvent(skillId, level, Damage, CharIndex, DefCharIndex)
        end
    end

    if rawget(damageTable, atkType) ~= nil then
        local myPlayer1 = MyPlayer:new(CharIndex);
        for funcName, func in pairs(damageTable[atkType]) do
            logPrint(funcName)
            atkRate = func(myPlayer1, atkRate)
        end
        atkType = atkType + 10
        for funcName, func in pairs(damageTable[atkType]) do
            logPrint(funcName)
            defRate = func(myPlayer1, defRate)
        end
    end

    if defRate == 100 then
        local defType =  Char.GetData(DefCharIndex, 0) + 20
        if rawget(damageTable, defType) ~= nil then
            local myPlayer1 = MyPlayer:new(DefCharIndex);
            for funcName, func in pairs(damageTable[defType]) do
                logPrint(funcName)
                defRate = func(myPlayer1, defRate)
            end
            if defRate < 0 then
                defRate = 1
            end
        end
    end

    local realDamage = 0
    if atkType ~= 2 then
        for i, func in ipairs(otherDamageEvent) do
            realDamage = realDamage + func(CharIndex, DefCharIndex, OriDamage, Damage, BattleIndex, Com1, Com2, Com3, DefCom1, DefCom2, DefCom3, Flg) - Damage
        end
    end

    logPrint("RealDamage1 ", realDamage)
    if defRate == 100 then
        realDamage = realDamage + math.ceil(Damage * (atkRate / 100) * (defRate / 100))
    else
        realDamage = realDamage + math.floor(Damage * (atkRate / 100) * (defRate / 100))
    end
    logPrint("RealDamage2 ", realDamage, atkRate, defRate)
    return realDamage
end

Delegate.RegInit("doServerInitEvent")
InitEvent["server"] = initTaskHandler