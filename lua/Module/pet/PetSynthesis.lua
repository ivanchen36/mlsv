local synthesisAmount = 50000

function getSynthesisInfo()
    local petArr = {}
    for i = 0, 4 do
        local pet = MyPet:new(player:getObj(), i)
        if not pet:isValid() then
            petArr[i] = nil
        elseif pet:getLevel() ~= 1 then
            petArr[i] = nil
        else
            petArr[i] = {
                ["name"] = pet:getName(),
                ["uuid"] = pet:getUuid(),
                ["vital"] = pet:getVital(),
                ["str"] = pet:getStr(),
                ["tough"] = pet:getTough(),
                ["quick"] = pet:getQuick(),
                ["magic"] = pet:getMagic(),
                ["earth"] = pet:getEarthAttribute(),
                ["water"] = pet:getWaterAttribute(),
                ["fire"] = pet:getFireAttribute(),
                ["wind"] = pet:getWindAttribute(),
            }
        end
    end
    return petArr
end

function showSynthesis(player, arg)
    Protocol.PowerSend(player:getObj(),"SHOW_SYNTHESIS", getSynthesisInfo())
end

function petSynthesis(player, arg)
    local param = strSplit(arg, "|")
    local uuid1 = tonumber(param[1]);
    local uuid2 = tonumber(param[2]);
    local pet1 = MyPet:getByUuid(player:getObj(), uuid1)
    local pet2 = MyPet:getByUuid(player:getObj(), uuid2)
    if nil == pet1 or nil == pet2 then
        player:sysMsg("��Ҫ�ϳɵĳ��ﲻ���ڣ�����ϳ�ʧ��");
        Protocol.PowerSend(player:getObj(),"UPDATE_SYNTHESIS", getSynthesisInfo())
        return
    end
    if pet1:getLevel() ~= 1 or pet2:getLevel() ~= 1 then
        player:sysMsg("����ȼ�����1��������ϳ�ʧ��");
        Protocol.PowerSend(player:getObj(),"UPDATE_SYNTHESIS", getSynthesisInfo())
        return
    end

    if player:subMoney(synthesisAmount) <= 0 then
        player:sysMsg("�ϳ�����ħ�Ҳ��㣬����ϳ�ʧ��");
        return
    end

    if pet2:delete() <= 0 then
        player:sysMsg("��Ҫ�ϳɵĳ��ﲻ���ڣ�����ϳ�ʧ��");
        return
    end
    pet1:flush()
    Protocol.PowerSend(player:getObj(),"UPDATE_SYNTHESIS", getSynthesisInfo())
end

TalkEvent["[synthesis]"] = showSynthesis
ClientEvent["pet_synthesis"] = petSynthesis