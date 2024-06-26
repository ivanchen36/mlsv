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

local partyBuffInfo = {}
local partyMemberInfo = {}

function addPartyBuff(buffList, members)
    for _, member in ipairs(members) do
        for _, buff in ipairs(buffList) do
            local funcName = buff[1]
            local val = buff[2]
            local method = MyPlayer[funcName]
            method(member, val)
        end
    end
end

function subPartyBuff(buffList, members)
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
    local leader = MyPlayer:new(target)
    local num = leader:getPartyNum()
    local newList = {leader}
    local oldList = partyMemberInfo[target]
    local oldBuffList = partyBuffInfo[target]
    if player:isLeader() then
        partyBuffInfo[target] = oldBuffList
        partyMemberInfo[target] = oldList
        partyBuffInfo[index] = nil
        partyMemberInfo[index] = nil

        return
    end

    if num > 1 and nil ~= oldBuffList and nil ~= oldList then
        subPartyBuff(oldList, oldBuffList)
    end

    if (index == target or 2 == num) and 1 == pType then
        partyBuffInfo[target] = nil
        partyMemberInfo[target] = nil
        return
    end

    for i = 1, num - 1 do
        local member = leader:getPartyMember(i)
        if member:getObj() ~= index then
            table.insert(newList, member)
        end
    end
    if 0 == pType then
        table.insert(newList, MyPlayer:new(index))
    end
    local newBuffList = {}
    for _, member in ipairs(newList) do
        local buff = jobBuff[member:getJob()]
        if nil ~= buff then
            table.insert(newBuffList, buff)
        end
    end
    addPartyBuff(newBuffList, newList)
    partyBuffInfo[target] = newBuffList
    partyMemberInfo[target] = newList
end

function showPartyBuff(player, arg)
    local member = player:getPartyMember(0)
    Protocol.PowerSend(player:getObj(),"PARTY_BUFF", partyBuffInfo[member:getObj()])
end

ClientEvent["[party_buff]"] = showPartyBuff