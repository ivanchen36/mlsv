local raceHuman = 0    -- 人形种族
local raceDragon = 1   -- 龙种族
local raceUndead = 2   -- 不死种族
local raceFlying = 3   -- 飞行种族
local raceInsect = 4   -- 昆虫种族
local racePlant = 5    -- 植物种族
local raceBeast = 6    -- 野兽种族
local raceSpecial = 7  -- 特殊种族
local raceMetal = 8    -- 金属种族
local raceDemonic = 9  -- 邪魔种族

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

local proficientKill = { 99, 399, 999, 2999}

function showProficient(player)
    local sql = "select Race, Level, KillNum from tbl_pet_proficient where RegNum = " .. player:getRegistNumber();
    local rs = SQL.Run(sql);
    local proficientInfo = {};
    if(type(rs) ~= "table")then
        print("proficientInfo not found, id:" .. player:getRegistNumber());
        for i = raceHuman, raceDemonic + 1 do
            sql = "INSERT INTO `tbl_pet_proficient`(`RegNum`, `Race`, `Level`, `KillNum`, `CreateTime`) VALUES ("
                    .. player:getRegistNumber() .. ", " .. i .. ", 0, 0, unix_timestamp());"
            SQL.Run(sql);
            proficientInfo[i] = "0|0"
        end

        Protocol.PowerSend(player:getObj(),"SHOW_PROFICIENT", proficientInfo)
        return
    end
    local len = countKeys(rs)
    for i = 0, (len / 34) - 1  do
        proficientInfo[rs[i .. "_0"]] = rs[i .. "_1"] .. "|" .. rs[i .. "_2"]
    end

    Protocol.PowerSend(player:getObj(),"SHOW_PROFICIENT", proficientInfo)
end

function upProficient(player, arg)
    local race = tonumber(arg);
    local sql = "select Level, KillNum from tbl_pet_proficient where RegNum = " .. player:getRegistNumber() .. " and Race = " .. race;
    local rs = SQL.Run(sql);
    local level = tonumber(rs[0 .. "_0"]);
    local killNum = tonumber(rs[0 .. "_1"]);
    if proficientKill[level + 1] < killNum then
        sql = "update tbl_pet_proficient set Level = Level + 1, KillNum = KillNum - " .. proficientKill[level + 1]
                .. " where RegNum = " .. player:getRegistNumber() .. " and Race = " .. race .. " and KillNum >= " .. proficientKill[level + 1];
        SQL.Run(sql);
        killNum = killNum - proficientKill[level + 1];
        level = level + 1;
        player:sysMsg(raceName[race] .. "专精提升至" .. level .."级！");
    else
        player:sysMsg(raceName[race] .. "专精提失败，击杀数据量不足！");
    end
    Protocol.PowerSend(player:getObj(),"SHOW_PROFICIENT", {
        [race] = level .. "|" .. killNum
    })
end

function updateProficientKill(index, exp)
    logPrint("updateProficientKill", index, exp);
    if exp < 100 then
        return
    end

    local race = MyPlayer:getBattlePet(index):getRace();
    local sql = "update tbl_pet_proficient set KillNum = KillNum + 1 where RegNum = " .. player:getRegistNumber() .. " and Race = " .. race;
    SQL.Run(sql);
end

TalkEvent["[proficient]"] = showProficient
ClientEvent["up_proficient"] = upProficient
NL.RegGetExpEvent(nil, "updateProficientKill");
