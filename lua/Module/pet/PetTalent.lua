local beginnerSkill = {
}
local intermediateSkill = {
}
local advancedSkill = {
}

local allSkill = {

}

local initItemId = 1
local reInitItemId = 1

function initTalent(player, slot)
    local pet = MyPet:new(player:getObj(), slot)
    if player:getItemNum(initItemId) < 0 then
        player:sysMsg("道具不足,无法觉醒天赋")
        return
    end

    for i = 1, 10 do
        local skillId = pet:getSkill(i)
        if skillId > 0 and rawget(allSkill, skillId) ~= nil then
            player:sysMsg("宠物觉醒天赋, 无法重新觉醒")
            return
        end
    end

    if player:delNum(initItemId, 1) > 0 then
        pet:addSkill(allSkill[math.random(#allSkill)])
        self:sysMsg("宠物天赋觉醒成功");
        return
    end

    player:sysMsg("道具不足,无法觉醒天赋")
end

function reInitTalent(player, slot, level)
    local pet = MyPet:new(player:getObj(), slot)
    if player:getItemNum(reInitItemId) < 0 then
        player:sysMsg("道具不足,无法重置天赋")
        return
    end

    for i = 1, 10 do
        local skillId = pet:getSkill(i)
        if skillId > 0 and rawget(allSkill, skillId) ~= nil then
            pet:delSkill(i)
            if player:delNum(initItemId, 1) <= 0 then
                player:sysMsg("道具不足,无法重置天赋")
                return
            end

            if level == 1 then
                local skillId = beginnerSkill[math.random(#beginnerSkill)]
                pet:addSkill(skillId)
            elseif level == 2 then
                local skillId = intermediateSkill[math.random(#intermediateSkill)]
                pet:addSkill(skillId)
            elseif level == 3 then
                local skillId = advancedSkill[math.random(#advancedSkill)]
                pet:addSkill(skillId)
            end
            self:sysMsg("宠物天赋重置成功");
            return
        end
    end

    player:sysMsg("宠物没有觉醒天赋, 无法进行重置")
end