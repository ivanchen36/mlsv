function getTaskClient(player, arg)
    local taskClient = {
        {
            ["type"] = "bg",
            ["img"] = "task.bmp",
        },
        {
            ["type"] = "close",
            ["x"] = 461,
            ["y"] = 8,
            ["img"] = 243000,
            ["active"] = 243002,
            ["disable"] = 243001,
        }
    }
    Protocol.PowerSend(player:getObj(), "TASK_CLIENT", taskClient)
end

ClientEvent["task_client"] = getTaskClient