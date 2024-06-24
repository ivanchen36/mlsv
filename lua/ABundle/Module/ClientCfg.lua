<?
function Event.RegLoginEvent.registInit(player)
    -- 基础模块
    Client.RunABundle(player, "Image.lua")
    Client.RunABundle(player, "StaticText.lua")
    Client.RunABundle(player, "Button.lua")
    Client.RunABundle(player, "Radio.lua")
    Client.RunABundle(player, "Window.lua")
    Client.RunABundle(player, "Util.lua")

    -- 业务模块
    Client.RunABundle(player, "Vip.lua")
    Client.RunABundle(player, "Proficient.lua")
--Client.RunABundle(player, "Synthesis.lua")
--Client.RunABundle(player, "Pk.lua")
--Client.RunABundle(player, "Awakening.lua")
--Client.RunABundle(player, "Task.lua")
end
?>