local sellerWnd = nil
local sellerId = 0
local sellerCat = {}
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

local function flushPayInfo()
    local payInfo = {}
    local catGoodList = sellerInfo[tostring(curCat)]
    for itemId, buyNum in ipairs(buyList) do
        local payDetail = catGoodList[itemId]
        for payId, num in pairs(payDetail) do
            if rawget(payInfo, payId) == nil then
                payInfo[payId] = num * buyNum
            else
                payInfo[payId] = payInfo[payId] + num * buyNum
            end
        end
    end
    local index = 1
    for item, num in pairs(payInfo) do
        local imgW = sellerWnd:getWidget("payI" .. index)
        local numW = sellerWnd:getWidget("payN" .. index)
        imgW:setImg(goodDetail[item]["i"])
        numW:setText("x " .. num)
    end
end

local function setGoodsImg(index, itemId, pay)
    local img = sellerWnd:getWidget("goodI" .. index)
    local name = sellerWnd:getWidget("goodN" .. index)
    local add = sellerWnd:getWidget("goodA" .. index)
    local sub = sellerWnd:getWidget("goodS" .. index)
    local count = sellerWnd:getWidget("goodC" .. index)
    local detail = goodDetail[itemId]

    img:setImg(detail["i"])
    name:setText(detail["n"])
    count:setText("0")
    add:clicked(function(w)
        local count = sellerWnd:getWidget("goodC" .. index)
        local num = tonumber(count:getText())
        if num < 99 then
            num = num + 1
            count:setText(tostring(num))
            buyList[itemId] = num
            flushPayInfo()
        end
    end)
    sub:clicked(function(w)
        local count = sellerWnd:getWidget("goodC" .. index)
        local num = tonumber(count:getText())
        if num > 1 then
            num = num - 1
            count:setText(tostring(num))
            if num == 0 then
                buyList[itemId] = nil
            end
            flushPayInfo()
        end
    end)
    if imgId == 0 then
        add:setEnabled(false)
        sub:setEnabled(false)
    end
end

local function initSellerContent()
    buyList = {}
    payList = {}
    local curGoodList = sellerInfo[tostring(curCat)]
    local i = 0
    for key, val in pairs(curGoodList) do
        i = i + 1
    end
    for i = 1, maxGoodsNum do

    end
    for i = 1, maxPayNum do
        local img = sellerWnd:getWidget("payI" .. i)
        local num = sellerWnd:getWidget("payN" .. i)
        img:setImg(0)
        num:setText("x 0")
        flushPayInfo()
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

function loadSellerClient(client)
    logPrintTbl(client)

    local needShow = false
    if nil == sellerWnd and nil ~= sellerInfo then
        needShow = true
    end
    sellerWnd = createWindow(1015, "seller", client)
    if needShow then
        sellerWnd:getWidget("title"):setText(wndName)
        sellerWnd:show()
        showSellerTab()
        initSellerContent()
    end
    logPrint('loadSellerClient')
end

function showSeller(info)
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