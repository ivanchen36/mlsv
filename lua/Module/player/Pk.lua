local waitBattleIndex = {}
local startPk = false

function isJoinPk(player, pkId)
    local mac = player:getMac()
    local reqNum = player:getRegistNumber()
    local sql = string.format("select Id from tbl_pk_team where (RegNum = '%s' or Mac = '%s' or TeamInfo like '%%|%s|%%') and PkId = %d",
            reqNum, mac, reqNum, pkId)
    local rs = SQL.Run(sql)

    if type(rs) == "table" then
        return 1
    end

    return 0
end

function joinPk(player, arg)
    if player:isLeader() then
        player:sysMsg("[PKϵͳ]�㲻�ǶԶӳ���û�б������ʸ�")
        Protocol.PowerSend(player:getObj(),"FLUSH_PK", {2,0})
        return
    end

    if player:getPartyNum() ~= 5 then
        player:sysMsg("[PKϵͳ]������5�˶���������ս��")
        Protocol.PowerSend(player:getObj(),"FLUSH_PK", {2,0})
        return
    end

    local sql = "select Id from tbl_pk_info where Status = 0 and PkType <> 1";
    local rs = SQL.Run(sql)
    if type(rs) ~= "table" then
        player:sysMsg("[PKϵͳ]��ǰû�оٰ�PK����")
        Protocol.PowerSend(player:getObj(),"FLUSH_PK", {2,0})
        return
    end
    local pkId = tonumber(rs["0_0"])
    if isJoinPk(player, pkId) > 0 then
        player:sysMsg("[PKϵͳ]���Ѿ�����PK������")
        Protocol.PowerSend(player:getObj(),"FLUSH_PK", {2,1})
        return
    end
    local teamInfo = "|" .. player:getPartyMember(1):getRegistNumber() .. "|"
    for i = 2, 4 do
        teamInfo = teamInfo .. player:getPartyMember(i):getRegistNumber() .. "|"
    end

    sql = string.format("insert into tbl_pk_team (RegNum, Name, PkId, Status, CurrentRanking, TeamInfo, CreateTime, Mac) values ('%s', %d, 0, 0, '%s', UNIX_TIMESTAMP(), %s);",
            player:getRegistNumber(), player:getName(), pkId, teamInfo, player:getMac())
    SQL.Run(sql)
    player:sysMsg("[PKϵͳ]���Ѿ�����PK�����ɹ�����׼ʱ�μӱ�����")
    Protocol.PowerSend(player:getObj(),"FLUSH_PK", {2,1})
end

function setPkResult(pid, rid, round, winnerRegNum, loserRegNum, winnerName, loserName)
    local sql = "update tbl_pk_info set Count = Count - Count, Status = if(Count == 0, 1, Status) where Id = " .. pid;
    SQL.Run(sql)
    if 0 == round then
        local sql1 = string.format("update tbl_pk_record set Status = 2, EndTime = UNIX_TIMESTAMP(), WinnerRegNum = '' where Id = %d", rid);
        SQL.Run(sql1)
        if 0 ~= winnerRegNum then
            local sql2 = "update tbl_pk_team set Status = 2 where RegNum = '" .. winnerRegNum .. "' and Status = 1;"
            SQL.Run(sql2)
        end
        if 0 ~= loserRegNum then
            local sql3 = "update tbl_pk_team set Status = 2 where RegNum = '" .. loserRegNum .. "' and Status = 1;"
            SQL.Run(sql3)
        end
        return
    end

    local sql1 = "update tbl_pk_record set Status = 2, EndTime = UNIX_TIMESTAMP(), WinnerRegNum = '"
            .. winnerRegNum .. "' where Id = " .. rid;
    SQL.Run(sql1)

    local sql2 = "update tbl_pk_team set Status = 0 where RegNum = '" .. winnerRegNum .. "' and Status = 1;"
    SQL.Run(sql2)

    if 0 == loserRegNum then
        NLG.SystemMessage(-1, "[PKϵͳ] ��ϲ" .. winnerName .. " �ڱ��ֱ����������ֿգ�ֱ�ӽ�����һ�ֱ�����")
        return
    end

    local sql3 = "update tbl_pk_team set Status = 2 where RegNum = '" .. loserRegNum .. "' and Status = 1;"
    SQL.Run(sql3)

    if round == 4 then
        NLG.SystemMessage(-1, "[PKϵͳ] ��ϲ��� " .. winnerName .. " �ڰ������սʤ�� " .. loserName .. "��")
    elseif round == 2 then
        NLG.SystemMessage(-1, "[PKϵͳ] ��ϲ��� " .. loserName .. " �ڱ��ֱ����л���Ǿ���")
        NLG.SystemMessage(-1, "[PKϵͳ] ��ϲ��� " .. winnerName .. " �ڱ��ֱ����л�ùھ���")
        startPk = false
        waitBattleIndex = {}
        NLG.SystemMessage(-1, "[PKϵͳ] ���ֱ�����������л��λ�Ĳ��룬��Ʒ�����Ժ󷢷ţ�ף�����ÿ��ģ�")
        local sql = "update tbl_pk_info set Status = 4 where Id = " .. pid;
        SQL.Run(sql)
    else
        NLG.SystemMessage(-1, "[PKϵͳ] ��ϲ��� " .. winnerName.. " ��" .. round / 2 .. "ǿ����������սʤ�� " .. loserName .. "��")
    end
end

function startBattle(player1, player2)
    local battleIndex = Battle.PVP(player1:getObj(), player2:getObj())
    if battleIndex < 0 then
        return 0
    end
    return battleIndex
end

function pkNotice()
    local sql = "select EventDescription from tbl_pk_info where Status = 1 limit 1;"
    local rs = SQL.Run(sql)
    local desc = rs["0_0"]
    NLG.SystemMessage(-1, "[PKϵͳ] " .. desc .. "��ʽ��ʼ���������̨�ϣ�ÿһ��ƴ�����������ǣ�ÿһ��ͻ�ƶ�����Ϊ���档�������Ա��������飬ӭ���ⳡ�������ĵĶԾ�������ʤ��ȫ����̰ɣ�")
end

function startPk(regNum, info)
    if not startPk then
        startPk = true
        pkNotice()
    end

    local sql = "select Id, TeamARegNum, TeamBRegNum, TeamAName, TeamBName,Round, PkId from tbl_pk_record where Status = 0"
    local rs = SQL.Run(sql)
    local round = tonumber(rs["0_5"])
    local pkId = tonumber(rs["0_6"])
    if round == 4 then
        NLG.SystemMessage(-1, "[PKϵͳ] �������ʼ");
    elseif round == 2 then
        NLG.SystemMessage(-1, "[PKϵͳ] ������ʼ");
    else
        NLG.SystemMessage(-1, "[PKϵͳ] ����" .. (rs["0_5"] / 2) .. "ǿ��������ʼ");
    end

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
            setPkResult (pkId, rid, round, aRegNum, bRegNum, playerAName, playerBName)
        elseif nil ~= playerB then
            setPkResult (pkId, rid, round, bRegNum, aRegNum, playerBName, playerAName)
        else
            setPkResult (pkId, rid, 0, aRegNum, bRegNum, playerAName, playerBName)
        end
    end

    return 1
end

function pkSummary(battleIndex)
    if not startPk then
        return
    end

    -- ���ս�������Ƿ���Ч
    if rawget(waitBattleIndex, battleIndex) == nil then
        return
    end

    waitBattleIndex[battleIndex]  = nil
    -- ��ȡս�����
    local winner = Battle.GetWinSide(battleIndex)
    -- ��ѯս����¼
    local sql = "select Id, TeamARegNum, TeamBRegNum, Round, PkId, TeamAName, TeamBName from tbl_pk_record where BattleIndex = " .. battleIndex .. " and Status = 1;"
    local rs = SQL.Run(sql)

    -- ��������Ƿ���Ч
    if type(rs) ~= "table" or #rs == 0 then
        return
    end

    -- ȷ��ʤ��ע���
    local winnerRegNum = rs["0_2"] -- Ĭ��ʤ��ΪTeamB
    local winnerName = rs["0_6"]
    local loserRegNum = rs["0_1"]
    local loserName = rs["0_5"]
    local round = tonumber(rs["0_3"])
    if winner == 1 then
        winnerRegNum = rs["0_1"] -- ���TeamAʤ���������ʤ��ע���
        winnerName = rs["0_5"]
        loserRegNum = rs["0_2"]
        loserName = rs["0_6"]
    end

    setPkResult(tonumber(rs["0_4"]), tonumber(rs["0_0"]), round, winnerRegNum, loserRegNum, winnerName, loserName)
    if #waitBattleIndex == 0 and startPk then
        waitBattleIndex = {}
        NLG.SystemMessage(-1, "[PKϵͳ] ���ֱ�����������һ�����Ͽ��������Եȣ�")
        local sql = "update tbl_pk_info set Status = 1 where Status = 2"
        SQL.Run(sql)
    end
end

function showPk(player)
    logPrint("showPk")
    local pkInfo = {}
    local sql1 = "select Id, EventDescription, Status from tbl_pk_info where PkType = 1 and CreateTime >= UNIX_TIMESTAMP() - 604800 limit 1";
    local sql2 = "select Id, EventDescription, Status from tbl_pk_info where PkType IN (2, 3, 4, 5) and CreateTime >= UNIX_TIMESTAMP() - 604800 limit 1";
    local rs1 = SQL.Run(sql1)
    local rs2 = SQL.Run(sql2)
    if type(rs1) ~= "table" then
        pkInfo[1] = {"��ǰ�޸��˻�����", 99, 0}
    else
        logPrintTbl(rs1)
        local pid = tonumber(rs1["0_0"])
        pkInfo[1] = {rs1["0_1"], tonumber(rs1["0_2"]),isJoinPk(player, pid)}
    end
    if type(rs2) ~= "table" then
        pkInfo[2] = {"��ǰ���Ŷ���̭��", 99, 0}
    else
        logPrintTbl(rs2)
        local pid = tonumber(rs2["0_0"])
        pkInfo[2] = {rs2["0_1"], tonumber(rs2["0_2"]),isJoinPk(player, pid)}
    end
    logPrintTbl(pkInfo)
    Protocol.PowerSend(player:getObj(),"SHOW_PK", pkInfo)
end

function warpPk(player, arg)
    return
end


DeinitEvent["battle"] = pkSummary
TalkEvent["[pk]"] = showPk
ClientEvent["warp_pk"] = warpPk
ClientEvent["join_team_pk"] = joinPk