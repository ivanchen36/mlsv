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
        },
        {
            ["type"] = "radio",
            ["layout"] = "0,2",
            ["width"] = 223,
            ["high"] = 39,
            ["x"] = 466,
            ["y"] = 14,
            ["img1"] = "false.bmp",
            ["img2"] = "true.bmp",
            ["texts"] = "地属性觉醒,水属性觉醒,火属性觉醒,风属性觉醒",
            ["values"] = "1,2,3,4"
        }
    }
    Protocol.PowerSend(player:getObj(), "AWAKENING_CLIENT", client)
end

ClientEvent["awakening_client"] = getAwakeningClient