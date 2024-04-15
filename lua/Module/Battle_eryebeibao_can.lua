




beibaoTable = {}
beibaoTable.conf = {1,1,1,1,1,1,1,1,1,1,1} -- 开启几页写几个1
beibaoTable.Num = 1   -- 默认几个扩展背包
beibaoTable.special = {18588,588151,16438,16424,16417,16416,41214,41215,41216,41217,41218,41219,41220,41221,200225,200214,200205,18575,18246,533} -- 填写 特殊道具id


beibaoTable.ban = {9611,9612 }  -- 不可以存入的道具


--道具?	背包扩展				LUA_usebeibaoItemUse						1455	99129		26		0	1	0	0	1	1	1	1	0					0	0																																																										0	0	1			0			100	0	0			0







NL.RegItemString(nil,"ItemUsebeibao_Event","LUA_usebeibaoItemUse"); --

function ItemUsebeibao_Event(_PlayerIndex,Target,haveitemindex) --道具双击

	local Itemindex =  Char.GetItemIndex(_PlayerIndex,haveitemindex);
	local ItemID = Item.GetData(Itemindex, %道具_ID%)
	local Num = tonumber(Field.Get(_PlayerIndex,"Iteme_Num")) or beibaoTable.Num
	if Num > 9 then 
		NLG.SystemMessage(_PlayerIndex,"[系统] 已经达到上限")
		return
	else
		Field.Set(_PlayerIndex,"Iteme_Num",Num+1)	
		Char.DelItem(_PlayerIndex,ItemID,1)
		NLG.SystemMessage(_PlayerIndex,"[系统] 包裹扩展完毕")
	end	
end

---------------------------------------------------------------------

	--using("Battle_eryebeibao",true)
	