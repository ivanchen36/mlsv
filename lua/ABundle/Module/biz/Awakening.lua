
local awakeningInfo = nil
local awakeningWnd = nil
local select1 = nil
local petNum1 = 0

function awakening(widget)
    if nil ~= select1 then
        Cli.Send("up_awakening|" .. awakeningInfo[select1]["uuid"] .. "," .. awakeningWnd:getWidget("type").getValue())
    end
end

function initAwakeningSelect()
    local next1 = awakeningWnd:getWidget(petTitle[1] .. "Next")
    local prev1 = awakeningWnd:getWidget(petTitle[1] .. "Prev")
    if select1 == nil then
        next1:setEnabled(false)
        prev1:setEnabled(false)
        return
    end
    next1:setEnabled(true)
    prev1:setEnabled(true)
    if select1 == 1 then
        prev1:setEnabled(false)
    end
    if select1 == petNum1 then
        next1:setEnabled(false)
    end
end

function selectAttrChanged(widget)
    local attr = widget:getValue()
end

function showAwakeningInfo()
    local attr = awakeningWnd:getWidget("type")

    initAwakeningSelect()
    showPetInfo(awakeningWnd,1, awakeningInfo[select1])
    showPetInfo(awakeningWnd,2, awakeningInfo[select1])
    selectAttrChanged(attr)
end

function awakeningPrev(widget)
    if nil == select1 then
        return
    end
    if select1 >= petNum1 then
        initAwakeningSelect()
        return
    end
    select1 = select1 + 1
    showAwakeningInfo()
end

function awakeningNext(widget)
    local attr = awakeningWnd:getWidget("type")

    if nil == select1 then
        return
    end
    if select1 <= 1 then
        initAwakeningSelect()
        return
    end
    select1 = select1 - 1
    showAwakeningInfo()
end

function initAwakeningContent()
    select1 = nil
    petNum1 = #awakeningInfo
    if petNum1 >= 1 then
        select1 = 1
    end
    initAwakeningSelect()
    local confirm = awakeningWnd:getWidget("confirm")
    local check = awakeningWnd:getWidget("check")

    if nil ~= select1 then
        showAwakeningInfo()
    else
        showAwakeningInfo(1, nil)
        showAwakeningInfo(2, nil)
    end
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
        Cli.Send("awakening_client")
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
