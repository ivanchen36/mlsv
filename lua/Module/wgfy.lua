
---------------------------------------------------
Delegate.RegInit("wgfy_Init");

function initwgfyNpc_Init(index)
	print("vipnpc_index = " .. index);
	return 1;
end

function initwgfyNpc()
	if (wgfys == nil) then
		wgfys = NL.CreateNpc("lua/Module/wgfy.lua", "initwgfyNpc_Init");
		Char.SetData(wgfys,%����_����%,NPCwgfy[1]);
		Char.SetData(wgfys,%����_ԭ��%,NPCwgfy[1]);
		Char.SetData(wgfys,%����_X%,NPCwgfy[3]);
		Char.SetData(wgfys,%����_Y%,NPCwgfy[4]);
		Char.SetData(wgfys,%����_��ͼ%,NPCwgfy[2]);
		Char.SetData(wgfys,%����_����%,NPCwgfy[5]);
		Char.SetData(wgfys,%����_ԭ��%,"������ӡʦ");
		NLG.UpChar(wgfys);
		Char.SetWindowTalkedEvent("lua/Module/wgfy.lua","wgfysA",wgfys);
		Char.SetTalkedEvent("lua/Module/wgfy.lua","wgfyMsg", wgfys);
	end
end

function wgfyMsg(_me,_tome)
	if (NLG.CanTalk(_me,_tome) == true) then
		str_ChangeWindow = "6|\\n\\n    ���߷�ӡʦ֮����\\n    ˭��ץ���ö��ļ�Ʒ���˭�ͽ���ý�����\\n\\n    ������"..wgfy_gold[1].."��    1����"..wgfy_gold[2].."��    2����"..wgfy_gold[3].."��\\n\\n               ���ǼǶ�Ӧħ�\\n               ���鿴ħ��Ŀ¼��";
		NLG.ShowWindowTalked(_tome,_me,%����_ѡ���%,%��ť_�ر�%,12,str_ChangeWindow);
		return;
	end
end

function wgfy_pet(id)
	local pet = Data.EnemyTempGetIndex(id);

	if(pet >= 0)then
		local xingxiang = Data.EnemyTempGetData(pet,29);
		return xingxiang;	
	else
		return 0;
	end
end


function wgfysA(_MeIndex,_PlayerIndex,_seqno,_select,_data)

	if(_select == 2)then
		return;
	end
	
	local _data = tonumber(_data)-1;

	
	---------------ȷ�ϴ���--------------------
	if(_data == 0 and _seqno == 12)then
		str_ChangeWindow = "3|\\n\\n    ����Ǽ���ֻħ���أ�\\n\\n";

		for i=0,4 do
			local pet_indexA = Char.GetPet(_PlayerIndex,i);
			if(pet_indexA >= 0)then
				local a6 = dangci(pet_indexA)
				if(a6 <= 2 )then
					str_ChangeWindow = str_ChangeWindow.."        "..kongge(Char.GetData(pet_indexA,%����_����%),6).."  "..kong(a6,1).."�� (��)\\n";
				else
					str_ChangeWindow = str_ChangeWindow.."        "..kongge(Char.GetData(pet_indexA,%����_����%),6).."  "..kong(a6,1).."�� (��)\\n";
				end
			else
			
				str_ChangeWindow = str_ChangeWindow.."        �޳���\\n";

			end
		end
		
		NLG.ShowWindowTalked(_PlayerIndex,_MeIndex,%����_ѡ���%,%��ť_�ر�%,13,str_ChangeWindow);
		return;
	end
	---------------ȷ�ϴ���--------------------
	
	----------��ѯ��������ҳ----------------
	
	if(_data == 1 and _seqno == 12)then
		web = "http://"..wgfy_http.."/wgfy.php";
		for i = 1,#wgfy_db do
		
			local x = wgfy_pet(wgfy_db[i]);
			if(x ~= 0)then
				local resset = SQL.Run("SELECT * FROM wgfy WHERE id = '"..wgfy_db[i].."'");
				if(type(resset)=="table")then
				
				else
					SQL.Run("INSERT INTO wgfy VALUES ('"..wgfy_db[i].."','','"..wgfy_pet(wgfy_db[i]).."','0','0','0')");
				end
			end

		end
		open_url(_PlayerIndex,web);
		return;
	end
	
	----------��ѯ��������ҳ----------------
	

	----------������Ӧ����----------------
	if(_data >= 0 and _seqno == 13)then
		local pet_indexA = Char.GetPet(_PlayerIndex,_data);
		wgfy_off = 0;
		if(pet_indexA >= 0)then
			
			for i = 1,#wgfy_db do
		
				if(wgfy_pet(wgfy_db[i]) == Char.GetData(pet_indexA,%����_ԭ��%))then
					wgfy_off = 1;
					break;
				end
			end

			if(wgfy_off == 0)then
				NLG.SystemMessage(_PlayerIndex,"��������ħ���޷����еǼǣ���鿴ħ��Ŀ¼��Ѱ�ɵǼǵ�ħ�");
				return;
			end
			
			local a6 = dangci(pet_indexA)

			if(a6 <= 2)then

				local sql = "SELECT * FROM wgfy WHERE xingxiang = '"..Char.GetData(pet_indexA,%����_ԭ��%).."' and  dang"..a6.." = '1' ";
				local resset = SQL.Run(sql);
				
				if(type(resset)=="table")then
					NLG.SystemMessage(_PlayerIndex,""..a6.."���ġ�"..Char.GetData(pet_indexA,%����_����%).."���Ѿ����Ǽ��ˣ�");
				else
				
					if(Char.ItemSlot(_PlayerIndex)==20)then
						NLG.SystemMessage(_PlayerIndex,"���ı������ˣ�������������");
						return;
					end
					
					if(Char.GetData(pet_indexA,%����_�ȼ�%) ~= 1) then
						NLG.SystemMessage(_PlayerIndex,"����1������,�޷��ύ��");
						return;
					end
					--NLG.SystemMessage(-1,""..a6.."���ġ�"..Char.GetData(pet_indexA,%����_����%).."�������["..Char.GetData(_PlayerIndex,%����_����%).."]�Ǽ��ˣ���ý𿨽�����");
					Char.GiveItem(_PlayerIndex,vipitemid,wgfy_gold[a6+1]);
					local sql = SQL.Run("UPDATE wgfy SET dang"..a6.." = '1' WHERE xingxiang = '"..Char.GetData(pet_indexA,%����_ԭ��%).."' ");
					NLG.SystemMessage(-1,""..a6.."���ġ�"..Char.GetData(pet_indexA,%����_����%).."�������["..Char.GetData(_PlayerIndex,%����_����%).."]�Ǽ��ˣ���ý𿨽�����");
				end
			else
				NLG.SystemMessage(_PlayerIndex,"��ֻħ�ﲻ����ǼǱ�׼��ֻ��������һ����������ħ����Խ����״εǼǣ�");
			end
			return;
		else
			NLG.SystemMessage(_PlayerIndex,"��λ����ħ�");
			return;
		end
	end
	----------������Ӧ����----------------
	
	
end


function dangci(pet_indexA)
	local arr_rank1 = Pet.GetArtRank(pet_indexA,%�赵_���%);
	local arr_rank11 = Pet.FullArtRank(pet_indexA,%�赵_���%);
	local arr_rank2 = Pet.GetArtRank(pet_indexA,%�赵_����%);
	local arr_rank21 = Pet.FullArtRank(pet_indexA,%�赵_����%);
	local arr_rank3 = Pet.GetArtRank(pet_indexA,%�赵_ǿ��%);
	local arr_rank31 = Pet.FullArtRank(pet_indexA,%�赵_ǿ��%);
	local arr_rank4 = Pet.GetArtRank(pet_indexA,%�赵_����%);
	local arr_rank41 = Pet.FullArtRank(pet_indexA,%�赵_����%);
	local arr_rank5 = Pet.GetArtRank(pet_indexA,%�赵_ħ��%);
	local arr_rank51 = Pet.FullArtRank(pet_indexA,%�赵_ħ��%);
	local a1 = math.abs(arr_rank1 - arr_rank11);
	local a2 = math.abs(arr_rank2 - arr_rank21);
	local a3 = math.abs(arr_rank3 - arr_rank31);
	local a4 = math.abs(arr_rank4 - arr_rank41);
	local a5 = math.abs(arr_rank5 - arr_rank51);
	local a6 = a1 + a2+ a3+ a4+ a5;
	return a6;
end

---�ո��������
function kongge(petnax,shu)

	local petnaxc = string.len(petnax)/2; 
	konggex = "";

	for i=petnaxc,shu do
		konggex = konggex.."��";
	end
	
	fanhui = petnax..""..konggex;
	return fanhui;
end
---�ո��������
function kong(petnax,shu)

	local petnaxc = string.len(petnax); 
	konggex = "";

	for i=petnaxc,shu do
		konggex = konggex.." ";
	end
	
	fanhui = petnax..""..konggex;
	return fanhui;
end
function open_url(player,link)
	Protocol.SendLuaCustomPacket(player,"openurl", link);
end
function wgfy_Init()
	initwgfyNpc();
end