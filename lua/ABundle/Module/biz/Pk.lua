pkTitle = {"single", "team"}
pkTime = {"ÿ��������8��", "ÿ��������8��"}
pkRule = {"������", "��̭��"}
pkInfo = {"���˲�������ȡ���ֶһ�����", "����������������η��Ž���"}

local pkInfo = {}
local pkWnd = nil
local statusDesc = {
    [0] = "������",
    [1] = "PK������",
    [2] = "PK������",
    [3] = "���Ž�Ʒ��",
    [4] = "�Ѿ�����",
}

function warpPk()
    Cli.Send("warp_pk")
end

function joinSinglePk()
    Cli.Send("join_single_pk")
end
function joinTeamPk()
    Cli.Send("join_team_pk")
end

pkFunc = {joinSinglePk, joinTeamPk}
function initPkContent()
    for i = 1, #pkTitle do
        local info = pkInfo[i]
        if info ~= nil then
            local title = pkTitle[i]
            local desc = pkWnd:getWidget(title .. "Cur")
            local status = pkWnd:getWidget(title .. "Status")
            local join = pkWnd:getWidget(title .. "Join")
            local warp = pkWnd:getWidget(title .. "Warp")
            desc:setText(info[1])
            status:setText(statusDesc[info[2]])
            join:setEnable(false)
            warp:setEnable(false)
            if 0 == info[2] and 0 == info[3] then
                join:setEnable(true)
            end
            if 1 == info[3] then
                warp:setEnable(true)
            end
        end
    end
end

function flushPkInfo(info)
    logPrintTbl(info)
    pkInfo[info[1]][3] = info[2];
    initPkContent()
end

function loadPkClient(client)
    logPrint("loadPkClient")
    logPrintTbl(client)
    pkWnd = createWindow("pk", client)
end

function showPk(info)
    if (pkWnd == nil) then
        Cli.Send("Pk_client")
        Cli.SysMessage("[ϵͳ��ʾ] pkϵͳ�������ڼ����У����Ժ�",4,3)
        return
    end
    logPrint( 'showPk1')
    logPrintTbl(info)
    pkInfo = info;
    pkWnd:show()
    initPkContent()
    logPrint( 'showPk2')
end

Cli.Send().wait["FLUSH_PK"] = flushPkInfo
Cli.Send().wait["SHOW_PK"] = showPk
Cli.Send().wait["PK_CLIENT"] = loadPkClient
Cli.Send("pk_client")