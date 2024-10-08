local bossID = {}
---地图名，BOSS形象，地图类型，地图编号，东，南，BOSS坐标提示，战斗编号【参照encount】,boss名称,boss类型
---类型 1-可以打多次 2-只能打一次 3-战斗中所有的人一起必须打够足够的血量
---奖励 1、2固定奖品，3-看排名
--多个请复制添加 编号往下推

bossID[1] = {"法兰城",107913,0,1000,188,88,"东医院附近",10000,"boss1", 1}
bossID[2] = {"索奇亚",107913,0,300,307,322,"奇力村附近",10000,"boss1", 1}
bossID[3] = {"索奇亚",107913,0,300,343,271,"奇力村附近",10000,"boss1"}
bossID[4] = {"索奇亚",107913,0,300,716,182,"加纳村附近",10000,"boss1"}
bossID[5] = {"索奇亚",107913,0,300,698,254,"加纳村附近",10000,"boss1"}
bossID[6] = {"法兰城",107913,0,1000,62,88,"西医院附近",10000,"boss1"}
bossID[7] = {"莎莲娜",107913,0,402,191,175,"阿巴尼斯村附近",10000,"boss1"}
bossID[8] = {"莎莲娜",107913,0,402,105,135,"魔法大学附近",10000,"boss1"}
-- NLG.Walkable(MapID, FloorID, X, Y)
--NLG.GetMapPlayer(MapID, FloorID)
local bossRate = {
    [30400] = 700,
    [30401] = 700,
    [30402] = 700,
    [30403] = 700,
    [30404] = 700,
    [30405] = 700,
    [30406] = 700,
    [30407] = 700,
    [30408] = 700,
    [30409] = 700,
    [30410] = 700,
    [30411] = 700,
    [30412] = 700,
    [30413] = 700,
    [30414] = 300,
    [30415] = 300,
    [30416] = 300,
}
local bossCount = 3 --每次出现boss数量
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
        local bossName = bossID[bossIndex][9]
        local bossType = bossID[bossIndex][10]
        local NPC = NL.CreateArgNpc("WalkEnemy","1|1000|1|1000|0|0||||||||9999999|"..H.."|||||||||",bossName,B,C,D,E,F,1);
        NLG.SystemMessage(-1, "[系统提示]世间的深渊中，怪物悄然苏醒，" .. bossName .. " 出现在【" .. A .. G .. " " .. E .. "." .. F.."】，震撼寰宇的咆哮震颤着每一寸土地，请大神速去剿灭。");
        table.insert(bossNpcList,NPC)
    end
end

function stopBoss(regNum, info)
    for SXJL = 1,#bossNpcList do
        NL.DelNpc(bossNpcList[SXJL])
    end
    NLG.SystemMessage(-1, "[系统提示]当晨光破晓，希望之光照亮世间，怪物的阴影在辉煌中渐行渐远，直至消逝无踪。");
    bossNpcList = {}
end

TaskHandler[7] = startBoss
TaskHandler[8] = stopBoss