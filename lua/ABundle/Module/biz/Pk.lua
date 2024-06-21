pkTitle = {"single", "team"}
pkTime = {"每周五晚上8点", "每周六晚上8点"}
pkRule = {"积分制", "淘汰制"}
pkInfo = {"单人参赛，获取积分兑换奖励", "队伍参赛，根据名次发放奖励"}

local pkInfo = {}
local pkWnd = nil
function initPkContent()
    local level = pkInfo["level"]

end

function flushPkInfo(info)
    logPrintTbl(info)
    pkInfo = info;
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
        Cli.SysMessage("[系统提示] pk系统功能正在加载中，请稍后！",4,3)
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
cli.send().wait["SHOW_PK"] = showPk
Cli.Send().wait["PK_CLIENT"] = loadPkClient
Cli.Send("pk_client")