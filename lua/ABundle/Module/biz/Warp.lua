local warpTitle = {"�ص�", "�ȼ�Ҫ��", "�۸�", "���"}
local warpBtn = {"daily", "weekly", "monthly"}
local warpTypeName = {"����", "����", "�չ�", "��ŵ"}
local curWarpPage = 1
local warpSize = 10
local warpInfo = nil
local warpWnd = nil

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
local warpList = {faWarpInfo, aiWarpInfo, suWarpInfo, yaWarpInfo}

local function showSelectWarp()
    for i = 1, #warpTypeName do
        local btn = warpWnd:getWidget("warp" .. i)
        if curWarpPage == i then
            btn:setEnabled(false)
        else
            btn:setEnabled(true)
        end
    end
end

local function initWarpContent()
    local warpInfo = warpList[curWarpPage]
    local canWarp = warpInfo[1]
    local num = warpInfo[2]
    local gold = warpInfo[3]
    local level = warpInfo[4]
    local index = 1

    showSelectWarp()
    for wid, info in pairs(warpInfo) do
        local name = warpWnd:getWidget("r" .. index .."c" .. 1)
        local levelCond = warpWnd:getWidget("r" .. index .."c" .. 2)
        local price = warpWnd:getWidget("r" .. index .."c" .. 3)
        local amount = warpWnd:getWidget("r" .. index .."c" .. 4)
        local warpBtn = warpWnd:getWidget("r" .. index .."c" .. 5)

        name:setText(info[1])
        levelCond:setText(info[2] .. "��")
        price:setText(info[3] .. "G")
        amount:setText((info[3] * num) .. "G")
        warpBtn:setVisible(true)
        if canWarp and level >= info[2] and  gold >= info[3] * num then
            warpBtn:clicked(function(w)
                Cli.Send("warp|" .. wid)
                warpWnd:close()
            end)
        else
            warpBtn:setEnabled(false)
        end
        index = index + 1
    end
    if index > warpSize then
        return
    end
    for i = index, warpSize do
        local name = warpWnd:getWidget("r" .. i .."c" .. 1)
        local levelCond = warpWnd:getWidget("r" .. i .."c" .. 2)
        local price = warpWnd:getWidget("r" .. i .."c" .. 3)
        local amount = warpWnd:getWidget("r" .. i .."c" .. 4)
        local warpBtn = warpWnd:getWidget("r" .. i .."c" .. 5)

        name:setText("")
        levelCond:setText("")
        price:setText("")
        amount:setText("")
        warpBtn:setVisible(false)
    end
end

local function loadWarpClient()
    logPrint("loadWarpClient")
    local gen = ClientGen:new("bg.bmp", 11, 5, 0, 0, 0, 0)
    for i, title in ipairs(warpTitle) do
        gen:addText(1, i, title)
    end
    for i = 1, warpSize do
        gen:addText(i + 1, 1, "")
        gen:addText(i + 1, 2, "")
        gen:addText(i + 1, 3, "")
        gen:addText(i + 1, 4, "")
        gen:addText(i + 1, 5, "����")
    end

    local client = gen:getClient()
    table.insert(client, {
        ["type"] = "lab",
        ["title"] = "title",
        ["x"] = 190,
        ["y"] = 35,
        ["text"] = "���ܴ���",
    })
    for i, name in ipairs(warpTypeName) do
        table.insert(client, {
            ["type"] = "btn",
            ["title"] = "warp" .. i,
            ["x"] = 20,
            ["y"] = 70 + 26 * (i - 1),
            ["img"] = "task1.bmp",
            ["active"] = "task2.bmp",
            ["disable"] = "task3.bmp",
            ["text"] = name,
            ["click"] = function()
                warpPage = i
                initWarpContent()
            end,
        })
    end
    warpWnd = createWindow(1013,"warp", client)
end

function showWarp(info)
    warpInfo = info;
    if (warpWnd == nil) then
        loadWarpClient()
    end
    logPrintTbl(info)

    warpWnd:show()
    initWarpContent()
    logPrint( 'showWarp2')
end

Cli.Send().wait["SHOW_TASK"] = showWarp