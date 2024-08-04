local warpTitle = {"地点", "等级要求", "价格", "金额"}
local warpTypeName = {"法兰", "艾国", "苏国", "亚国", "练级"}
local curWarpPage = 1
local warpSize = 10
local warpInfo = nil
local warpWnd = nil

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

local levelWarpInfo = {
    [41] = {"哈洞", 0, 0},
    [42] = {"灵堂", 0, 100},
    [43] = {"深绿", 15, 500},
    [44] = {"海底", 15, 500},
    [45] = {"魔法大学", 25, 800},
    [46] = {"炎洞", 35, 900},
    [47] = {"雪山", 40, 1000},
    [48] = {"水洞", 45, 1200},
}

local mapWarpInfo = {faWarpInfo, aiWarpInfo, suWarpInfo, yaWarpInfo, levelWarpInfo}
local mapWarpList = {}

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
    local canWarp = warpInfo.can
    local num = warpInfo.num
    local gold = warpInfo.gold
    local level = warpInfo.level
    local index = 2

    showSelectWarp()
    local warpList = mapWarpList[curWarpPage]
    local mapInfo = mapWarpInfo[curWarpPage]
    for _, wid in ipairs(warpList) do
        local info = mapInfo[wid]
        local name = warpWnd:getWidget("r" .. index .."c" .. 1)
        local levelCond = warpWnd:getWidget("r" .. index .."c" .. 2)
        local price = warpWnd:getWidget("r" .. index .."c" .. 3)
        local amount = warpWnd:getWidget("r" .. index .."c" .. 4)
        local warpBtn = warpWnd:getWidget("r" .. index .."c" .. 5)

        name:setText(info[1])
        levelCond:setText(info[2] .. "级")
        price:setText(info[3] .. "G")
        amount:setText((info[3] * num) .. "G")
        warpBtn:setVisible(true)
        if canWarp and level >= info[2] and  gold >= info[3] * num then
            warpBtn:setEnabled(true)
            warpBtn:clicked(function(w)
                Cli.Send("warp|" .. wid)
                warpWnd:close()
            end)
        else
            warpBtn:setEnabled(false)
        end
        index = index + 1
    end
    if index > warpSize + 1 then
        return
    end
    for i = index, warpSize + 1 do
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
    local gen = ClientGen:new("bg.bmp", 11, 5, 70, 60, 65, 30)
    for i, title in ipairs(warpTitle) do
        gen:addText(1, i, title)
    end
    for i = 1, warpSize do
        gen:addText(i + 1, 1, "")
        gen:addText(i + 1, 2, "")
        gen:addText(i + 1, 3, "")
        gen:addText(i + 1, 4, "")
        gen:addBtn(i + 1, 5, "传送")
    end

    local client = gen:getClient()
    table.insert(client, {
        ["type"] = "lab",
        ["title"] = "title",
        ["x"] = 210,
        ["y"] = 35,
        ["text"] = "万能传送",
        ["font"] = 10,
    })
    for i, name in ipairs(warpTypeName) do
        table.insert(client, {
            ["type"] = "btn",
            ["title"] = "warp" .. i,
            ["x"] = 20,
            ["y"] = 70 + 26 * (i - 1),
            ["img"] = "menu1.bmp",
            ["active"] = "menu2.bmp",
            ["disable"] = "menu3.bmp",
            ["text"] = name,
            ["click"] = function(w)
                curWarpPage = i
                initWarpContent()
            end,
        })
    end
    warpWnd = createWindow(1013,"warp", client)
end

function showWarp(info)
    warpInfo = info;
    if (warpWnd == nil) then
        for _, mapInfo in ipairs(mapWarpInfo) do
            local tmpList = {}
            for k in pairs(mapInfo) do
                table.insert(tmpList, k)
            end
            table.sort(tmpList)
            table.insert(mapWarpList, tmpList)
        end
        loadWarpClient()
    end

    warpWnd:show()
    initWarpContent()
end

Cli.Send().wait["SHOW_WARP"] = showWarp