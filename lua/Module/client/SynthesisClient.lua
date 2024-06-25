function getSynthesisClient(player, arg)
    local client = {
        {
            ["type"] = "bg",
            ["img"] = "synthesis.bmp",
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
            ["table"] = "1,0",
            ["width"] = 223,
            ["high"] = 39,
            ["type"] = "lab",
            ["title"] = "#petTitle",
            ["x"] = 33,
            ["y"] = 151,
            ["text"] = "--",
        },
        {
            ["table"] = "1,0",
            ["width"] = 223,
            ["high"] = 39,
            ["type"] = "btn",
            ["title"] = "#petTitle$Prev",
            ["x"] = 33,
            ["y"] = 151,
            ["img"] = "prev1.bmp",
            ["active"] = "prev2.bmp",
            ["disable"] = "prev3.bmp",
        },
        {
            ["table"] = "1,0",
            ["width"] = 223,
            ["high"] = 39,
            ["type"] = "btn",
            ["title"] = "#petTitle$Next",
            ["x"] = 33,
            ["y"] = 151,
            ["img"] = "next1.bmp",
            ["active"] = "next2.bmp",
            ["disable"] = "next3.bmp",
        },
        {
            ["table"] = "1,0",
            ["width"] = 223,
            ["high"] = 39,
            ["type"] = "img",
            ["title"] = "#petTitle$K",
            ["x"] = 33,
            ["y"] = 151,
            ["img"] = "#petFrame",
        },
        {
            ["table"] = "1,0",
            ["width"] = 223,
            ["high"] = 39,
            ["type"] = "img",
            ["title"] = "#petTitle$Img",
            ["x"] = 33,
            ["y"] = 151,
            ["img"] = "",
        },
        {
            ["table"] = "1,0",
            ["width"] = 223,
            ["high"] = 39,
            ["type"] = "lab",
            ["title"] = "#petTitle$V",
            ["x"] = 33,
            ["y"] = 151,
            ["text"] = "0",
        },
        {
            ["table"] = "1,0",
            ["width"] = 223,
            ["high"] = 39,
            ["type"] = "lab",
            ["title"] = "#petTitle$S",
            ["x"] = 33,
            ["y"] = 151,
            ["text"] = "0",
        },
        {
            ["table"] = "1,0",
            ["width"] = 223,
            ["high"] = 39,
            ["type"] = "lab",
            ["title"] = "#petTitle$T",
            ["x"] = 33,
            ["y"] = 151,
            ["text"] = "0",
        },
        {
            ["table"] = "1,0",
            ["width"] = 223,
            ["high"] = 39,
            ["type"] = "lab",
            ["title"] = "#petTitle$Q",
            ["x"] = 33,
            ["y"] = 151,
            ["text"] = "0",
        },
        {
            ["table"] = "1,0",
            ["width"] = 223,
            ["high"] = 39,
            ["type"] = "lab",
            ["title"] = "#petTitle$M",
            ["x"] = 33,
            ["y"] = 151,
            ["text"] = "0",
        },
        {
            ["table"] = "1,0",
            ["width"] = 223,
            ["high"] = 39,
            ["type"] = "img",
            ["title"] = "#petTitle$Attr",
            ["x"] = 33,
            ["y"] = 151,
            ["img"] = "attr.bmp",
        },
        {
            ["type"] = "lab",
            ["title"] = "amount",
            ["x"] = 33,
            ["y"] = 151,
            ["text"] = "��������:50000ħ��",
        },
        {
            ["type"] = "img",
            ["title"] = "check",
            ["x"] = 33,
            ["y"] = 151,
            ["img"] = "false.bmp",
        },
        {
            ["type"] = "btn",
            ["title"] = "confirm",
            ["x"] = 407,
            ["y"] = 96,
            ["img"] = "y1.bmp",
            ["active"] = "y2.bmp",
            ["disable"] = "y3.bmp",
            ["text"] = "�ϳ�",
            ["click"] = "synthesis",
        }
    }
    Protocol.PowerSend(player:getObj(), "SYNTHESIS_CLIENT", client)
end

ClientEvent["synthesis_client"] = getSynthesisClient