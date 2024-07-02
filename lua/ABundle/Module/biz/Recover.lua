recoverTitle = {"title", "member1", "member2", "member3", "member4", "member5"}

local recoverWnd = nil
local recoverInfo = nil

function recover(widget)
    if "confirm" == widget:getTitle() then
        Cli.Send("party_recover")
    end
    recoverWnd:close()
end

function initRecoverContent()
    recover:setImg("recover" .. level .. ".bmp")
    local sum = 0
    for i=1, #recoverTitle do
        local title = recoverTitle[i]
        local name = recoverWnd:getWidget(title)
        local health = recoverWnd:getWidget(title .. "H")
        local magic = recoverWnd:getWidget(title .. "M")
        local gold = recoverWnd:getWidget(title .. "G")
        if recoverInfo[i] ~= nil then
            local info = recoverInfo[i]
            sum = sum + info[4]
            name:setText(info[1])
            health:setText(info[2])
            magic:setText(info[3])
            gold:setText(info[4] .. "G")
        else
            name:setText("")
            health:setText("")
            magic:setText("")
            gold:setText("")
        end
    end
end

function loadRecoverClient(client)
    logPrint("loadRecoverClient")
    logPrintTbl(client)
    local needShow = false
    if nil == recoverWnd and nil ~= recoverInfo then
        needShow = true
    end
    recoverWnd = createWindow(1013, "recover", client)
    if needShow then
        showRecover(recoverInfo)
    end
end

function showRecover(info)
    recoverInfo = info;
    if (recoverWnd == nil) then
        Cli.Send("recover_client")
        return
    end
    recoverWnd:show()
    initRecoverContent()
end

Cli.Send().wait["RECOVER_CLIENT"] = loadRecoverClient
Cli.Send().wait["SHOW_RECOVER"] = showRecover