waitBattleIndex = {}

function setPkFinish(regNum)
    local sql1 = "update tbl_pk_team set Status = 2 where RegNum = " .. regNum .. " and Status = 1;";
    Sql.Run(sql1)
end

function confirmPK(id, winnerRegNum)
    local sql1 = "update tbl_pk_record set Status = 2, WinnerRegNum = " .. winnerRegNum .. " where Id = " .. id;
    Sql.Run(sql1)
end

function setPkResult(round, winnerRegNum, loseRegNum)
    -- 更新胜者队伍状态（如果需要的话，这里假设更新为状态3表示胜利）
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

function startPk()
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
        local bReqNum = tonumber(rs[i .. "_2"])
        local playerA = nil
        local playerB = nil
        if rawget(vipInfo, aRegNum) ~= nil then
            playerA = MyPlayer:new(vipInfo[aRegNum]["index"]);
        else
            setPkFinish(aRegNum)
        end
        if rawget(vipInfo, bReqNum) ~= nil then
            playerA = MyPlayer:new(player);
        else
            setPkFinish(bReqNum)
        end
        if nil ~= playerA and nil ~= playerB then
            local battleIndex = startBattle(playerA, playerB);
            local sql1 = "update tbl_pk_record set Status = 1 where Id = " .. id;
            Sql.Run(sql1)
            waitBattleIndex[battleIndex] = 0
        elseif nil ~= playerA then
            confirmPK(id, aRegNum)
        elseif nil ~= playerB then
            confirmPK(id, bRegNum)
        else
            confirmPK(id, 0)
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
    local sql = "select Id, TeamARegNum, TeamBRegNum, Round from tbl_pk_record where BattleIndex = " .. battleIndex .. " and Status = 1;"
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

    confirmPK(tonumber(rs["0_0"]), winnerRegNum)
    setPkResult(tonumber(rs["0_3"]), winnerRegNum, loseRegNum)
end
