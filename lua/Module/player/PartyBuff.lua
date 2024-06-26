local jobBuff = {
    [10] = {"hp", 1000}
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
    for _, member in ipairs(members) do
        for _, buff in ipairs(buffList) do
            local funcName = buff[1]
            local val = buff[2]
            local method = MyPlayer[buffFunc[funcName]]
            method(member, val)
        end
        member:flush()
        member:sysMsg("获得队伍加成：" .. desc)
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
    end
end

function Event.RegPartyEvent.PartyBuff(index, target, pType)
    local player = MyPlayer:new(index)
    local now = os.time()
    if player:isLeader() then
        local oldList = partyMemberInfo[target]
        local oldBuffList = partyBuffInfo[target]
        if rawget(waitHandleList, index) ~= nil then
            if waitHandleList[index] < now + 2 then
                waitHandleList[index] = now
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

    waitHandleList[target] = os.time() + 20
end

function showPartyBuff(player, arg)
    local member = player:getPartyMember(0)
    Protocol.PowerSend(player:getObj(),"PARTY_BUFF", partyBuffInfo[member:getObj()])
end

function addPartyBuff(index)
    local player = MyPlayer:new(index)
    local oldList = partyMemberInfo[index]
    local oldBuffList = partyBuffInfo[index]
    if nil ~= oldBuffList then
        subBuff(oldList, oldBuffList)
        partyBuffInfo[index] = nil
        partyMemberInfo[index] = nil
    end

    if not player:isLeader() then
        return
    end

    local newList = {player}
    local num = player:getPartyNum()
    for i = 1, num - 1 do
        local member = player:getPartyMember(i)
        table.insert(newList, member)
    end

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
    partyBuffInfo[index] = newBuffList
    partyMemberInfo[index] = newList
    addBuff(newBuffList, newList, partyDesc)
end

function handlePartyBuff()
    local now = os.time()
    for index, exeTime in pairs(waitHandleList) do
        if exeTime <= now then
            addPartyBuff(index)
        end
    end
end

addTimerTask(handlePartyBuff)
ClientEvent["[party_buff]"] = showPartyBuff