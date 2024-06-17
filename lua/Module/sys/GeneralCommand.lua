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
    player:warp(0,1000,240,80)
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

TalkEvent["[petfy]"] = function (player)
    for i=0,4 do
        myPet = MyPet:new(player:getObj(), pet, i)
        if not myPet:isValid() then
            return;
        end
        myPet:initXz()
    end
end

TalkEvent["[bianjie]"] = function (player)
    Protocol.SendLuaCustomPacket(player:getObj(),"khd_bianjie", "��Աϵͳ,[vip]|ǩ��,[qiandao2]|�ճ�����,[routine]|pkϵͳ,[pk]|����ר��,[proficient]|����ϳ�,[proficient]|�������,[synthesis]|ǿ��,[QiangHua]|����,[zuoqi2]|���,[#ChiBang]");
end

TaskHandler[99] = function(regNum, info)
    if regNum == 0 then
        NLG.SystemMessage(-1, info)
    elseif rawget(vipInfo, regNum) ~= nil then
        NLG.SystemMessage(vipInfo[regNum]["index"], info)
    end

    return 1
end
