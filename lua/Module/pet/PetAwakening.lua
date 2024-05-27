local earthAttr = 1
local waterAttr = 2
local fireAttr = 3
local windAttr = 4

local itemList = {18310, 18311, 18312, 18313}
local itemNum = {99, 399, 999}
local attrField = {"EarthLevel", "WaterLevel", "FireLevel", "WindLevel"}

function showAwakening(player, arg)
    local petAwake = {}
    for i = 0, 4 do
        local pet = MyPet:new(player:getObj(), i)
        if not pet:isValid() then
            petAwake[i] = "#|0|0|0|0|0"
        else
            local sql = "select EarthLevel + WaterLevel + FireLevel+ WindLevel, EarthLevel,WaterLevel,FireLevel,WindLevel from tbl_pet_info where uuid = " .. pet:getUuid();
            local rs = SQL.Run(sql);
            if(type(rs) ~= "table")then
                petAwake[i] = "#|0|0|0|0|0"
            else
                petAwake[i] = pet:getName() .. "|" .. rs["0_0"] .. "|" .. rs["0_1"] .. "|" .. rs["0_2"] .. "|" .. rs["0_3"] .. "|" .. rs["0_4"]
            end
        end
    end
    Protocol.PowerSend(player:getObj(),"SHOW_AWAKENING", petAwake)
end

function upAwakening(player, arg)
    local param = strSplit(arg, "|")
    local slot = tonumber(param[1]);
    local attr = tonumber(param[2]);
    local itemId = itemList[attr]
    local pet = MyPet:new(player:getObj(), slot)
    local sql = "select EarthLevel + WaterLevel + FireLevel+ WindLevel, " .. attrField[attr] .. " from tbl_pet_info where uuid = " .. pet:getUuid();
    local rs = SQL.Run(sql);
    local level = rs["0_0"]

    if level >= 3 then
        self:sysMsg("宠物" .. level .."已经完成第" .. level .."次觉醒失败");
        return
    end

    if player:getItemNum(itemId) < itemNum[level] then
        if player:delNum(itemId, itemNum[level]) > 0 then
            local sql1 = "update tbl_pet_info set " .. attrField[attr] .. " = " .. attrField[attr] .. " + 1 where uuid = " .. pet:getUuid()
            .. " and ".. attrField[attr] .. " < 3";
            SQL.Run(sql1);
            self:sysMsg("宠物" .. level .."完成第" .. level .."次觉醒");
            return
        end
    end
    self:sysMsg("道具不足，宠物" .. level .."完成第" .. level .."次觉醒失败");
end

TalkEvent["[awakening]"] = showAwakening
ClientEvent["upAwakening"] = upAwakening