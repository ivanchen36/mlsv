function getAwakeningClient(player, arg)
    local client = {
        {
            ["type"] = "bg",
            ["img"] = "awakening.bmp",
        },
        {
            ["type"] = "close",
            ["x"] = 466,
            ["y"] = 14,
            ["img"] = 243000,
            ["active"] = 243002,
            ["disable"] = 243001,
        }
    }
    Protocol.PowerSend(player:getObj(), "AWAKENING_CLIENT", client)
end

ClientEvent["awakening_client"] = getAwakeningClient