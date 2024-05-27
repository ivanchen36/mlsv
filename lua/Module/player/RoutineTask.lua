local taskType = {
    [1] = "封印",
    [2] = "猎杀",
    [3] = "搜寻",
    [4] = "挑战"
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
    -- 随机选择一个任务
    local type = math.random(#taskList)
    local selectedItemList = taskList[type]

    -- 从选定的任务中随机选择一个item
    local itemIndex = math.random(#selectedItemList)
    local item = selectedItemList[itemIndex]

    return type, item
end

-- 玩家领取任务
function receiveTask(player, arg)
    local regNum = player:getRegistNumber()
    local cycleType = tonumber(arg)
    local taskCount = taskNum[cycleType]
    local cycleDate = os.date(cycleFormat[cycleType])

    -- 检查玩家在指定周期是否已经领取了任务
    local query = string.format("SELECT COUNT(1) as count FROM tbl_player_task WHERE RegNum = ? AND Cycle = ? AND CycleDate = ?", regNum, cycleType, cycleDate)
    local existingTaskCount = Sql.RUN(query)
    if existingTaskCount["0_0"] > 0 then
        player:sysMsg("您已经领取了本周期的任务")
        return
    end

    for i = 1, taskCount do
        local typeIndex, item = getRandomTaskAndItem()
        local sql = string.format("INSERT INTO tbl_player_task (RegNum, Cycle, CycleDate, Type, Item, Count, Status, Progress, CreateTime, UpdateTime) VALUES (?, ?, ?, ?, ?, ?, '未开始', 0, ?, ?)",
                playerId, cycleType, cycleDate, typeIndex, item, 1, os.time(), os.time())
        Sql.RUN(sql)
    end

    player:sysMsg("任务领取成功")
    return
end

-- 查询玩家的任务
function queryTaskByType(regNum, cycleType)
    -- 计算当前周期日期
    local cycleDate = os.date(cycleFormat[cycleType])

    -- 从数据库获取任务信息
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

-- 玩家提交任务
function submitTask(player, arg)
    local regNum = player:getRegistNumber()
    local taskId = tonumber(arg)
    local query = string.format("SELECT Cycle, Type, Item, Count, Progress, Status FROM tbl_player_task WHERE RegNum = ? AND Id = ?", regNum, taskId)
    local result = Sql.RUN(query)
    if(type(result) ~= "table")then
        Protocol.PowerSend(player:getObj(),"SUBMIT_RS", 0)
        player:sysMsg("查询任务失败，无法提交任务")
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

    -- 检查任务状态
    if playerTask.status == 2 then
        Protocol.PowerSend(player:getObj(),"SUBMIT_RS", 0)
        player:sysMsg("任务已完成，无需重复提交")
        return
    end

    handleTask(regNum, playerTask)
    if playerTask.progress >= playerTask.count then
        -- 更新任务状态为已完成
        local sql = string.format("UPDATE tbl_player_task SET Status = 2, Progress = ? WHERE RegNum = ? AND Id = ?", playerTask.progress, regNum, taskId)
        Sql.RUN(sql)

        -- 领取奖励
        local reward = rewardList[playerTask.cycle][playerTask.type]
        player:getItem(reward)
        player:sysMsg("任务完成，奖励已领取")
        return
    else
        player:sysMsg("提交失败，请稍后重试")
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