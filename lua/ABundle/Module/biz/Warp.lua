warpTitle = {}
warpBtn = {"daily", "weekly", "monthly"}
warpTypeName = {"����", "����", "�չ�", "��ŵ"}

local faWarpInfo = {
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
}

local yaWarpInfo = {
    [14] = { "��ά������", 60, 1500 },
    [15] = { "Ħ�ٴ�", 60, 1500 },
    [16] = { "�����", 60, 1500 },
    [17] = { "��ŷ�ȴ�", 60, 1500 },
}

local suWarpInfo = {
    [18] = {"����³����", 30, 700},
    [19] = {"���Ǳ�����", 35, 900},
}

local aiWarpInfo = {
    [20] = {"��������", 40, 900},
    [21] = {"³����˹��", 40, 900},
    [22] = {"��ŵ���Ǵ�", 40, 900},
    [23] = {"�׿�������", 40, 900},
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
        local itemName = itemName[warp["item"]] or "δ֪"
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
