local jobBuff = {
    [0] = {"hp", 1000}
}

local buffFunc = {
    ["hp"] = "setBounsHp",
    ["mp"] = "setBounsMagic",
    ["atk"] = "setBounsAttack",
    ["def"] = "setBounsDefence",
    ["agi"] = "setBounsAgility",
    ["crit"] = "setBounsCritical",
    ["avoid"] = "setBounsAvoid",
    ["hit"] = "setBounsHitrate",
}

local buffDesc = {
    ["hp"] = "生命",
    ["mp"] = "魔力",
    ["atk"] = "攻击",
    ["def"] = "防御",
    ["agi"] = "敏捷",
    ["crit"] = "必杀",
    ["avoid"] = "躲闪",
    ["hit"] = "命中",
}

local partyBuffInfo = {}
local partyMemberInfo = {}
local waitHandleList = {}

function addBuff(buffList, members, desc)
    logPrintTbl(buffList)
    logPrintTbl(members)
    logPrint(desc)
    for _, member in ipairs(members) do
        for _, buff in ipairs(buffList) do
            local funcName = buff[1]
            local val = buff[2]
            local method = MyPlayer[buffFunc[funcName]]
            method(member, val)
        end
        member:flush()
        member:sysMsg("获得队伍加成：" .. desc)
        Protocol.PowerSend(member:getObj(), "FLUSH_PARTY_BUFF", desc)
    end
end

function subBuff(buffList, members)
    for _, member in ipairs(members) do
        for _, buff in ipairs(buffList) do
            local funcName = buff[1]
            local val = buff[2]
            local method = MyPlayer[funcName]
            method(member, -val)
        end
        Protocol.PowerSend(member:getObj(), "FLUSH_PARTY_BUFF", "")
    end
end

function Event.RegPartyEvent.PartyBuff(index, target, pType)
    local player = MyPlayer:new(index)
    local now = os.time()
    logPrint("1111")
    if player:isLeader() then
        logPrint("11112")
        local oldList = partyMemberInfo[target]
        local oldBuffList = partyBuffInfo[target]
        if rawget(waitHandleList, index) ~= nil then
            if waitHandleList[index] < now + 2 then
                waitHandleList[index] = now - 20
                waitHandleList[target] = now + 20
            else
                partyBuffInfo[target] = oldBuffList
                partyMemberInfo[target] = oldList
                partyBuffInfo[index] = nil
                partyMemberInfo[index] = nil
                waitHandleList[target] = waitHandleList[index]
                waitHandleList[index] = nil
            end
        else
            partyBuffInfo[target] = oldBuffList
            partyMemberInfo[target] = oldList
            partyBuffInfo[index] = nil
            partyMemberInfo[index] = nil
        end
        return
    end
    logPrint("222")
    waitHandleList[target] = os.time() + 20
end

function addPartyBuff(index)
    logPrint("333")
    local player = MyPlayer:new(index)
    local oldList = partyMemberInfo[index]
    local oldBuffList = partyBuffInfo[index]
    if nil ~= oldBuffList then
        subBuff(oldList, oldBuffList)
        partyBuffInfo[index] = nil
        partyMemberInfo[index] = nil
    end
    logPrint("444")
    if not player:isLeader() then
        return
    end
    logPrint("555")
    local newList = {player}
    local num = player:getPartyNum()
    for i = 1, num - 1 do
        local member = player:getPartyMember(i)
        table.insert(newList, member)
    end
    logPrint("666")
    local newBuffList = {}
    local partyDesc = ""
    for _, member in ipairs(newList) do
        local buff = jobBuff[member:getJob()]
        if nil ~= buff then
            table.insert(newBuffList, buff)
            if 0 ~= #partyDesc then
                partyDesc = partyDesc .. ", "
            end
            partyDesc = partyDesc .. buffDesc[buff[1]] .. " +" .. buff[2]
        end
    end
    if #newBuffList > 0 then
        partyBuffInfo[index] = newBuffList
        partyMemberInfo[index] = newList
        addBuff(newBuffList, newList, partyDesc)
    end
end

function handlePartyBuff()
    local now = os.time()
    local deleteList = {}
    for index, exeTime in pairs(waitHandleList) do
        logPrint("exe1")
        if exeTime <= now then
            logPrint("exe2")
            addPartyBuff(index)
            table.insert(deleteList, index)
        end
    end

    for _, index in ipairs(deleteList) do
        waitHandleList[index] = nil
    end
end

addTimerTask(handlePartyBuff)