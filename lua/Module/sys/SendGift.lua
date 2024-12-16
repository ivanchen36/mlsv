
function openGift(player, arg)
    local regNum = player:getRegNum()
    local sql = string.format("SELECT RegNum, Type, Title, Info FROM tbl_red_packet WHERE RegNum = '%s' and Type = %s and Status <> 2", regNum, arg)
    local rs = SQL.Run(sql);

    if(type(rs) ~= "table")then
        player:sysMsg("����Ѿ���ȡ��ɣ�")
        return
    end

    local regNum = tonumber(rs[i .. "_0"])
    local type = tonumber(rs[i .. "_1"])
    local title = rs[i .. "_2"]
    local info = rs[i .. "_3"]
    local itemList = MyJson.jsonToTbl(info)
    local checkRs = checkFreeNum(itemList)
    if 1 == checkRs then
        player:sysMsg("��Ʒ���ռ䲻�㣬��ȡʧ��")
        return
    end
    if 2 == checkRs then
        player:sysMsg("��Я��ħ�����㣬��ȡʧ��")
        return 2
    end

    if 3 == checkRs then
        player:sysMsg("�������ռ䲻�㣬��ȡʧ��")
        return
    end
    giveItemList(player, itemList)
    local sql1 = string.format("UPDATE tbl_red_packet SET Status = 2 WHERE RegNum = '%s' and Type = %d", regNum, type)
    SQL.Run(sql1);
    player:sysMsg("��ȡ" .. title .. "����ɹ���")
    queryGift(player)
end

function sendGift()
    local sql = "SELECT RegNum, Type, Title, Info FROM tbl_red_packet WHERE Status = 1 and SendTime <= UNIX_TIMESTAMP()"
    local rs = SQL.Run(sql);

    if(type(rs) ~= "table")then
        return
    end

    for i = 0, 99999 do
        if rs[i .. "_0"] == nil then
            break
        end
        local regNum = tonumber(rs[i .. "_0"])
        local type = tonumber(rs[i .. "_1"])
        local title = rs[i .. "_2"]
        local vip = vipInfo[regNum]
        if vip ~= nil then
            local sql1 = string.format("UPDATE tbl_red_packet SET Status = 3 WHERE RegNum = '%s' and Type = %d", regNum, type)
            SQL.Run(sql1);
            logPrint(regNum .. "������")
            return
        end
        local info = {
            ["name"] = title,
            ["type"] = type,
        }
        Protocol.PowerSend(vip["index"],"SEND_GIFT", info)
    end
end

function queryGift(player)
    local regNum = player:getRegNum()
    local sql = string.format("SELECT RegNum, Type, Title, Info FROM tbl_red_packet WHERE RegNum = '%s' and Status = 3 LIMIT 1", regNum)
    local rs = SQL.Run(sql);

    if(type(rs) ~= "table")then
        return
    end

    local info = {
        ["name"] = rs["0_2"],
        ["type"] = tonumber(rs["0_1"]),
    }
    Protocol.PowerSend(vip["index"],"SEND_GIFT", info)
end

InitEvent["char"] = queryGift
ClientEvent["open_gift"] = openGift
addTimerTask(sendGift)