awakeningInfo = {}

local awakeningWnd = nil

function initAwakeningContent()
    local level = awakeningInfo["level"]

end

function flushAwakeningInfo(info)
    logPrintTbl(info)
    awakeningInfo = info;
    initAwakeningContent()
end

function loadAwakeningClient(client)
    logPrint("loadAwakeningClient")
    logPrintTbl(client)
    awakeningWnd = createWindow("awakening", client)
end

function showAwakening(info)
    if (awakeningWnd == nil) then
        Cli.Send("Awakening_client")
        Cli.SysMessage("[系统提示] awakening系统功能正在加载中，请稍后！",4,3)
        return
    end
    logPrint( 'showAwakening1')
    logPrintTbl(info)
    awakeningInfo = info;
    awakeningWnd:show()
    initAwakeningContent()
    logPrint( 'showAwakening2')
end

Cli.Send().wait["FLUSH_AWAKENING"] = flushAwakeningInfo
cli.send().wait["SHOW_AWAKENING"] = showAwakening
Cli.Send().wait["AWAKENING_CLIENT"] = loadAwakeningClient
Cli.Send("awakening_client")