vipInfo = {}
--120,1020,3360,6720,13880,23880,33600,67200,201600
local vipExp = {
    [1] = 120,
    [2] = 1020,
    [3] = 3360,
    [4] = 6720,
    [5] = 13880,
    [6] = 23880,
    [7] = 33600,
    [8] = 67200,
    [9] = 201600
}

local vipLuck = {
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 5,
    [5] = 10,
    [6] = 12,
    [7] = 15,
    [8] = 17,
    [9] = 20
}

local vipAvoid = {
    [1] = 600,
    [2] = 1800,
    [3] = 3600,
    [4] = 5400,
    [5] = 7200,
    [6] = 7800,
    [7] = 8400,
    [8] = 9200,
    [9] = 10800
}

local vipGiftInfo = {
    {
        ["id"] = 111,
        ["name"] = "test",
        ["count"] = 222
    },{
        ["id"] = 222,
        ["name"] = "test",
        ["count"] = 222
    },{
        ["id"] = 3333,
        ["name"] = "test",
        ["count"] = 222
    }
}

local vipGift = {
    111, 222, 333, 444
}

function getVipLevel(exp)
    local level = 0
    for i = 1, #vipExp do
        if(exp < vipExp[i]) then
            return level
        end

        level = i
    end

    return level
end

function initVip(player)
    local sql = "SELECT VipLevel,VipExp,LastExp,LastTime,LuckVal,EnemyAvoidSec,RemoteBank, GodGift, Warp, UpGift, UpGift,AddExp, UNIX_TIMESTAMP(UpdateTime) FROM tbl_vip_info WHERE RegNum = " .. player:getRegistNumber();
    local rs = SQL.Run(sql);
    if(type(rs) ~= "table")then
        print("vipInfo not found, id:" .. player:getRegistNumber());
        sql = "INSERT INTO tbl_vip_info (RegNum,VipLevel,VipExp,LastExp,LastTime,CreateTime,LuckVal,EnemyAvoidSec,RemoteBank) VALUES ("
                .. player:getRegistNumber() .. ",0,0,0,0,unix_timestamp(),0,0,0)";
        SQL.Run(sql);
        vipInfo[player:getRegistNumber()] = {
            ["level"] = 0,
            ["exp"] = 0,
            ["lastExp"] = 0,
            ["lastTime"] = 0,
            ["luck"] = 0,
            ["avoid"] = 0,
            ["bank"] = 0,
            ["gift"] = 0,
            ["warp"] = 0,
            ["avoidFlag"] = 0,
            ["avoidTime"] = 0,
            ["upGift"] = 0,
            ["addExp"] = 0,
            ["up"] = os.time(),
            ["index"] = player:getObj()
        }
        return
    end

    vipInfo[player:getRegistNumber()] = {
        ["level"] = tonumber(rs["0_0"]),
        ["exp"] = tonumber(rs["0_1"]),
        ["lastExp"] = tonumber(rs["0_2"]),
        ["lastTime"] = tonumber(rs["0_3"]),
        ["luck"] = tonumber(rs["0_4"]),
        ["avoid"] = tonumber(rs["0_5"]),
        ["bank"] = tonumber(rs["0_6"]),
        ["gift"] = tonumber(rs["0_7"]),
        ["warp"] = tonumber(rs["0_8"]),
        ["upGift"] = tonumber(rs["0_9"]),
        ["addExp"] = tonumber(rs["0_10"]),
        ["up"] = tonumber(rs["0_11"]),
        ["avoidFlag"] = 0,
        ["avoidTime"] = 0,
        ["index"] = player:getObj()
    }
end

function deinitVip(player)
    userCloseAvoid(player)
    vipInfo[player:getRegistNumber()] = nil
end

function showVip(player)
    local info = vipInfo[player:getRegistNumber()]
    if not isToday(info["up"]) then
        initVip(player)
    end
    Protocol.PowerSend(player:getObj(),"SHOW_VIP", info)
end

function addVipExp(player, info, exp)
    info["lastExp"] = exp
    info["lastTime"] = os.time()
    info["exp"] = info["exp"] + exp
    local level = getVipLevel(info["exp"])
    local curLevel = info["level"]
    if level <= curLevel then
        local sql = "UPDATE tbl_vip_info SET VipExp=" .. info["exp"] .. ",LastTime=unix_timestamp(),LastExp=" ..
                info["lastExp"] .. " WHERE RegNum=" .. player:getRegistNumber();
        SQL.Run(sql);
        return
    end
    local sql = "UPDATE tbl_vip_info SET VipExp=" .. info["exp"] .. ",LastTime=unix_timestamp(),LastExp=" ..
            info["lastExp"]
    if curLevel == 0 then
        info["addExp"] = 1
    end
    if curLevel <= 6 and level > 6 then
        info["bank"] = 1
        sql = sql .. ",RemoteBank=" .. info["bank"]
    end
    if curLevel <= 7 and level > 7 then
        info["gift"] = 1
        sql = sql .. ",GodGift=" .. info["gift"]
    end
    if curLevel <= 8 and level > 8 then
        info["warp"] = 1
        sql = sql .. ",Warp=" .. info["warp"]
    end

    info["level"] = level
    info["upGift"] = 1
    info["luck"] = vipLuck[level]
    info["avoid"] = info["avoid"] + vipAvoid[level] - vipAvoid[info["level"]]
    sql = sql .. ",VipLevel=" .. info["level"] .. ",LuckVal=" .. info["luck"] .. ",EnemyAvoidSec=" .. info["avoid"]

    sql = sql .. " WHERE RegNum=" .. player:getRegistNumber();
    SQL.Run(sql);
    self:sysMsg("��Ա�ȼ�������" .. level .."����");
end

function collectVip(player, arg)
    local info = vipInfo[player:getRegistNumber()]
    if(isToday(info["lastTime"])) then
        self:sysMsg("�����Ѿ���ȡ����Ա���飡");
        return
    end
    local exp = info["lastExp"]
    if exp < 40 then
        exp = exp + 10
    end
    self:sysMsg("��ȡ" .. exp .."��Ա���飡");
    addVipExp(player, info, exp)
    Protocol.PowerSend(player:getObj(), "UPDATE_VIP", info)
end

function openAvoid(player, arg)
    local info = vipInfo[player:getRegistNumber()]
    if info["avoid"] <= 0 then
        return 1
    end

    player:setEnemyAvoidSwitch(1)
    info["avoidFlag"] = 1
    info["avoidTime"] = os.time()
    local sql = "insert into tbl_task(RegNum,Type,Status,Info, ExeTime, CreateTime) values (" ..
            player:getRegistNumber() .. ",1,1,'',unix_timestamp() + " .. info["avoid"] .. ", UNIX_TIMESTAMP());"
    SQL.Run(sql);
    Protocol.PowerSend(player:getObj(), "UPDATE_VIP", info)
    return 1
end

function closeAvoid(player)
    local info = vipInfo[player:getRegistNumber()]
    if info["avoidFlag"] == 0 then
        return 1
    end

    player:setEnemyAvoidSwitch(0)
    info["avoid"] = info["avoid"] + info["avoidTime"] - os.time()
    if info["avoid"] < 0 then
        info["avoid"] = 0
    end
    local sql = "UPDATE tbl_vip_info SET EnemyAvoidSec = " .. info["avoid"] .. " WHERE RegNum = " .. player:getRegistNumber()
    info["avoidFlag"] = 0
    info["avoidTime"] = 0
    SQL.Run(sql)
    Protocol.PowerSend(player:getObj(), "UPDATE_VIP", info)
    return 1
end

function userCloseAvoid(player, arg)
    local regNum = player:getRegistNumber()
    if rawget(vipInfo, regNum) ~= nil then
        local myPlayer = MyPlayer:new(vipInfo[regNum]["index"]);
        closeAvoid(myPlayer)
        local sql1 = "UPDATE tbl_task SET Status = 2 WHERE Type = 1 and RegNum =" .. player:getRegistNumber()
        SQL.Run(sql1)
    end
end

function sysCloseAvoid(regNum, info)
    if rawget(vipInfo, regNum) ~= nil then
        local myPlayer = MyPlayer:new(vipInfo[regNum]["index"]);
        closeAvoid(myPlayer)
        return
    end
end

function openBank(player, arg)
    local info = vipInfo[player:getRegistNumber()]
end

function godGift(player, arg)
    local info = vipInfo[player:getRegistNumber()]
    if info["level"] <= 7 or info["gift"] ~= 1 then
        player:sysMsg("���޷��������콵�������")
        return
    end

    NLG.SystemMessage(-1 , "��л����VIP��ҡ�" ..  player:getName() .. "�����������ġ��콵�������ҫȫ������������ͬ�ڣ�")
    info["gift"] = 1
    startGift(vipGiftInfo)
    Protocol.PowerSend(player:getObj(), "UPDATE_VIP", info)
end

function upGift(player, arg)
    local info = vipInfo[player:getRegistNumber()]
    if info["upGift"] ~= 1 then
        player:sysMsg("���Ѿ���ȡ��Ա�����")
        return
    end

    local sql = "UPDATE tbl_vip_info SET UpGift = 0 WHERE UpGift = 1 and RegNum = " .. player:getRegistNumber()
    SQL.Run(sql)
    player:getItem(vipGift[info["level"]])
    player:sysMsg("��ϲ����ȡ��Ա�����")
    info["upGift"] = 0
    Protocol.PowerSend(player:getObj(), "UPDATE_VIP", info)
end

function vipWarp(player, arg)
end

function openExp(player, arg)
    local info = vipInfo[player:getRegistNumber()]
    if info["addExp"] ~= 1 then
        player:sysMsg("���Ѿ�����������ӳɣ�")
        return
    end

    local addRate = info["level"] * 10
    if ADD_EXP_RATE >= addRate then
        player:sysMsg("ϵͳ�Ѿ�������ǿ��ľ���ӳɣ�")
        return
    end
    info["addExp"] = 0
    player:sysMsg("���Ѿ��ɹ������ӳɣ�")
    if ADD_EXP_RATE == 0 then
        NLG.SystemMessage(-1 , "��л����VIP��ҡ�" ..  player:getName() .. "��������������������" .. addRate .."%����������ͬ�ڣ�")
    else
        NLG.SystemMessage(-1 , "��л����VIP��ҡ�" ..  player:getName() .. "����������������" .. ADD_EXP_RATE .. "%����������" .. addRate .."%����������ͬ�ڣ�")
    end
    setCharExpRate(ADD_EXP_RATE + addRate, 7200)
    Protocol.PowerSend(player:getObj(),"UPDATE_VIP", info)
end

ClientEvent["up_gift"] = upGift

TalkEvent["[vip]"] = showVip
ClientEvent["collect_vip"] = collectVip
ClientEvent["open_avoid"] = openAvoid
ClientEvent["close_avoid"] = userCloseAvoid
ClientEvent["open_bank"] = openBank
ClientEvent["god_gift"] = godGift
ClientEvent["vip_warp"] = vipWarp
ClientEvent["open_exp"] = openExp

InitEvent["char"] = initVip
DeinitEvent["char"] = deinitVip

TaskHandler[1] = sysCloseAvoid