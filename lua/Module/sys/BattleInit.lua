local function notifyPlayer(battleIndex, msg)
    local player = MyPlayer:new(Battle.GetPlayer(battleIndex,0))
    if not player:isValid() or not player:isPerson() then
        player = MyPlayer:new(Battle.GetPlayer(battleIndex,5))
    end
    NLG.TalkToCli(player:getObj(), -1, msg, 5, 0);
    local num = player:getPartyNum()
    if num <= 1 then
        return
    end

    for i = 1, num - 1 do
        NLG.TalkToCli(player:getPartyMember(i):getObj(), -1, msg, 5, 0);
    end
end

function showLvOne(battleIndex)
    if Battle.GetType(battleIndex) ~= Const.BT_ENEMY then
        return
    end
    if Battle.IsBossBattle(battleIndex) then
        return
    end

    for i = 10, 19 do
        local enemy = MyEnemy:new(Battle.GetPlayer(battleIndex, i))
        if enemy:isValid() then
            local name = enemy:getName()
            if enemy:getLevel() == 1 and name ~= "哥布林" and name ~= "迷你蝙蝠" then
                local xue = enemy:getHp()
                local msg = "[★☆★一级宠物★☆★]发现一级宠物「" .. name .. "」出现！生命值「" .. xue .. "」"
                notifyPlayer(battleIndex, msg)
            end
        end
    end
end

local function newbieBlessByPlayer(player)
    if player:getLevel() > 30 or not player:needHp() then
        return
    end

    local pet = player:getBattlePet()
    pet:recoverHp()
    pet:flush()
    player:recoverHp()
    player:flush()
    NLG.SystemMessage(player:getObj(), "[天使庇护]"..player:getName().."受到了天使的祝福,生命值恢复全满.");
end

function newbieBless(battle)
    local player = MyPlayer:new(Battle.GetPlayer(battle,0))
    if not player:isValid() or not player:isPerson() then
        player = MyPlayer:new(Battle.GetPlayer(battle,5))
    end
    newbieBlessByPlayer(player)
    local num = player:getPartyNum()
    if num <= 1 then
        return
    end

    for i = 1, num - 1 do
        newbieBlessByPlayer(player:getPartyMember(i))
    end
end

InitEvent["battle"] = startEnemyBattle
DeinitEvent["battle"] = newbieBless