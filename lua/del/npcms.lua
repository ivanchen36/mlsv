
function setinfo(i,name,title)
	 if Char.GetData(i,%����_����%) == name then
		Char.SetData(i,%����_��ҳƺ�%,title)
	end	
end

-- [����] = ��ɫ;
tbl_npc_color = {
	[54] = 5;
	[2] = 4;
}

function MyForeachNpc(CharIndex)
	local object_x = Char.GetData(CharIndex,%����_��%);
    if(object_x ~= nil and (object_x == 2 or object_x >=4) )then
	    NLG.SetShowName(CharIndex,1)
		if tbl_npc_color[object_x] ~= nil then
	       	Char.SetData(CharIndex,%����_��ɫ%,tbl_npc_color[object_x])
		else
	       	Char.SetData(CharIndex,%����_��ɫ%,6) --Ĭ��6��ɫ
		end
		Char.SetData(CharIndex,%����_�ƺ�%,4166)
		Char.SetData(CharIndex,%����_��ҳƺ�%,"NPC")
		
		setinfo(CharIndex,"��Ӷ��","NPC�ɹ�ӶӶ��")
		setinfo(CharIndex,"�򿨴�","NPC���Դ�")
		--NLG.UpChar(CharIndex)
    end
 	 return 0
end

Foreach.Npc(MyForeachNpc); -- ������NPC��ɫ����ִ��NpcFunction
