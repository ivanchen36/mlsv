local waitBattleIndex = {}
local startPk = false

function joinPk(player)
    if player:isLeader() then
        player:sysMsg("[PKϵͳ]�㲻�ǶԶӳ���û�б������ʸ�")
        return
    end

    if player:getPartyNum() ~= 5 then
        player:sysMsg("[PKϵͳ]������5�˶���������ս��")
        return
    end

    local sql = "select Id from tbl_pk_info where Status = 1 and PkType <> 1";
    local rs = SQL.Run(sql)
    if type(rs) ~= "table" then
        player:sysMsg("[PKϵͳ]��ǰû�оٰ�PK����")
        return
    end
    local pkId = tonumber(rs["0_0"])
    local mac = player:getMac()
    sql = string.format("select Id from tbl_pk_team where (RegNum = %d or Mac = '%s') and PkId = %d",
        player:getRegistNumber(), mac, pkId)
    rs = SQL.Run(sql)
    if type(rs) == "table" then
        player:sysMsg("[PKϵͳ]���Ѿ�����PK������")
        return
    end
    local teamInfo = tostring(player:getPartyMember(1):getRegistNumber())
    for i = 2, 4 do
        teamInfo = teamInfo .. "|" .. player:getPartyMember(i):getRegistNumber()
    end

    sql = string.format("insert into tbl_pk_team (RegNum, Name, PkId, Status, CurrentRanking, TeamInfo, CreateTime, Mac) values (%d, %d, 0, 0, '%s', UNIX_TIMESTAMP(), %s);",
            player:getRegistNumber(), player:getName(), pkId, teamInfo, player:getMac())
    SQL.Run(sql)
    player:sysMsg("[PKϵͳ]���Ѿ�����PK�����ɹ�����׼ʱ�μӱ�����")
end

function setPkResult(pid, rid, round, winnerRegNum, loserRegNum, winnerName, loserName)
    local sql = "update tbl_pk_info set Count = Count - Count, Status = if(Count == 0, 1, Status) where Id = " .. pid;
    SQL.Run(sql)
    if 0 == round then
        local sql1 = "update tbl_pk_record set Status = 2, EndTime = UNIX_TIMESTAMP(), WinnerRegNum = " .. 0 .. " where Id = " .. rid;
        SQL.Run(sql1)
        if 0 ~= winnerRegNum then
            local sql2 = "update tbl_pk_team set Status = 2 where RegNum = " .. winnerRegNum .. " and Status = 1;"
            SQL.Run(sql2)
        end
        if 0 ~= loserRegNum then
            local sql3 = "update tbl_pk_team set Status = 2 where RegNum = " .. loserRegNum .. " and Status = 1;"
            SQL.Run(sql3)
        end
        return
    end

    local sql1 = "update tbl_pk_record set Status = 2, EndTime = UNIX_TIMESTAMP(), WinnerRegNum = "
            .. winnerRegNum .. " where Id = " .. rid;
    SQL.Run(sql1)

    local sql2 = "update tbl_pk_team set Status = 0 where RegNum = " .. winnerRegNum .. " and Status = 1;"
    SQL.Run(sql2)

    if 0 == loserRegNum then
        NLG.SystemMessage(-1, "[PKϵͳ] ��ϲ" .. winnerName .. " �ڱ��ֱ����������ֿգ�ֱ�ӽ�����һ�ֱ�����")
        return
    end

    local sql3 = "update tbl_pk_team set Status = 2 where RegNum = " .. loserRegNum .. " and Status = 1;"
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

    local sql = "select Id,TeamARegNum, TeamBRegNum, TeamAName, TeamBName,Round, PkId from tbl_pk_record where Status = 0"
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
        local aRegNum = tonumber(rs[i .. "_1"])
        local bRegNum = tonumber(rs[i .. "_2"])
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
    local winnerRegNum = tonumber(rs["0_2"]) -- Ĭ��ʤ��ΪTeamB
    local winnerName = rs["0_6"]
    local loserRegNum = tonumber(rs["0_1"])
    local loserName = rs["0_5"]
    local round = tonumber(rs["0_3"])
    if winner == 1 then
        winnerRegNum = tonumber(rs["0_1"]) -- ���TeamAʤ���������ʤ��ע���
        winnerName = rs["0_5"]
        loserRegNum = tonumber(rs["0_2"])
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

DeinitEvent["battle"] = pkSummary
