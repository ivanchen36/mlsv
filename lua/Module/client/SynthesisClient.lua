function getSynthesisClient(player, arg)
    local client = {
        {
            ["type"] = "bg",
            ["img"] = "synthesis.bmp",
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
            ["table"] = "1,0",
            ["width"] = 220,
            ["high"] = 39,
            ["type"] = "lab",
            ["title"] = "#petTitle",
            ["x"] = 90,
            ["y"] = 68,
            ["text"] = "无可选择宠物",
        },
        {
            ["table"] = "1,0",
            ["width"] = 220,
            ["high"] = 39,
            ["type"] = "btn",
            ["title"] = "#petTitle$Prev",
            ["x"] = 63,
            ["y"] = 65,
            ["img"] = "prev1.bmp",
            ["active"] = "prev2.bmp",
            ["disable"] = "prev3.bmp",
        },
        {
            ["table"] = "1,0",
            ["width"] = 220,
            ["high"] = 39,
            ["type"] = "btn",
            ["title"] = "#petTitle$Next",
            ["x"] = 193,
            ["y"] = 65,
            ["img"] = "next1.bmp",
            ["active"] = "next2.bmp",
            ["disable"] = "next3.bmp",
        },
        {
            ["table"] = "1,0",
            ["width"] = 220,
            ["high"] = 39,
            ["type"] = "img",
            ["title"] = "#petTitle$Frame",
            ["x"] = 75,
            ["y"] = 89,
            ["img"] = "#petFrame",
        },
        {
            ["table"] = "1,0",
            ["width"] = 220,
            ["high"] = 39,
            ["type"] = "ani",
            ["title"] = "#petTitle$ZImg",
            ["x"] = 0,
            ["y"] = 0,
            ["img"] = 0,
            ["bg"] = "#petTitle$Frame",
        },
        {
            ["table"] = "1,0",
            ["width"] = 220,
            ["high"] = 39,
            ["type"] = "lab",
            ["title"] = "#petTitle$V",
            ["x"] = 78,
            ["y"] = 267,
            ["text"] = "体力: 0",
        },
        {
            ["table"] = "1,0",
            ["width"] = 220,
            ["high"] = 39,
            ["type"] = "lab",
            ["title"] = "#petTitle$S",
            ["x"] = 139,
            ["y"] = 267,
            ["text"] = "力量: 0",
        },
        {
            ["table"] = "1,0",
            ["width"] = 220,
            ["high"] = 39,
            ["type"] = "lab",
            ["title"] = "#petTitle$T",
            ["x"] = 78,
            ["y"] = 282,
            ["text"] = "强度: 0",
        },
        {
            ["table"] = "1,0",
            ["width"] = 220,
            ["high"] = 39,
            ["type"] = "lab",
            ["title"] = "#petTitle$Q",
            ["x"] = 139,
            ["y"] = 282,
            ["text"] = "速度: 0",
        },
        {
            ["table"] = "1,0",
            ["width"] = 220,
            ["high"] = 39,
            ["type"] = "lab",
            ["title"] = "#petTitle$M",
            ["x"] = 78,
            ["y"] = 297,
            ["text"] = "魔法: 0",
        },
        {
            ["table"] = "1,0",
            ["width"] = 220,
            ["high"] = 39,
            ["type"] = "img",
            ["title"] = "#petTitle$Earth",
            ["x"] = 76,
            ["y"] = 207,
            ["img"] = 243150,
        },
        {
            ["table"] = "1,0",
            ["width"] = 220,
            ["high"] = 39,
            ["type"] = "img",
            ["title"] = "#petTitle$Water",
            ["x"] = 76,
            ["y"] = 222,
            ["img"] = 243155,
        },
        {
            ["table"] = "1,0",
            ["width"] = 220,
            ["high"] = 39,
            ["type"] = "img",
            ["title"] = "#petTitle$Fire",
            ["x"] = 76,
            ["y"] = 237,
            ["img"] = 243160,
        },
        {
            ["table"] = "1,0",
            ["width"] = 220,
            ["high"] = 39,
            ["type"] = "img",
            ["title"] = "#petTitle$Wind",
            ["x"] = 76,
            ["y"] = 252,
            ["img"] = 243165,
        },
        {
            ["type"] = "lab",
            ["title"] = "mobi",
            ["x"] = 202,
            ["y"] = 218,
            ["text"] = "需要:50000魔币",
        },
        {
            ["type"] = "img",
            ["title"] = "check",
            ["x"] = 228,
            ["y"] = 230,
            ["img"] = "f.bmp",
        },
        {
            ["type"] = "btn",
            ["title"] = "confirm",
            ["x"] = 228,
            ["y"] = 123,
            ["img"] = "y1.bmp",
            ["active"] = "y2.bmp",
            ["disable"] = "y3.bmp",
            ["text"] = "合成",
            ["click"] = "synthesis",
        }
    }
    Protocol.PowerSend(player:getObj(), "SYNTHESIS_CLIENT", client)
end

ClientEvent["synthesis_client"] = getSynthesisClient