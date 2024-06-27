taskTitle = {"title1", "title2", "title3", "title4", "title5", "title6"}

local taskInfo = nil
local taskWnd = nil

local dailyType = 1
local weeklyType = 2
local monthlyType = 3
local taskDesc = {
    [1] = ""
}

function initTaskContent()
    local level = taskInfo["level"]
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
    taskWnd = createWindow("task", client)
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

Cli.Send().wait["FLUSH_TASK"] = flushTaskInfo
Cli.Send().wait["SHOW_TASK"] = showTask
Cli.Send().wait["TASK_CLIENT"] = loadTaskClient
