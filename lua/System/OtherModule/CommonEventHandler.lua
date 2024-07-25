ClientEvent = {} --客户端报文事件

TalkEvent = {} --聊天命令事件
GmTalkEvent = {} --gm聊天命令事件

InitEvent = {} --初始化事件 支持 char server battle
DeinitEvent = {} --反初始化事件 支持 char server battle

CharExpEvent = {}
SkillExpEvent = {}
ProductExpEvent = {}

DamageEvent = {}
OtherDamageName = {}
OtherDamageEvent = {}
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

local funcName = {}

local function setFuncName(func)
    for key, val in pairs(_G) do
        if val == func then
            funcName[func] = key
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
        table.insert(damageTable[key], val)
        setFuncName(val)
        logPrint("DamageEvent set: ", key, #damageTable[key])
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
        table.insert(initTable[key], val)
        setFuncName(val)
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

-- 创建并设置metatable
setmetatable(DeinitEvent, {
    __index = function(t, key)
        logPrint("DeinitEvent get: " .. key)
        return deinitTable[key]
    end,
    __newindex = function(t, key, val)
        table.insert(deinitTable[key], val)
        setFuncName(val)
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
        print("char init " .. funcName[func])
        logPrint("char init ", funcName[func])
        func(myPlayer)
    end
end

function Event.RegAllOutEvent.doCharDeinitEvent(player)
    logPrint("doCharDeinitEvent: ", player)
    local myPlayer = MyPlayer:new(player);
    for i, func in ipairs(charDeinitEvent) do
        print("char deinit " .. funcName[func])
        logPrint("char deinit ", funcName[func])
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

    for i, v in ipairs(OtherDamageName) do
        if rawget(_G, v) ~= nil then
            logPrint("insert OtherDamageEvent: ", v, _G[v])
            table.insert(OtherDamageEvent, _G[v])
        end
    end
    local deleteFunc = {}
    for k, v in pairs(Event.RegDamageCalculateEvent) do
        if k ~= "doDamageEvent" then
            logPrint("insert OtherDamageEvent: ", k, v)
            table.insert(OtherDamageEvent, v)
            table.insert(deleteFunc, k)
        else
            logPrint("doDamageEvent")
        end
    end

    for i, v in ipairs(deleteFunc) do
        Event.RegDamageCalculateEvent[v] = nil
    end
end

function NL.RegDamageCalculateEvent(Dofile, FuncName)
    table.insert(OtherDamageName, FuncName)
end

function Event.RegBattleStartEvent.doBattleInitEvent(battle)
    logPrint("doBattleInitEvent")
    for i, func in ipairs(battleInitEvent) do
        func(battle)
    end
    logPrint("doBattleInitEvent1")
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
        local level = math.mod(Com3,  10) + 1
        if rawget(SkillDamageEvent, skillId) ~= nil then
            Damage = SkillDamageEvent(skillId, level, Damage, CharIndex, DefCharIndex)
        end
    end

    if rawget(damageTable, atkType) ~= nil then
        local myPlayer1 = MyPlayer:new(CharIndex);
        for _, func in ipairs(damageTable[atkType]) do
            logPrint(funcName[func])
            atkRate = func(myPlayer1, atkRate)
        end
        atkType = atkType + 10
        for _, func in ipairs(damageTable[atkType]) do
            logPrint(funcName[func])
            defRate = func(myPlayer1, defRate)
        end
    end

    if defRate == 100 then
        local defType =  Char.GetData(DefCharIndex, 0) + 20
        if rawget(damageTable, defType) ~= nil then
            local myPlayer1 = MyPlayer:new(DefCharIndex);
            for i, func in ipairs(damageTable[defType]) do
                logPrint(funcName[func])
                defRate = func(myPlayer1, defRate)
            end
            if defRate < 0 then
                defRate = 1
            end
        end
    end

    local realDamage = 0
    if atkType ~= 2 then
        for i, func in ipairs(OtherDamageEvent) do
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