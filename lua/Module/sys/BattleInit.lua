function lvOnePet(battle)
    for i = 10, 19 do
        local player = MyPlayer:new(Battle.GetPlayer(battle, i))
        if player:isValid() then
            local name = player:getName()
            if player:getLevel() == 1 and name ~= "�粼��" and name ~= "��������" then
                local xue = player:getHp()
                local msg = "[����һ���������]����һ�����" .. name .. "�����֣�����ֵ��" .. xue .. "��"
                for j = 0, 4 do
                    local player1 = MyPlayer:new(Battle.GetPlayer(battle, j));
                    if player1:isPerson() then
                        NLG.TalkToCli(player1:getObj(), -1, msg, 5, 0);
                    end
                end
            end
        end
    end
end

function newbieBlessByPlayer(player)
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

InitEvent["battle"] = lvOnePet
DeinitEvent["battle"] = newbieBless