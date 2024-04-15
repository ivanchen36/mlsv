
SG_ChongLian = {}




SG_ChongLian.ChonglianIndex = {}
SG_ChongLian.CLTime = 300  --道具重连等待时间


----------------
-- × 禁止修改 ×
----------------

local PetChongLian_table = {}
NL.RegItemString(nil,"ChongLian_Event","LUA_useChongLian"); --注册诱魔香
Delegate.RegDelDropEvent("ChongLian_Logout")

	
function ChongLian_Event(_PlayerIndex,Target,haveitemindex) --道具双击

	local Itemindex =  Char.GetItemIndex(_PlayerIndex,haveitemindex);
	local ItemID = Item.GetData(Itemindex, %道具_ID%)
	local UseEffect = Item.GetData(Itemindex,常量.道具.自用参数)
	local 特殊类别 = Item.GetData(Itemindex,常量.道具.特殊类型)
	local 子参数二 = Item.GetData( Itemindex, 常量.道具.子参二);
	local 子参数一 = Item.GetData( Itemindex, 常量.道具.子参一)
	local 名字 = Item.GetData( Itemindex, 常量.道具.已鉴定名)
	local level = Char.GetData(_PlayerIndex,%对象_等级%)
	local _cdkey = Char.GetData(_PlayerIndex, 2002)
	local COUNT = tonumber(Item.GetData(Itemindex,%道具_堆叠数%))
	local _player = _PlayerIndex

	PetChongLian_table[_PlayerIndex] = Itemindex

	
		
	local str_caller = "　　　　　　　　　◆断线重连◆" ..
		"\n\n　你好，欢迎使用断线重连系统" ..
		"\n 如果你在之前的战斗中掉线或者登出服务器" ..
		"\n 可以使用本系统，可以在".. SG_ChongLian.CLTime.."秒内重新链接"..
		"\n 需要注意："..
		"\n $6保持离线前的所有状态 不要改变任何人物状态$0"..
		"\n 例如：+HP +MP 恢复健康 等"..
		"\n\n 你是否要重新连接呢？"
		NLG.ShowWindowTalked1(_PlayerIndex,0,3,40,str_caller,LuaNpcIndex["SG_ChongLianNpc_Index1"]);
	return	
end


function ChongLian_Logout(_PlayerIndex)
	local _BattleIndex = Char.GetData(_PlayerIndex,%对象_战斗Index%)
	local key = Char.GetData(_PlayerIndex, 2002).."_"..Char.GetData(_PlayerIndex,48)
	if Char.GetData(_PlayerIndex,%对象_战斗状态%) > 0 and Battle.GetType(_BattleIndex) == %战斗_普通% then  		
		SG_ChongLian.ChonglianIndex[key] = {os.time()+SG_ChongLian.CLTime, _BattleIndex, Char.GetData(_PlayerIndex,%对象_血%),Char.GetData(_PlayerIndex,%对象_魔%),Char.GetData(_PlayerIndex,%对象_受伤%)}
	end	

end

function SG_ChongLianNpc_Window( _MeIndex, _PlayerIndex, _Seqno, _Select, _Data)
	--print("\n_Seqno=".._Seqno.."\n_Select=".._Select.."\n_Data=".._Data)
	if _Select == 2 then return end		
		
	if  _Seqno == 40 then
		local key = Char.GetData(_PlayerIndex, 2002).."_"..Char.GetData(_PlayerIndex,48)
		local CLIndex =  SG_ChongLian.ChonglianIndex[key]
		local CLItemID = Item.GetData(PetChongLian_table[_PlayerIndex], %道具_ID%)
		if CLIndex  then		
			if Char.GetData(_PlayerIndex,%对象_血%)~= tonumber(CLIndex[3])or Char.GetData(_PlayerIndex,%对象_魔%)~= tonumber(CLIndex[4]) or Char.GetData(_PlayerIndex,%对象_受伤%)~= tonumber(CLIndex[5]) then
				local str_caller = "　　　　　　　　　◆断线重连◆" ..
						"\n\n　对不起，人物数据不符." ..
						"\n 请查看是否 加过血 魔 或恢复健康状态" ..
						"\n  无法重新连接" 	
					NLG.ShowWindowTalked1(_PlayerIndex,0,2,999,str_caller ,_MeIndex);
				return 0;
		elseif 	os.time() > CLIndex[1] then 
				SG_ChongLian.ChonglianIndex[key] = nil
				local str_caller = "　　　　　　　　　◆断线重连◆" ..
					"\n\n　对不起，超过重连时间." ..
					"\n " ..
					"\n  无法重新连接" 	
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
	
			if _dplayer == -1 then-- 战斗已经结束
				local str_caller = "　　　　　　　　　◆断线重连◆" ..
						"\n\n　对不起，战斗已经结束." ..
						"\n" ..
						"\n  无法重新连接" 	
				NLG.ShowWindowTalked1(_PlayerIndex,0,2,999,str_caller ,_MeIndex);
				return 0;	
			else								
				--成功加入战斗
				Char.JoinParty( _PlayerIndex,_dplayer)
				Battle.JoinBattle(_dplayer, _PlayerIndex)
				NLG.DelItem(_PlayerIndex,CLItemID,1)
				NLG.SystemMessage(_PlayerIndex,"[系统]： 重新链接了战斗");	
				return 0;
			end
		else
			-- 你当前没有战斗可以链接
			local str_caller = "　　　　　　　　　◆断线重连◆" ..
				"\n\n　对不起，你当前没有战斗可以链接." ..
				"\n" ..
				"\n  无法重新连接" 	
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



		
