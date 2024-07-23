
function welcome(player)
    logPrint("player ")
    NLG.SystemMessage(player:getObj(), "自动寻路 F3 F4 开启 自动战斗F1 F2 F5");
    NLG.SystemMessage(-1, "自动寻路 F3 F4 开启 自动战斗F1 F2 F5");
end

function skillSet(player)
    logPrint("skillSet ")
    --tech_原图档&新图档, --为了区分官方 tech尾数后两位 为51开始才生效 比如乾坤 351~399 才支持更改新图档
    local skillset = "481_111055&111252,6381_110085&111154,6681_111019&111199,6681_110168&111019,"

    Protocol.SendLuaCustomPacket(player:getObj(), "diyskill", skillset);
end

function chibangSet(player)
    logPrint("chibangSet ")
    --加载翅膀图档
    local chibangset = "119750,119751,"

    Protocol.SendLuaCustomPacket(player:getObj(), "diychibang", chibangset);

end

function toushiSet(player)
    logPrint("toushiSet ")
    --设置无数据默认偏移-65_-1为默认, -200_119751为单独设置 如果打算新增称号图档 直接后面 偏移_编号
    local toushiset = "-65_-1,-200_119751,"

    Protocol.SendLuaCustomPacket(player:getObj(), "diytoushinil", toushiset);

end

function buttonInit(player)
    logPrint("buttonInit ")
    Protocol.SendLuaCustomPacket(player:getObj(), "diy6", "显示隐藏地上的宠物&|组队T人&[TEAM]|宠物算档&[1]|宠物自售&[2]|发送观战代码&[3]|离线挂机&[5]|test&[t3]|test&[t4]|test&[t5]|test&[t6]|在线商城&[shop]|联系客服&[6]|加入QQ群&[7]");
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


