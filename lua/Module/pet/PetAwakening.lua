local earthAttr = 1
local waterAttr = 2
local fireAttr = 3
local windAttr = 4

local attrList = {18310, 18311, 18312, 18313}
local attrImgList = {
    getItemImg(attrList[1]),
    getItemImg(attrList[2]),
    getItemImg(attrList[3]),
    getItemImg(attrList[4])
}

local itemList = {0, 20101, 20102}
local itemImgList = {
    0,
    getItemImg(itemList[2]) or 0,
    getItemImg(itemList[3]) or 0
}

local attrNum = {99, 399, 999}
local attrField = {"EarthLevel", "WaterLevel", "FireLevel", "WindLevel"}

function getAwakeningInfo(player)
    logPrint("getAwakeningInfo")
    local petArr = {}
    local index = 1
    for i = 0, 4 do
        local pet = player:getPet(i)
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
            local sql = string.format("select EarthLevel + WaterLevel + FireLevel+ WindLevel, EarthLevel,WaterLevel,FireLevel,WindLevel from tbl_pet_info where uuid = '%s'", pet:getUuid())
            local rs = SQL.Run(sql);
            if(type(rs) ~= "table")then
                petAwake["level"] = 0
                petAwake["eLevel"] = 0
                petAwake["wLevel"] = 0
                petAwake["fLevel"] = 0
                petAwake["wLevel"] = 0
            else
                petAwake["level"] = tonumber(rs["0_0"])
                petAwake["eLevel"] = tonumber(rs["0_1"])
                petAwake["wLevel"] = tonumber(rs["0_2"])
                petAwake["fLevel"] = tonumber(rs["0_3"])
                petAwake["wLevel"] = tonumber(rs["0_4"])
            end
            local level = petAwake["level"] + 1
            if petAwake["level"] > 3 then
                petAwake["itemImg"] = 0
                petAwake["itemNum"] = 0
            else
                petAwake["itemImg"] = itemImgList[level]
                if  petAwake["itemImg"] == 0 then
                    petAwake["itemNum"] = 0
                else
                    petAwake["itemNum"] = player:getItemNum(itemList[level])
                end
            end

            petArr[index] = petAwake
            index = index + 1
        end
    end
    petArr["attrImg"] = attrImgList
    petArr["attrNum"] = {
        player:getItemNum(attrList[1]),
        player:getItemNum(attrList[2]),
        player:getItemNum(attrList[3]),
        player:getItemNum(attrList[4]),
    }
    
    return petArr
end

function showAwakening(player)
    Protocol.PowerSend(player:getObj(),"SHOW_AWAKENING", getAwakeningInfo(player))
end

function delUpItem(player, attr, level)
    local attrId = attrList[attr]
    if player:getItemNum(attrId) < attrNum[level] then
        return 0
    end
    if itemList[level] > 0 then
        if player:getItemNum(itemList[level]) < 1 then
            return 0
        end
    end

    if player:delItem(attrId, attrNum[level]) <= 0 then
        logPrint("扣除 ", attrId, attrNum[level], " 失败");
        return 0
    end
    if itemList[level] > 0 then
        if player:delItem(itemList[level], 1) <= 0 then
            logPrint("扣除 ", itemList[level], " 失败");
            return 0
        end
    end

    return 1
end
local addBpFunc = {
    "addHealthStamina", "addStrength", "addIntensity", "addSpeed", "addMagic"
}
function upAwakening(player, arg)
    local param = strSplit(arg, ",")
    local uuid = param[1];
    local attr = tonumber(param[2]);
    local pet = player:getPetByUuid(uuid)
    if nil == pet then
        player:sysMsg("需要觉醒的宠物不存在，宠物觉醒失败");
        return
    end
    local sql = string.format("select EarthLevel + WaterLevel + FireLevel+ WindLevel, %s from tbl_pet_info where uuid = '%s'", attrField[attr], pet:getUuid());
    local rs = SQL.Run(sql);
    local level = 0
    local attrLevel = 0
    local addAttr = 10
    local addArt = 3
    if(type(rs) == "table")then
        level = tonumber(rs["0_0"])
        attrLevel = tonumber(rs["0_1"])
    end
    if level >= 3 then
        player:sysMsg("宠物" .. level .."已经完成第" .. level .."次觉醒");
        return
    end

    level = level + 1
    if delUpItem(player, attr, level) <= 0 then
        player:sysMsg("道具不足，宠物" .. level .."完成第" .. level .."次觉醒失败");
        return
    end
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
    local exp = pet:getExperience()
    local oldBp = {pet:getHealthStamina(), pet:getStrength(), pet:getIntensity(), pet:getSpeed(), pet:getMagic()}
    pet:reBirth()
    pet:setExperience(exp)
    pet:flush()
    local upBp = pet:getUpgradePoints()
    local newBp = {pet:getHealthStamina(), pet:getStrength(), pet:getIntensity(), pet:getSpeed(), pet:getMagic()}
    local maxBp = 0
    local maxIndex = 0
    pet:setUpgradePoints(0)
    for i = 1, #newBp do
        if upBp > 0 then
            local diff = math.floor((oldBp[i] - newBp[i]) / 100)
            if diff > upBp then
                diff = upBp
            end
            if diff > 0 then
                MyChar[addBpFunc[i]](pet, diff * 100)
                upBp = upBp - diff
            end
            if oldBp[i] > maxBp then
                maxIndex = i
                maxBp = oldBp[i]
            end
        end
    end
    if upBp > 0 then
        MyChar[addBpFunc[maxIndex]](pet, upBp * 100)
    end
    pet:flush()
    if level == 1 then
        local sql1 = string.format("insert into tbl_pet_info (`uuid`, `EarthLevel`, `WaterLevel`, `FireLevel`, `WindLevel`, `CreateTime`) values ('%s', 0, 0, 0, 0, UNIX_TIMESTAMP())", pet:getUuid())
        SQL.Run(sql1);
    end
    local sql1 = string.format("update tbl_pet_info set %s = %s + 1 where uuid = '%s' and %s < 3",
            attrField[attr], attrField[attr], pet:getUuid(), attrField[attr])
    SQL.Run(sql1);
    player:sysMsg("宠物" .. level .. "完成第" .. level .. "次觉醒");
    Protocol.PowerSend(player:getObj(), "FLUSH_AWAKENING", getAwakeningInfo(player))
end

function npcAwakening(npc, player, s)
    showAwakening(player)
end

npcDialog[Const.NpcAwakening] = npcAwakening
TalkEvent["[awakening]"] = showAwakening
ClientEvent["up_awakening"] = upAwakening