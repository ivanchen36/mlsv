local bossID = {}
---地图名，BOSS形象，地图类型，地图编号，东，南，BOSS坐标提示，战斗编号【参照encount】--多个请复制添加 编号往下推
bossID[1] = {"法兰城",107913,0,1000,188,88,"东医院附近",10000,"boss1"}
bossID[2] = {"索奇亚",107913,0,300,307,322,"奇力村附近",10000,"boss1"}
bossID[3] = {"索奇亚",107913,0,300,343,271,"奇力村附近",10000,"boss1"}
bossID[4] = {"索奇亚",107913,0,300,716,182,"加纳村附近",10000,"boss1"}
bossID[5] = {"索奇亚",107913,0,300,698,254,"加纳村附近",10000,"boss1"}
bossID[6] = {"法兰城",107913,0,1000,62,88,"西医院附近",10000,"boss1"}
bossID[7] = {"莎莲娜",107913,0,402,191,175,"阿巴尼斯村附近",10000,"boss1"}
bossID[8] = {"莎莲娜",107913,0,402,105,135,"魔法大学附近",10000,"boss1"}

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
        local bossName = bossID[bossIndex][8]
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