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
    [41] = {11003,9,38},
    [42] = {11015,8,10},
    [43] = {33000,290,433},
    [44] = {15005,10,8},
    [45] = {402,118,106},
    [46] = {15595,22,2},
    [47] = {402,80,191},
    [48] = {15542,17,18},
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
    [41] = {"哈洞", 0, 0},
    [42] = {"灵堂", 0, 100},
    [43] = {"深绿", 15, 500},
    [44] = {"海底", 15, 500},
    [45] = {"魔法大学", 25, 800},
    [46] = {"炎洞", 35, 900},
    [47] = {"雪山", 40, 1000},
    [48] = {"水洞", 45, 1200},
}

function showPlayerWarp(npc, player, s)
    Protocol.PowerSend(player:getObj(), "SHOW_WARP", {
        ["can"] = player:canWarp(),
        ["num"] = player:getPartyNum(),
        ["gold"] = player:getGold(),
        ["level"] = player:getLevel(),
    })
end

function playerWarp(player, arg)
    local mapId = tonumber(arg)
    if not player:canWarp() then
        player:sysMsg("您不是队长无法传送")
        return
    end
    local amount = player:getGold()
    local num = player:getPartyNum()
    local need = num * warpInfo[mapId][3]
    if amount < need then
        player:sysMsg("传送失败，魔币不足！")
    end
    player:subMoney(need)
    player:flush()
    local mapInfo = warpList[mapId]
    player:warp(0, mapInfo[1], mapInfo[2], mapInfo[3])
end

npcDialog[104890] = showPlayerWarp;
ClientEvent["warp"] = playerWarp;

local needLoadHomeNpc = true
local homeWarpList = {
    {64148,39,28},
    {64121,34,31},
    {64124,10,23},
    {64125,18,32},
    {64126,18,39}
}
local zzzzb = {{40,28,64148},{34,31,64121},{10,23,64124},{18,32,64125},{19,39,64126}}
function homeCreate()
    if needLoadHomeNpc then
        needLoadHomeNpc = false
        for i = 1, 5 do
            local myPlayer = MyPlayer:createNpc(110083, zzzzb[i][1], zzzzb[i][2], zzzzb[i][3], 0, "彩虹大厅电梯")
            NLG.UpChar(myPlayer:getObj());
            Char.SetTalkedEvent(nil, "homeTalk", myPlayer:getObj());
            Char.SetWindowTalkedEvent(nil, "homeEvent", myPlayer:getObj());
        end
    end
end

function homeTalk(_NpcIndex,_PlayerIndex)
    if (NLG.CanTalk(_NpcIndex,_PlayerIndex) == true) then
        WindowMsg = "2\\n$4请选择要前往的地点\\n------------------------------------------\\n$2[一楼]综合大厅\\n[二楼]职业技能大厅\\n$0[三楼]研究大厅\\n[四楼]活动大厅\\n[五楼]天空之竞技场";
        NLG.ShowWindowTalked(_PlayerIndex,_NpcIndex,2,2,1,WindowMsg);
    end
    return;
end

function homeEvent(_NpcIndex,_PlayerIndex,_SqeNo,_select,_data)
    if ((_select == 0 or _select == "0") and (_data ~= "")) then
        local select = tonumber(_data);
        if Char.GetPartyMember(_PlayerIndex, 0) ~= _PlayerIndex then
            NLG.SystemMessage(_PlayerIndex,"对不起，只有队长可以使用！");
            return
        end
        local warpMap = homeWarpList[select];
        Char.Warp(_PlayerIndex,0,warpMap[1],warpMap[2],warpMap[3]);
    end
end

InitEvent["server"] = homeCreate