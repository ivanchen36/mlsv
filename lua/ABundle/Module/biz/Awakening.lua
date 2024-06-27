
local awakeningInfo = nil
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

    local needShow = false
    if nil == awakeningWnd and nil ~= awakeningInfo then
        needShow = true
    end
    awakeningWnd = createWindow("awakening", client)
    if needShow then
        showAwakening(awakeningInfo)
    end
end

function showAwakening(info)
    awakeningInfo = info;
    if (awakeningWnd == nil) then
        Cli.Send("Awakening_client")
        return
    end

    logPrint( 'showAwakening1')
    logPrintTbl(info)
    awakeningWnd:show()
    initAwakeningContent()
    logPrint( 'showAwakening2')
end

Cli.Send().wait["FLUSH_AWAKENING"] = flushAwakeningInfo
Cli.Send().wait["SHOW_AWAKENING"] = showAwakening
Cli.Send().wait["AWAKENING_CLIENT"] = loadAwakeningClient
