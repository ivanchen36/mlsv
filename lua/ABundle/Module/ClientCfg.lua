<?
function Event.RegLoginEvent.registInit(player)
    -- 基础模块
    Client.RunABundle(player, "Image.lua")
    Client.RunABundle(player, "Animation.lua")
    Client.RunABundle(player, "StaticText.lua")
    Client.RunABundle(player, "Button.lua")
    Client.RunABundle(player, "Radio.lua")
    Client.RunABundle(player, "Window.lua")
    Client.RunABundle(player, "MyJson.lua")
    Client.RunABundle(player, "Util.lua")


    -- 业务模块
    Client.RunABundle(player, "Vip.lua")
    Client.RunABundle(player, "Proficient.lua")
    Client.RunABundle(player, "Synthesis.lua")
    Client.RunABundle(player, "Pk.lua")
    Client.RunABundle(player, "Awakening.lua")
    Client.RunABundle(player, "Task.lua")
    Client.RunABundle(player, "Recover.lua")
    Client.RunABundle(player, "Warp.lua")
    Client.RunABundle(player, "PartyBuff.lua")
end
?>