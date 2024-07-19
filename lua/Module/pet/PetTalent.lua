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
    [1] = 40103,
    [2] = 40104,
    [3] = 40105
}

local petTalentMap = {}
petTalentAtkMap = {}
petTalentDefMap = {}

local function setTalentAttr(pet, index, level)
    local tmp = petSkillBuff[index]
    local buff = {tmp[1], tmp[2]}
    buff[2] = buff[2] * level
    if index > 6 then
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

local function setTalentBuff(pet, skillId)
    local index = skillId - 30400
    local level = math.floor(index / 30) + 1
    index = math.mod(index, 30)
    if index >= 14 then
        local uuid = pet:getUuid()
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
        setTalentAttr(pet, index, level)
    end
end

local function getTalent(pet)
    for i = 1, 10 do
        local skillId = pet:getSkill(i)
        if skillId > 30400 and skillId < 30499 then
            return skillId
        end
    end
    return 0
end

function loadTalent(player)
    for i = 0, 4 do
        local pet = MyPet:new(player, i)
        if pet:isValid() then
            local skillId = getTalent(pet)
            if skillId > 0 then
                setTalentBuff(pet, skillId)
            end
        end
    end
end

function unloadTalent(player)
    for i = 0, 4 do
        local pet = MyPet:new(player, i)
        if pet:isValid() then
            local skillId = getTalent(pet)
            if skillId > 0 then
                local uuid = pet:getUuid()
                petTalentMap[uuid] = nil
                petTalentAtkMap[uuid] = nil
                petTalentDefMap[uuid] = nil
            end
        end
    end
end

function initTalent(player)
    local pet = MyPet:new(player:getObj(), 0)
    if not pet:isValid() then
        player:sysMsg("宠物第一栏没有宠物，无法领悟天赋")
        return
    end
    if pet:getLevel() < 70 then
        player:sysMsg("宠物等级不足70级，无法领悟天赋")
        return
    end
    for i = 1, 10 do
        local skillId = pet:getSkill(i)
        if skillId > 30400 and skillId < 30499 then
            player:sysMsg("宠物领悟天赋, 无法重新领悟")
            return
        end
    end

    local skillId = getRandObj(skillRate)
    pet:addSkill(skillId)
    setTalentAttr(pet, skillId)
    player:sysMsg("宠物成功领悟天赋【" .. skillName[skillId - 30400] .. "LV1】");
end

function reInitTalent(player, slot, level)
    local pet = MyPet:new(player:getObj(), slot)
    if pet:getLevel() < 70 then
        player:sysMsg("宠物等级不足70级，无法重置天赋")
        return
    end
    if player:delNum(talentItemId[level], 1) <= 0 then
        player:sysMsg("道具不足,无法重置天赋")
        return
    end

    local oldSkillId = 0
    for i = 1, 10 do
        local skillId = pet:getSkill(i)
        if skillId > 30400 and skillId < 30499 then
            oldSkillId = skillId
            pet:delSkill(i)
        end
    end

    local skillId = getRandObj(skillRate)
    pet:addSkill(skillId + (level - 1) * 30)
    if oldSkillId ~= skillId then
        setTalentBuff(pet, skillId)
    end
    player:sysMsg("宠物重置天赋成功，获得新天赋【" .. skillName[skillId - 30400] .. "LV" .. level .. "】");
end

function Event.RegPetLevelUpEvent.doPetLevelUp(index)
    local pet = MyPet:new1(index)
    if pet:isValid() then
        local skillId = getTalent(pet)
        if skillId > 0 then
            setTalentBuff(pet, skillId)
        end
    end
end

InitEvent["char"] = loadTalent
DeinitEvent["char"] = unloadTalent