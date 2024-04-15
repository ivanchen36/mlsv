local bossID = {}
 ---��ͼ����BOSS���󣬵�ͼ���ͣ���ͼ��ţ������ϣ�BOSS������ʾ��ս����š�����encount��--����븴����� ���������
bossID[1] = {"������",107913,0,1000,188,88,"��ҽԺ����",10000}
bossID[2] = {"������",107913,0,300,307,322,"�����帽��",10000}
bossID[3] = {"������",107913,0,300,343,271,"�����帽��",10000}
bossID[4] = {"������",107913,0,300,716,182,"���ɴ帽��",10000}
bossID[5] = {"������",107913,0,300,698,254,"���ɴ帽��",10000}
bossID[6] = {"������",107913,0,1000,62,88,"��ҽԺ����",10000}
bossID[7] = {"ɯ����",107913,0,402,191,175,"������˹�帽��",10000}
bossID[8] = {"ɯ����",107913,0,402,105,135,"ħ����ѧ����",10000}

local Openweek = {0,1,2,3,4,5,6}  --���ڼ�����
local Opening = {2,4,6,8,10,13,14,16,18,20,22} --���㿪��
local MinuteK = 22  ---���ŷ���
local Recovery = {3,5,7,9,11,13,15,17,19,21,23} --�������
local MinuteH = 23  ---���շ���


-------------------------------------------------------





BossTable = {}
function Boss_CheckInTable(_idTab, _idVar) ---ѭ������
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
		local NPC = NL.CreateArgNpc("WalkEnemy","1|1000|1|1000|0|0||||||||9999999|"..H.."|||||||||","����BOSS",B,C,D,E,F,1);
		table.insert(BossTable,NPC)
		NLG.SystemMessage(-1, "[ϵͳ]��"..G.."������������BOSS���������ȥ����");

	end	
end
function Recoveryofboss (_index)
	for SXJL = 1,#BossTable do 
		NL.DelNpc(BossTable[SXJL])	
	end	
	NLG.SystemMessage(-1, "[ϵͳ]����������BOSS������ս���о����Ǻ���Ȥ��ĬĬ����ʧ�ˡ�");	
	BossTable = {}
end
Delegate.RegDelTalkEvent("Boss_TalkEvent")
function Boss_TalkEvent(player,msg,color,range,size)
	local GM = Char.GetData(player,%����_GM%);
	if(msg == "[����BOSS]") then
		if GM >= 0 then
			Refresh_boss (_index)
		else
			NLG.SystemMessage(_index, "[ϵͳ]�����ǹ���Ա�޷�ʹ�á�����")
		end
	end
	if(msg == "[����BOSS]") then
		if GM >= 0 then
			Recoveryofboss (_index)
		else
			NLG.SystemMessage(_index, "[ϵͳ]�����ǹ���Ա�޷�ʹ�á�����")
		end
	end
end

function Boss_refereesss(que_refereeaaaaa)

		Char.SetData(que_refereeaaaaa,%����_����%,101003);
		Char.SetData(que_refereeaaaaa,%����_ԭ��%,101003);
		Char.SetData(que_refereeaaaaa,%����_X%,18);
		Char.SetData(que_refereeaaaaa,%����_Y%,21);
		Char.SetData(que_refereeaaaaa,%����_��ͼ%,777);
		Char.SetData(que_refereeaaaaa,%����_����%,4);
		Char.SetData(que_refereeaaaaa,%����_����%,"boss");
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