local bossID = {}
 ---地图名，BOSS形象，地图类型，地图编号，东，南，BOSS坐标提示，战斗编号【参照encount】--多个请复制添加 编号往下推
bossID[1] = {"法兰城",107913,0,1000,188,88,"东医院附近",10000}
bossID[2] = {"索奇亚",107913,0,300,307,322,"奇力村附近",10000}
bossID[3] = {"索奇亚",107913,0,300,343,271,"奇力村附近",10000}
bossID[4] = {"索奇亚",107913,0,300,716,182,"加纳村附近",10000}
bossID[5] = {"索奇亚",107913,0,300,698,254,"加纳村附近",10000}
bossID[6] = {"法兰城",107913,0,1000,62,88,"西医院附近",10000}
bossID[7] = {"莎莲娜",107913,0,402,191,175,"阿巴尼斯村附近",10000}
bossID[8] = {"莎莲娜",107913,0,402,105,135,"魔法大学附近",10000}

local Openweek = {0,1,2,3,4,5,6}  --星期几开放
local Opening = {2,4,6,8,10,13,14,16,18,20,22} --几点开放
local MinuteK = 22  ---开放分钟
local Recovery = {3,5,7,9,11,13,15,17,19,21,23} --几点回收
local MinuteH = 23  ---回收分钟


-------------------------------------------------------





BossTable = {}
function Boss_CheckInTable(_idTab, _idVar) ---循环函数
	for k,v in pairs(_idTab) do
		if v==_idVar then
			return true
		end
	end
	return false
end

function BossLoop(_index)
	local tWeek = tonumber(os.date("%w", os.time()))
	local tHour = tonumber(os.date("%H", os.time()))
	local tMin = tonumber(os.date("%M", os.time()))
	local tS = tonumber(os.date("%S", os.time()))
	if Boss_CheckInTable(Openweek,tWeek)==true then
		if Boss_CheckInTable(Opening,tHour)==true and tMin == MinuteK and #BossTable == 0 then
			Refresh_boss (_index)				
			return
		elseif Boss_CheckInTable(Recovery,tHour)==true and tMin == MinuteH and #BossTable > 0 then
			Recoveryofboss (_index)
			return
		end
	end

	return
end
function Refresh_boss (_index)
	for SXJL = 1,#bossID do 
		local A = bossID[SXJL][1]
		local B = bossID[SXJL][2]
		local C = bossID[SXJL][3]
		local D = bossID[SXJL][4]
		local E = bossID[SXJL][5]
		local F = bossID[SXJL][6]
		local G = bossID[SXJL][7]
		local H = bossID[SXJL][8]
		local NPC = NL.CreateArgNpc("WalkEnemy","1|1000|1|1000|0|0||||||||9999999|"..H.."|||||||||","神秘BOSS",B,C,D,E,F,1);
		table.insert(BossTable,NPC)
		NLG.SystemMessage(-1, "[系统]【"..G.."】出现了神秘BOSS，请大神速去剿灭。");

	end	
end
function Recoveryofboss (_index)
	for SXJL = 1,#BossTable do 
		NL.DelNpc(BossTable[SXJL])	
	end	
	NLG.SystemMessage(-1, "[系统]【由于世界BOSS无人挑战，感觉你们很无趣，默默的消失了】");	
	BossTable = {}
end
Delegate.RegDelTalkEvent("Boss_TalkEvent")
function Boss_TalkEvent(player,msg,color,range,size)
	local GM = Char.GetData(player,%对象_GM%);
	if(msg == "[开启BOSS]") then
		if GM >= 0 then
			Refresh_boss (_index)
		else
			NLG.SystemMessage(_index, "[系统]您不是管理员无法使用。。。")
		end
	end
	if(msg == "[回收BOSS]") then
		if GM >= 0 then
			Recoveryofboss (_index)
		else
			NLG.SystemMessage(_index, "[系统]您不是管理员无法使用。。。")
		end
	end
end

function Boss_refereesss(que_refereeaaaaa)

		Char.SetData(que_refereeaaaaa,%对象_形象%,101003);
		Char.SetData(que_refereeaaaaa,%对象_原形%,101003);
		Char.SetData(que_refereeaaaaa,%对象_X%,18);
		Char.SetData(que_refereeaaaaa,%对象_Y%,21);
		Char.SetData(que_refereeaaaaa,%对象_地图%,777);
		Char.SetData(que_refereeaaaaa,%对象_方向%,4);
		Char.SetData(que_refereeaaaaa,%对象_名字%,"boss");
		NLG.UpChar(que_refereeaaaaa);
		Char.SetLoopEvent(nil, "BossLoop", que_refereeaaaaa, 5000);
	return true
end
	if LuaNpcIndex["Boss_referee"] == nil then
		LuaNpcIndex["Boss_referee"] =  NL.CreateNpc(nil,"Boss_refereesss");
		NLG.UpChar(LuaNpcIndex["Boss_referee"]);
	else
		NL.DelNpc(LuaNpcIndex["Boss_referee"])
		LuaNpcIndex["Boss_referee"] =  NL.CreateNpc(nil,"Boss_refereesss");
		NLG.UpChar(LuaNpcIndex["Boss_referee"]);	
	end