local raceHuman = 1    -- 人形种族
local raceDragon = 2   -- 龙种族
local raceUndead = 3   -- 不死种族
local raceFlying = 4   -- 飞行种族
local raceInsect = 5   -- 昆虫种族
local racePlant = 6    -- 植物种族
local raceBeast = 7    -- 野兽种族
local raceSpecial = 8  -- 特殊种族
local raceMetal = 9    -- 金属种族
local raceDemonic = 10  -- 邪魔种族

local raceName = {
    [raceHuman] = "人形系",
    [raceDragon] = "龙系",
    [raceUndead] = "不死系",
    [raceFlying] = "飞行系",
    [raceInsect] = "昆虫系",
    [racePlant] = "植物系",
    [raceBeast] = "野兽系",
    [raceSpecial] = "特殊系",
    [raceMetal] = "金属系",
    [raceDemonic] = "邪魔系"
}
proficientInfo = {}
local proficientDamage = {4, 7, 10, 15}
local proficientKill = { 99, 399, 999, 2999}

function showProficient(player)
    logPrint("showProficient")
    local sql = "select Race, Level, KillNum from tbl_pet_proficient where RegNum = '" .. player:getRegistNumber() .. "'";
    local rs = SQL.Run(sql);
    local info = {};
    if(type(rs) ~= "table")then
        logPrint("proficientInfo not found, id:" .. player:getRegistNumber());
        for i = raceHuman, raceDemonic do
            sql = "INSERT INTO `tbl_pet_proficient`(`RegNum`, `Race`, `Level`, `KillNum`, `CreateTime`) VALUES ('"
                    .. player:getRegistNumber() .. "', " .. i .. ", 0, 0, unix_timestamp());"
            SQL.Run(sql);
            info[i] = "0|0"
        end

        Protocol.PowerSend(player:getObj(),"SHOW_PROFICIENT", info)
        return
    end
    local len = countKeys(rs)
    for i = 0, (len / 3) - 1  do
        info[tonumber(rs[i .. "_0"])] = rs[i .. "_1"] .. "|" .. rs[i .. "_2"]
    end

    Protocol.PowerSend(player:getObj(),"SHOW_PROFICIENT", info)
    logPrint("showProficient1")
end

function upProficient(player, arg)
    local race = tonumber(arg);
    local sql = "select Level, KillNum from tbl_pet_proficient where RegNum = '" .. player:getRegistNumber() .."' and Race = " .. race;
    local rs = SQL.Run(sql);
    local level = tonumber(rs[0 .. "_0"]);
    local killNum = tonumber(rs[0 .. "_1"]);
    if proficientKill[level + 1] < killNum then
        sql = "update tbl_pet_proficient set Level = Level + 1, KillNum = KillNum - " .. proficientKill[level + 1]
                .. " where RegNum = '" .. player:getRegistNumber() .. "' and Race = " .. race .. " and KillNum >= " .. proficientKill[level + 1];
        SQL.Run(sql);
        killNum = killNum - proficientKill[level + 1];
        level = level + 1;
        player:sysMsg(raceName[race] .. "专精提升至" .. level .."级！");
        if 3 == level then
            MyLimit:new(tostring(player:getRegistNumber()), race):init(Const.DaySecond, 1)
        end
        proficientInfo[player:getRegistNumber()][race] = proficientDamage[level]
    else
        player:sysMsg(raceName[race] .. "专精提失败，击杀数据量不足！");
    end

    Protocol.PowerSend(player:getObj(),"FLUSH_PROFICIENT", {
        [race] = level .. "|" .. killNum
    })
end

function raceChallenge(player, arg)
    local race = tonumber(arg);
    local limit = MyLimit:new(tostring(player:getRegistNumber()), race)
    if limit:deduct(1) <= 0 then
        player:sysMsg(raceName[race] .. "秘境剩余挑战次数不足");
        return
    end
    player:warp(0,1000,240,80)
end

function Event.RegGetExpEvent.updateProficientKill(index, exp)
    logPrint("updateProficientKill", index, exp);
    if exp < 100 then
        return
    end
    local player = MyPlayer:new(index)
    if player:isPerson() then
        local pet = MyPet:getBattlePet(player:getObj())
        if pet:isValid() then
            local race = pet:getRace() + 1;
            local sql = "update tbl_pet_proficient set KillNum = KillNum + 1 where RegNum = '" .. player:getRegistNumber() .. "' and Race = " .. race;
            SQL.Run(sql);
        end
    end
end

function initProficient(player)
    local sql = "select Race, Level from tbl_pet_proficient where Level > 0 And RegNum = '" .. player:getRegistNumber() .. "'"
    local rs = SQL.Run(sql);
    local info = {}

    if(type(rs) ~= "table") then
        return
    end

    local len = countKeys(rs)
    for i = 0, (len / 2) - 1  do
        info[tonumber(rs[i .. "_0"])] = proficientDamage[tonumber(rs[i .. "_1"])]
    end
    proficientInfo[player:getRegistNumber()] = info
end

function deinitProficient(player)
    proficientInfo[player:getRegistNumber()] = nil
end

function addProficientDamage(pet, rate)
    local race = pet:getRace() + 1
    local player = MyPlayer:new(pet:getOwner())
    local info = proficientInfo[player:getRegistNumber()]
    if nil == info then
        return rate
    end
    local addRate = info[race]
    if nil == addRate then
        return rate
    end
    logPrint("addProficientDamage ", addRate)
    return rate + addRate
end

DamageEvent[3] = addProficientDamage

InitEvent["char"] = initProficient
DeinitEvent["char"] = deinitProficient
TalkEvent["[proficient]"] = showProficient
ClientEvent["up_proficient"] = upProficient
ClientEvent["race_challenge"] = raceChallenge
