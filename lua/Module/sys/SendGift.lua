
function openGift(player, arg)
    local regNum = player:getRegNum()
    local sql = string.format("SELECT RegNum, Type, Title, Info FROM tbl_red_packet WHERE RegNum = '%s' and Type = %s", regNum, arg)
    local rs = SQL.Run(sql);

    if(type(rs) ~= "table")then
        player:sysMsg("礼包已经领取完成！")
        return
    end

    local regNum = tonumber(rs[i .. "_0"])
    local type = tonumber(rs[i .. "_1"])
    local title = rs[i .. "_2"]
    local info = rs[i .. "_3"]
    local itemList = MyJson.jsonToTbl(info)
    local checkRs = checkFreeNum(itemList)
    if 1 == checkRs then
        player:sysMsg("物品栏空间不足，领取失败")
        return
    end
    if 2 == checkRs then
        player:sysMsg("可携带魔币余额不足，领取失败")
        return 2
    end

    if 3 == checkRs then
        player:sysMsg("宠物栏空间不足，领取失败")
        return
    end
    giveItemList(player, itemList)
    local sql1 = string.format("UPDATE tbl_red_packet SET Status = 2 WHERE RegNum = '%s' and Type = %d", regNum, type)
    SQL.Run(sql1);
    player:sysMsg("领取" .. title .. "礼包成功！")
end

function sendGift()
    local sql = "SELECT RegNum, Type, Title, Info FROM tbl_red_packet WHERE Status = 1 and SendTime <= UNIX_TIMESTAMP()"
    local rs = SQL.Run(sql);

    if(type(rs) ~= "table")then
        return
    end
    local len = countKeys(rs)
    for i = 0, (len / 4) - 1  do
        local regNum = tonumber(rs[i .. "_0"])
        local type = tonumber(rs[i .. "_1"])
        local title = rs[i .. "_2"]
        local vip = vipInfo[regNum]
        if vip ~= nil then
            local sql1 = string.format("UPDATE tbl_red_packet SET Status = 3 WHERE RegNum = '%s' and Type = %d", regNum, type)
            SQL.Run(sql1);
            logPrint(regNum .. "不在线")
            return
        end
        local info = {
            ["name"] = title,
            ["type"] = type,
        }
        Protocol.PowerSend(vip["index"],"FLUSH_TASK", info)
    end
end

ClientEvent["open_gift"] = openGift
addTimerTask(sendGift)