local SpecialPack = 1 --���
local SpecialUnpack = 2 --���
local SpecialComp = 3 --ѹ���ϳ�
local SpecialComp1 = 4 --ѹ���ϳ�
local SpecialWorkTime = 5 --ʱ��ˮ��
local SpecialFame = 6 --����
local SpecialSkillSlot = 7 --������
local SpecialXz = 8 --��������
local SpecialUpJob = 9 --ְҵ����

local function packItem(player, useItem, slot)
    for i = 8, 28 do
        local item = player:getItem(i);
        if item:isValid() then
            local type = item:getType()
            if rawget(Const.PackImgMap, type) ~= nil then
                local packInfo = Const.PackImgMap[type]
                local stackNum = item:getMaxStackCount()
                local itemNum = item:getItemNum()
                local groupNum = math.floor(itemNum / stackNum)
                if groupNum >= 2 then
                    if groupNum > Const.MaxPackGroupNum then
                        groupNum = Const.MaxPackGroupNum
                    end
                    local delNum = groupNum * stackNum
                    player:delItem(item:getId(), delNum)
                    local tempItem = player:addItem(Const.CommonTempItemId, 1)
                    tempItem:setSpecialType(SpecialUnpack)
                    tempItem:setSubParamOne(item:getId())
                    tempItem:setSubParamTwo(delNum)
                    tempItem:setImage(packInfo[1])
                    tempItem:setType(type)
                    tempItem:setType(type)
                    tempItem:setDurability(1)
                    tempItem:setMaxDurability(1)
                    tempItem:setName("װ��" .. groupNum .. "��" .. item:getName() .. "��" .. packInfo[2])
                    tempItem:flush(player)
                    local durability = useItem:getDurability()
                    if durability > 1 then
                        useItem:setDurability(durability - 1)
                        useItem:flush(player)
                    else
                        Item.Kill(player:getObj(), useItem:getObj(), slot)
                    end
                    return 1
                end
            end
        end
    end
    return 0
end

local function unpackItem(player, useItem, slot)
    local itemId = useItem:getSubParamOne()
    local itemNum = useItem:getSubParamTwo()
    local itemData = MyDataItem:new(itemId)
    local stackNum = itemData:getMaxStackCount()
    local groupNum = math.ceil(itemNum / stackNum)
    local freeNum = player:freeBagNum()
    if groupNum <= freeNum then
        player:addItem(itemId, itemNum)
        Item.Kill(player:getObj(), useItem:getObj(), slot)
        return 1
    end

    player:sysMsg("�����ռ䲻��" .. groupNum .. "����" .. itemData:getName() .. "�޷����뱳��")
    return 0
end

local function compItem(player, useItem, slot)
    for i = 8, 28 do
        local item = player:getItem(i);
        if item:isValid() then
            local itemId = item:getId()
            if rawget(Const.CompItemMap, itemId) ~= nil then
                local compInfo = Const.CompItemMap[itemId]
                local itemNum = item:getItemNum()
                local groupNum = math.floor(itemNum / compInfo[1])
                if groupNum >= 1 then
                    local delNum = groupNum * compInfo[1]
                    player:delItem(itemId, delNum)
                    player:addItem(compInfo[2], groupNum)
                    local durability = useItem:getDurability()
                    if durability > 1 then
                        useItem:setDurability(durability - 1)
                        useItem:flush(player)
                    else
                        Item.Kill(player:getObj(), useItem:getObj(), slot)
                    end
                    return 1
                end
            end
        end
    end
    return 0
end

local function compItem1(player, useItem, slot)
    local itemId = useItem:getId()
    if rawget(Const.CompItemMap, itemId) ~= nil then
        local compInfo = Const.CompItemMap[itemId]
        local itemNum = useItem:getItemNum()
        local groupNum = math.floor(itemNum / compInfo[1])
        if groupNum >= 1 then
            local delNum = groupNum * compInfo[1]
            player:delItem(itemId, delNum)
            player:addItem(compInfo[2], groupNum)
            return 1
        end
    end
    return 0
end

local function addWorkTime(player, useItem, slot)
    local sec = useItem:getSubParamOne()
    player:setStuckTime(player:getStuckTime() + sec)
    Item.Kill(player:getObj(), useItem:getObj(), slot)
    player:flush()
    player:sysMsg("���Ĵ�ʱ��������" .. sec / 3600 .. "Сʱ")
    return 1
end

local function addFame(player, useItem, slot)
    local val = useItem:getSubParamOne()
    player:setReputation(player:getReputation() + val)
    Item.Kill(player:getObj(), useItem:getObj(), slot)
    player:flush()
    player:sysMsg("��������������" .. val .. "��")
    return 1
end

local function addSpecialSkillSlot(player, useItem, slot)
    local openSlot = useItem:getSubParamOne()
    local curSlots = player:getSkillSlots()
    if openSlot <= curSlots then
        player:sysMsg("���Ѿ�������" .. openSlot .. "��������")
        return 1
    end

    if openSlot ~= curSlots + 1 then
        player:sysMsg("����δ����" .. curSlots + 1 .. "��������,�޷���������������")
        return 1
    end
    player:setSkillSlots(openSlot)
    Item.Kill(player:getObj(), useItem:getObj(), slot)
    player:flush()
    return 1
end

-- 1-��ɱ 2-���� 3-���� 4-����
local baseFieldId = 27
local xzDesc = {"��ɱ", "����", "����", "����"}
local function addPetXz(player, useItem, slot)
    local fieldId = useItem:getSubParamOne() + baseFieldId
    local maxVal = useItem:getSubParamTwo()
    local pet = player:getPet(0)
    local val = pet:get(fieldId)
    if val >= maxVal then
        player:sysMsg("��ʵ�ȼ��Ѵ����ֵ")
        return 1
    end

    pet:set(fieldId, val + 1)
    Item.Kill(player:getObj(), useItem:getObj(), slot)
    pet:flush()
    player:sysMsg("����" .. pet:getName() .. xzDesc[fieldId] .. "+1")
    return 1
end

local function upJob(player, useItem, slot)
    local jobLevel = useItem:getSubParamOne()
    local jobClassId = player:getJobClassId()
    local curJobLevel = math.fmod(jobClassId, 10)
    if curJobLevel >= jobLevel then
        player:sysMsg("���Ѿ����" .. jobLevel .. "ת")
        return 1
    end

    if jobLevel ~= curJobLevel + 1 then
        player:sysMsg("����δ���" .. curJobLevel + 1 .. "ת")
        return 1
    end

    player:setJobClassId(curJobLevel + 1)
    player:setEndEvent(94 - jobLevel)
    Item.Kill(player:getObj(), useItem:getObj(), slot)
    player:flush()
    player:sysMsg("��ϲ�����" .. jobLevel .. "ת")
    return 1
end

local specialTypeEvent = {
    [SpecialPack] = packItem,
    [SpecialUnpack] = unpackItem,
    [SpecialComp] = compItem,
    [SpecialComp1] = compItem1,
    [SpecialWorkTime] = addWorkTime,
    [SpecialFame] = addFame,
    [SpecialSkillSlot] = addSpecialSkillSlot,
    [SpecialXz] = addPetXz,
    [SpecialUpJob] = upJob,
}

function myItemUse(index, toIndex, slot)
    local player = MyPlayer:new(index);
    local item = player:getItem(slot)

    local specialType = player:getSpecialType()
    if rawget(specialTypeEvent, specialType) ~= nil then
        specialTypeEvent[specialType](player, item, slot)
    else
        player(item:getName() .. "�޷�ʹ�ã�����ϵ�ͷ�")
    end
end

NL.RegItemString(nil, "myItemUse", "LUA_useMyItem")