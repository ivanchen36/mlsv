local recoverHurtAmount = {1000, 2000, 3000, 4000}

TalkEvent["/dk"] = function (player)
    if 1 == player:getCheckIn() then
        player:feverStop()
        return
    end

    if player:subMoney(200) > 0 then
        player:feverStart()
        return
    end
end

TalkEvent["/hc"] = function (player)
    player:warp(0,64148,19 + math.random(0, 4), 24 + math.random(0, 8))
end

TalkEvent["/zl"] = function (player)
    local health = math.ceil(player:getHurtStatus() / 25)
    if health == 0 then
        player:sysMsg("您没有受伤，无需治疗。")
        return
    end
    local amount = recoverHurtAmount[health]
    if player:subMoney(amount) > 0 then
        player:recoverHurt()
        NLG.UpdateParty(player:getObj());
        player:flush()
        NLG.SendGraphEvent(player:getObj(), 45, 0);
        player:sysMsg("治疗成功，您已经恢复健康。")
        return
    end

    player:sysMsg("您的魔币不足" .. amount .."，治疗失败。")
end

TalkEvent["/1"] = function (player)
    if player:isYudi() then
        player:stopYudi()
        return
    end

    player:startYudi()
end

TalkEvent["/3"] = function (player)
    player:switchQietu()
end

TalkEvent["/4"] = function (player)
    player:switchZhizao()
end

TalkEvent["[bianjie]"] = function (player)
    Protocol.SendLuaCustomPacket(player:getObj(),"khd_bianjie", "会员系统,[vip]|坐骑,[zuoqi2]|翅膀,[#ChiBang]");
end

TaskHandler[99] = function(regNum, info)
    if regNum == 0 then
        NLG.SystemMessage(-1, info)
    elseif rawget(vipInfo, regNum) ~= nil then
        NLG.SystemMessage(vipInfo[regNum]["index"], info)
    end

    return 1
end
