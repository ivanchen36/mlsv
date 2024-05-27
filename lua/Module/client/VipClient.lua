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
            ["type"] = "lab",
            ["title"] = "lab",
            ["x"] = 100,
            ["y"] = 100,
            ["text"] = "¿ªÊ¼",
        }
    }
    logPrint("getVipClient")
    Protocol.PowerSend(player:getObj(), "VIP_CLIENT", vipClient)
end

ClientEvent["vip_client"] = getVipClient