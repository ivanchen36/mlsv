local sellerWnd = nil
local sellerMap = {}
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

function buyNpcItem()
    logPrintTbl(buyList)

    local buyLen = 0
    local sendData = "buy_item|" .. sellerId
    for itemId, buyNum in pairs(buyList) do
        sendData = sendData .. "|" .. itemId .. "," .. buyNum
        buyLen = buyLen + 1
    end
    if buyLen == 0 then
        Cli.SysMessage("请先选择商品",4,3);
        return
    end
    Cli.Send()
end

local function flushPayInfo()
    local payItems = {}
    local canBuy = true
    local catGoodList = sellerInfo[tostring(curCat)]
    local buyLen = 0
    for itemId, buyNum in pairs(buyList) do
        buyLen = buyLen + 1
        logPrint("buyNum" .. itemId .. ":" .. buyNum)
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
    logPrintTbl(payItems)
    for itemId, num in pairs(payItems) do
        logPrint("payItems", itemId, num)
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
        logPrint("payI" .. i)
        local imgW = sellerWnd:getWidget("payI" .. i)
        local numW = sellerWnd:getWidget("payN" .. i)
        imgW:setImg(0)
        numW:setText("")
    end
    if buyLen == 0 then
        sellerWnd:getWidget("confirm"):setEnabled(false)
    end
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
        add:clicked(function(w)
            local count = sellerWnd:getWidget("goodC" .. index)
            local num = 0
            if rawget(buyList, itemId) ~= nil then
                num = buyList[itemId]
            end
            logPrint("add", num)
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
            logPrint("sub", num)
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
    logPrint("initSellerContent")
    buyList = {}
    local curGoodList = sellerInfo[tostring(curCat)]
    logPrintTbl(curGoodList)
    local index = 0
    local tmpList = {}
    for key, _ in pairs(curGoodList) do
        logPrint("curGoodList", key)
        if index < maxGoodsNum then
            if type(key) == "number" then
                table.insert(tmpList, key)
                table.sort(tmpList)
                index = index + 1
            end
        end
    end
    for k, v in ipairs(tmpList) do
        logPrint("tmpList", k, v)
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
    logPrint("showSellerTab")
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

function loadSellerClient(client)
    logPrintTbl(client)
    local needShow = false
    if nil == sellerWnd and nil ~= sellerInfo then
        needShow = true
    end
    sellerWnd = createWindow(1015, "seller", client)
    if needShow then
        sellerWnd:show()
        sellerWnd:getWidget("title"):setText(wndName .. "\n" .. "test")
        showSellerTab()
        safeCall(initSellerContent)
    end
    logPrint('loadSellerClient1')
end

function showSeller(info)
    logPrintTbl(info)
    wndName = info["name"]
    sellerId = info["id"]
    sellerInfo = info["good"]
    freeBagNum = info["free"]
    payInfo = info["pay"]
    goodDetail = info["img"]
    if rawget(sellerMap, sellerId) == nil then
        sellerMap[sellerId] = info
    end
    if (sellerWnd == nil) then
        Cli.Send("seller_client")
        return
    end

    sellerWnd:show()
    sellerWnd:getWidget("title"):setText(wndName .. "\n" .. "test")
    showSellerTab()
    safeCall(initSellerContent)
    logPrint( 'showSeller2')
end

function initSeller(sellerId)
    logPrint("initSeller")
    if rawget(sellerMap, sellerId) == nil then
        Cli.Send("init_seller|" .. sellerId)
        return
    end
    showSeller(sellerMap[sellerId])
end

Cli.Send().wait["INIT_SELLER"] = initSeller
Cli.Send().wait["SHOW_SELLER"] = showSeller
Cli.Send().wait["SELLER_CLIENT"] = loadSellerClient