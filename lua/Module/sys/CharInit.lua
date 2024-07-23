
function welcome(player)
    logPrint("player ")
    NLG.SystemMessage(player:getObj(), "�Զ�Ѱ· F3 F4 ���� �Զ�ս��F1 F2 F5");
    NLG.SystemMessage(-1, "�Զ�Ѱ· F3 F4 ���� �Զ�ս��F1 F2 F5");
end

function skillSet(player)
    logPrint("skillSet ")
    --tech_ԭͼ��&��ͼ��, --Ϊ�����ֹٷ� techβ������λ Ϊ51��ʼ����Ч ����Ǭ�� 351~399 ��֧�ָ�����ͼ��
    local skillset = "481_111055&111252,6381_110085&111154,6681_111019&111199,6681_110168&111019,"

    Protocol.SendLuaCustomPacket(player:getObj(), "diyskill", skillset);
end

function chibangSet(player)
    logPrint("chibangSet ")
    --���س��ͼ��
    local chibangset = "119750,119751,"

    Protocol.SendLuaCustomPacket(player:getObj(), "diychibang", chibangset);

end

function toushiSet(player)
    logPrint("toushiSet ")
    --����������Ĭ��ƫ��-65_-1ΪĬ��, -200_119751Ϊ�������� ������������ƺ�ͼ�� ֱ�Ӻ��� ƫ��_���
    local toushiset = "-65_-1,-200_119751,"

    Protocol.SendLuaCustomPacket(player:getObj(), "diytoushinil", toushiset);

end

function buttonInit(player)
    logPrint("buttonInit ")
    Protocol.SendLuaCustomPacket(player:getObj(), "diy6", "��ʾ���ص��ϵĳ���&|���T��&[TEAM]|�����㵵&[1]|��������&[2]|���͹�ս����&[3]|���߹һ�&[5]|test&[t3]|test&[t4]|test&[t5]|test&[t6]|�����̳�&[shop]|��ϵ�ͷ�&[6]|����QQȺ&[7]");
end

function petInit(player, arg)
    for i = 0, 4 do
        local myPet = player:getPet(i)
        if myPet:isValid() then
            if 0 == myPet:getNameColor() then
                local slots = myPet:getSkillSlots()
                if slots < 10 then
                    slots = slots + 1
                    myPet:setSkillSlots(slots)
                end
                myPet:setSkill(slots - 1, 30400)
                myPet:initXz()
                myPet:setNameColor(1)
                myPet:flush()
            end
        end
    end
end

ClientEvent["pet_init"] = petInit;
InitEvent["char"] = welcome
InitEvent["char"] = skillSet
InitEvent["char"] = chibangSet
InitEvent["char"] = toushiSet
InitEvent["char"] = buttonInit


