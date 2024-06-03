local waitBattleIndex = {}
local startPk = false

function setPkFinish(regNum)
    local sql1 = "update tbl_pk_team set Status = 2 where RegNum = " .. regNum .. " and Status = 1;";
    Sql.Run(sql1)
end

function joinPk(player)
    if player:isLeader() then
        player:sysMsg("[PK系统]你不是对队长，没有报名的资格")
        return
    end

    if player:getPartyNum() ~= 5 then
        player:sysMsg("[PK系统]请组满5人队伍再来参战。")
        return
    end

    local sql = "select Id from tbl_pk_info where Status = 0";
    local rs = Sql.Run(sql)
    if type(rs) ~= "table" then
        player:sysMsg("[PK系统]当前没有举办PK比赛")
        return
    end

    sql = "select Id from tbl_pk_team where RegNum = 1 and Status IN (1, 0);"
    rs = Sql.Run(sql)
    if type(rs) == "table" then
        player:sysMsg("[PK系统]您已经报名PK比赛！")
        return
    end
    local teamInfo = tostring(player:getPartyMember(1):getRegistNumber())
    for i = 2, 4 do
        teamInfo = teamInfo .. "|" .. player:getPartyMember(i):getRegistNumber()
    end
    local pkId = tonumber(rs["0_0"])
    sql = string.format("insert into tbl_pk_team (RegNum, PkId, Status, CurrentRanking, TeamInfo, CreateTime) values (%d, %d, 0, 0, '%s', UNIX_TIMESTAMP());",
            player:getRegistNumber(), pkId, teamInfo)
    Sql.Run(sql)
    player:sysMsg("[PK系统]您已经报名PK比赛成功，请准时参加比赛！")
end

function setPkResult(id, round, winnerRegNum, loseRegNum)
    if 0 == round then
        local sql1 = "update tbl_pk_record set Status = 2, EndTime = UNIX_TIMESTAMP(), WinnerRegNum = " .. 0 .. " where Id = " .. id;
        local sql2 = "update tbl_pk_team set Status = 2 where RegNum = " .. winnerRegNum .. " and Status = 1;"
        local sql3 = "update tbl_pk_team set Status = 2 where RegNum = " .. loseRegNum .. " and Status = 1;"
        Sql.Run(sql1)
        Sql.Run(sql2)
        Sql.Run(sql3)

        return
    end

    local sql1 = "update tbl_pk_record set Status = 2, EndTime = UNIX_TIMESTAMP(), WinnerRegNum = " .. winnerRegNum .. " where Id = " .. id;
    Sql.Run(sql1)

    local sql2 = "update tbl_pk_team set Status = 0 where RegNum = " .. winnerRegNum .. " and Status = 1;"
    Sql.Run(sql2)

    local sql3 = "update tbl_pk_team set Status = 2 where RegNum = " .. loseRegNum .. " and Status = 1;"
    Sql.Run(sql3)

    local winner = MyPlayer:new(vipInfo[winnerRegNum]["index"])
    local loser = MyPlayer:new(vipInfo[loseRegNum]["index"])

    if round == 4 then
        NLG.SystemMessage(-1, "[PK系统] 恭喜" .. winner:getName() .. " 在半决赛中战胜了 " .. loser:getName() .. "！")
    elseif round == 2 then
        NLG.SystemMessage(-1, "[PK系统] 恭喜" .. loser:getName() .. " 在本轮比赛中获得亚军！")
        NLG.SystemMessage(-1, "[PK系统] 恭喜" .. winner:getName() .. " 在本轮比赛中获得冠军！")
        startPk = false
        waitBattleIndex = {}
        NLG.SystemMessage(-1, "[PK系统] 本轮比赛结束，感谢各位的参与，奖品将在稍后发放，祝大家玩得开心！")
        local sql = "update tbl_pk_info set Status = 3 where Status = 2"
        Sql.Run(sql)
    else
        NLG.SystemMessage(-1, "[PK系统] 恭喜" .. winner:getName() .. " 在" .. rs["0_3"] .. "进" .. (rs["0_3"] / 2) .. "比赛中战胜了 " .. loser:getName() .. "！")
    end
end

function startBattle(player1, player2)
    local battleIndex = Battle.PVP(player1:getObj(), player2:getObj())
    if battleIndex < 0 then
        return 0
    end
    table.insert(waiBattleList, battleIndex)
    return battleIndex
end

function pkNotice()
    local sql = "select EventDescription from tbl_pk_info where Status = 1 limit 1;"
    local rs = Sql.Run(sql)
    local desc = rs["0_0"]
    NLG.SystemMessage(-1, "[PK系统] " .. desc .. "正式开始，在这个舞台上，每一次拼搏都将被铭记，每一次突破都将成为传奇。让我们以饱满的热情，迎接这场激动人心的对决，向着胜利全力冲刺吧！")
end

function startPk(regNum, info)
    if not startPk then
        startPk = true
        pkNotice()
    end

    local sql = "select Id,TeamARegNum, TeamBRegNum,Round from tbl_pk_record where Status = 0"
    local rs = Sql.Run(sql)
    local round = rs["0_3"]
    if round == 4 then
        NLG.SystemMessage(-1, "[PK系统] 半决赛开始");
    elseif round == 2 then
        NLG.SystemMessage(-1, "[PK系统] 决赛开始");
    else
        NLG.SystemMessage(-1, "[PK系统] 本轮" .. rs["0_3"] .. "进" .. (rs["0_3"] / 2) .. "开始");
    end

    if(type(rs) ~= "table")then
        return 1
    end

    for i = 1, (#rs) / 3 do
        local id = rs[i .. "_0"]
        local aRegNum = tonumber(rs[i .. "_1"])
        local bRegNum = tonumber(rs[i .. "_2"])
        local playerA = nil
        local playerB = nil
        if rawget(vipInfo, aRegNum) ~= nil then
            playerA = MyPlayer:new(vipInfo[aRegNum]["index"]);
        end
        if rawget(vipInfo, bRegNum) ~= nil then
            playerA = MyPlayer:new(player);
        end
        if nil ~= playerA and nil ~= playerB then
            local battleIndex = startBattle(playerA, playerB);
            local sql1 = "update tbl_pk_record set Status = 1, StartTime = UNIX_TIMESTAMP() where Id = " .. id;
            Sql.Run(sql1)
            waitBattleIndex[battleIndex] = 0
        elseif nil ~= playerA then
            setPkResult (id, round, aRegNum, bRegNum)
        elseif nil ~= playerB then
            setPkResult (id, round, bRegNum, aRegNum)
        else
            setPkResult (id, 0, bRegNum, aRegNum)
        end
    end

    return 1
end

function pkSummary(battleIndex)
    -- 检查战斗索引是否有效
    if rawget(waiBattleList, battleIndex) == nil then
        return
    end

    waitBattleIndex[battleIndex]  = nil
    -- 获取战斗结果
    local winner = Battle.GetWinSide(battleIndex)
    -- 查询战斗记录
    local sql = "select Id, TeamARegNum, TeamBRegNum, Round, PkId from tbl_pk_record where BattleIndex = " .. battleIndex .. " and Status = 1;"
    local rs = Sql.Run(sql)

    -- 检查结果集是否有效
    if type(rs) ~= "table" or #rs == 0 then
        return
    end

    -- 确定胜者注册号
    local winnerRegNum = tonumber(rs["0_2"]) -- 默认胜者为TeamB
    local loseRegNum = tonumber(rs["0_1"])
    if winner == 1 then
        winnerRegNum = tonumber(rs["0_1"]) -- 如果TeamA胜利，则更新胜者注册号
        loseRegNum = tonumber(rs["0_2"])
    end

    setPkResult(tonumber(rs["0_0"]), tonumber(rs["0_3"]), winnerRegNum, loseRegNum)
    if #waitBattleIndex == 0 and startPk then
        waitBattleIndex = {}
        NLG.SystemMessage(-1, "[PK系统] 本轮比赛结束，下一轮马上开启，请稍等！")
        local sql = "update tbl_pk_info set Status = 1 where Status = 2"
        Sql.Run(sql)
    end
end

DeinitEvent["battle"] = pkSummary
