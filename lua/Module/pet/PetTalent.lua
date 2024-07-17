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
    [30401] = { },
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
}

local talentItemId = {
    [1] = 40103,
    [2] = 40104,
    [3] = 40105
}

function loadTalent(player)

end

function initTalent(player, slot)
    local pet = MyPet:new(player:getObj(), slot)
    if pet:getLevel() < 70 then
        player:sysMsg("宠物等级不足70级，无法领悟天赋")
        return
    end
    for i = 1, 10 do
        local skillId = pet:getSkill(i)
        if skillId > 30401 and skillId < 30499 then
            player:sysMsg("宠物领悟天赋, 无法重新领悟")
            return
        end
    end

    local skillId = getRandObj(skillRate)
    pet:addSkill(skillId)
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

    for i = 1, 10 do
        local skillId = pet:getSkill(i)
        if skillId > 30401 and skillId < 30499 then
            pet:delSkill(i)
        end
    end

    local skillId = getRandObj(skillRate)
    pet:addSkill(skillId + (level - 1) * 30)
    pet:flush()
    player:sysMsg("宠物重置天赋成功，获得新天赋【" .. skillName[skillId - 30400] .. "LV" .. level .. "】");
end

InitEvent["char"] = loadTalent