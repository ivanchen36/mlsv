function getPkClient(player, arg)
    local client = {
        {
            ["type"] = "bg",
            ["img"] = "pk.bmp",
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
    Protocol.PowerSend(player:getObj(), "PK_CLIENT", client)
end

ClientEvent["pk_client"] = getPkClient