local waitSingleBattleIndex = {}
local startSinglePk = false
local winnerVal = 3
local loserVal = 1

function joinSinglePk(player, arg)
    local sql = "select Id from tbl_pk_info where Status = 0 and PkType = 1";
    local rs = SQL.Run(sql)
    if type(rs) ~= "table" then
        Protocol.PowerSend(player:getObj(),"FLUSH_PK", {1,0})
        player:sysMsg("[PK系统]当前没有举办PK比赛")
        return
    end
    local pkId = tonumber(rs["0_0"])
    if isJoinPk(player, pkId) > 0 then
        Protocol.PowerSend(player:getObj(),"FLUSH_PK", {1,1})
        player:sysMsg("[PK系统]您已经报名PK比赛！")
        return
    end

    sql = string.format("insert into tbl_pk_team (RegNum, Name, PkId, Status, CurrentRanking, TeamInfo, CreateTime, Mac) values ('%s', '%s', %d, 0, 0, '', UNIX_TIMESTAMP(), '%s');",
            player:getRegistNumber(), player:getName(), pkId, player:getMac())
    SQL.Run(sql)
    player:sysMsg("[PK系统]您已经报名PK比赛成功，请准时参加比赛！")
    Protocol.PowerSend(player:getObj(),"FLUSH_PK", {1,1})
end

function setSinglePkResult(rid, winnerRegNum, loserRegNum, winnerName, loserName, winnerStatus, loserStatus)
    local sql1 = ""
    if 0 == winnerStatus then
        sql1 = "update tbl_pk_team set Status = 2 where RegNum = '" .. winnerRegNum .. "' and Status = 1;"
        SQL.Run(sql1)
    else
        sql1 = "update tbl_pk_team set CurrentRanking = CurrentRanking + " .. winnerVal .. " where RegNum = '" .. winnerRegNum .. "' and Status = 1;"
        SQL.Run(sql1)
    end
    if 0 == loserStatus then
        sql1 = "update tbl_pk_team set Status = 2 where RegNum = '" .. loserRegNum .. "' and Status = 1;"
        SQL.Run(sql1)
    else
        sql1 = "update tbl_pk_team set CurrentRanking = CurrentRanking + " .. loserVal .. " where RegNum = '" .. loserRegNum .. "' and Status = 1;"
        SQL.Run(sql1)
    end

    if 0 == winnerStatus then
        sql1 = "update tbl_pk_record set Status = 2, EndTime = UNIX_TIMESTAMP(), WinnerRegNum = '' where Id = " .. rid;
        SQL.Run(sql1)
    else
        sql1 = "update tbl_pk_record set Status = 2, EndTime = UNIX_TIMESTAMP(), WinnerRegNum = '"
                .. winnerRegNum .. "' where Id = " .. rid;
        SQL.Run(sql1)
        if 1 == loserStatus then
            NLG.SystemMessage(-1, "[PK系统] 恭喜玩家 " .. winnerName.. " 在个人积分赛比赛中战胜了 " .. loserName .. "！")
        else
            NLG.SystemMessage(-1, "[PK系统] 恭喜玩家 " .. winnerName .. " 在本轮比赛中幸运轮空，直接成功！")
        end
    end
end

function startSingleBattle(player1, player2)
    local battleIndex = Battle.PVP(player1:getObj(), player2:getObj())
    if battleIndex < 0 then
        return 0
    end
    table.insert(waitSingleBattleIndex, battleIndex)
    return battleIndex
end

function startSinglePk(regNum, info)
    if not startSinglePk then
        startSinglePk = true
    end

    local sql = "select Id,TeamARegNum, TeamBRegNum, TeamAName, TeamBName,Round, PkId from tbl_pk_record where Status = 0"
    local rs = SQL.Run(sql)
    local pkId = tonumber(rs["0_6"])
    NLG.SystemMessage(-1, "[PK系统] PK对决，斗志昂扬，一往无前，加油必胜！");

    if(type(rs) ~= "table")then
        return 1
    end

    local len = countKeys(rs)
    for i = 1, (len / 7) do
        local rid = rs[i .. "_0"]
        local aRegNum = rs[i .. "_1"]
        local bRegNum = rs[i .. "_2"]
        local playerA = nil
        local playerB = nil
        local playerAName = rs[i .. "_3"]
        local playerBName = rs[i .. "_4"]
        if rawget(vipInfo, aRegNum) ~= nil then
            playerA = MyPlayer:new(vipInfo[aRegNum]["index"]);
        end
        if rawget(vipInfo, bRegNum) ~= nil then
            playerA = MyPlayer:new(vipInfo[bRegNum]["index"]);
        end
        if nil ~= playerA and nil ~= playerB then
            local battleIndex = startBattle(playerA, playerB);
            local sql1 = "update tbl_pk_record set Status = 1, StartTime = UNIX_TIMESTAMP() where Id = " .. id;
            SQL.Run(sql1)
            waitBattleIndex[battleIndex] = 0
        elseif nil ~= playerA then
            setSinglePkResult(rid, aRegNum, bRegNum, playerAName, playerBName, 1, 0)
        elseif nil ~= playerB then
            setSinglePkResult(rid, bRegNum, aRegNum, playerBName, playerAName, 1, 0)
        else
            setSinglePkResult(rid, aRegNum, bRegNum, playerAName, playerBName, 0, 0)
        end
    end

    return 1
end

function singlePkSummary(battleIndex)
    if not startSinglePk then
        return
    end

    -- 检查战斗索引是否有效
    if rawget(waitSingleBattleIndex, battleIndex) == nil then
        return
    end

    waitSingleBattleIndex[battleIndex]  = nil
    -- 获取战斗结果
    local winner = Battle.GetWinSide(battleIndex)
    -- 查询战斗记录
    local sql = "select Id, TeamARegNum, TeamBRegNum, Round, PkId, TeamAName, TeamBName from tbl_pk_record where BattleIndex = " .. battleIndex .. " and Status = 1;"
    local rs = SQL.Run(sql)

    -- 检查结果集是否有效
    if type(rs) ~= "table" or #rs == 0 then
        return
    end

    -- 确定胜者注册号
    local winnerRegNum = rs["0_2"] -- 默认胜者为TeamB
    local winnerName = rs["0_6"]
    local loserRegNum = rs["0_1"]
    local loserName = rs["0_5"]
    if winner == 1 then
        winnerRegNum = rs["0_1"] -- 如果TeamA胜利，则更新胜者注册号
        winnerName = rs["0_5"]
        loserRegNum = rs["0_2"]
        loserName = rs["0_6"]
    end

    setSinglePkResult(tonumber(rs["0_0"]), winnerRegNum, loserRegNum, winnerName, loserName, 1, 1)
    if #waitSingleBattleIndex == 0 then
        startSinglePk = false
    end
end

DeinitEvent["battle"] = singlePkSummary
ClientEvent["join_single_pk"] = joinSinglePk
