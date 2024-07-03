
function getRecoverAmount(player)
    local gold = player:getMaxMp() - player:getMp()
    local gold1 = math.floor((player:getMaxHp() - player:getHp()) / 2)
    if gold1 > gold then
        gold = gold1
    end
    if player:getJob() == 1 or (player:getJob() > 200 and player:getJob() < 500) then
        return gold
    end
    local gold2 = (player:getLevel() - 1) * 15 + 1375
    if gold2 < gold then
        gold = gold2
    end

    return gold
end

function partyRecover(player, arg)
    local num = player:getPartyNum()

    for i = 1, num do
        local member = player:getPartyMember(i - 1)
        local amount = getRecoverAmount(member)
        if player:subMoney(amount) > 0 then
            player:setHp(self:getMaxHp())
            player:setMp(self:getMaxMp())
            player:flush()
            player:sysMsg("�ָ��ɹ�������������ħ���Ѿ��ָ���")
            return
        else
            player:sysMsg("�ָ�ʧ�ܣ�����ħ�Ҳ���" .. amount .. "G��")
        end
    end
end

function showRecover(player)
    local info = {}
    local num = player:getPartyNum()
    info[1] = {"����", "����", "ħ��", "�ָ��۸�"}
    for i = 1, num do
        local member = player:getPartyMember(i - 1)
        info[i + 1] = {
            member:getName(),
            member:getHp() .. "/" .. member:getMaxHp(),
            member:getMp() .. "/" .. member:getMaxMp(),
            getRecoverAmount(member)
        }
    end
    Protocol.PowerSend(player:getObj(),"SHOW_RECOVER", info)
    getRecoverClient(player)
end

ClientEvent["party_recover"] = partyRecover
TalkEvent["[recover]"] = showRecover