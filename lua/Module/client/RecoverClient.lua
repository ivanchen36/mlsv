function getRecoverClient(player, arg)
    local recoverClient = {
        {
            ["type"] = "bg",
            ["img"] = "recover.bmp",
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
            ["table"] = "0,1",
            ["width"] = 223,
            ["high"] = 39,
            ["type"] = "lab",
            ["title"] = "#partyTitle",
            ["x"] = 33,
            ["y"] = 151,
            ["text"] = "",
        },
        {
            ["table"] = "0,1",
            ["width"] = 223,
            ["high"] = 39,
            ["type"] = "lab",
            ["title"] = "#partyTitle$H",
            ["x"] = 33,
            ["y"] = 151,
            ["text"] = "",
        },
        {
            ["table"] = "0,1",
            ["width"] = 223,
            ["high"] = 39,
            ["type"] = "lab",
            ["title"] = "#partyTitle$M",
            ["x"] = 33,
            ["y"] = 151,
            ["text"] = "",
        },
        {
            ["table"] = "0,1",
            ["width"] = 223,
            ["high"] = 39,
            ["type"] = "lab",
            ["title"] = "#partyTitle$G",
            ["x"] = 33,
            ["y"] = 151,
            ["text"] = "",
        },
        {
            ["type"] = "btn",
            ["title"] = "confirm",
            ["x"] = 397,
            ["y"] = 143,
            ["img"] = "b1.bmp",
            ["active"] = "b2.bmp",
            ["disable"] = "b3.bmp",
            ["text"] = "",
            ["click"] = "recover",
        },
        {
            ["type"] = "btn",
            ["title"] = "cancel",
            ["x"] = 397,
            ["y"] = 143,
            ["img"] = "b1.bmp",
            ["active"] = "b2.bmp",
            ["disable"] = "b3.bmp",
            ["text"] = "",
            ["click"] = "recover",
        }
    }
    Protocol.PowerSend(player:getObj(), "RECOVER_CLIENT", recoverClient)
end

ClientEvent["recover_client"] = getRecoverClient