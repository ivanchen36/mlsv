local waitSingleBattleIndex = {}
local startSinglePk = false
local winnerVal = 3
local loserVal = 1

function joinSinglePk(player, arg)
    local sql = "select Id from tbl_pk_info where Status = 0 and PkType = 1";
    local rs = SQL.Run(sql)
    if type(rs) ~= "table" then
        Protocol.PowerSend(player:getObj(),"FLUSH_PK", {1,0})
        player:sysMsg("[PKϵͳ]��ǰû�оٰ�PK����")
        return
    end
    local pkId = tonumber(rs["0_0"])
    if isJoinPk(player, pkId) > 0 then
        Protocol.PowerSend(player:getObj(),"FLUSH_PK", {1,1})
        player:sysMsg("[PKϵͳ]���Ѿ�����PK������")
        return
    end

    sql = string.format("insert into tbl_pk_team (RegNum, Name, PkId, Status, CurrentRanking, TeamInfo, CreateTime, Mac) values ('%s', '%s', %d, 0, 0, '', UNIX_TIMESTAMP(), '%s');",
            player:getRegistNumber(), player:getName(), pkId, player:getMac())
    SQL.Run(sql)
    player:sysMsg("[PKϵͳ]���Ѿ�����PK�����ɹ�����׼ʱ�μӱ�����")
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
            NLG.SystemMessage(-1, "[PKϵͳ] ��ϲ��� " .. winnerName.. " �ڸ��˻�����������սʤ�� " .. loserName .. "��")
        else
            NLG.SystemMessage(-1, "[PKϵͳ] ��ϲ��� " .. winnerName .. " �ڱ��ֱ����������ֿգ�ֱ�ӳɹ���")
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
    NLG.SystemMessage(-1, "[PKϵͳ] PK�Ծ�����־���һ����ǰ�����ͱ�ʤ��");

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

    -- ���ս�������Ƿ���Ч
    if rawget(waitSingleBattleIndex, battleIndex) == nil then
        return
    end

    waitSingleBattleIndex[battleIndex]  = nil
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
    if winner == 1 then
        winnerRegNum = rs["0_1"] -- ���TeamAʤ���������ʤ��ע���
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
