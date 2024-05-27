tbl_MateChage_select = {};
Delegate.RegInit("MateChage_Init");
Delegate.RegDelAllOutEvent("MateChage_Out");

function MateChageNpc_Init(index)
	return 1;
end

--%����_����% 1
--%����_ԭ��% 2
--%����_��ͼ%	4
--%����_X%	5
--%����_Y%	6
--%����_����%	7
--%����_ԭ��%	2000
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
	local _zc1 = Item.GetData(_itemindex, 46); -- %����_�Ӳ�һ% 46
	tbl_MateChage_select[Playerkey(charPointer)] = slot;

	if (_zc1 == 1) then
		--�������
		--%����_�Ӳζ�% 47
		str_ChangeWindow = "" .. tonumber(Item.GetData(_itemindex, 47)) .. "|�뿴���ҵ�����Ŀô�������֮��Ϳ����Լ�����������\\n\\nȷ��������������Ϊ������ô��\\n\\n";
		NLG.ShowWindowTalked(charPointer, tonumber(tbl_MateChageNpc["MateChageNpc"]), 37, 1 + 2, 10, str_ChangeWindow); -- %��ť_ȷ��% 1 %��ť_�ر�% 2
		return ;
	end

	if (_zc1 == 2) then
		--�������
		str_ChangeWindow = "4|\\n\\n 			 \\n	 			������Ҫ���������������ֻ�����ϣ�\\n\\n";
		for i = 0, 4 do
			local pet = Char.GetPet(charPointer, i);
			if (VaildChar(pet)) then
				str_ChangeWindow = str_ChangeWindow .. " 			 			" .. Char.GetData(pet, 2000) .. "\\n"; -- %����_ԭ��% 2000

			else
				str_ChangeWindow = str_ChangeWindow .. " 			 			��\\n";
			end
		end
		NLG.ShowWindowTalked(charPointer, tonumber(tbl_MateChageNpc["MateChageNpc"]), 2, 2, 20, str_ChangeWindow);--%����_ѡ���% 2
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
			local _zc2 = tonumber(Item.GetData(_itemindex, 47)); -- %����_�Ӳζ�% 47
			Char.SetData(_PlayerIndex, 1, _zc2);--%����_����% 1
			Char.SetData(_PlayerIndex, 2, _zc2);--%����_ԭ��% 2
			Char.SetData(_PlayerIndex, 178, _zc2);--%����_ԭʼͼ��% 178
			NLG.UpChar(_PlayerIndex);
			NLG.SystemMessage(_PlayerIndex, "��ϲ�㣬����ɹ�����");
			Item.Kill(_PlayerIndex, _itemindex, s);

		else
			NLG.SystemMessage(_PlayerIndex, "δ֪����������ʹ�ã�");

		end
		tbl_MateChage_select[Playerkey(_PlayerIndex)] = nil;

	end

	if (tonumber(_seqno) == 20 and (_data ~= "")) then
		local selectitem = tonumber(_data) - 1;
		if (selectitem == nil or (selectitem ~= nil and (selectitem > 4 or selectitem < 0))) then
			NLG.ShowWindowTalked(_PlayerIndex, _PlayerIndex, 0, 2, 1, "\\n\\n\\n����ѡ���λ�ò�����!");--%����_��Ϣ��% 0 %��ť_�ر�% 2
			return ;
		end
		local pet_indexA = Char.GetPet(_PlayerIndex, selectitem);
		if (pet_indexA == 0) then
			NLG.ShowWindowTalked(_PlayerIndex, _MeIndex, 0, 2, 1, "\\n\\n\\n��ȷ������Ӧ�ĳ������г���!");
			return ;
		end

		if (tbl_MateChage_select[Playerkey(_PlayerIndex)] ~= nil) then
			local s = tonumber(tbl_MateChage_select[Playerkey(_PlayerIndex)]);
			local _itemindex = Char.GetItemIndex(_PlayerIndex, s);
			local _zc2 = tonumber(Item.GetData(_itemindex, 47));-- %����_�Ӳζ�% 47
			--NLG.SystemMessage(_PlayerIndex,Char.GetData(pet_indexA,%����_����%).." "..Char.GetData(pet_indexA,%����_ԭ��%).." "..Char.GetData(pet_indexA,%����_ԭʼͼ��%));



			if (_zc2 == 0) then
				_zc2 = Char.GetData(pet_indexA, 178); -- %����_ԭʼͼ��%	178
				if (_zc2 ~= 0) then
					Char.SetData(pet_indexA, 1, _zc2);--%����_����% 1
					Char.SetData(pet_indexA, 2, _zc2);--%����_ԭ��% 2
					Pet.UpPet(_PlayerIndex, pet_indexA);
					Item.Kill(_PlayerIndex, _itemindex, s);
					Char.SetData(pet_indexA, 178, 0);--%����_ԭʼͼ��% 178
					NLG.SystemMessage(_PlayerIndex, "��ϲ�㣬���ﻹԭ�ɹ���");
					return ;
				else
					NLG.SystemMessage(_PlayerIndex, "�Ѿ���ԭ������ò�ˣ��޷���ԭ��");
					return ;

				end
				return ;
			end

			if (Char.GetData(pet_indexA, 178) == 0) then
				--%����_ԭʼͼ��% 178
				Char.SetData(pet_indexA, 178, Char.GetData(pet_indexA, 178));
			end

			Char.SetData(pet_indexA, 1, _zc2);--%����_����% 1
			Char.SetData(pet_indexA, 2, _zc2);--%����_ԭ��% 2
			--NLG.SystemMessage(_PlayerIndex,Char.GetData(pet_indexA,%����_����%).." "..Char.GetData(pet_indexA,%����_ԭ��%).." "..Char.GetData(pet_indexA,%����_ԭʼͼ��%));


			Pet.UpPet(_PlayerIndex, pet_indexA);
			Item.Kill(_PlayerIndex, _itemindex, s);

			NLG.SystemMessage(_PlayerIndex, "��ϲ�㣬�������ɹ���");

		else
			NLG.SystemMessage(_PlayerIndex, "δ֪����������ʹ�ã�");
		end
		tbl_MateChage_select[Playerkey(_PlayerIndex)] = nil;
	end
end