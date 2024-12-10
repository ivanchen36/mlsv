local curPrice = 5000
local curBuy = 0
local curSell = 0
local cardBalance = 0
local goldBalance = 0
local lastAdjust = 0
local adjustDiff = 100

local function adjustPrice(newPrice)
    if newPrice > curPrice then
        curPrice = newPrice
        if curPrice > newPrice then
            lastAdjust = Const.CardUp
        else
            lastAdjust = Const.CardDown
        end
        return
    end

    local newAdjust = Const.CardDown
    if curPrice > newPrice then
        lastAdjust = Const.CardUp
    end
    if newAdjust == lastAdjust or newAdjust == Const.CardUp then
        curPrice = newPrice
        lastAdjust = newAdjust
        return
    end
    local balance = goldBalance + cardBalance * newPrice
    if balance > 0 then
        curPrice = newPrice
        lastAdjust = newAdjust
    end
end

local function getPriceInfo()
    return string.format("%d,%d,%d,%d,%d", curPrice, curBuy, curSell, cardBalance, goldBalance)
end

local function setGoldSellInfo()
    sellerList[Const.NpcGoldCard][2] = {
        ["1"] = {
            ["name"] = "½ð¿¨",
            [Const.ItemCard] = {[Const.ItemGold] = curPrice},
            [Const.CardSkuId] = {[Const.ItemGold] = curPrice * 10},
            [Const.GoldSkuId] = {[Const.ItemCard] = 1},
            [Const.GoldSkuId1] = {[Const.ItemCard] = 10},
        }
    }
    sellerSkuList[Const.CardSkuId] = {Const.SkuTypeItem, Const.ItemCard, 10,""}
    sellerSkuList[Const.GoldSkuId] = {Const.SkuTypeGold, Const.ItemGold,curPrice,""}
    sellerSkuList[Const.GoldSkuId1] = {Const.SkuTypeGold, Const.ItemGold, curPrice * 10,""}
end

local function setPriceInfo(info)
    local arr = strSplit(info, ",")
    if #arr ~= 5 then
        return
    end
    curPrice = tonumber(arr[1])
    curBuy = tonumber(arr[2])
    curSell = tonumber(arr[3])
    cardBalance = tonumber(arr[4])
    goldBalance = tonumber(arr[5])
    logPrint("setPriceInfo", curPrice, curBuy, curSell, cardBalance, goldBalance)
end

function initGoldCardTrade()
    local sql = string.format("SELECT Info FROM tbl_task WHERE Type = %d and Status = 2", Const.TaskTypeCard)
    local rs = SQL.Run(sql);
    logPrintTbl(rs)
    if(type(rs) ~= "table")then
        setGoldSellInfo()
        local sql = string.format("insert into tbl_task(RegNum,Type,Status,Info, ExeTime, CreateTime) values ('',%d,2,'%s',unix_timestamp() + %d, UNIX_TIMESTAMP());",
                                  Const.TaskTypeCard, getPriceInfo(), 86400 * 730)
        SQL.Run(sql);
        return
    end
    setPriceInfo(rs["0_0"])
    setGoldSellInfo()
end

function saveGoldCardTrade()
    local sql = string.format("SELECT Id FROM tbl_task WHERE Type = %d and Status = 2", Const.TaskTypeCard)
    local rs = SQL.Run(sql);
    if(type(rs) ~= "table")then
        return
    end
    local sql = string.format("UPDATE tbl_task SET Info = '%s' WHERE Id = %s", getPriceInfo(), rs["0_0"])
    SQL.Run(sql);
end

function statsGoldCardTrade(itemId, num)
    local buyItemId = itemId
    local buyNum = num
    local payNum = 0
    if itemId > Const.SkuBaseItemId then
        local sku = sellerSkuList[itemId]
        local itemType = sku[1]
        local itemNum = sku[3]

        if Const.SkuTypeGold == itemType then
            buyNum = num * itemNum
            payNum = buyNum / curPrice
        else
            buyItemId = Const.ItemCard
            buyNum = num * itemNum
            payNum = buyNum * curPrice
        end
    end
    if buyItemId == Const.ItemCard then
        curBuy = curBuy + buyNum
        cardBalance = cardBalance - buyNum
        goldBalance = goldBalance + payNum
    else
        curSell = curSell + payNum
        cardBalance = cardBalance + payNum
        goldBalance = goldBalance - buyNum
    end
    local oldPrice = curPrice
    if curBuy - curSell > adjustDiff then
        adjustPrice(curPrice + 500)
    end
    if oldPrice ~= curPrice then
        logPrint("priceInfo", curPrice, curBuy, curSell, cardBalance, goldBalance)
        Const.GoldSkuId = Const.GoldSkuId + 1000
        Const.GoldSkuId1 = Const.GoldSkuId1 + 1000
        Const.CardSkuId = Const.CardSkuId + 1000
        setGoldSellInfo()
    end
end

InitEvent["server"] = initGoldCardTrade
DeinitEvent["server"] = saveGoldCardTrade