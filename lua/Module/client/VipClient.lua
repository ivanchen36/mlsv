function getVipClient(player, arg)
    local vipClient = {
        {
            ["type"] = "bg",
            ["img"] = "vip.bmp",
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
            ["x"] = 60,
            ["y"] = 50,
            ["img"] = "vip0.bmp",
        },
        {
            ["align"] = "x",
            ["dis"] = 22,
            ["type"] = "lab",
            ["title"] = "#vipTitle",
            ["x"] = 260,
            ["y"] = 74,
            ["text"] = "#vipTitleVal",
        },
        {
            ["align"] = "x",
            ["dis"] = 22,
            ["type"] = "lab",
            ["title"] = "#vipText",
            ["x"] = 320,
            ["y"] = 74,
            ["text"] = "",
        },
        {
            ["align"] = "x",
            ["dis"] = 22,
            ["type"] = "btn",
            ["title"] = "#vipBtn",
            ["x"] = 380,
            ["y"] = 77,
            ["img"] = "green1.bmp",
            ["active"] = "green2.bmp",
            ["disable"] = "gray.bmp",
            ["text"] = "#vipBtnText",
            ["click"] = "#vipEvents",
        },
        {
            ["type"] = "btn",
            ["title"] = "collect",
            ["x"] = 362,
            ["y"] = 247,
            ["img"] = "y1.bmp",
            ["active"] = "y2.bmp",
            ["disable"] = "y3.bmp",
            ["text"] = "¡Ï»°",
        }
    }
    logPrint("getVipClient")
    Protocol.PowerSend(player:getObj(), "VIP_CLIENT", vipClient)
end

ClientEvent["vip_client"] = getVipClient