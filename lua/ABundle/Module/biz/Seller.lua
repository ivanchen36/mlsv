local sellerWnd = nil
local sellerId = 0
local sellerCat = {}
local curCat = 1
local wndName = ""
local sellerInfo = {}
local payInfo = {}
local freeBagNum = 0
local imgInfo = {}
local maxCatNum = 10
local maxGoodsNum = 8

local function showSellerTab()
    for i = 1, maxCatNum do
        local btn = sellerWnd:getWidget("seller" .. i)
        if sellerCat[i] ~= nil then
            btn:setText(sellerCat[i])
            if curCat == i then
                btn:setEnabled(false)
            else
                btn:setEnabled(true)
            end
        else
            btn:setVisible(false)
        end
    end
end

local function initSellerContent()

end

local function loadSellerClient()
    logPrint("loadSellerClient")
    local gen = ClientGen:new("bg.bmp", 11, 5, 70, 60, 65, 30)
    for i = 1, maxGoodsNum do
        gen:addText(i + 1, 1, "")
        gen:addText(i + 1, 2, "")
        gen:addText(i + 1, 3, "")
        gen:addText(i + 1, 4, "")
        gen:addBtn(i + 1, 5, "´«ËÍ")
    end

    local client = gen:getClient()
    table.insert(client, {
        ["type"] = "lab",
        ["title"] = "title",
        ["x"] = 210,
        ["y"] = 35,
        ["text"] = "",
        ["font"] = 10,
    })
    for i = 1, maxCatNum do
        table.insert(client, {
            ["type"] = "btn",
            ["title"] = "seller" .. i,
            ["x"] = 20,
            ["y"] = 70 + 26 * (i - 1),
            ["img"] = "task1.bmp",
            ["active"] = "task2.bmp",
            ["disable"] = "task3.bmp",
            ["text"] = "",
            ["click"] = function(w)
                local btn = sellerWnd:getWidget("seller" .. curCat)
                btn:setEnabled(true)
                curCat = i
                btn = sellerWnd:getWidget("seller" .. curCat)
                btn:setEnabled(false)
            end,
        })
    end
    logPrintTbl(client)
    sellerWnd = createWindow(1015,"seller", client)
end

function showSeller(info)
    sellerInfo = info;
    wndName = info["name"]
    sellerId = info["id"]
    sellerInfo = info[sellerId]
    freeBagNum = info["free"]
    payInfo = info["pay"]
    imgInfo = info["img"]
    for i = 1, maxCatNum do
        local key = tostring(i)
        if rawget(sellerInfo, key) ~= nil then
            sellerCat[i] = sellerInfo[key]["name"]
        else
            sellerCat[i] = nil
        end
    end
    if (sellerWnd == nil) then
        loadSellerClient()
    end

    sellerWnd:show()
    initSellerContent()
    logPrint( 'showSeller2')
end

Cli.Send().wait["SHOW_SELLER"] = showSeller