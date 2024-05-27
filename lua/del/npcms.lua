
function setinfo(i,name,title)
	 if Char.GetData(i,%对象_名字%) == name then
		Char.SetData(i,%对象_玩家称号%,title)
	end	
end

-- [种类] = 颜色;
tbl_npc_color = {
	[54] = 5;
	[2] = 4;
}

function MyForeachNpc(CharIndex)
	local object_x = Char.GetData(CharIndex,%对象_序%);
    if(object_x ~= nil and (object_x == 2 or object_x >=4) )then
	    NLG.SetShowName(CharIndex,1)
		if tbl_npc_color[object_x] ~= nil then
	       	Char.SetData(CharIndex,%对象_名色%,tbl_npc_color[object_x])
		else
	       	Char.SetData(CharIndex,%对象_名色%,6) --默认6颜色
		end
		Char.SetData(CharIndex,%对象_称号%,4166)
		Char.SetData(CharIndex,%对象_玩家称号%,"NPC")
		
		setinfo(CharIndex,"雇佣兵","NPC可雇佣佣兵")
		setinfo(CharIndex,"打卡处","NPC可以打卡")
		--NLG.UpChar(CharIndex)
    end
 	 return 0
end

Foreach.Npc(MyForeachNpc); -- 对所有NPC角色批量执行NpcFunction
