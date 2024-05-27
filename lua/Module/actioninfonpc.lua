tbl_TJitemset = {} --{物品id,个数,几率(千分比)}
tbl_TJitemset[0] = {88888,500,1000};--周日物品设置
tbl_TJitemset[1] = {88888,500,160};--周1物品设置
tbl_TJitemset[2] = {88888,500,160};--周2物品设置
tbl_TJitemset[3] = {88888,500,160};--周3物品设置
tbl_TJitemset[4] = {88888,500,160};--周4物品设置
tbl_TJitemset[5] = {88888,500,160};--周5物品设置
tbl_TJitemset[6] = {88888,500,160};--周6物品设置

battle_enemytotallv = 1;--怪物最低综合等级
tbl_TJtime = "16:35:00";--天降活动开始时间

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
		Char.SetData(ActioninfoNpc_id26,%对象_形象%,14575);
		Char.SetData(ActioninfoNpc_id26,%对象_原形%,14575);
		Char.SetData(ActioninfoNpc_id26,%对象_X%,1);
		Char.SetData(ActioninfoNpc_id26,%对象_Y%,9);
		Char.SetData(ActioninfoNpc_id26,%对象_地图%,777);
		Char.SetData(ActioninfoNpc_id26,%对象_方向%,6);
		Char.SetData(ActioninfoNpc_id26,%对象_名字%,"a");
		NLG.UpChar(ActioninfoNpc_id26);
		Char.SetLoopEvent("lua/Module/actioninfonpc.lua","ActioninfoNpc_id26_LoopEvent", ActioninfoNpc_id26,1000);
		LoadItemsetData()
	end
end


function ActioninfoNpc_id26_LoopEvent(_npc)
	local num = tonumber(os.date("%w",os.time()));
	if os.date("%X",os.time()) == tbl_TJtime and tbl_TJitemset[num] ~= nil then
		NLG.SystemMessage(-1,"[系统提示] 系统已自动开启天降宝物活动！");
		GMF_setaction_item(nil,1,tbl_TJitemset[num][1],tbl_TJitemset[num][2],tbl_TJitemset[num][3],-1,1);
	end
	
	
end
Delegate.RegDelBattleOverEvent("RBattleOverEvent");
Delegate.RegDelBattleStartEvent("RBattleStartEvent");



function RBattleStartEvent( _btlp)
	if ((Battle.GetGainMode( _btlp)==%战奖_普通%) and (Battle.GetType( _btlp)==%战斗_普通%)) then
		tbl_battle_enemytotallv[_btlp] = 0;
		for i = 10,19 do
			local _enemy = Battle.GetPlayer(_btlp,i);
			if (_enemy ~= -1) and (_enemy ~= nil) then
				tbl_battle_enemytotallv[_btlp] = tbl_battle_enemytotallv[_btlp] + Char.GetData(_enemy,%对象_等级%);
			end
		end
	end
	
end
function RBattleOverEvent( _btlp)

	
	for i=0,9 do 
		local RBO_player = Battle.GetPlayer(_btlp,i);
		if (RBO_player ~= nil) and (RBO_player ~= -1)  then
			if (Char.GetData(RBO_player,%对象_战死%) == 0 and (Char.GetData(RBO_player,%对象_序%) == %对象类型_人%) and (Battle.GetGainMode(_btlp)==%战奖_普通%) and (Battle.GetType(_btlp)==%战斗_普通%)) then 
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
						NLG.SystemMessage(-1,"[系统提示] 天降宝物活动时间已到，活动自动关闭，祝大家游戏开心");
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
									NLG.SystemMessage(RBO_player,"[系统] 恭喜您获得天降宝物：".._item_name);
									if _item_an == 1 then
										NLG.SystemMessage(-1,"[系统提示]“"..Char.GetData(RBO_player,%对象_名字%).."”获得"..tbl_item_actionset[9].."开启的天降宝物：".._item_name.."(剩"..tbl_item_actionset[3]..")");
									end
									
								end
							else
								tbl_item_actionset[1] = 0;
								NLG.SystemMessage(-1,"[系统提示] 天降宝物已全部被玩家领取完，活动自动关闭，祝大家游戏开心");
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
			NLG.TalkToCli(_me,-1,"[系统] 全服道具奖励活动已成功关闭！");
		end
		NLG.SystemMessage(-1,"[系统] 系统关闭了天降宝物活动！")
		return;
	end
	local _type = tonumber(_var1);
	local _itemid = tonumber(_var2);
	local _count = tonumber(_var3);
	local _rd = tonumber(_var4);
	local _time = tonumber(_var5);
	local _an = tonumber(_var6);
	local _itemname = "";
	local _openname = "系统";
	if _var7 ~= nil then
		_openname = _var7;
	end

	if (_type == nil) or (_itemid == nil) or (_count  == nil) or (_rd == nil) or (_time == nil) or (_an == nil) then
		NLG.TalkToCli(_me,-1,"[Error] 参数错误！");
		return;
	else
		if (_type ~= 1) then
			NLG.TalkToCli(_me,-1,"[Error] 类型参数设置错误！只能设置1！");
			return;
		end
		if _itemid < 0 then
			NLG.TalkToCli(_me,-1,"[Error] 道具编号设置错误！必须设置大于等于0的数！");
			return;
		end
		if (_count <= 0) and (_count ~= -1) then
			NLG.TalkToCli(_me,-1,"[Error] 道具总量设置错误！只能设置-1或者大于0的数");
			return;
		end
		if (_rd <= 0) or (_rd > 1000) then
			NLG.TalkToCli(_me,-1,"[Error] 几率设置错误！只能设置1~1000之间的数！");
			return;
		end
		if (_time <= 0) and (_time ~= -1) then
			NLG.TalkToCli(_me,-1,"[Error] 持续时间设置错误！只能设置-1或者大于0的数");
			return;
		end
		if (_an ~= 0) and ( _an ~= 1) then
			NLG.TalkToCli(_me,-1,"[Error] 最大值设置错误！只能设置大于0的数！");
			return;
		end
		if tbl_itemset[_itemid] == nil then
			if _me ~= nil then
				NLG.TalkToCli(_me,-1,"[Error] 无此编号道具，请重新设置宝物ID");
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
			NLG.TalkToCli(_me,-1,"[系统] 全服天降宝物活动开启成功！");
		end
		NLG.SystemMessage(-1,"[系统] ".._openname.."已开启天降宝物活动！");
		NLG.SystemMessage(-1,"[系统] 宝物：".._itemname);
		if _count ~= -1 then
			NLG.SystemMessage(-1,"[系统] 总量：".._count.."个");
		else
			NLG.SystemMessage(-1,"[系统] 总量：不限制！直到活动时间结束！");
		end
		_rd = _rd/10;
		NLG.SystemMessage(-1,"[系统] 获得几率：".._rd.."%");
		if _time ~= -1 then
			local _kt = _time / 3600;
			NLG.SystemMessage(-1,"[系统] 持续时间：".._kt.."小时");
		else
			NLG.SystemMessage(-1,"[系统] 持续时间：奖励放完为止！");
		end
		NLG.SystemMessage(-1,"[系统] 全服玩家，战斗结束随机可获得。");
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

