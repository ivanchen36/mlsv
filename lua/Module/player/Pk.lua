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
    -- ����ʤ�߶���״̬�������Ҫ�Ļ�������������Ϊ״̬3��ʾʤ����
    local sql2 = "update tbl_pk_team set Status = 0 where RegNum = " .. winnerRegNum .. " and Status = 1;"
    Sql.Run(sql2)

    local sql3 = "update tbl_pk_team set Status = 2 where RegNum = " .. loseRegNum .. " and Status = 1;"
    Sql.Run(sql3)

    local winner = MyPlayer:new(vipInfo[winnerRegNum]["index"])
    local loser = MyPlayer:new(vipInfo[loseRegNum]["index"])

    if round == 4 then
        NLG.SystemMessage(-1, "[PKϵͳ] ��ϲ" .. winner:getName() .. " �ڰ������սʤ�� " .. loser:getName() .. "��")
    elseif round == 2 then
        NLG.SystemMessage(-1, "[PKϵͳ] ��ϲ" .. loser:getName() .. " �ڱ��ֱ����л���Ǿ���")
        NLG.SystemMessage(-1, "[PKϵͳ] ��ϲ" .. winner:getName() .. " �ڱ��ֱ����л�ùھ���")
        NLG.SystemMessage(-1, "[PKϵͳ] ���ֱ�����������л��λ�Ĳ��룬��Ʒ�����Ժ󷢷ţ�ף�����ÿ��ģ�")
        local sql = "update tbl_pk_info set Status = 3 where Status = 2"
        Sql.Run(sql)
    else
        NLG.SystemMessage(-1, "[PKϵͳ] ��ϲ" .. winner:getName() .. " ��" .. rs["0_3"] .. "��" .. (rs["0_3"] / 2) .. "������սʤ�� " .. loser:getName() .. "��")
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
        NLG.SystemMessage(-1, "[PKϵͳ] �������ʼ");
    elseif round == 2 then
        NLG.SystemMessage(-1, "[PKϵͳ] ������ʼ");
    else
        NLG.SystemMessage(-1, "[PKϵͳ] ����" .. rs["0_3"] .. "��" .. (rs["0_3"] / 2) .. "��ʼ");
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
    -- ���ս�������Ƿ���Ч
    if rawget(waiBattleList, battleIndex) == nil then
        return
    end

    waitBattleIndex[battleIndex]  = nil
    -- ��ȡս�����
    local winner = Battle.GetWinSide(battleIndex)
    -- ��ѯս����¼
    local sql = "select Id, TeamARegNum, TeamBRegNum, Round from tbl_pk_record where BattleIndex = " .. battleIndex .. " and Status = 1;"
    local rs = Sql.Run(sql)

    -- ��������Ƿ���Ч
    if type(rs) ~= "table" or #rs == 0 then
        return
    end

    -- ȷ��ʤ��ע���
    local winnerRegNum = tonumber(rs["0_2"]) -- Ĭ��ʤ��ΪTeamB
    local loseRegNum = tonumber(rs["0_1"])
    if winner == 1 then
        winnerRegNum = tonumber(rs["0_1"]) -- ���TeamAʤ���������ʤ��ע���
        loseRegNum = tonumber(rs["0_2"])
    end

    confirmPK(tonumber(rs["0_0"]), winnerRegNum)
    setPkResult(tonumber(rs["0_3"]), winnerRegNum, loseRegNum)
end
