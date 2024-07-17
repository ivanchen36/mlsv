local warpList = {
    [1] = {2000,55,71},
    [2] = {2300,48,56},
    [3] = {2400,53,44},
    [4] = {2100,60,47},
    [5] = {2200,65,20},
    [6] = {3200,58,74},
    [7] = {3000,43,52},
    --[8] = {3100,51,78},
    --[9] = {3300,13,26},
    [10] = {4000,43,37},
    [11] = {4200,31,25},
    [12] = {4300,41,60},
    [13] = {30010,148,119},
    [14] = {30011,27,63},
    [15] = {30013,91,42},
    [16] = {30012,31,54},
    [17] = {30014,60,52},
    [18] = {33200,168,108},
    [19] = {33500,18,47},
    [20] = {43100,120,107},
    [21] = {43600,63,29},
    [22] = {43500,68,92},
    [23] = {43700,75,102},
    [31] = {15507,29,14},
    [32] = {16511,26,28},
    [33] = {24068,21,19},
}
local warpInfo = {
    [1] = { "伊尔村", 0, 100 },
    [2] = { "圣拉鲁卡村", 0, 100 },
    [3] = { "亚留特村", 10, 200 },
    [4] = { "维诺亚镇", 15, 300 },
    [5] = { "乌克兰村", 15, 300 },
    [6] = { "奇利村", 20, 400 },
    [7] = { "加纳村", 25, 500 },
    --[8] = {"哈贝鲁村", 30, 1000},
    --[9] = {"毁灭之村", 30, 1000},
    [10] = { "杰诺瓦镇", 30, 700 },
    [11] = { "蒂娜村", 40, 900 },
    [12] = { "阿巴尼斯村", 40, 900 },
    [14] = { "尼维尔海村", 60, 1500 },
    [15] = { "摩顿村", 60, 1500 },
    [16] = { "克瑞村", 60, 1500 },
    [17] = { "雷欧娜村", 60, 1500 },
    [18] = {"阿凯鲁法村", 30, 700},
    [19] = {"坎那贝拉村", 35, 900},
    [20] = {"哥拉尔城", 40, 900},
    [21] = {"鲁米那斯村", 40, 900},
    [22] = {"米诺基亚村", 40, 900},
    [23] = {"雷克塔尔镇", 40, 900},
    [31] = {"树精长老", 0, 100},
    [32] = {"神兽", 0, 100},
    [33] = {"双王", 0, 100},
}

function showWarp(npc, player, s)
    Protocol.PowerSend(player:getObj(), "SHOW_WARP", {
       [1] = player:canWarp(),
       [2] = player:getPartyNum(),
       [3] = player:getGold(),
       [4] = player:getLevel(),
    })
end

function playerWarp(npc, player, arg)
    local myPlayer = MyPlayer:new(player)
    local mapId = tonumber(arg)
    if player:canWarp() then
        myPlayer:sysMsg("您不是队长无法传送")
        return
    end
    local amount = player:getGold()
    local num = player:getPartyNum()
    local need = num * warpInfo[mapId][3]
    if amount < need then
        myPlayer:sysMsg("传送失败，魔币不足！")
    end
    myPlayer:subMoney(need)
    local mapInfo = warpList[mapId]
    myPlayer:warp(0, mapInfo[1], mapInfo[2], mapInfo[3])
end

scriptEvent["show_warp"] = showWarp;
scriptEvent["warp"] = playerWarp;