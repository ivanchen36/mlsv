
local function getSellAndPayItem(seller)
    local sellList = {}
    local payList = {}
    local tmpMap = {}
    for _, tmpList in pairs(seller) do
        for k, v in pairs(tmpList) do
            if k ~= "name" then
                if rawget(sellList, k) == nil then
                    table.insert(sellList, k)
                end
                for p, n in pairs(v) do
                    if rawget(tmpMap, p) == nil then
                        tmpMap[p] = 1
                        table.insert(payList, p)
                    end
                end
            end
        end
    end
    return sellList, payList
end

local function getSkuItemInfo(item)
    if rawget(sellerSkuList, item) == nil then
        player:sysMsg("系统异常")
        return {
            ["i"] = Const.GoldImgId,
            ["n"] = "0G魔币"
        }
    end
    local sku = sellerSkuList[item]
    local itemType = sku[1]
    local itemId = sku[2]
    local itemNum = sku[3]
    local itemName = sku[4]
    if Const.SkuTypeGold == itemType then
        return {
            ["i"] = Const.GoldImgId,
            ["n"] = tostring(itemNum) .. "G魔币"
        }
    elseif Const.SkuTypeItem == itemType then
        local itemInfo = MyDataItem:new(itemId)
        if itemName ~= "" then
            return {
                ["i"] = itemInfo:getImage(),
                ["n"] = itemName
            }
        else
            return {
                ["i"] = itemInfo:getImage(),
                ["n"] = itemInfo:getName() .. "×" .. itemNum
            }
        end
    elseif Const.SkuTypePet == itemType then
        local enemy = MyEnemyData:new(itemId)
        return {
            ["i"] = Const.PetImgId,
            ["n"] = "[宠物]" .. enemy:getName()
        }
    end
end

local function getSellItemImg(sellList)
    local imgList = {}
    for _, itemId in ipairs(sellList) do
        if itemId > Const.SkuBaseItemId then
            imgList[itemId] = getSkuItemInfo(itemId)
        else
            local item = MyDataItem:new(itemId)
            imgList[itemId] = {
                ["i"] = item:getImage(),
                ["n"] = item:getName()
            }
        end
    end
    return imgList
end

local function getPayItemNum(player, payList)
    local payNumList = {}
    for _, itemId in ipairs(payList) do
        payNumList[itemId] = {
            ["c"] = player:getItemNum(itemId),
            ["i"] = getItemImg(itemId),
        }
    end
    return payNumList
end

function showSeller(npc, player, s)
    logPrint("showSeller")

    Protocol.PowerSend(player:getObj(), "INIT_SELLER", MyPlayer:new(npc):getImage())
end

function initSeller(player, arg)
    logPrint("initSeller")

    local imgId = tonumber(arg)
    local seller = sellerList[imgId][2]
    local resp = {}
    local sellList, payList = getSellAndPayItem(seller)

    resp["name"] = sellerList[imgId][1]
    resp["id"] = imgId
    resp["good"] = seller
    resp["img"] = getSellItemImg(sellList)
    resp["free"] = player:freeBagNum()
    resp["pay"] = getPayItemNum(player, payList)
    logPrintTbl(resp)
    Protocol.PowerSend(player:getObj(), "SHOW_SELLER", resp)
end

function buyNpcItem(player, arg)
    logPrint("buyNpcItem", arg)
    local parts = strSplit(arg, "#")
    local npcImg = tonumber(parts[1])
    local seller = sellerList[npcImg][2]
    if seller == nil then
        player:sysMsg("系统异常，售卖NPC不存")
        return
    end

    local itemList = seller[parts[2]]
    local needPayInfo = {}
    local buyList = {}
    for i = 3, #parts do
        local itemArr = strSplit(parts[i], ",")
        local buyItem = tonumber(itemArr[1])
        local buyNum = tonumber(itemArr[2])
        if rawget(itemList, buyItem) == nil then
            player:sysMsg("系统异常，您购买的商品不存在")
            return
        end
        local payInfo = itemList[buyItem]
        for payItem, payNum in pairs(payInfo) do
            if rawget(needPayInfo, payItem) == nil then
                needPayInfo[payItem] = payNum * buyNum
            else
                needPayInfo[payItem] = needPayInfo[payItem] + payNum * buyNum
            end
        end
        if buyItem > Const.SkuBaseItemId then
            local sku = sellerSkuList[buyItem]
            if nil == sku then
                player:sysMsg("系统异常，您购买的商品不存在")
                return
            end
            table.insert(buyList,{sku[1], sku[2], sku[3] * buyNum})
        else
            table.insert(buyList,{Const.SkuTypeItem, buyItem, buyNum})
        end
    end
    local checkRs = checkFreeNum(buyList)
    if 1 == checkRs then
        player:sysMsg("物品栏空间不足，购买失败")
        return
    end
    if 2 == checkRs then
        player:sysMsg("可携带魔币余额不足，购买失败")
        return 2
    end

    if 3 == checkRs then
        player:sysMsg("宠物栏空间不足，购买失败")
        return
    end

    logPrintTbl(needPayInfo)
    for item, num in pairs(needPayInfo) do
        if 0 == item then
            if player:getGold() < num then
                player:sysMsg("您的魔币不足" .. num)
                return
            end
        else
            if player:getItemNum(item) < num then
                player:sysMsg("您需要的道具" .. getItemName(item) .. "不足" .. num .. "个")
                return
            end
        end
    end
    for item, num in pairs(needPayInfo) do
        if 0 == item then
            if player:subMoney(num) <= 0 then
                player:sysMsg("扣除魔币失败");
                return
            end
        else
            if player:delItem(item, num) <= 0 then
                player:sysMsg("扣除 " .. getItemName(item) .. " 失败");
                return
            end
        end
    end
    logPrintTbl(buyList)
    giveItemList(player, buyList)
    player:flush()
    player:sysMsg("购买成功")
end

local function registerSeller()
    for sellerId, _ in pairs(sellerList) do
        npcDialog[sellerId] = showSeller;
    end
end

ClientEvent["buy_item"] = buyNpcItem;
ClientEvent["init_seller"] = initSeller;
registerSeller()