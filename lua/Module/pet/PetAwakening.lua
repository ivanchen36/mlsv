local earthAttr = 1
local waterAttr = 2
local fireAttr = 3
local windAttr = 4

local itemList = {18310, 18311, 18312, 18313}
local itemNum = {99, 399, 999}
local attrField = {"EarthLevel", "WaterLevel", "FireLevel", "WindLevel"}

function getSynthesisInfo(player)
    local petArr = {}
    local index = 1
    for i = 0, 4 do
        local pet = MyPet:new(player:getObj(), i)
        if pet:isValid() then
            local petAwake = {
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
            local sql = "select EarthLevel + WaterLevel + FireLevel+ WindLevel, EarthLevel,WaterLevel,FireLevel,WindLevel from tbl_pet_info where uuid = " .. pet:getUuid();
            local rs = SQL.Run(sql);
            if(type(rs) ~= "table")then
                petAwake["level"] = 0
                petAwake["earth"] = 0
                petAwake["water"] = 0
                petAwake["fire"] = 0
                petAwake["wind"] = 0
            else
                petAwake["level"] = tonumber(rs["0_0"])
                petAwake["earth"] = tonumber(rs["0_1"])
                petAwake["water"] = tonumber(rs["0_2"])
                petAwake["fire"] = tonumber(rs["0_3"])
                petAwake["wind"] = tonumber(rs["0_4"])
            end
            petArr[index] = petAwake
            index = index + 1
        end
    end
    return petArr
end

function showAwakening(player, arg)
    Protocol.PowerSend(player:getObj(),"SHOW_AWAKENING", getSynthesisInfo(player))
end

function upAwakening(player, arg)
    local param = strSplit(arg, "|")
    local uuid = tonumber(param[1]);
    local attr = tonumber(param[2]);
    local itemId = itemList[attr]
    local pet = MyPet:getByUuid(player:getObj(), uuid)
    if nil == pet then
        player:sysMsg("需要觉醒的宠物不存在，宠物觉醒失败");
        return
    end
    local sql = "select EarthLevel + WaterLevel + FireLevel+ WindLevel, " .. attrField[attr] .. " from tbl_pet_info where uuid = " .. pet:getUuid();
    local rs = SQL.Run(sql);
    local level = tonumber(rs["0_0"])
    local attrLevel = tonumber(rs["0_1"])
    local addAttr = 10
    local addArt = 3

    if level >= 3 then
        player:sysMsg("宠物" .. level .."已经完成第" .. level .."次觉醒");
        return
    end

    if player:getItemNum(itemId) < itemNum[level] then
        if player:delNum(itemId, itemNum[level]) > 0 then
            if 2 == attrLevel then
                addAttr = 20
                addArt = 4
            end
            if attr == earthAttr then
                pet:setEarthAttribute(pet:getEarthAttribute() + addAttr)
                pet:setMagic(pet:getMagic() + addArt)
            elseif attr == waterAttr then
                pet:setWaterAttribute(pet:getWaterAttribute() + addAttr)
                pet:setVital(pet:getVital() + addArt)
            elseif attr == fireAttr then
                pet:setFireAttribute(pet:getFireAttribute() + addAttr)
                pet:setStr(pet:getStr() + addArt)
            elseif attr == windAttr then
                pet:setWindAttribute(pet:getWindAttribute() + addAttr)
                pet:setQuick(pet:getQuick() + addArt)
            end
            pet:flush()
            local sql1 = "update tbl_pet_info set " .. attrField[attr] .. " = " .. attrField[attr] .. " + 1 where uuid = " .. pet:getUuid() .. " and ".. attrField[attr] .. " < 3";
            SQL.Run(sql1);
            player:sysMsg("宠物" .. level .."完成第" .. level .."次觉醒");
            Protocol.PowerSend(player:getObj(),"FLUSH_AWAKENING", getSynthesisInfo(player))
            return
        end
    end
    player:sysMsg("道具不足，宠物" .. level .."完成第" .. level .."次觉醒失败");
end

TalkEvent["[awakening]"] = showAwakening
ClientEvent["up_awakening"] = upAwakening