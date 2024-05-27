local taskType = {
    [1] = "��ӡ",
    [2] = "��ɱ",
    [3] = "��Ѱ",
    [4] = "��ս"
}
local dailyReward = {
    [1] = reward1,
    [2] = reward2,
    [3] = reward3,
    [4] = reward4
}
local weeklyReward = {
    [1] = reward1,
    [2] = reward2,
    [3] = reward3,
    [4] = reward4
}
local monthlyReward = {
    [1] = reward1,
    [2] = reward2,
    [3] = reward3,
    [4] = reward4
}
local rewardList = {dailyReward, weeklyReward, monthlyReward}

local sealItemList = {1, 2, 3, 4}
local huntItemList = {1, 2, 3, 4}
local searchItemList = {1, 2, 3, 4}
local challengeItemList = {1, 2, 3, 4}
local taskList = {sealItemList, huntItemList, searchItemList, challengeItemList}

local cycleFormat = {'%j', '%W', '%m'}
local dailyType = 1
local weeklyType = 2
local monthlyType = 2
local taskNum = {6, 6, 10}

function getRandomTaskAndItem()
    -- ���ѡ��һ������
    local type = math.random(#taskList)
    local selectedItemList = taskList[type]

    -- ��ѡ�������������ѡ��һ��item
    local itemIndex = math.random(#selectedItemList)
    local item = selectedItemList[itemIndex]

    return type, item
end

-- �����ȡ����
function receiveTask(player, arg)
    local regNum = player:getRegistNumber()
    local cycleType = tonumber(arg)
    local taskCount = taskNum[cycleType]
    local cycleDate = os.date(cycleFormat[cycleType])

    -- ��������ָ�������Ƿ��Ѿ���ȡ������
    local query = string.format("SELECT COUNT(1) as count FROM tbl_player_task WHERE RegNum = ? AND Cycle = ? AND CycleDate = ?", regNum, cycleType, cycleDate)
    local existingTaskCount = Sql.RUN(query)
    if existingTaskCount["0_0"] > 0 then
        player:sysMsg("���Ѿ���ȡ�˱����ڵ�����")
        return
    end

    for i = 1, taskCount do
        local typeIndex, item = getRandomTaskAndItem()
        local sql = string.format("INSERT INTO tbl_player_task (RegNum, Cycle, CycleDate, Type, Item, Count, Status, Progress, CreateTime, UpdateTime) VALUES (?, ?, ?, ?, ?, ?, 'δ��ʼ', 0, ?, ?)",
                playerId, cycleType, cycleDate, typeIndex, item, 1, os.time(), os.time())
        Sql.RUN(sql)
    end

    player:sysMsg("������ȡ�ɹ�")
    return
end

-- ��ѯ��ҵ�����
function queryTaskByType(regNum, cycleType)
    -- ���㵱ǰ��������
    local cycleDate = os.date(cycleFormat[cycleType])

    -- �����ݿ��ȡ������Ϣ
    local query = string.format("SELECT Id, Type, Item, Count, Progress, Status, Cycle FROM tbl_player_task WHERE RegNum = ? AND Cycle = ? AND CycleDate = ?", regNum, cycleType, cycleDate)
    local result = Sql.RUN(query)
    if(type(result) ~= "table")then
        return
    end

    for i = 1, (#result) / 5 do
        local task = {
            ["id"] = tonumber(result[i .. "_0"]),
            ["type"] = tonumber(result[i .. "_1"]),
            ["item"] = tonumber(result[i .. "_2"]),
            ["count"] = tonumber(result[i .. "_3"]),
            ["progress"] = tonumber(result[i .. "_4"]),
            ["status"] = tonumber(result[i .. "_5"]),
            ["cycle"] = tonumber(result[i .. "_6"]),
        }
        table.insert(taskList, task)
    end

    return taskList
end

function checkTask(player, task)
    if 2 == task.type  or 4 == task.type then
        return
    end
    if 3 == task.type then
        if player:getItemNum(task) >= task.count then
            task.progress = task.count
        end
        return
    end
    if 4 == task.type then
        for i = 0, 4 do
            if player:havePet(task.item) >= 0 then
                task.progress = task.count
            end
        end
    end
end

function handleTask(player, task)
    if 2 == task.type  or 4 == task.type then
        return
    end
    if 3 == task.type then
        if player:getItemNum(task) >= task.count then
            task.progress = task.count
        end
    end
    if 4 == task.type then
        for i = 0, 4 do
            if player:havePet(task.item) >= 0 then
                task.progress = task.count
            end
        end
    end
end

-- ����ύ����
function submitTask(player, arg)
    local regNum = player:getRegistNumber()
    local taskId = tonumber(arg)
    local query = string.format("SELECT Cycle, Type, Item, Count, Progress, Status FROM tbl_player_task WHERE RegNum = ? AND Id = ?", regNum, taskId)
    local result = Sql.RUN(query)
    if(type(result) ~= "table")then
        Protocol.PowerSend(player:getObj(),"SUBMIT_RS", 0)
        player:sysMsg("��ѯ����ʧ�ܣ��޷��ύ����")
        return
    end

    local playerTask = {
        ["cycle"] = tonumber(result["0_0"]),
        ["type"] = tonumber(result["0_1"]),
        ["item"] = tonumber(result["0_2"]),
        ["count"] = tonumber(result["0_3"]),
        ["progress"] = tonumber(result["0_4"]),
        ["status"] = tonumber(result["0_5"])
    }

    -- �������״̬
    if playerTask.status == 2 then
        Protocol.PowerSend(player:getObj(),"SUBMIT_RS", 0)
        player:sysMsg("��������ɣ������ظ��ύ")
        return
    end

    handleTask(regNum, playerTask)
    if playerTask.progress >= playerTask.count then
        -- ��������״̬Ϊ�����
        local sql = string.format("UPDATE tbl_player_task SET Status = 2, Progress = ? WHERE RegNum = ? AND Id = ?", playerTask.progress, regNum, taskId)
        Sql.RUN(sql)

        -- ��ȡ����
        local reward = rewardList[playerTask.cycle][playerTask.type]
        player:getItem(reward)
        player:sysMsg("������ɣ���������ȡ")
        return
    else
        player:sysMsg("�ύʧ�ܣ����Ժ�����")
        return
    end
end

function showRoutine(player)
    local regNum = player:getRegistNumber()
    local taskList = queryTaskByType(regNum, dailyType)
    Protocol.PowerSend(player:getObj(),"SHOW_ROUTINE", taskList)
end

function queryTask(player, arg)
    local regNum = player:getRegistNumber()
    local taskList = queryTaskByType(regNum, tonumber(arg))
    Protocol.PowerSend(player:getObj(),"FLUSH_TASK", taskList)
end

TalkEvent["[routine]"] = showRoutine
ClientEvent["query_task"] = queryTask
ClientEvent["receive_task"] = receiveTask
ClientEvent["submit_task"] = submitTask