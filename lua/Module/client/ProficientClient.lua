function getProficientClient(player, arg)
    local client = {
        {
            ["type"] = "bg",
            ["img"] = "proficient.bmp",
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
            ["table"] = "0,1",
            ["high"] = 22,
            ["type"] = "lab",
            ["title"] = "#raceTitle",
            ["x"] = 300,
            ["y"] = 82,
            ["text"] = "#raceTitleVal$专精:",
        },
        {
            ["table"] = "0,1",
            ["high"] = 22,
            ["type"] = "lab",
            ["title"] = "#raceTitle$Lab",
            ["x"] = 27,
            ["y"] = 146,
            ["img"] = "lab.bmp",
        },
        {
            ["table"] = "0,1",
            ["high"] = 22,
            ["type"] = "lab",
            ["title"] = "#raceTitle$Level",
            ["x"] = 300,
            ["y"] = 82,
            ["text"] = "等级1",
        },
        {
            ["table"] = "0,1",
            ["high"] = 22,
            ["type"] = "lab",
            ["title"] = "#raceTitle$Info",
            ["x"] = 300,
            ["y"] = 82,
            ["text"] = "--",
        },
        {
            ["table"] = "0,1",
            ["high"] = 22,
            ["type"] = "btn",
            ["title"] = "#raceTitle$Up",
            ["x"] = 400,
            ["y"] = 78,
            ["img"] = "b1.bmp",
            ["active"] = "b2.bmp",
            ["disable"] = "b3.bmp",
            ["text"] = "升级",
            ["click"] = "upProficient",
        },
        {
            ["table"] = "0,1",
            ["high"] = 22,
            ["type"] = "btn",
            ["title"] = "#raceTitle$Challenge",
            ["x"] = 400,
            ["y"] = 78,
            ["img"] = "b1.bmp",
            ["active"] = "b2.bmp",
            ["disable"] = "b3.bmp",
            ["text"] = "挑战",
            ["click"] = "raceChallenge",
        }
    }
    Protocol.PowerSend(player:getObj(), "PROFICIENT_CLIENT", client)
end

ClientEvent["proficient_client"] = getProficientClient
