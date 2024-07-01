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
            ["high"] = 25,
            ["type"] = "img",
            ["title"] = "#taskTitle",
            ["x"] = 80,
            ["y"] = 62,
            ["img"] = 0,
        },
        {
            ["table"] = "0,2",
            ["high"] = 25,
            ["type"] = "lab",
            ["title"] = "#taskTitle$Desc",
            ["x"] = 80,
            ["y"] = 62,
            ["text"] = 0,
        },
        {
            ["table"] = "0,2",
            ["high"] = 25,
            ["type"] = "btn",
            ["title"] = "#taskTitle$Submit",
            ["x"] = 228,
            ["y"] = 123,
            ["img"] = "y1.bmp",
            ["active"] = "y2.bmp",
            ["disable"] = "y3.bmp",
            ["text"] = "Ã·Ωª",
            ["click"] = "",
        }
    }
    Protocol.PowerSend(player:getObj(), "TASK_CLIENT", taskClient)
end

ClientEvent["task_client"] = getTaskClient