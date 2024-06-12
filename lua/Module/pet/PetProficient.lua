local raceHuman = 1    -- ��������
local raceDragon = 2   -- ������
local raceUndead = 3   -- ��������
local raceFlying = 4   -- ��������
local raceInsect = 5   -- ��������
local racePlant = 6    -- ֲ������
local raceBeast = 7    -- Ұ������
local raceSpecial = 8  -- ��������
local raceMetal = 9    -- ��������
local raceDemonic = 10  -- аħ����

local raceName = {
    [raceHuman] = "����ϵ",
    [raceDragon] = "��ϵ",
    [raceUndead] = "����ϵ",
    [raceFlying] = "����ϵ",
    [raceInsect] = "����ϵ",
    [racePlant] = "ֲ��ϵ",
    [raceBeast] = "Ұ��ϵ",
    [raceSpecial] = "����ϵ",
    [raceMetal] = "����ϵ",
    [raceDemonic] = "аħϵ"
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
        player:sysMsg(raceName[race] .. "ר��������" .. level .."����");
    else
        player:sysMsg(raceName[race] .. "ר����ʧ�ܣ���ɱ���������㣡");
    end
    Protocol.PowerSend(player:getObj(),"SHOW_PROFICIENT", {
        [race] = level .. "|" .. killNum
    })
end

function raceChallenge(player, arg)
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
        player:sysMsg(raceName[race] .. "ר��������" .. level .."����");
    else
        player:sysMsg(raceName[race] .. "ר����ʧ�ܣ���ɱ���������㣡");
    end
end

function Event.RegGetExpEvent.updateProficientKill(index, exp)
    logPrint("updateProficientKill", index, exp);
    if exp < 100 then
        return
    end
    local myPlayer = MyPlayer:new(index)
    if myPlayer:isPerson() then
        local pet = MyPet:getBattlePet(myPlayer:getObj())
        if pet:isValid() then
            local race = pet:getRace();
            local sql = "update tbl_pet_proficient set KillNum = KillNum + 1 where RegNum = " .. player:getRegistNumber() .. " and Race = " .. race;
            SQL.Run(sql);
        end
    end
end

TalkEvent["[proficient]"] = showProficient
ClientEvent["up_proficient"] = upProficient
ClientEvent["race_challenge"] = raceChallenge
