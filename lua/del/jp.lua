--===========================================
--请自行修改以下配置
--掉落物品编号
local ObjectCount = 69999

--掉落物品个数限制
local ObjectMax = 100

--掉率几率（百分比，当前掉率几率为5%）
local Eqmax = 5

--活动开始时间
local funStime = 20
local funEtime = 21

--获得礼品后的提示
local tip = "恭喜你，获得了战斗礼包一个。"

--===========================================



--===========================================
--以下内容请不要修改
local tmax;
--注册初始化事件
Delegate.RegInit("jp_Init");
function jp_Init()
	tmax = ObjectMax;
end

--注册战斗结束事件
Delegate.RegDelBattleOverEvent("jp_BattleOver_Event");


function jp_BattleOver_Event(battle)
	
	for PwhI=0,9 do
		local PIndex = Battle.GetPlayer(battle,PwhI);
		if(PIndex >= 0) then
			if(Char.GetData(PIndex,%对象_序%) == %对象类型_人%)then
				get_object(PIndex);
			end
		end
	end
end


function get_object(player)
	--是否在活动时间内
	if(tonumber(os.date("%H",os.time()))>= funStime and tonumber(os.date("%H",os.time())) < funEtime)then
		--如果奖品已经发完
		if(tmax <= 0)then
			return;
		end
		--获取当前几率
		local thisEq = NLG.Rand(1,Eqmax);
		--开始分配
		local PlayerEq = NLG.Rand(1,100);
		if(PlayerEq <= thisEq)then  --获得奖品
			Char.GiveItem(player,ObjectCount,1);
			tmax = tmax - 1;
			NLG.SystemMessage(player, tip);
		end
	else
		--补充奖品
		tmax = ObjectMax;

	end
end

