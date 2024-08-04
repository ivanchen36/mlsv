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
        submit:clicked(function(w)
            Cli.Send("submit_task|" .. task.id)
        end)
    end
    showSelectBtn(curCycleType)
end

function flushtaskInfo(info)
    taskInfo = info;
    initTaskContent()
end

local function loadTaskClient()
    local client = {
        {
            ["type"] = "bg",
            ["img"] = "task.bmp",
        },
        {
            ["type"] = "close",
            ["x"] = 461,
            ["y"] = 8,
            ["img"] = 243000,
            ["active"] = 243002,
            ["disable"] = 243001,
        },
        {
            ["table"] = "0,2",
            ["width"] = 188,
            ["high"] = 76,
            ["type"] = "img",
            ["title"] = "#taskTitle$Z",
            ["x"] = 58,
            ["y"] = 78,
            ["img"] = 0,
        },
        {
            ["table"] = "0,2",
            ["width"] = 188,
            ["high"] = 76,
            ["type"] = "lab",
            ["title"] = "#taskTitle$Desc",
            ["x"] = 108,
            ["y"] = 85,
            ["text"] = "",
        },
        {
            ["table"] = "0,2",
            ["width"] = 188,
            ["high"] = 76,
            ["type"] = "lab",
            ["title"] = "#taskTitle$Line",
            ["x"] = 110,
            ["y"] = 96,
            ["text"] = "--------------",
        },
        {
            ["table"] = "0,2",
            ["width"] = 188,
            ["high"] = 76,
            ["type"] = "lab",
            ["title"] = "#taskTitle$Process",
            ["x"] = 136,
            ["y"] = 106,
            ["text"] = "",
        },
        {
            ["table"] = "0,2",
            ["width"] = 188,
            ["high"] = 76,
            ["type"] = "btn",
            ["title"] = "#taskTitle$Submit",
            ["x"] = 206,
            ["y"] = 87,
            ["img"] = "y1.bmp",
            ["active"] = "y2.bmp",
            ["disable"] = "y3.bmp",
            ["text"] = "提交",
        },
        {
            ["table"] = "0,1",
            ["high"] = 26,
            ["type"] = "btn",
            ["title"] = "#taskBtn",
            ["x"] = 20,
            ["y"] = 70,
            ["img"] = "menu1.bmp",
            ["active"] = "menu2.bmp",
            ["disable"] = "menu3.bmp",
            ["text"] = "#cycleName",
        }
    }
    taskWnd = createWindow(1009,"task", client)
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
        loadTaskClient()
    end

    taskWnd:show()
    initTaskContent()
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
