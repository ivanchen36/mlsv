function getTaskClient(player, arg)
    local taskClient = {
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
            ["width"] = 166,
            ["high"] = 76,
            ["type"] = "img",
            ["title"] = "#taskTitle$Z",
            ["x"] = 92,
            ["y"] = 78,
            ["img"] = 0,
        },
        {
            ["table"] = "0,2",
            ["width"] = 179,
            ["high"] = 76,
            ["type"] = "lab",
            ["title"] = "#taskTitle$Desc",
            ["x"] = 136,
            ["y"] = 83,
            ["text"] = "",
        },
        {
            ["table"] = "0,2",
            ["width"] = 179,
            ["high"] = 76,
            ["type"] = "lab",
            ["title"] = "#taskTitle$Line",
            ["x"] = 143,
            ["y"] = 105,
            ["text"] = "-----------",
        },
        {
            ["table"] = "0,2",
            ["width"] = 179,
            ["high"] = 76,
            ["type"] = "lab",
            ["title"] = "#taskTitle$Process",
            ["x"] = 166,
            ["y"] = 120,
            ["text"] = "",
        },
        {
            ["table"] = "0,2",
            ["width"] = 179,
            ["high"] = 76,
            ["type"] = "btn",
            ["title"] = "#taskTitle$Submit",
            ["x"] = 132,
            ["y"] = 95,
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
            ["img"] = "task1.bmp",
            ["active"] = "task2.bmp",
            ["disable"] = "task3.bmp",
            ["text"] = "日常",
        }
    }
    Protocol.PowerSend(player:getObj(), "TASK_CLIENT", taskClient)
end

ClientEvent["task_client"] = getTaskClient