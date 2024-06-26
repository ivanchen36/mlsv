pkTitle = {"single", "team"}
pkTime = {"每周五晚上8点", "每周六晚上8点"}
pkCond = {"等级80级以上", "队伍满5人,等级80级以上"}
pkRule = {"积分制", "淘汰制"}
pkRuleInfo = {"单人参赛，获取积分兑换奖励", "队伍参赛，根据名次发放奖励"}

local pkInfo = nil
local pkWnd = nil
local statusDesc = {
    [0] = "报名中",
    [1] = "PK进行中",
    [2] = "PK进行中",
    [3] = "发放奖品中",
    [4] = "已经结束",
    [99] = "未开始",
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
            join:setEnabled(false)
            warp:setEnabled(false)
            if 0 == info[2] and 0 == info[3] then
                join:setEnabled(true)
            end
            if 1 == info[3] then
                warp:setEnabled(true)
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

    local needShow = false
    if nil == pkWnd and nil ~= pkInfo then
        needShow = true
    end
    pkWnd = createWindow(1003, "pk", client)
    if needShow then
        showPk(pkInfo)
    end
end

function showPk(info)
    logPrintTbl(info)
    pkInfo = info;
    if (pkWnd == nil) then
        Cli.Send("pk_client")
        return
    end

    logPrint( 'showPk1')
    logPrintTbl(info)

    pkWnd:show()
    initPkContent()
    logPrint( 'showPk2')
end

Cli.Send().wait["FLUSH_PK"] = flushPkInfo
Cli.Send().wait["SHOW_PK"] = showPk
Cli.Send().wait["PK_CLIENT"] = loadPkClient
