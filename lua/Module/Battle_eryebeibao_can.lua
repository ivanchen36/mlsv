




beibaoTable = {}
beibaoTable.conf = {1,1,1,1,1,1,1,1,1,1,1} -- ������ҳд����1
beibaoTable.Num = 1   -- Ĭ�ϼ�����չ����
beibaoTable.special = {18588,588151,16438,16424,16417,16416,41214,41215,41216,41217,41218,41219,41220,41221,200225,200214,200205,18575,18246,533} -- ��д �������id


beibaoTable.ban = {9611,9612 }  -- �����Դ���ĵ���


--����?	������չ				LUA_usebeibaoItemUse						1455	99129		26		0	1	0	0	1	1	1	1	0					0	0																																																										0	0	1			0			100	0	0			0







NL.RegItemString(nil,"ItemUsebeibao_Event","LUA_usebeibaoItemUse"); --

function ItemUsebeibao_Event(_PlayerIndex,Target,haveitemindex) --����˫��

	local Itemindex =  Char.GetItemIndex(_PlayerIndex,haveitemindex);
	local ItemID = Item.GetData(Itemindex, %����_ID%)
	local Num = tonumber(Field.Get(_PlayerIndex,"Iteme_Num")) or beibaoTable.Num
	if Num > 9 then 
		NLG.SystemMessage(_PlayerIndex,"[ϵͳ] �Ѿ��ﵽ����")
		return
	else
		Field.Set(_PlayerIndex,"Iteme_Num",Num+1)	
		Char.DelItem(_PlayerIndex,ItemID,1)
		NLG.SystemMessage(_PlayerIndex,"[ϵͳ] ������չ���")
	end	
end

---------------------------------------------------------------------

	--using("Battle_eryebeibao",true)
	