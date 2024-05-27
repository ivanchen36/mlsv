function lvOnePet(battle)
    logPrint("lvOnePet ")
    for i=10,19 do
        local player = MyPlayer:new(Battle.GetPlayer(battle,i))
        if player:isValid() then
            goto continue
        end
        local name = player:getName()
        if player:getLevel() ~= 1 or name == "�粼��" or name ==  "��������" then
            goto continue
        end
        local xue = player:getHp()
        local msg = "[����һ���������]����һ�����"..name.."�����֣�����ֵ��".. xue.."��"
        for j=0,4 do
            local BPlayerIndex = Battle.GetPlayer(battle,j);
            if(BPlayerIndex >= 0) then
                NLG.TalkToCli(BPlayerIndex,-1, msg, 5, 0); -- %��ɫ_��ɫ%,%����_��%
            end
        end
        ::continue::
    end
end

function newbieBlessByPlayer(player)
    if not player:isValid() or player:getLevel() > 30 or not player.needHp() then
        return
    end

    player:recoverHp()
    if player:isPerson() then
        NLG.SystemMessage(player,"[��ʹ�ӻ�]"..player.getName().."�ܵ�����ʹ��ף��,����ֵ�ָ�ȫ��.");
    end
end

function newbieBless(battle)
    logPrint("newbieBless ")
    for i=0,9 do
        local player = MyPlayer:new(Battle.GetPlayer(battle,i))
        newbieBlessByPlayer(player)
    end
    return 1;
end

InitEvent["battle"] = lvOnePet
DeinitEvent["battle"] = newbieBless