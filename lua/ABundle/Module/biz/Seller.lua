local sellerWnd = nil
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
local payList = {}

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
        local payDetail = catGoodList[itemId]
        logPrintTbl(payDetail)
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
    local index = 1
    for itemId, num in pairs(payItems) do
        local payItem = payInfo[itemId]
        local imgW = sellerWnd:getWidget("payI" .. index)
        local numW = sellerWnd:getWidget("payN" .. index)
        imgW:setImg(payItem["i"])
        numW:setText("× " .. num)
        if num > payItem["c"] and canBuy then
            canBuy = false
            sellerWnd:getWidget("confirm"):setEnabled(false)
        end
    end
    if canBuy then
        sellerWnd:getWidget("confirm"):setEnabled(true)
    end
    if index >= maxPayNum then
        return
    end
    for i = index, maxPayNum do
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

    if 0 == itemId then
        local detail = goodDetail[itemId]
        img:setImg(detail["i"])
        name:setText(detail["n"])
        count:setText("× 0")
        add:clicked(function(w)
            local count = sellerWnd:getWidget("goodC" .. index)
            local num = tonumber(count:getText())
            if num < 99 then
                num = num + 1
                count:setText("× " .. num)
                buyList[itemId] = num
                flushPayInfo()
            end
        end)
        sub:clicked(function(w)
            local count = sellerWnd:getWidget("goodC" .. index)
            local num = tonumber(count:getText())
            if num > 1 then
                num = num - 1
                count:setText("× " .. num)
                if num == 0 then
                    buyList[itemId] = nil
                end
                flushPayInfo()
            end
        end)
    else
        img:setImg(0)
        name:setText("")
        count:setText("× 0")
        add:setEnabled(false)
        sub:setEnabled(false)
    end
end

local function initSellerContent()
    logPrint("initSellerContent")
    buyList = {}
    payList = {}
    local curGoodList = sellerInfo[tostring(curCat)]
    local index = 1
    for key, _ in pairs(curGoodList) do
        setGoodsImg(index, key)
        index = index + 1
    end
    for i = index, maxGoodsNum do
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
            logPrint(catGoodList["name"])
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
    logPrintTbl(sellerWnd)
    if needShow then
        logPrintTbl(sellerInfo)
        logPrintTbl(payInfo)
        logPrintTbl(goodDetail)
        sellerWnd:getWidget("title"):setText(wndName)
        sellerWnd:show()
        safeCall(showSellerTab)
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
    if (sellerWnd == nil) then
        Cli.Send("seller_client")
        return
    end

    sellerWnd:getWidget("title"):setText(wndName)
    sellerWnd:show()
    showSellerTab()
    initSellerContent()
    logPrint( 'showSeller2')
end

Cli.Send().wait["SHOW_SELLER"] = showSeller
Cli.Send().wait["SELLER_CLIENT"] = loadSellerClient