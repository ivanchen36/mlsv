local jobBuff = {
    [1] = {"hp", 50}
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
    ["hp"] = "����",
    ["mp"] = "ħ��",
    ["atk"] = "����",
    ["def"] = "����",
    ["agi"] = "����",
    ["crit"] = "��ɱ",
    ["avoid"] = "����",
    ["hit"] = "����",
}

local partyBuffInfo = {}
local partyMemberInfo = {}
local waitHandleList = {}

function addBuff(members, buffList, desc)
    logPrint("addBuff")
    for _, member in ipairs(members) do
        if member:isValid() then
            for attr, buff in pairs(buffList) do
                local method = MyChar[buffFunc[attr]]
                method(member, buff)
            end
            member:flush()
            member:sysMsg("��ö���ӳɣ�" .. desc)
            Protocol.PowerSend(member:getObj(), "FLUSH_PARTY_BUFF", desc)
        end
    end
end

function subBuff(members, buffList)
    logPrint("subBuff")
    for _, member in ipairs(members) do
        logPrint(member:isValid())
        if member:isValid() then
            for attr, buff in pairs(buffList) do
                local method = MyChar[buffFunc[attr]]
                method(member, -buff)
            end
            member:flush()
            Protocol.PowerSend(member:getObj(), "FLUSH_PARTY_BUFF", "")
        end
    end
end

function Event.RegPartyEvent.PartyBuff(index, target, pType)
    local player = MyPlayer:new(index)
    local now = os.time()
    if player:isLeader() and index ~= target then
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
    waitHandleList[target] = os.time() + 20
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
        local jobId = member:getJob()
        if rawget(jobBuff, jobId) == nil then
            jobId = 1
        end
        local buff = jobBuff[jobId]
        if nil ~= buff then
            if rawget(newBuffList, buff[1]) == nil then
                newBuffList[buff[1]] = buff[2]
            elseif buff[2] > newBuffList[buff[1]] then
                newBuffList[buff[1]] = buff[2]
            end
        end
    end
    for attr, buff in pairs(newBuffList) do
        if 0 ~= string.len(partyDesc) then
            partyDesc = partyDesc .. ", "
        end
        partyDesc = partyDesc .. buffDesc[attr] .. " +" .. buff
    end
    if #newBuffList > 0 then
        partyBuffInfo[index] = newBuffList
        partyMemberInfo[index] = newList
        addBuff(newList, newBuffList, partyDesc)
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