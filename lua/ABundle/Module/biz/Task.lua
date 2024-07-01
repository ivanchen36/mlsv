taskTitle = {"title1", "title2", "title3", "title4", "title5", "title6"}
local dailyType = 1
local weeklyType = 2
local monthlyType = 3
cycleTaskType = {
    dailyType,
    weeklyType,
    monthlyType
}
local typeImg = {
    [1] = "bmp",
    [2] = "bmp",
    [3] = "bmp",
    [4] = "bmp"
}
local taskDesc = {
    [1] = "封印%d只%s: %d/%d",
    [2] = "猎杀%d只%s: %d/%d",
    [3] = "上交%d个%s: %d/%d",
    [4] = "战胜%d次%s: %d/%d"
}

local itemName = {

}
local taskInfo = nil
local taskWnd = nil



function initTaskContent()
    for i = 1, #taskInfo do
        local task = taskInfo[i]
        local title = taskTitle[i]
        local taskImg = taskWnd:getWidget(title)
        local taskDesc = taskWnd:getWidget(title .. "Desc")
        local submit = taskWnd:getWidget(title .. "Submit")
        local itemName = itemName[task["item"]] or "未知"
        local taskType = task["type"]
        local desc = string.format(taskDesc[taskType], task.count, itemName,
                                   task.process, task.count)

        task:setImg(typeImg[task["type"]])
        taskDesc:setText(desc)
        if task.process >= task.count and task.status ~= 2 then
            submit:setEnabled(true)
        else
            submit:setEnabled(false)
        end
        submit:clicked(function()
            Cli.Send("submit_task|" .. task.id)
        end)
    end
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

function showTask(info)
    taskInfo = info;

    if (taskWnd == nil) then
        Cli.Send("Task_client")
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
