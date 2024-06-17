function getTaskClient(player, arg)
    local taskClient = {
        {
            ["type"] = "bg",
            ["img"] = "task.bmp",
        },
        {
            ["type"] = "close",
            ["x"] = 466,
            ["y"] = 14,
            ["img"] = 243000,
            ["active"] = 243002,
            ["disable"] = 243001,
        },
        {
            ["type"] = "img",
            ["title"] = "level",
            ["x"] = 59,
            ["y"] = 50,
            ["img"] = "vip10.bmp",
        },
        {
            ["type"] = "img",
            ["title"] = "me",
            ["x"] = 135,
            ["y"] = 141,
            ["img"] = player:getFace(),
        },
        {
            ["table"] = "0,1",
            ["high"] = 22,
            ["type"] = "lab",
            ["title"] = "#vipTitle",
            ["x"] = 240,
            ["y"] = 82,
            ["text"] = "#vipTitleVal",
        },
        {
            ["table"] = "0,1",
            ["high"] = 22,
            ["type"] = "lab",
            ["title"] = "#vipText",
            ["x"] = 300,
            ["y"] = 82,
            ["text"] = "#vipTextVal",
        },
        {
            ["table"] = "0,1",
            ["high"] = 22,
            ["type"] = "btn",
            ["title"] = "#vipBtn",
            ["x"] = 400,
            ["y"] = 78,
            ["img"] = "b1.bmp",
            ["active"] = "b2.bmp",
            ["disable"] = "b3.bmp",
            ["text"] = "#vipBtnText",
            ["click"] = "#vipEvents",
        },
        {
            ["type"] = "btn",
            ["title"] = "upVip",
            ["x"] = 362,
            ["y"] = 258,
            ["img"] = "y1.bmp",
            ["active"] = "y2.bmp",
            ["disable"] = "y3.bmp",
            ["text"] = "Éý¼¶",
            ["click"] = "upVip",
        },
        {
            ["table"] = "0,2",
            ["witdh"] = 170,
            ["high"] = 22,
            ["type"] = "btn",
            ["title"] = "#rewardBtn",
            ["x"] = 407,
            ["y"] = 258,
            ["img"] = "y1.bmp",
            ["active"] = "y2.bmp",
            ["disable"] = "y3.bmp",
            ["text"] = "ÁìÈ¡",
            ["click"] = "taskReward",
        }
    }
    Protocol.PowerSend(player:getObj(), "TASK_CLIENT", taskClient)
end

ClientEvent["task_client"] = getTaskClient