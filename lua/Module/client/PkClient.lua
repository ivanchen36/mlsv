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
        },
        {
            ["table"] = "1,0",
            ["width"] = 120,
            ["type"] = "lab",
            ["title"] = "#pkTitle$Time",
            ["x"] = 300,
            ["y"] = 82,
            ["text"] = "#pkTime",
        },
        {
            ["table"] = "1,0",
            ["width"] = 120,
            ["type"] = "lab",
            ["title"] = "#pkTitle$Rule",
            ["x"] = 300,
            ["y"] = 82,
            ["text"] = "#pkRule",
        },
        {
            ["table"] = "1,0",
            ["width"] = 120,
            ["type"] = "lab",
            ["title"] = "#pkTitle$Info",
            ["x"] = 300,
            ["y"] = 82,
            ["text"] = "#pkInfo",
        },
        {
            ["table"] = "1,0",
            ["width"] = 120,
            ["type"] = "lab",
            ["title"] = "#pkTitle",
            ["x"] = 300,
            ["y"] = 82,
            ["text"] = "--",
        }
    }
    Protocol.PowerSend(player:getObj(), "PK_CLIENT", client)
end

ClientEvent["pk_client"] = getPkClient