Delegate.RegDelLoginEvent("antiDName_LoginEvent");
function antiDName_LoginEvent(player)
	local tname = Char.GetData(player,%����_����%);
	local query = "SELECT count(*) FROM tbl_character WHERE Name ='"..tname.."'";
	local resset = SQL.Run(query);
	local GetNum = tonumber(resset["0_0"]);
	if GetNum ~= 1 then
		local tcdkey = Char.GetData(player,%����_�˺�%);
		if string.sub(tcdkey, 1, 3)~= "yb_" then 
			local query2 = "update tbl_user set EnableFlg ='0',AccountPassword ='block_PPP' where Cdkey ='"..tcdkey.."';";
			SQL.Run(query2);
			--NLG.SystemMessage(player,"�������ˣ������������ϵȺ����");
			NLG.DropPlayer(player); 
			return;
		end
	end
end


