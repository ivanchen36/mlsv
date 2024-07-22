local synthesisAmount = 50000

function getSynthesisInfo(player)
    local petArr = {}
    local index = 1
    for i = 0, 4 do
        local pet = player:getPet(i)
        if pet:isValid() and pet:getLevel() == 1 then
            petArr[index] = {
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
                ["img"] = pet:getImage(),
            }
            index = index + 1
        end
    end
    if player:getGold() >= synthesisAmount then
        petArr["amount"] = 1
    else
        petArr["amount"] = 0
    end
    return petArr
end

function showSynthesis(player, arg)
    Protocol.PowerSend(player:getObj(),"SHOW_SYNTHESIS", getSynthesisInfo(player))
end

function petSynthesis(player, arg)
    local param = strSplit(arg, ",")
    local uuid1 = param[1];
    local uuid2 = param[2];
    local pet1 = player:getPetByUuid(uuid1)
    local pet2 = player:getPetByUuid(uuid2)
    if nil == pet1 or nil == pet2 then
        player:sysMsg("需要合成的宠物不存在，宠物合成失败");
        Protocol.PowerSend(player:getObj(),"UPDATE_SYNTHESIS", getSynthesisInfo(player))
        return
    end
    if pet1:getLevel() ~= 1 or pet2:getLevel() ~= 1 then
        player:sysMsg("宠物等级不是1级，宠物合成失败");
        Protocol.PowerSend(player:getObj(),"UPDATE_SYNTHESIS", getSynthesisInfo(player))
        return
    end
    if player:subMoney(synthesisAmount) <= 0 then
        player:sysMsg("合成所需魔币不足，宠物合成失败");
        return
    end

    pet1:setId(pet2:getId())
    if pet2:delete() <= 0 then
        player:sysMsg("需要合成的宠物不存在，宠物合成失败");
        return
    end
    pet1:reinitDang(math.random(0,4), math.random(0,4), math.random(0,4), math.random(0,4), math.random(0,4))
    player:flush()
    Protocol.PowerSend(player:getObj(),"FLUSH_SYNTHESIS", getSynthesisInfo(player))
    player:sysMsg("合成宠物成功");
end

TalkEvent["[synthesis]"] = showSynthesis
ClientEvent["pet_synthesis"] = petSynthesis