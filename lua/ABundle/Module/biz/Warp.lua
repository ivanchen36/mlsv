warpTitle = {}
warpBtn = {"daily", "weekly", "monthly"}
warpTypeName = {"法兰", "艾国", "苏国", "亚诺"}

local faWarpInfo = {
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
}

local yaWarpInfo = {
    [14] = { "尼维尔海村", 60, 1500 },
    [15] = { "摩顿村", 60, 1500 },
    [16] = { "克瑞村", 60, 1500 },
    [17] = { "雷欧娜村", 60, 1500 },
}

local suWarpInfo = {
    [18] = {"阿凯鲁法村", 30, 700},
    [19] = {"坎那贝拉村", 35, 900},
}

local aiWarpInfo = {
    [20] = {"哥拉尔城", 40, 900},
    [21] = {"鲁米那斯村", 40, 900},
    [22] = {"米诺基亚村", 40, 900},
    [23] = {"雷克塔尔镇", 40, 900},
}

local curCycleType = 1

local warpInfo = nil
local warpWnd = nil

function showSelectWarpBtn(cycleType)
    for i = 1, #warpBtn do
        local btn = warpWnd:getWidget(warpBtn[i])
        if cycleType == i then
            btn:setEnabled(false)
        else
            btn:setEnabled(true)
        end
    end
end

function initWarpContent()
    for i = 1, #warpInfo do
        local warp = warpInfo[i]
        local title = warpTitle[i]
        local warpImg = warpWnd:getWidget(title .. "Z")
        local warpDesc = warpWnd:getWidget(title .. "Desc")
        local warpProcess = warpWnd:getWidget(title .. "Process")
        local submit = warpWnd:getWidget(title .. "Submit")
        local itemName = itemName[warp["item"]] or "未知"
        local warpType = warp["type"]
        local desc = string.format(warpDescFormat[warpType], warp.count, itemName)
        warpImg:setImg(typeImg[warp["type"]])
        warpDesc:setText(desc)
        warpProcess:setText(string.format("%d / %d", warp.process, warp.count))
        if warp.process >= warp.count and warp.status ~= 2 then
            submit:setEnabled(true)
        else
            submit:setEnabled(false)
        end
        logPrintTbl(submit)
        submit:clicked(function()
            Cli.Send("submit_warp|" .. warp.id)
        end)
    end
    showSelectWarpBtn(curCycleType)
end

function flushwarpInfo(info)
    logPrintTbl(info)
    warpInfo = info;
    initWarpContent()
end

function loadWarpClient(client)
    logPrint("loadWarpClient")
    logPrintTbl(client)
    local needShow = false
    if nil == warpWnd and nil ~= warpInfo then
        needShow = true
    end
    warpWnd = createWindow(1009,"warp", client)
    if needShow then
        showWarp(warpInfo)
    end
end

function addCycleEvent()
    for i = 1, #warpBtn do
        local btn = warpWnd:getWidget(warpBtn[i])
        btn:clicked(function()
            curCycleType = i
            Cli.Send("query_warp|" .. i)
        end)
    end
end

function showWarp(info)
    warpInfo = info;

    if (warpWnd == nil) then
        Cli.Send("warp_client")
        return
    end
    logPrint( 'showWarp1')
    logPrintTbl(info)

    warpWnd:show()
    initWarpContent()
    logPrint( 'showWarp2')
end

function flushSubmitWarp(warpId)
    for i = 1, #warpInfo do
        local warp = warpInfo[i]
        if warp.id == warpId then
            local title = warpTitle[i]
            local submit = warpWnd:getWidget(title .. "Submit")
            submit:setEnabled(false)
        end
    end
end

Cli.Send().wait["FLUSH_TASK"] = flushWarpInfo
Cli.Send().wait["SUBMIT_TASK"] = flushSubmitWarp
Cli.Send().wait["SHOW_TASK"] = showWarp
Cli.Send().wait["TASK_CLIENT"] = loadWarpClient
