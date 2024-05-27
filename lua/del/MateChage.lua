tbl_MateChage_select = {};
Delegate.RegInit("MateChage_Init");
Delegate.RegDelAllOutEvent("MateChage_Out");

function MateChageNpc_Init(index)
	return 1;
end

--%对象_形象% 1
--%对象_原形% 2
--%对象_地图%	4
--%对象_X%	5
--%对象_Y%	6
--%对象_方向%	7
--%对象_原名%	2000
function initMateChageNpc()
	tbl_MateChageNpc = {};
	if (MateChageNpc == nil) then
		MateChageNpc = NL.CreateNpc("lua/Module/MateChage.lua", "MateChageNpc_Init");
		Char.SetData(MateChageNpc, 1, 231088);
		Char.SetData(MateChageNpc, 2, 231088);
		Char.SetData(MateChageNpc, 5, 48);
		Char.SetData(MateChageNpc, 6, 48);
		Char.SetData(MateChageNpc, 4, 777);
		Char.SetData(MateChageNpc, 7, 4);
		Char.SetData(MateChageNpc, 2000, "MateChageNpc");
		NLG.UpChar(MateChageNpc);
		--Char.SetTalkedEvent("lua/Module/MateChage.lua","MateChageNpcTalk_Event", MateChageNpc);
		Char.SetWindowTalkedEvent("lua/Module/MateChage.lua", "MateChageNpcWinTalk_Event", MateChageNpc);
		tbl_MateChageNpc["MateChageNpc"] = tonumber(MateChageNpc);
	end

end

function MateChage_Init()
	initMateChageNpc();
	NL.RegItemString("lua/Module/MateChage.lua", "MateChage_Event", "LUA_useM1");
end

function MateChage_Out(player)
	tbl_MateChage_select[Playerkey(player)] = nil;
end

function MateChage_Event(charPointer, toPlayerPointer, slot)

	local _itemindex = Char.GetItemIndex(charPointer, slot);
	local _zc1 = Item.GetData(_itemindex, 46); -- %道具_子参一% 46
	tbl_MateChage_select[Playerkey(charPointer)] = slot;

	if (_zc1 == 1) then
		--人物变身卡
		--%道具_子参二% 47
		str_ChangeWindow = "" .. tonumber(Item.GetData(_itemindex, 47)) .. "|想看到我的真面目么，你变身之后就可以自己看个够啦！\\n\\n确定将人物形象变成为我这样么？\\n\\n";
		NLG.ShowWindowTalked(charPointer, tonumber(tbl_MateChageNpc["MateChageNpc"]), 37, 1 + 2, 10, str_ChangeWindow); -- %按钮_确定% 1 %按钮_关闭% 2
		return ;
	end

	if (_zc1 == 2) then
		--宠物变身卡
		str_ChangeWindow = "4|\\n\\n 			 \\n	 			请问你要将宠物变身卡用在哪只宠物上？\\n\\n";
		for i = 0, 4 do
			local pet = Char.GetPet(charPointer, i);
			if (VaildChar(pet)) then
				str_ChangeWindow = str_ChangeWindow .. " 			 			" .. Char.GetData(pet, 2000) .. "\\n"; -- %对象_原名% 2000

			else
				str_ChangeWindow = str_ChangeWindow .. " 			 			空\\n";
			end
		end
		NLG.ShowWindowTalked(charPointer, tonumber(tbl_MateChageNpc["MateChageNpc"]), 2, 2, 20, str_ChangeWindow);--%窗口_选择框% 2
		return ;
	end

	tbl_MateChage_select[Playerkey(charPointer)] = nil;

end

function MateChageNpcWinTalk_Event(_MeIndex, _PlayerIndex, _seqno, _select, _data)

	if (tonumber(_select) == 2) then
		return ;
	end

	if (tonumber(_seqno) == 10 and tonumber(_select) == 1) then

		if (tbl_MateChage_select[Playerkey(_PlayerIndex)] ~= nil) then
			local s = tonumber(tbl_MateChage_select[Playerkey(_PlayerIndex)]);
			local _itemindex = Char.GetItemIndex(_PlayerIndex, s);
			local _zc2 = tonumber(Item.GetData(_itemindex, 47)); -- %道具_子参二% 47
			Char.SetData(_PlayerIndex, 1, _zc2);--%对象_形象% 1
			Char.SetData(_PlayerIndex, 2, _zc2);--%对象_原形% 2
			Char.SetData(_PlayerIndex, 178, _zc2);--%对象_原始图档% 178
			NLG.UpChar(_PlayerIndex);
			NLG.SystemMessage(_PlayerIndex, "恭喜你，变身成功啦！");
			Item.Kill(_PlayerIndex, _itemindex, s);

		else
			NLG.SystemMessage(_PlayerIndex, "未知错误，请重新使用！");

		end
		tbl_MateChage_select[Playerkey(_PlayerIndex)] = nil;

	end

	if (tonumber(_seqno) == 20 and (_data ~= "")) then
		local selectitem = tonumber(_data) - 1;
		if (selectitem == nil or (selectitem ~= nil and (selectitem > 4 or selectitem < 0))) then
			NLG.ShowWindowTalked(_PlayerIndex, _PlayerIndex, 0, 2, 1, "\\n\\n\\n您所选择的位置不正常!");--%窗口_信息框% 0 %按钮_关闭% 2
			return ;
		end
		local pet_indexA = Char.GetPet(_PlayerIndex, selectitem);
		if (pet_indexA == 0) then
			NLG.ShowWindowTalked(_PlayerIndex, _MeIndex, 0, 2, 1, "\\n\\n\\n请确定您对应的宠物栏有宠物!");
			return ;
		end

		if (tbl_MateChage_select[Playerkey(_PlayerIndex)] ~= nil) then
			local s = tonumber(tbl_MateChage_select[Playerkey(_PlayerIndex)]);
			local _itemindex = Char.GetItemIndex(_PlayerIndex, s);
			local _zc2 = tonumber(Item.GetData(_itemindex, 47));-- %道具_子参二% 47
			--NLG.SystemMessage(_PlayerIndex,Char.GetData(pet_indexA,%对象_形象%).." "..Char.GetData(pet_indexA,%对象_原形%).." "..Char.GetData(pet_indexA,%对象_原始图档%));



			if (_zc2 == 0) then
				_zc2 = Char.GetData(pet_indexA, 178); -- %对象_原始图档%	178
				if (_zc2 ~= 0) then
					Char.SetData(pet_indexA, 1, _zc2);--%对象_形象% 1
					Char.SetData(pet_indexA, 2, _zc2);--%对象_原形% 2
					Pet.UpPet(_PlayerIndex, pet_indexA);
					Item.Kill(_PlayerIndex, _itemindex, s);
					Char.SetData(pet_indexA, 178, 0);--%对象_原始图档% 178
					NLG.SystemMessage(_PlayerIndex, "恭喜你，宠物还原成功！");
					return ;
				else
					NLG.SystemMessage(_PlayerIndex, "已经是原来的相貌了，无法还原。");
					return ;

				end
				return ;
			end

			if (Char.GetData(pet_indexA, 178) == 0) then
				--%对象_原始图档% 178
				Char.SetData(pet_indexA, 178, Char.GetData(pet_indexA, 178));
			end

			Char.SetData(pet_indexA, 1, _zc2);--%对象_形象% 1
			Char.SetData(pet_indexA, 2, _zc2);--%对象_原形% 2
			--NLG.SystemMessage(_PlayerIndex,Char.GetData(pet_indexA,%对象_形象%).." "..Char.GetData(pet_indexA,%对象_原形%).." "..Char.GetData(pet_indexA,%对象_原始图档%));


			Pet.UpPet(_PlayerIndex, pet_indexA);
			Item.Kill(_PlayerIndex, _itemindex, s);

			NLG.SystemMessage(_PlayerIndex, "恭喜你，宠物变身成功！");

		else
			NLG.SystemMessage(_PlayerIndex, "未知错误，请重新使用！");
		end
		tbl_MateChage_select[Playerkey(_PlayerIndex)] = nil;
	end
end