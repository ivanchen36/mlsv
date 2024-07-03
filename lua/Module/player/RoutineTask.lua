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
local sealItemNumList = {5, 5, 5, 5}
local huntItemList = {1, 2, 3, 4}
local huntItemNumList = {5, 5, 5, 5}
local searchItemList = {1, 2, 3, 4}
local searchItemNumList = {5, 5, 5, 5}
local challengeItemList = {1, 2, 3, 4}
local challengeItemNumList = {5, 5, 5, 5}
local routineTaskList = {sealItemList, huntItemList, searchItemList, challengeItemList}
local routineTaskNumList = {sealItemNumList, huntItemNumList, searchItemNumList, challengeItemNumList}

local cycleFormat = {'%j', '%W', '%m'}
local dailyType = 1
local weeklyType = 2
local monthlyType = 3
local taskNum = {6, 6, 6}

function getRandomTaskAndItem()
    -- ���ѡ��һ������
    local type = math.random(#routineTaskList)
    local selectedItemList = routineTaskList[type]
    local selectedItemNumList = routineTaskNumList[type]

    -- ��ѡ�������������ѡ��һ��item
    local itemIndex = math.random(#selectedItemList)
    return type, selectedItemList[itemIndex], selectedItemNumList[itemIndex]
end

-- �����ȡ����
function receiveTask(player, cycleType)
    logPrint("receiveTask")
    local regNum = player:getRegistNumber()
    local taskCount = taskNum[cycleType]
    local cycleDate = os.date(cycleFormat[cycleType])

    for i = 1, taskCount do
        local typeIndex, item, count = getRandomTaskAndItem()
        local sql = string.format("INSERT INTO tbl_player_task (RegNum, Cycle, CycleDate, Type, Item, Count, Status, Process, CreateTime) VALUES ('%s', %d, %d, %d, %d, %d, 1, 0, UNIX_TIMESTAMP())",
                regNum, cycleType, cycleDate, typeIndex, item, count)
        SQL.Run(sql)
    end

    return
end

-- ��ѯ��ҵ�����
function queryTaskByType(player, cycleType)
    local regNum = player:getRegistNumber()
    -- ���㵱ǰ��������
    local cycleDate = os.date(cycleFormat[cycleType])

    -- �����ݿ��ȡ������Ϣ
    local query = string.format("SELECT Id, Type, Item, Count, Process, Status, Cycle FROM tbl_player_task WHERE RegNum = '%s' AND Cycle = %d AND CycleDate = %d", regNum, cycleType, cycleDate)
    local result = SQL.Run(query)
    if(type(result) ~= "table")then
        receiveTask(player, cycleType)
        result = SQL.Run(query)
        if(type(result) ~= "table")then
            player:sysMsg("��ѯ����ʧ�ܣ����Ժ�����")
            return
        end
    end
    local taskList = {}
    local len = countKeys(result)
    logPrintTbl(result)
    len = len / 7 - 1
    for i = 0, len do

        local task = {
            ["id"] = tonumber(result[i .. "_0"]),
            ["type"] = tonumber(result[i .. "_1"]),
            ["item"] = tonumber(result[i .. "_2"]),
            ["count"] = tonumber(result[i .. "_3"]),
            ["process"] = tonumber(result[i .. "_4"]),
            ["status"] = tonumber(result[i .. "_5"]),
            ["cycle"] = tonumber(result[i .. "_6"]),
        }
        if task.status ~= 2 then
            if 3 == task.type then
                task.process = player:getItemNum(task.item)
                if task.process > task.count then
                    task.process = task.count
                end
            elseif 4 == task.type and player:havePet(task.item) >= 0 then
                task.process = 1
            end
        end
        logPrintTbl(task)
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
    local query = string.format("SELECT Cycle, Type, Item, Count, Process, Status FROM tbl_player_task WHERE RegNum = '%s' AND Id = %d", regNum, taskId)
    local result = SQL.Run(query)
    if(type(result) ~= "table")then
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
        player:sysMsg("��������ɣ������ظ��ύ")
        return
    end

    handleTask(regNum, playerTask)
    if playerTask.progress >= playerTask.count then
        -- ��������״̬Ϊ�����
        local sql = string.format("UPDATE tbl_player_task SET Status = 2, Process = %d WHERE RegNum = '%s' AND Id = %d", playerTask.progress, regNum, taskId)
        SQL.Run(sql)

        -- ��ȡ����
        local reward = rewardList[playerTask.cycle][playerTask.type]
        player:getItem(reward)
        player:sysMsg("������ɣ���������ȡ")
        Protocol.PowerSend(player:getObj(),"SUBMIT_TASK", taskId)
        return
    else
        player:sysMsg("�ύʧ�ܣ����Ժ�����")
        return
    end
end

function showRoutine(player)
    logPrint("showRoutine")
    local taskList = queryTaskByType(player, dailyType)
    logPrintTbl(taskList)
    Protocol.PowerSend(player:getObj(),"SHOW_TASK", taskList)
end

function queryTask(player, arg)
    local taskList = queryTaskByType(player, tonumber(arg))
    Protocol.PowerSend(player:getObj(),"FLUSH_TASK", taskList)
end

TalkEvent["[routine]"] = showRoutine
ClientEvent["query_task"] = queryTask
ClientEvent["submit_task"] = submitTask