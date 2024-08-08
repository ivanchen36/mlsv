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

local function setPriceInfo(info)
    local arr = strSplit(info, ",")
    if #arr ~= 5 then
        curPrice = 10000
        curBuy = 0
        curSell = 0
        cardBalance = 0
        goldBalance = 0
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
        sellerList[Const.NpcGoldCard] = {
            ["1"] = {
                ["name"] = "½ð¿¨",
                [29999] = {[0] = curPrice},
                [curPrice / 500] = {[29999] = 1},
            }
        }
        local sql = string.format("insert into tbl_task(RegNum,Type,Status,Info, ExeTime, CreateTime) values ('',%d,2,'%s',unix_timestamp() + %d, UNIX_TIMESTAMP());",
                                  Const.TaskTypeCard, getPriceInfo(), 86400 * 730)
        SQL.Run(sql);
        return
    end
    setPriceInfo(rs["0_0"])
    sellerList[Const.NpcGoldCard] = {
        ["1"] = {
            ["name"] = "½ð¿¨",
            [29999] = {[0] = curPrice},
            [curPrice / 500] = {[29999] = 1},
        }
    }
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
    if itemId == 29999 then
        curBuy = curBuy + num
        cardBalance = cardBalance - num
        goldBalance = goldBalance + num * curPrice
    else
        curSell = curSell + num
        cardBalance = cardBalance + num
        goldBalance = goldBalance - num * itemId * 500
    end
    local oldPrice = curPrice
    if curBuy - curSell > adjustDiff then
        adjustPrice(curPrice + 500)
    end
    if oldPrice ~= curPrice then
        logPrint("priceInfo", curPrice, curBuy, curSell, cardBalance, goldBalance)
        sellerList[Const.NpcGoldCard] = {
            ["1"] = {
                ["name"] = "½ð¿¨",
                [29999] = {[0] = curPrice},
                [curPrice / 500] = {[29999] = 1},
            }
        }
    end
end

InitEvent["server"] = initGoldCardTrade
DeinitEvent["server"] = saveGoldCardTrade