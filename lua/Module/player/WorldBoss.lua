local bossID = {}
---��ͼ����BOSS���󣬵�ͼ���ͣ���ͼ��ţ������ϣ�BOSS������ʾ��ս����š�����encount��--����븴����� ���������
bossID[1] = {"������",107913,0,1000,188,88,"��ҽԺ����",10000,"boss1"}
bossID[2] = {"������",107913,0,300,307,322,"�����帽��",10000,"boss1"}
bossID[3] = {"������",107913,0,300,343,271,"�����帽��",10000,"boss1"}
bossID[4] = {"������",107913,0,300,716,182,"���ɴ帽��",10000,"boss1"}
bossID[5] = {"������",107913,0,300,698,254,"���ɴ帽��",10000,"boss1"}
bossID[6] = {"������",107913,0,1000,62,88,"��ҽԺ����",10000,"boss1"}
bossID[7] = {"ɯ����",107913,0,402,191,175,"������˹�帽��",10000,"boss1"}
bossID[8] = {"ɯ����",107913,0,402,105,135,"ħ����ѧ����",10000,"boss1"}

local bossRate = {
    [1] = 2500,
    [2] = 1500,
    [3] = 1500,
    [4] = 1000,
    [5] = 1000,
    [6] = 1000,
    [7] = 1000,
    [8] = 500
}
local bossCount = 3 --ÿ�γ���boss����
local bossNpcList = {}

function startBoss(regNum, info)
    local bossArr = getMulRandObj(bossRate, bossCount)
    for i = 1, #bossArr do
        local bossIndex = bossArr[i]
        local A = bossID[bossIndex][1]
        local B = bossID[bossIndex][2]
        local C = bossID[bossIndex][3]
        local D = bossID[bossIndex][4]
        local E = bossID[bossIndex][5]
        local F = bossID[bossIndex][6]
        local G = bossID[bossIndex][7]
        local H = bossID[bossIndex][8]
        local bossName = bossID[bossIndex][8]
        local NPC = NL.CreateArgNpc("WalkEnemy","1|1000|1|1000|0|0||||||||9999999|"..H.."|||||||||",bossName,B,C,D,E,F,1);
        NLG.SystemMessage(-1, "[ϵͳ��ʾ]�������Ԩ�У�������Ȼ���ѣ�" .. bossName .. " �����ڡ�" .. A .. G .. " " .. E .. "." .. F.."�������������������ÿһ�����أ��������ȥ����");
        table.insert(bossNpcList,NPC)
    end
end

function stopBoss(regNum, info)
    for SXJL = 1,#bossNpcList do
        NL.DelNpc(bossNpcList[SXJL])
    end
    NLG.SystemMessage(-1, "[ϵͳ��ʾ]������������ϣ��֮���������䣬�������Ӱ�ڻԻ��н��н�Զ��ֱ���������١�");
    bossNpcList = {}
end

TaskHandler[7] = startBoss
TaskHandler[8] = stopBoss