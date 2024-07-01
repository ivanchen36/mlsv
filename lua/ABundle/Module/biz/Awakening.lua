
local awakeningInfo = nil
local awakeningWnd = nil
local select1 = nil
local petNum1 = 0
local itemNum = {99, 399, 999}

function awakening(widget)
    if nil ~= select1 then
        Cli.Send("up_awakening|" .. awakeningInfo[select1]["uuid"] .. "," .. awakeningWnd:getWidget("attrType").getValue())
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
    local attr = awakeningWnd:getWidget("attrType")
    local confirm = awakeningWnd:getWidget("confirm")
    local check = awakeningWnd:getWidget("check")

    initAwakeningSelect()
    if nil ~= select1 then
        showPetInfo(awakeningWnd,1, awakeningInfo[select1])
        showPetInfo(awakeningWnd,2, awakeningInfo[select1])
    else
        showPetInfo(awakeningWnd, 1, nil)
        showPetInfo(awakeningWnd, 2, nil)
    end
    selectAttrChanged(attr)
end

function awakeningPrev(widget)
    logPrint("awakeningPrev")
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

function awakeningNext(widget)
    logPrint("awakeningNext")
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

function initAwakeningContent()
    logPrint("initAwakeningContent")
    select1 = nil
    petNum1 = #awakeningInfo
    if petNum1 >= 1 then
        select1 = 1
    end

    showAwakeningInfo()
    logPrint("222")
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
    awakeningWnd = createWindow(1001, "awakening", client)
    addCharAttr(awakeningWnd, petTitle[1])
    addCharAttr(awakeningWnd, petTitle[2])
    addItem(awakeningWnd, "item1")
    addItem(awakeningWnd, "item2")
    if needShow then
        showAwakening(awakeningInfo)
    end

    logPrint("loadAwakeningClient111")
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
    safeCall(initAwakeningContent)
    logPrint( 'showAwakening2')
end

Cli.Send().wait["FLUSH_AWAKENING"] = flushAwakeningInfo
Cli.Send().wait["SHOW_AWAKENING"] = showAwakening
Cli.Send().wait["AWAKENING_CLIENT"] = loadAwakeningClient
