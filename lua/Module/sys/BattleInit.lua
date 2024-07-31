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
                for j = 0, 4 do
                    local player1 = MyPlayer:new(Battle.GetPlayer(battleIndex, j));
                    if player1:isPerson() then
                        NLG.TalkToCli(player1:getObj(), -1, msg, 5, 0);
                    end
                end
            end
        end
    end
end

local function newbieBlessByPlayer(player)
    if not player:isValid() or player:getLevel() > 30 or not player:needHp() then
        return
    end

    player:recoverHp()
    player:flush()
    if player:isPerson() then
        NLG.SystemMessage(player,"[��ʹ�ӻ�]"..player:getName().."�ܵ�����ʹ��ף��,����ֵ�ָ�ȫ��.");
    end
end

function newbieBless(battle)
    for i=0,9 do
        local player = MyPlayer:new(Battle.GetPlayer(battle,i))
        newbieBlessByPlayer(player)
    end
    return 1;
end

InitEvent["battle"] = startEnemyBattle
DeinitEvent["battle"] = newbieBless