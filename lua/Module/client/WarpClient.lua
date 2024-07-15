function getWarpClient(player, arg)
    local warpClient = {
        {
            ["type"] = "bg",
            ["img"] = "warp.bmp",
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
            ["title"] = "#warpTitle$Z",
            ["x"] = 58,
            ["y"] = 78,
            ["img"] = 0,
        },
        {
            ["table"] = "0,2",
            ["width"] = 188,
            ["high"] = 76,
            ["type"] = "lab",
            ["title"] = "#warpTitle$Desc",
            ["x"] = 108,
            ["y"] = 85,
            ["text"] = "",
        },
        {
            ["table"] = "0,2",
            ["width"] = 188,
            ["high"] = 76,
            ["type"] = "lab",
            ["title"] = "#warpTitle$Line",
            ["x"] = 110,
            ["y"] = 96,
            ["text"] = "--------------",
        },
        {
            ["table"] = "0,2",
            ["width"] = 188,
            ["high"] = 76,
            ["type"] = "lab",
            ["title"] = "#warpTitle$Process",
            ["x"] = 136,
            ["y"] = 106,
            ["text"] = "",
        },
        {
            ["table"] = "0,2",
            ["width"] = 188,
            ["high"] = 76,
            ["type"] = "btn",
            ["title"] = "#warpTitle$Submit",
            ["x"] = 206,
            ["y"] = 87,
            ["img"] = "y1.bmp",
            ["active"] = "y2.bmp",
            ["disable"] = "y3.bmp",
            ["text"] = "Ã·Ωª",
        },
        {
            ["table"] = "0,1",
            ["high"] = 26,
            ["type"] = "btn",
            ["title"] = "#warpBtn",
            ["x"] = 20,
            ["y"] = 70,
            ["img"] = "warp1.bmp",
            ["active"] = "warp2.bmp",
            ["disable"] = "warp3.bmp",
            ["text"] = "#cycleName",
        }
    }
    Protocol.PowerSend(player:getObj(), "WARP_CLIENT", warpClient)
end

ClientEvent["warp_client"] = getWarpClient