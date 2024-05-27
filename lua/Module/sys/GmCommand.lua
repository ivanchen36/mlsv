GmTalkEvent["[allout2]"] = function (player)
        for k,v in pairs(DropPlayers) do
        if v ~= nil and v ~= player then
        NLG.DropPlayer(v)
        end
        end
        NLG.SystemMessage(player, "[提示]已经踢掉全部玩家.")
end