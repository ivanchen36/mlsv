DropPlayers = DropPlayers or {};

Delegate.RegDelLoginEvent("DPlayer_LoginEvent");
Delegate.RegDelAllOutEvent("DPlayer_LogoutEvent");
Delegate.RegDelTalkEvent("DPlayer_TalkEvent");

function DPlayer_LoginEvent(player)
	DropPlayers[player] = player;

end

function DPlayer_LogoutEvent(player)

	DropPlayers[player] = nil;
end

function DPlayer_TalkEvent(player,msg,color,range,size)
	if (msg == "[allout2]") then
		if tonumber(Char.GetData(player,%����_GM%)) < 1 then
			return;
		end
		
		for k,v in pairs(DropPlayers) do
			if v ~= nil and v ~= player then
				NLG.DropPlayer(v)
			end
		end
		NLG.SystemMessage(player, "[��ʾ]�Ѿ��ߵ�ȫ�����.")
	end
end