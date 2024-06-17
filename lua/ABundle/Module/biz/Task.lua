taskInfo = {}

local taskWnd = nil

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
    taskWnd = createWindow("task", client)
end

function showTask(info)
    if (taskWnd == nil) then
        Cli.Send("Task_client")
        Cli.SysMessage("[系统提示] task系统功能正在加载中，请稍后！",4,3)
        return
    end
    logPrint( 'showTask1')
    logPrintTbl(info)
    taskInfo = info;
    taskWnd:show()
    initTaskContent()
    logPrint( 'showTask2')
end

Cli.Send().wait["FLUSH_TASK"] = flushTaskInfo
cli.send().wait["SHOW_TASK"] = showTask
Cli.Send().wait["TASK_CLIENT"] = loadTaskClient
Cli.Send("task_client")