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
    [1] = { "������", 0, 100 },
    [2] = { "ʥ��³����", 0, 100 },
    [3] = { "�����ش�", 10, 200 },
    [4] = { "άŵ����", 15, 300 },
    [5] = { "�ڿ�����", 15, 300 },
    [6] = { "������", 20, 400 },
    [7] = { "���ɴ�", 25, 500 },
    --[8] = {"����³��", 30, 1000},
    --[9] = {"����֮��", 30, 1000},
    [10] = { "��ŵ����", 30, 700 },
    [11] = { "���ȴ�", 40, 900 },
    [12] = { "������˹��", 40, 900 },
    [14] = { "��ά������", 60, 1500 },
    [15] = { "Ħ�ٴ�", 60, 1500 },
    [16] = { "�����", 60, 1500 },
    [17] = { "��ŷ�ȴ�", 60, 1500 },
    [18] = {"����³����", 30, 700},
    [19] = {"���Ǳ�����", 35, 900},
    [20] = {"��������", 40, 900},
    [21] = {"³����˹��", 40, 900},
    [22] = {"��ŵ���Ǵ�", 40, 900},
    [23] = {"�׿�������", 40, 900},
    [31] = {"��������", 0, 100},
    [32] = {"����", 0, 100},
    [33] = {"˫��", 0, 100},
    [41] = {"����", 0, 0},
    [42] = {"����", 0, 100},
    [43] = {"����", 15, 500},
    [44] = {"����", 15, 500},
    [45] = {"ħ����ѧ", 25, 800},
    [46] = {"�׶�", 35, 900},
    [47] = {"ѩɽ", 40, 1000},
    [48] = {"ˮ��", 45, 1200},
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
        player:sysMsg("�����Ƕӳ��޷�����")
        return
    end
    local amount = player:getGold()
    local num = player:getPartyNum()
    local need = num * warpInfo[mapId][3]
    if amount < need then
        player:sysMsg("����ʧ�ܣ�ħ�Ҳ��㣡")
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
            local myPlayer = MyPlayer:createNpc(110083, zzzzb[i][1], zzzzb[i][2], zzzzb[i][3], 0, "�ʺ��������")
            NLG.UpChar(myPlayer:getObj());
            Char.SetTalkedEvent(nil, "homeTalk", myPlayer:getObj());
            Char.SetWindowTalkedEvent(nil, "homeEvent", myPlayer:getObj());
        end
    end
end

function homeTalk(_NpcIndex,_PlayerIndex)
    if (NLG.CanTalk(_NpcIndex,_PlayerIndex) == true) then
        WindowMsg = "2\\n$4��ѡ��Ҫǰ���ĵص�\\n------------------------------------------\\n$2[һ¥]�ۺϴ���\\n[��¥]ְҵ���ܴ���\\n$0[��¥]�о�����\\n[��¥]�����\\n[��¥]���֮������";
        NLG.ShowWindowTalked(_PlayerIndex,_NpcIndex,2,2,1,WindowMsg);
    end
    return;
end

function homeEvent(_NpcIndex,_PlayerIndex,_SqeNo,_select,_data)
    if ((_select == 0 or _select == "0") and (_data ~= "")) then
        local select = tonumber(_data);
        if Char.GetPartyMember(_PlayerIndex, 0) ~= _PlayerIndex then
            NLG.SystemMessage(_PlayerIndex,"�Բ���ֻ�жӳ�����ʹ�ã�");
            return
        end
        local warpMap = homeWarpList[select];
        Char.Warp(_PlayerIndex,0,warpMap[1],warpMap[2],warpMap[3]);
    end
end

InitEvent["server"] = homeCreate