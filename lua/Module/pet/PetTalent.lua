local skillName = {
    "百毒不侵","悬梁刺股","镜盾反射","众人皆醉","乱中有序","永生难忘","生命脉动","魔力共鸣","防御壁垒","迅捷疾风","致命打击","心灵之眼","生命不息","致命绽放","混沌波动","永恒之壁"
}

local skillRate = {
    [30401] = 700,
    [30402] = 700,
    [30403] = 700,
    [30404] = 700,
    [30405] = 700,
    [30406] = 700,
    [30407] = 700,
    [30408] = 700,
    [30409] = 700,
    [30410] = 700,
    [30411] = 700,
    [30412] = 700,
    [30413] = 700,
    [30414] = 300,
    [30415] = 300,
    [30416] = 300,
}

local petSkillBuff = {
    {"poison", 30},
    {"sleep", 30},
    {"stone", 30},
    {"drunk", 30},
    {"confusion", 30},
    {"amnesia", 30},
    {"hp", 5},
    {"mp", 5},
    {"def", 5},
    {"agi", 5},
    {"atk", 5},
    {"spirit", 5},
    {"recover", 5},
}

local skillAtkDamage = {
    [30414] = function()
        return 5
    end,
    [30444] = function()
        return 10
    end,
    [30474] = function()
        return 15
    end,
    [30415] = function()
        return math.random(0, 10)
    end,
    [30445] = function()
        return math.random(0, 20)
    end,
    [30475] = function()
        return math.random(0, 30)
    end,
}

local talentItemId = {
    [0] = 0,
    [1] = 20103,
    [2] = 20104,
    [3] = 20105
}

local talentItemImg = {
    [0] = getItemImg(talentItemId[0]),
    [1] = getItemImg(talentItemId[1]),
    [2] = getItemImg(talentItemId[2]),
    [3] = getItemImg(talentItemId[3])
}

local talentItemNeed = {
    [0] = 5000,
    [1] = 1,
    [2] = 1,
    [3] = 1
}

local petTalentMap = {}
petTalentAtkMap = {}
petTalentDefMap = {}

local function setTalentAttr(pet, talentIndex, level)
    local tmp = petSkillBuff[talentIndex]
    local buff = {tmp[1], tmp[2]}
    buff[2] = buff[2] * level
    if talentIndex > 6 then
        buff[2] = math.ceil((getAttr(pet, buff[1]) * buff[2]) / 100)
    end
    local uuid = pet:getUuid()
    if rawget(petTalentMap, uuid) ~= nil then
        changeBuff(pet, petTalentMap[uuid], buff)
    else
        addBuff(pet, buff)
    end
    petTalentMap[uuid] = buff
end

local function removePetTalentBuff(pet)
    local uuid = pet:getUuid()
    if rawget(petTalentMap, uuid) ~= nil then
        subBuff(pet, petTalentMap[uuid])
        petTalentMap[uuid] = nil
    end
    if rawget(petTalentAtkMap, uuid) ~= nil then
        petTalentAtkMap[uuid] = nil
    end
    if rawget(petTalentDefMap, uuid) ~= nil then
        petTalentDefMap[uuid] = nil
    end
end

local function setTalentBuff(pet, skillId)
    local index = skillId - 30400
    local level = math.floor((index - 1) / 30) + 1
    index = math.fmod(index, 30)
    local uuid = pet:getUuid()
    if index >= 14 then
        if rawget(petTalentMap, uuid) ~= nil then
            subBuff(pet, petTalentMap[uuid])
            petTalentMap[uuid] = nil
        end
        if 16 ~= index then
            petTalentAtkMap[uuid] = skillAtkDamage[uuid]
        else
            petTalentDefMap[uuid] = 5 * level
        end
    else
        if rawget(petTalentAtkMap, uuid) ~= nil then
            petTalentAtkMap[uuid] = nil
        end
        if rawget(petTalentDefMap, uuid) ~= nil then
            petTalentDefMap[uuid] = nil
        end
        setTalentAttr(pet, index, level)
    end
end

function loadTalent(player)
    logPrint("getTalent ", player:getObj())
    local pet = player:getBattlePet()
    if pet:isValid() then
        local skillId = pet:getSkill(pet:getSkillSlots() - 1)
        logPrint("loadTalent ", skillId)
        if skillId > 30400 and skillId < 30500 then
            setTalentBuff(pet, skillId)
        end
    end
end

function unloadTalent(player)
    for i = 0, 4 do
        local pet = player:getPet(i)
        if pet:isValid() then
            local uuid = pet:getUuid()
            if rawget(petTalentMap, uuid) ~= nil then
                petTalentMap[uuid] = nil
                petTalentAtkMap[uuid] = nil
                petTalentDefMap[uuid] = nil
            end
        end
    end
end

local function getTalentInfo(player)
    local talentInfo = {}
    local petArr = {}
    local index = 1
    for i = 0, 4 do
        local pet = player:getPet(i)
        if pet:isValid() then
            local skillId = pet:getSkill(pet:getSkillSlots() - 1)
            if skillId >= 30400 and skillId < 30500 and pet:getLevel() >= 70 then
                local petInfo = {
                    ["name"] = string.sub(pet:getName(), 1, 16),
                    ["uuid"] = pet:getUuid(),
                    ["img"] = pet:getImage(),
                    ["talent"] = skillId,
                }
                petArr[tostring(index)] = petInfo
                index = index + 1
            end
        end
    end
    talentInfo["pet"] = petArr
    local itemArr = {}
    for i = 0, 3 do
        itemArr[tostring(i)] = {
            ["img"] = talentItemImg[i],
            ["num"] = player:getItemNum(talentItemId[i]),
            ["need"] = talentItemNeed[i],
        }
    end
    talentInfo["item"] = itemArr
    logPrintTbl(talentInfo)
    return talentInfo
end

local function initTalent(player, pet)
    if pet:getLevel() < 70 then
        player:sysMsg("宠物等级不足70级，无法领悟天赋")
        return
    end
    local slots = pet:getSkillSlots() - 1
    if pet:getSkill(slots) ~= 30400 then
        player:sysMsg("宠物已经领悟天赋, 无法重新领悟")
        return
    end

    local skillId = getRandObj(skillRate)
    pet:setSkill(slots, skillId)
    pet:flush()
    if pet:getStatus() == Const.PetBattle then
        setTalentBuff(pet, skillId)
    end
    player:sysMsg("宠物成功领悟天赋【" .. skillName[skillId - 30400] .. "LV1】");
end

function getTalent(player, arg)
    local arr = strSplit(arg, ",")
    local level = tonumber(arr[2])
    local pet = player:getPetByUuid(arr[1])
    if 0 == level then
        return initTalent(player, pet)
    end
    local slots = pet:getSkillSlots() - 1
    if pet:getSkill(slots) == 30400 then
        player:sysMsg("宠物尚未领悟天赋, 无法重置天赋")
        return
    end
    if player:delNum(talentItemId[level], 1) <= 0 then
        player:sysMsg("道具不足,无法重置天赋")
        return
    end

    local skillId = getRandObj(skillRate)
    local slots = pet:getSkillSlots() - 1
    local oldSkillId = pet:getSkill(slots)

    if oldSkillId ~= skillId then
        pet:setSkill(slots, skillId + (level - 1) * 30)
        pet:flush()
        if pet:getStatus() == Const.PetBattle then
            setTalentBuff(pet, skillId)
        end
    end
    player:sysMsg("宠物重置天赋成功，获得新天赋【" .. skillName[skillId - 30400] .. "LV" .. level .. "】");
    Protocol.PowerSend(player:getObj(),"FLUSH_TALENT", getTalentInfo(player))
end

function Event.RegPetLevelUpEvent.doPetLevelUp(index)
    local pet = MyPet:new1(index)
    if pet:isValid() then
        local skillId = pet:getSkill(pet:getSkillSlots() - 1)
        if skillId > 0 then
            setTalentBuff(pet, skillId)
        end
    end
end

function setPetStatus(fd, head, packet)
    logPrint("setPetStatus ", head, packet)
    local player = MyPlayer:new(Protocol.GetCharByFd(fd))
    local battleSlot = player:getBattlePetSlot()
    local arr = strSplit(packet, ":")
    for i, val in ipairs(arr) do
        if val == "2" and i ~= battleSlot then
            local pet1 = player:getPet(battleSlot)
            local pet2 = player:getPet(i)
            local skillId = pet1:getSkill(pet1:getSkillSlots() - 1)
            if skillId ~= 30400 then
                removePetTalentBuff(pet1)
            end
            skillId = pet2:getSkill(pet1:getSkillSlots() - 1)
            if skillId ~= 30400 then
                setTalentBuff(pet1, skillId)
            end
            logPrint("atk ", i)
        end
    end
    return 0
end

function changeSkill(fd, head, packet)
    logPrint("changeSkill ", head, packet)
    local myPlayer = MyPlayer:new(Protocol.GetCharByFd(fd))
    local arr = strSplit(packet, ":")
    local pet = myPlayer:getPet(tonumber(arr[1]))
    local slots = pet:getSkillSlots() - 1
    if tonumber(arr[2]) == slots or tonumber(arr[3]) == slots then
        myPlayer:sysMsg("天赋技能不允许交换位置。")
        return 1
    end
    return 0
end

function showTalent(player)
    Protocol.PowerSend(player:getObj(),"SHOW_TALENT", getTalentInfo(player))
    logPrintTbl("showTalent")
end

function npcTalent(npc, player, s)
    showTalent(player)
end

npcDialog[Const.NpcTalent] = npcTalent
TalkEvent["[talent]"] = showTalent
InitEvent["char"] = loadTalent
DeinitEvent["char"] = unloadTalent
ClientEvent["get_talent"] = getTalent

Protocol.OnRecv(nil, "setPetStatus", 37)
Protocol.OnRecv(nil, "changeSkill", 58);

