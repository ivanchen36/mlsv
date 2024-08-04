local sellerWnd = nil
local sellerMap = {}
local goodInfoMap = {}
local sellerId = 0
local curCat = 1
local wndName = ""
local sellerInfo = {}
local payInfo = {}
local freeBagNum = 0
local goodDetail = {}
local maxCatNum = 10
local maxGoodsNum = 8
local maxPayNum = 3
local buyList = {}

function buyNpcItem(w)
    local buyLen = 0
    local sendData = "buy_item|" .. sellerId .. "#" .. curCat
    for itemId, buyNum in pairs(buyList) do
        sendData = sendData .. "#" .. itemId .. "," .. buyNum
        buyLen = buyLen + 1
    end
    if buyLen == 0 then
        Cli.SysMessage("请先选择商品",4,3);
        return
    end
    Cli.Send(sendData)
    sellerWnd:close()
end

local function flushPayInfo()
    local payItems = {}
    local canBuy = true
    local catGoodList = sellerInfo[tostring(curCat)]
    local buyLen = 0
    for itemId, buyNum in pairs(buyList) do
        buyLen = buyLen + 1
        local payDetail = catGoodList[itemId]
        for payId, payNum in pairs(payDetail) do
            if rawget(payItems, payId) == nil then
                payItems[payId] = payNum * buyNum
            else
                payItems[payId] = payItems[payId] + payNum * buyNum
            end
        end
    end
    if buyLen > freeBagNum then
        canBuy = false
        sellerWnd:getWidget("confirm"):setEnabled(false)
    end
    local index = 0
    for itemId, num in pairs(payItems) do
        index = index + 1
        if index <= maxPayNum then
            local payItem = payInfo[itemId]
            local imgW = sellerWnd:getWidget("payI" .. index)
            local numW = sellerWnd:getWidget("payN" .. index)
            imgW:setImg(payItem["i"])
            numW:setText("×" .. num)
            if num > payItem["c"] and canBuy then
                canBuy = false
                sellerWnd:getWidget("confirm"):setEnabled(false)
            end
        end
    end
    if canBuy then
        sellerWnd:getWidget("confirm"):setEnabled(true)
    end
    if index >= maxPayNum then
        return
    end
    for i = index + 1, maxPayNum do
        local imgW = sellerWnd:getWidget("payI" .. i)
        local numW = sellerWnd:getWidget("payN" .. i)
        imgW:setImg(0)
        numW:setText("")
    end
    if buyLen == 0 then
        sellerWnd:getWidget("confirm"):setEnabled(false)
    end
end

local function showGoodTip(widget, itemId)
    if rawget(goodInfoMap, itemId) == nil then
        return
    end
    showItemTip(sellerWnd, widget, goodInfoMap[itemId], itemId)
end

local function setGoodsImg(index, itemId)
    local img = sellerWnd:getWidget("goodI" .. index)
    local name = sellerWnd:getWidget("goodN" .. index)
    local add = sellerWnd:getWidget("goodA" .. index)
    local sub = sellerWnd:getWidget("goodS" .. index)
    local count = sellerWnd:getWidget("goodC" .. index)

    if img == nil then
        return
    end

    if 0 ~= itemId then
        local detail = goodDetail[itemId]
        img:setImg(detail["i"])
        name:setText(detail["n"])
        count:setText("×0")
        img:activated(function(w)
            showGoodTip(w, itemId)
        end,function(w)
            closeItemTip(sellerWnd)
        end)
        add:clicked(function(w)
            local count = sellerWnd:getWidget("goodC" .. index)
            local num = 0
            if rawget(buyList, itemId) ~= nil then
                num = buyList[itemId]
            end
            if num < 99 then
                num = num + 1
                count:setText("×" .. num)
                buyList[itemId] = num
                flushPayInfo()
            end
        end)
        sub:clicked(function(w)
            local count = sellerWnd:getWidget("goodC" .. index)
            local num = 0
            if rawget(buyList, itemId) ~= nil then
                num = buyList[itemId]
            end
            if num > 0 then
                num = num - 1
                count:setText("×" .. num)
                if num == 0 then
                    buyList[itemId] = nil
                else
                    buyList[itemId] = num
                end
                flushPayInfo()
            end
        end)
    else
        img:setImg(0)
        name:setText("")
        count:setText("×0")
        add:setEnabled(false)
        sub:setEnabled(false)
    end
end

local function initSellerContent()
    buyList = {}
    local curGoodList = sellerInfo[tostring(curCat)]
    local index = 0
    local tmpList = {}
    for key, _ in pairs(curGoodList) do
        if index < maxGoodsNum then
            if type(key) == "number" then
                table.insert(tmpList, key)
                table.sort(tmpList)
                index = index + 1
            end
        end
    end
    for k, v in ipairs(tmpList) do
        setGoodsImg(k, v)
    end
    flushPayInfo()
    if index >= maxGoodsNum then
        return
    end
    for i = index + 1, maxGoodsNum do
        setGoodsImg(i, 0)
    end
end

local function showSellerTab()
    curCat = 1
    for i = 1, maxCatNum do
        local btn = sellerWnd:getWidget("cat" .. i)
        local catGoodList = sellerInfo[tostring(i)]
        if catGoodList ~= nil then
            btn:setText(catGoodList["name"])
            btn:clicked(function(w)
                local btn = sellerWnd:getWidget("cat" .. curCat)
                btn:setEnabled(true)
                curCat = i
                w:setEnabled(false)
                initSellerContent()
            end)

            if curCat == i then
                btn:setEnabled(false)
            else
                btn:setEnabled(true)
            end
            btn:setVisible(true)
        else
            btn:setVisible(false)
        end
    end
end

local function loadSellerClient()
    local client = {
        {
            ["type"] = "bg",
            ["img"] = "seller.bmp",
        },
        {
            ["type"] = "close",
            ["x"] = 461,
            ["y"] = 8,
            ["img"] = 243000,
            ["active"] = 243002,
            ["disable"] = 243001,
        },
        {
            ["type"] = "lab",
            ["title"] = "title",
            ["x"] = 210,
            ["y"] = 35,
            ["text"] = "商店标题",
            ["font"] = 3,
        },
        {
            ["table"] = "10,1",
            ["high"] = 25,
            ["type"] = "btn",
            ["title"] = "cat&",
            ["x"] = 20,
            ["y"] = 60,
            ["img"] = "menu1.bmp",
            ["active"] = "menu2.bmp",
            ["disable"] = "menu3.bmp",
            ["text"] = "分类",
        },
        {
            ["table"] = "4,2",
            ["width"] = 161,
            ["high"] = 59,
            ["type"] = "img",
            ["title"] = "goodI&",
            ["cx"] = 97,
            ["cy"] = 97,
            ["img"] = 0,
        },
        {
            ["table"] = "4,2",
            ["width"] = 161,
            ["high"] = 59,
            ["type"] = "lab",
            ["title"] = "goodN&",
            ["x"] = 123,
            ["y"] = 88,
            ["text"] = "",
        },
        {
            ["table"] = "4,2",
            ["width"] = 161,
            ["high"] = 59,
            ["type"] = "btn",
            ["title"] = "goodA&",
            ["x"] = 165,
            ["y"] = 107,
            ["img"] = 243003,
            ["active"] = 243005,
            ["disable"] = 243004,
            ["text"] = "",
        },
        {
            ["table"] = "4,2",
            ["width"] = 161,
            ["high"] = 59,
            ["type"] = "btn",
            ["title"] = "goodS&",
            ["x"] = 185,
            ["y"] = 107,
            ["img"] = 243006,
            ["active"] = 243008,
            ["disable"] = 243007,
            ["text"] = "",
        },
        {
            ["table"] = "4,2",
            ["width"] = 161,
            ["high"] = 59,
            ["type"] = "lab",
            ["title"] = "goodC&",
            ["x"] = 130,
            ["y"] = 107,
            ["text"] = "×0",
        },
        {
            ["table"] = "3,1",
            ["high"] = 71,
            ["type"] = "img",
            ["title"] = "payI&",
            ["cx"] = 430,
            ["cy"] = 97,
            ["img"] = 0,
        },
        {
            ["table"] = "3,1",
            ["high"] = 71,
            ["type"] = "lab",
            ["title"] = "payN&",
            ["x"] = 407,
            ["y"] = 125,
            ["text"] = "×0",
        },
        {
            ["type"] = "btn",
            ["title"] = "confirm",
            ["x"] = 407,
            ["y"] = 285,
            ["img"] = "b1.bmp",
            ["active"] = "b2.bmp",
            ["disable"] = "b3.bmp",
            ["text"] = "购买",
            ["click"] = "buyNpcItem",
        }
    }
    sellerWnd = createWindow(1015, "seller", client)
    addItemTip(sellerWnd)
end

function showSeller(info)
    wndName = info["name"]
    sellerId = info["id"]
    sellerInfo = info["good"]
    freeBagNum = info["free"]
    payInfo = info["pay"]
    goodDetail = info["img"]
    if rawget(sellerMap, sellerId) == nil then
        sellerMap[sellerId] = info
        for _, v in pairs(sellerInfo) do
            for itemId, _ in pairs(v) do
                if itemId ~= "name" then
                    Cli.Send("item_info|INIT_GOOD," .. itemId)
                end
            end
        end
    end
    if (sellerWnd == nil) then
        loadSellerClient()
    end

    sellerWnd:show()
    sellerWnd:getWidget("title"):setText(wndName)
    showSellerTab()
    initSellerContent()
end

function initSeller(sellerId)
    if rawget(sellerMap, sellerId) == nil then
        Cli.Send("init_seller|" .. sellerId)
        return
    end
    showSeller(sellerMap[sellerId])
end

function initSellGood(info)
    local itemId = info["id"]
    info["id"] = nil
    goodInfoMap[itemId] = info
end

Cli.Send().wait["INIT_SELLER"] = initSeller
Cli.Send().wait["SHOW_SELLER"] = showSeller
Cli.Send().wait["INIT_GOOD"] = initSellGood
