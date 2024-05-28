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
    local sql = "SELECT VipLevel,VipExp,LastExp,LastTime,LuckVal,EnemyAvoidSec,RemoteBank, GodGift, Warp, UpGift FROM tbl_vip_info WHERE RegNum = " .. player:getRegistNumber();
    local rs = SQL.Run(sql);
    if(type(rs) ~= "table")then
        print("vipInfo not found, id:" .. player:getRegistNumber());
        sql = "INSERT INTO tbl_vip_info (RegNum,VipLevel,VipExp,LastExp,LastTime,LuckVal,EnemyAvoidSec,RemoteBank) VALUES ("
                .. player:getRegistNumber() .. ",0,0,0,unix_timestamp(),0,0,0)";
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
            ["index"] = player:getObj()
        }
        Protocol.PowerSend(player:getObj(),"FLUSH_VIP", vipInfo[player:getRegistNumber()])
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
        ["avoidFlag"] = 0,
        ["avoidTime"] = 0,
        ["index"] = player:getObj()
    }
    Protocol.PowerSend(player:getObj(),"FLUSH_VIP", vipInfo[player:getRegistNumber()])
end

function deinitVip(player)
    userCloseAvoid(player)
    vipInfo[player:getRegistNumber()] = nil
end

function showVip(player)
    local info = vipInfo[player:getRegistNumber()]
    Protocol.PowerSend(player:getObj(),"SHOW_VIP", info)
end

function addVipExp(player, info, exp)
    info["lastExp"] = exp
    info["lastTime"] = os.time()
    info["exp"] = info["exp"] + exp
    local level = getVipLevel(info["exp"])
    self:sysMsg("领取" .. exp .."会员经验！");
    local sql = "UPDATE tbl_vip_info SET VipExp=" .. info["exp"] .. ",LastTime=unix_timestamp(),LastExp=" ..
            info["lastExp"]
    if level > 6 then
        info["bank"] = 1
        sql = sql .. ",RemoteBank=" .. info["bank"]
    end
    if level > 7 then
        info["gift"] = 1
        sql = sql .. ",GodGift=" .. info["gift"]
    end
    if level > 8 then
        info["warp"] = 1
        sql = sql .. ",Warp=" .. info["warp"]
    end
    if level > info["level"] then
        info["level"] = level
        info["upGift"] = 1
        info["luck"] = vipLuck[level]
        info["avoid"] = info["avoid"] + vipAvoid[level] - vipAvoid[info["level"]]
        sql = sql .. ",VipLevel=" .. info["level"] .. ",LuckVal=" .. info["luck"] .. ",EnemyAvoidSec=" .. info["avoid"]
        Protocol.PowerSend(player:getObj(), "UPDATE_VIP", info)
        self:sysMsg("会员等级提升至" .. level .."级！");
    end
    sql = sql .. " WHERE RegNum=" .. player:getRegistNumber();
    SQL.Run(sql);
end

function collectVip(player, arg)
    local info = vipInfo[player:getRegistNumber()]
    if(isToday(info["lastTime"])) then
        self:sysMsg("今日已经领取过会员经验！");
        return
    end
    local exp = info["lastExp"]
    if exp < 40 then
        exp = exp + 10
    end
    addVipExp(player, info, exp)
end

function openAvoid(player, arg)
    local info = vipInfo[player:getRegistNumber()]
    if info["avoid"] <= 0 then
        return
    end

    player:setEnemyAvoidSwitch(1)
    info["avoidFlag"] = 1
    info["avoidTime"] = os.time()
    local sql = "insert into tbl_task(RegNum,Type,Status,Info, ExeTime, CreateTime) values (" ..
            player:getRegistNumber() .. ",1,1,'',unix_timestamp() + " .. info["avoid"] .. ", Now());"
    SQL.Run(sql);
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
        player:sysMsg("您无法开启【天降礼包】！")
        return
    end

    NLG.SystemMessage(-1 , "感谢尊贵的VIP玩家【" ..  player:getName() .. "】，您开启的【天降礼包】闪耀全场，好运与您同在！")
    startGift(vipGiftInfo)
end

function upGift(player, arg)
    local info = vipInfo[player:getRegistNumber()]
    if info["upGift"] ~= 1 then
        player:sysMsg("您已经领取会员礼包！")
        return
    end

    local sql = "UPDATE tbl_vip_info SET UpGift = 0 WHERE UpGift = 1 and RegNum = " .. player:getRegistNumber()
    SQL.Run(sql)
    player:getItem(vipGift[info["level"]])
    player:sysMsg("恭喜您领取会员礼包！")
end

function vipWarp(player, arg)
end

TalkEvent["[vip]"] = showVip
ClientEvent["collect_vip"] = collectVip
ClientEvent["open_avoid"] = openAvoid
ClientEvent["close_avoid"] = userCloseAvoid
ClientEvent["open_bank"] = openBank
ClientEvent["god_gift"] = godGift
ClientEvent["vip_warp"] = vipWarp
ClientEvent["up_gift"] = upGift

InitEvent["char"] = initVip
DeinitEvent["char"] = deinitVip

TaskHandler[1] = sysCloseAvoid
