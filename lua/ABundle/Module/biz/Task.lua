taskTitle = {"title1", "title2", "title3", "title4", "title5", "title6"}
taskBtn = {"daily", "weekly", "monthly"}
cycleName = {"日常", "周常", "月常"}
local dailyType = 1
local weeklyType = 2
local monthlyType = 3
local curCycleType = dailyType

local typeImg = {
    [1] = "fy.bmp",
    [2] = "ls.bmp",
    [3] = "sx.bmp",
    [4] = "tz.bmp"
}
local taskDescFormat = {
    [1] = "封印%d只%s",
    [2] = "猎杀%d只%s",
    [3] = "搜寻%d个%s",
    [4] = "挑战%d次%s"
}

local itemName = {
    [1] = "测试1",
    [2] = "测试2",
    [3] = "测试3",
    [4] = "测试4",
}

local taskInfo = nil
local taskWnd = nil

function showSelectBtn(cycleType)
    for i = 1, #taskBtn do
        local btn = taskWnd:getWidget(taskBtn[i])
        if cycleType == i then
            btn:setEnabled(false)
        else
            btn:setEnabled(true)
        end
    end
end

function initTaskContent()
    for i = 1, #taskInfo do
        local task = taskInfo[i]
        local title = taskTitle[i]
        local taskImg = taskWnd:getWidget(title .. "Z")
        local taskDesc = taskWnd:getWidget(title .. "Desc")
        local taskProcess = taskWnd:getWidget(title .. "Process")
        local submit = taskWnd:getWidget(title .. "Submit")
        local itemName = itemName[task["item"]] or "未知"
        local taskType = task["type"]
        local desc = string.format(taskDescFormat[taskType], task.count, itemName)
        taskImg:setImg(typeImg[task["type"]])
        taskDesc:setText(desc)
        taskProcess:setText(string.format("%d / %d", task.process, task.count))
        if task.process >= task.count and task.status ~= 2 then
            submit:setEnabled(true)
        else
            submit:setEnabled(false)
        end
        logPrintTbl(submit)
        submit:clicked(function(w)
            Cli.Send("submit_task|" .. task.id)
        end)
    end
    showSelectBtn(curCycleType)
end

function flushtaskInfo(info)
    logPrintTbl(info)
    taskInfo = info;
    initTaskContent()
end

function loadTaskClient(client)
    logPrint("loadTaskClient")
    logPrintTbl(client)
    local needShow = false
    if nil == taskWnd and nil ~= taskInfo then
        needShow = true
    end
    taskWnd = createWindow(1009,"task", client)
    if needShow then
        showTask(taskInfo)
    end
end

function addCycleEvent()
    for i = 1, #taskBtn do
        local btn = taskWnd:getWidget(taskBtn[i])
        btn:clicked(function(w)
            curCycleType = i
            Cli.Send("query_task|" .. i)
        end)
    end
end

function showTask(info)
    taskInfo = info;

    if (taskWnd == nil) then
        Cli.Send("task_client")
        return
    end
    logPrint( 'showTask1')
    logPrintTbl(info)

    taskWnd:show()
    initTaskContent()
    logPrint( 'showTask2')
end

function flushSubmitTask(taskId)
    for i = 1, #taskInfo do
        local task = taskInfo[i]
        if task.id == taskId then
            local title = taskTitle[i]
            local submit = taskWnd:getWidget(title .. "Submit")
            submit:setEnabled(false)
        end
    end
end

Cli.Send().wait["FLUSH_TASK"] = flushTaskInfo
Cli.Send().wait["SUBMIT_TASK"] = flushSubmitTask
Cli.Send().wait["SHOW_TASK"] = showTask
Cli.Send().wait["TASK_CLIENT"] = loadTaskClient
