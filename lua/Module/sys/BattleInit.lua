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
            if enemy:getLevel() == 1 and name ~= "�粼��" and name ~= "��������" then
                local xue = enemy:getHp()
                local msg = "[����һ���������]����һ�����" .. name .. "�����֣�����ֵ��" .. xue .. "��"
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
    NLG.SystemMessage(player:getObj(), "[��ʹ�ӻ�]"..player:getName().."�ܵ�����ʹ��ף��,����ֵ�ָ�ȫ��.");
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