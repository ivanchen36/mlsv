tbl_TJitemset = {} --{��Ʒid,����,����(ǧ�ֱ�)}
tbl_TJitemset[0] = {88888,500,1000};--������Ʒ����
tbl_TJitemset[1] = {88888,500,160};--��1��Ʒ����
tbl_TJitemset[2] = {88888,500,160};--��2��Ʒ����
tbl_TJitemset[3] = {88888,500,160};--��3��Ʒ����
tbl_TJitemset[4] = {88888,500,160};--��4��Ʒ����
tbl_TJitemset[5] = {88888,500,160};--��5��Ʒ����
tbl_TJitemset[6] = {88888,500,160};--��6��Ʒ����

battle_enemytotallv = 1;--��������ۺϵȼ�
tbl_TJtime = "16:35:00";--�콵���ʼʱ��

tbl_item_actionset = tbl_item_actionset or {0,0,0,0,0,0,0,"",""};
tbl_itemset = tbl_itemset or {};
tbl_battle_enemytotallv = tbl_battle_enemytotallv or {};

function Myinit(_MeIndex)
	return true;
end


Delegate.RegInit("ActioninfoNpc_id26_Create");

function ActioninfoNpc_id26_Create()
	if (ActioninfoNpc_id26 == nil) then
		ActioninfoNpc_id26 = NL.CreateNpc("lua/Module/actioninfonpc.lua", "Myinit");
		Char.SetData(ActioninfoNpc_id26,%����_����%,14575);
		Char.SetData(ActioninfoNpc_id26,%����_ԭ��%,14575);
		Char.SetData(ActioninfoNpc_id26,%����_X%,1);
		Char.SetData(ActioninfoNpc_id26,%����_Y%,9);
		Char.SetData(ActioninfoNpc_id26,%����_��ͼ%,777);
		Char.SetData(ActioninfoNpc_id26,%����_����%,6);
		Char.SetData(ActioninfoNpc_id26,%����_����%,"a");
		NLG.UpChar(ActioninfoNpc_id26);
		Char.SetLoopEvent("lua/Module/actioninfonpc.lua","ActioninfoNpc_id26_LoopEvent", ActioninfoNpc_id26,1000);
		LoadItemsetData()
	end
end


function ActioninfoNpc_id26_LoopEvent(_npc)
	local num = tonumber(os.date("%w",os.time()));
	if os.date("%X",os.time()) == tbl_TJtime and tbl_TJitemset[num] ~= nil then
		NLG.SystemMessage(-1,"[ϵͳ��ʾ] ϵͳ���Զ������콵������");
		GMF_setaction_item(nil,1,tbl_TJitemset[num][1],tbl_TJitemset[num][2],tbl_TJitemset[num][3],-1,1);
	end
	
	
end
Delegate.RegDelBattleOverEvent("RBattleOverEvent");
Delegate.RegDelBattleStartEvent("RBattleStartEvent");



function RBattleStartEvent( _btlp)
	if ((Battle.GetGainMode( _btlp)==%ս��_��ͨ%) and (Battle.GetType( _btlp)==%ս��_��ͨ%)) then
		tbl_battle_enemytotallv[_btlp] = 0;
		for i = 10,19 do
			local _enemy = Battle.GetPlayer(_btlp,i);
			if (_enemy ~= -1) and (_enemy ~= nil) then
				tbl_battle_enemytotallv[_btlp] = tbl_battle_enemytotallv[_btlp] + Char.GetData(_enemy,%����_�ȼ�%);
			end
		end
	end
	
end
function RBattleOverEvent( _btlp)

	
	for i=0,9 do 
		local RBO_player = Battle.GetPlayer(_btlp,i);
		if (RBO_player ~= nil) and (RBO_player ~= -1)  then
			if (Char.GetData(RBO_player,%����_ս��%) == 0 and (Char.GetData(RBO_player,%����_��%) == %��������_��%) and (Battle.GetGainMode(_btlp)==%ս��_��ͨ%) and (Battle.GetType(_btlp)==%ս��_��ͨ%)) then 
				if (tbl_item_actionset[1] == 1) and (tbl_battle_enemytotallv[_btlp] >= battle_enemytotallv) then
					local _item_id = tbl_item_actionset[2]; 
					local _item_count = tbl_item_actionset[3];
					local _item_rd = tbl_item_actionset[4]; 
					local _item_time = tbl_item_actionset[5]; 
					local _item_an = tbl_item_actionset[6]; 
					local _item_opentime = tbl_item_actionset[7]; 
					local _item_name = tbl_item_actionset[8];

					if (_item_time~= -1) and (_item_opentime + _item_time < os.time()) then
						tbl_item_actionset[1] = 0;
						NLG.SystemMessage(-1,"[ϵͳ��ʾ] �콵����ʱ���ѵ�����Զ��رգ�ף�����Ϸ����");
					else
						if Char.ItemSlot(RBO_player) < 20 then
							if _item_count ~= 0 then
								local _myrd = math.random(1,1000);
								if _myrd <= _item_rd then
									local _item = GiveItem(RBO_player,_item_id);
									if _item_count ~= -1 then
										tbl_item_actionset[3] = tbl_item_actionset[3] - 1;
										if tbl_item_actionset[3] < 0 then tbl_item_actionset[3] = 0 end
									end									
									NLG.SystemMessage(RBO_player,"[ϵͳ] ��ϲ������콵���".._item_name);
									if _item_an == 1 then
										NLG.SystemMessage(-1,"[ϵͳ��ʾ]��"..Char.GetData(RBO_player,%����_����%).."�����"..tbl_item_actionset[9].."�������콵���".._item_name.."(ʣ"..tbl_item_actionset[3]..")");
									end
									
								end
							else
								tbl_item_actionset[1] = 0;
								NLG.SystemMessage(-1,"[ϵͳ��ʾ] �콵������ȫ���������ȡ�꣬��Զ��رգ�ף�����Ϸ����");
							end
						end
					end
				end
			end
		end
	end
	
end



function GMF_setaction_item(_me,_var1,_var2,_var3,_var4,_var5,_var6,_var7)
	if tonumber(_var1) == 0 then
		for i = 1,7 do
			tbl_item_actionset[i] = 0;
		end
		if _me ~= nil then
			NLG.TalkToCli(_me,-1,"[ϵͳ] ȫ�����߽�����ѳɹ��رգ�");
		end
		NLG.SystemMessage(-1,"[ϵͳ] ϵͳ�ر����콵������")
		return;
	end
	local _type = tonumber(_var1);
	local _itemid = tonumber(_var2);
	local _count = tonumber(_var3);
	local _rd = tonumber(_var4);
	local _time = tonumber(_var5);
	local _an = tonumber(_var6);
	local _itemname = "";
	local _openname = "ϵͳ";
	if _var7 ~= nil then
		_openname = _var7;
	end

	if (_type == nil) or (_itemid == nil) or (_count  == nil) or (_rd == nil) or (_time == nil) or (_an == nil) then
		NLG.TalkToCli(_me,-1,"[Error] ��������");
		return;
	else
		if (_type ~= 1) then
			NLG.TalkToCli(_me,-1,"[Error] ���Ͳ������ô���ֻ������1��");
			return;
		end
		if _itemid < 0 then
			NLG.TalkToCli(_me,-1,"[Error] ���߱�����ô��󣡱������ô��ڵ���0������");
			return;
		end
		if (_count <= 0) and (_count ~= -1) then
			NLG.TalkToCli(_me,-1,"[Error] �����������ô���ֻ������-1���ߴ���0����");
			return;
		end
		if (_rd <= 0) or (_rd > 1000) then
			NLG.TalkToCli(_me,-1,"[Error] �������ô���ֻ������1~1000֮�������");
			return;
		end
		if (_time <= 0) and (_time ~= -1) then
			NLG.TalkToCli(_me,-1,"[Error] ����ʱ�����ô���ֻ������-1���ߴ���0����");
			return;
		end
		if (_an ~= 0) and ( _an ~= 1) then
			NLG.TalkToCli(_me,-1,"[Error] ���ֵ���ô���ֻ�����ô���0������");
			return;
		end
		if tbl_itemset[_itemid] == nil then
			if _me ~= nil then
				NLG.TalkToCli(_me,-1,"[Error] �޴˱�ŵ��ߣ����������ñ���ID");
			end
			return;
		else
			local _stl = Split(tbl_itemset[_itemid],"	");
			_itemname = _stl[2];
		end
		tbl_item_actionset[1] = _type;
		tbl_item_actionset[2] = _itemid;
		tbl_item_actionset[3] = _count;
		tbl_item_actionset[4] = _rd;
		tbl_item_actionset[5] = _time;
		tbl_item_actionset[6] = _an;
		tbl_item_actionset[7] = os.time();
		tbl_item_actionset[8] = _itemname;
		tbl_item_actionset[9] = _openname;
		if _me ~= nil then
			NLG.TalkToCli(_me,-1,"[ϵͳ] ȫ���콵���������ɹ���");
		end
		NLG.SystemMessage(-1,"[ϵͳ] ".._openname.."�ѿ����콵������");
		NLG.SystemMessage(-1,"[ϵͳ] ���".._itemname);
		if _count ~= -1 then
			NLG.SystemMessage(-1,"[ϵͳ] ������".._count.."��");
		else
			NLG.SystemMessage(-1,"[ϵͳ] �����������ƣ�ֱ���ʱ�������");
		end
		_rd = _rd/10;
		NLG.SystemMessage(-1,"[ϵͳ] ��ü��ʣ�".._rd.."%");
		if _time ~= -1 then
			local _kt = _time / 3600;
			NLG.SystemMessage(-1,"[ϵͳ] ����ʱ�䣺".._kt.."Сʱ");
		else
			NLG.SystemMessage(-1,"[ϵͳ] ����ʱ�䣺��������Ϊֹ��");
		end
		NLG.SystemMessage(-1,"[ϵͳ] ȫ����ң�ս����������ɻ�á�");
		return;
	end
end






function LoadItemsetData()
	local n = 0;
	local LuaItemsetFile = io.open("data/itemset.txt","r");
	while true do
		local line = LuaItemsetFile:read("*line");
		if line == nil then break end
		if (line ~= "") and (string.sub(line,1,1) ~= "#") then
			local tmp_stl = Split(line,"	");
			if table.getn(tmp_stl) == 102 and tonumber(tmp_stl[12])~= nil then
				tbl_itemset[tonumber(tmp_stl[12])] = line;
				n = n+1;
			end
		end
	end
end

function table.getn(_mytable)
   return #_mytable;
end
function GiveItem(_player,_itemid,_num)
	local _GI_num = 1;
	if (_num ~= nil) then
		_GI_num = _num;
	end
	
	local _GI_R = Char.GiveItem(_player,_itemid,_GI_num);
end

