
SG_ChongLian = {}




SG_ChongLian.ChonglianIndex = {}
SG_ChongLian.CLTime = 300  --���������ȴ�ʱ��


----------------
-- �� ��ֹ�޸� ��
----------------

local PetChongLian_table = {}
NL.RegItemString(nil,"ChongLian_Event","LUA_useChongLian"); --ע����ħ��
Delegate.RegDelDropEvent("ChongLian_Logout")

	
function ChongLian_Event(_PlayerIndex,Target,haveitemindex) --����˫��

	local Itemindex =  Char.GetItemIndex(_PlayerIndex,haveitemindex);
	local ItemID = Item.GetData(Itemindex, %����_ID%)
	local UseEffect = Item.GetData(Itemindex,����.����.���ò���)
	local ������� = Item.GetData(Itemindex,����.����.��������)
	local �Ӳ����� = Item.GetData( Itemindex, ����.����.�Ӳζ�);
	local �Ӳ���һ = Item.GetData( Itemindex, ����.����.�Ӳ�һ)
	local ���� = Item.GetData( Itemindex, ����.����.�Ѽ�����)
	local level = Char.GetData(_PlayerIndex,%����_�ȼ�%)
	local _cdkey = Char.GetData(_PlayerIndex, 2002)
	local COUNT = tonumber(Item.GetData(Itemindex,%����_�ѵ���%))
	local _player = _PlayerIndex

	PetChongLian_table[_PlayerIndex] = Itemindex

	
		
	local str_caller = "������������������������������" ..
		"\n\n����ã���ӭʹ�ö�������ϵͳ" ..
		"\n �������֮ǰ��ս���е��߻��ߵǳ�������" ..
		"\n ����ʹ�ñ�ϵͳ��������".. SG_ChongLian.CLTime.."������������"..
		"\n ��Ҫע�⣺"..
		"\n $6��������ǰ������״̬ ��Ҫ�ı��κ�����״̬$0"..
		"\n ���磺+HP +MP �ָ����� ��"..
		"\n\n ���Ƿ�Ҫ���������أ�"
		NLG.ShowWindowTalked1(_PlayerIndex,0,3,40,str_caller,LuaNpcIndex["SG_ChongLianNpc_Index1"]);
	return	
end


function ChongLian_Logout(_PlayerIndex)
	local _BattleIndex = Char.GetData(_PlayerIndex,%����_ս��Index%)
	local key = Char.GetData(_PlayerIndex, 2002).."_"..Char.GetData(_PlayerIndex,48)
	if Char.GetData(_PlayerIndex,%����_ս��״̬%) > 0 and Battle.GetType(_BattleIndex) == %ս��_��ͨ% then  		
		SG_ChongLian.ChonglianIndex[key] = {os.time()+SG_ChongLian.CLTime, _BattleIndex, Char.GetData(_PlayerIndex,%����_Ѫ%),Char.GetData(_PlayerIndex,%����_ħ%),Char.GetData(_PlayerIndex,%����_����%)}
	end	

end

function SG_ChongLianNpc_Window( _MeIndex, _PlayerIndex, _Seqno, _Select, _Data)
	--print("\n_Seqno=".._Seqno.."\n_Select=".._Select.."\n_Data=".._Data)
	if _Select == 2 then return end		
		
	if  _Seqno == 40 then
		local key = Char.GetData(_PlayerIndex, 2002).."_"..Char.GetData(_PlayerIndex,48)
		local CLIndex =  SG_ChongLian.ChonglianIndex[key]
		local CLItemID = Item.GetData(PetChongLian_table[_PlayerIndex], %����_ID%)
		if CLIndex  then		
			if Char.GetData(_PlayerIndex,%����_Ѫ%)~= tonumber(CLIndex[3])or Char.GetData(_PlayerIndex,%����_ħ%)~= tonumber(CLIndex[4]) or Char.GetData(_PlayerIndex,%����_����%)~= tonumber(CLIndex[5]) then
				local str_caller = "������������������������������" ..
						"\n\n���Բ����������ݲ���." ..
						"\n ��鿴�Ƿ� �ӹ�Ѫ ħ ��ָ�����״̬" ..
						"\n  �޷���������" 	
					NLG.ShowWindowTalked1(_PlayerIndex,0,2,999,str_caller ,_MeIndex);
				return 0;
		elseif 	os.time() > CLIndex[1] then 
				SG_ChongLian.ChonglianIndex[key] = nil
				local str_caller = "������������������������������" ..
					"\n\n���Բ��𣬳�������ʱ��." ..
					"\n " ..
					"\n  �޷���������" 	
				NLG.ShowWindowTalked1(_PlayerIndex,0,2,999,str_caller ,_MeIndex);
				return 0;
			end	
				
			local _BattleIndex = CLIndex[2]
			local _dplayer = -1
				for BWhile=0,9 do
					local PlayerIndex = Battle.GetPlayer(_BattleIndex,BWhile);
					if PlayerIndex >= 0 and Char.GetData(PlayerIndex,0) == 1 then 
						_dplayer = PlayerIndex
						break
					end		
				end
	
			if _dplayer == -1 then-- ս���Ѿ�����
				local str_caller = "������������������������������" ..
						"\n\n���Բ���ս���Ѿ�����." ..
						"\n" ..
						"\n  �޷���������" 	
				NLG.ShowWindowTalked1(_PlayerIndex,0,2,999,str_caller ,_MeIndex);
				return 0;	
			else								
				--�ɹ�����ս��
				Char.JoinParty( _PlayerIndex,_dplayer)
				Battle.JoinBattle(_dplayer, _PlayerIndex)
				NLG.DelItem(_PlayerIndex,CLItemID,1)
				NLG.SystemMessage(_PlayerIndex,"[ϵͳ]�� ����������ս��");	
				return 0;
			end
		else
			-- �㵱ǰû��ս����������
			local str_caller = "������������������������������" ..
				"\n\n���Բ����㵱ǰû��ս����������." ..
				"\n" ..
				"\n  �޷���������" 	
				NLG.ShowWindowTalked1(_PlayerIndex,0,2,999,str_caller ,_MeIndex);
			return 0;			
		end
	end		
	return
end	

function SG_ChongLianNpc_Init1( _npc )
	Char.SetData(_npc, 1, 99147)
	Char.SetData(_npc, 2, 99147)
	Char.SetData(_npc, 3, 0)
	Char.SetData(_npc, 4, 555)
	Char.SetData(_npc, 5, 1)
	Char.SetData(_npc, 6, 98)
	Char.SetData(_npc, 7, 0)
	Char.SetData(_npc, 2000, "111")	


	if (Char.SetWindowTalkedEvent(nil, "SG_ChongLianNpc_Window", _npc) < 0) then
		print("SG_ChongLianNpc_Window erro")
		return false
	end
	return true
end

if LuaNpcIndex["SG_ChongLianNpc_Index1"] == nil then
	LuaNpcIndex["SG_ChongLianNpc_Index1"] =  NL.CreateNpc(nil,"SG_ChongLianNpc_Init1");
	NLG.UpChar(LuaNpcIndex["SG_ChongLianNpc_Index1"]);
else
	NL.DelNpc(LuaNpcIndex["SG_ChongLianNpc_Index1"])
	LuaNpcIndex["SG_ChongLianNpc_Index1"] =  NL.CreateNpc(nil,"SG_ChongLianNpc_Init1");
	NLG.UpChar(LuaNpcIndex["SG_ChongLianNpc_Index1"]);	
end



		
