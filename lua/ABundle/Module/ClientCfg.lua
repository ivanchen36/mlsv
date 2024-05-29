<?
function Event.RegTalkEvent.showVip(player, msg, color, font)
    if msg == '/9' then
        Client.WaitABRunScript(player,'showVip()');
    end
end

function Event.RegLoginEvent.registInit(player)
    Client.RunABundle(player, "Image.lua")
    Client.RunABundle(player, "StaticText.lua")
    Client.RunABundle(player, "Button.lua")
    Client.RunABundle(player, "Window.lua")
    Client.RunABundle(player, "Util.lua")
    Client.RunABundle(player, "Vip.lua")
    Client.RunABundle(player, "ClientCfg.lua")
end
?>