local petEquipSeller = {
    ["1"] = {
        ["name"] = "青铜",
        [20201] = {[20399] = 10, [0] = 1000},
        [20202] = {[20399] = 20, [0] = 1000},
        [20203] = {[20399] = 10, [0] = 1000},
        [20204] = {[20398] = 10, [0] = 1000},
        [20205] = {[20398] = 10, [0] = 1000},
        [20206] = {[20398] = 10, [0] = 1000},
        [20207] = {[20398] = 10, [0] = 1000},
        [20208] = {[20398] = 10, [0] = 1000},
    },
    ["2"] = {
        ["name"] = "白银",
        [20211] = {[20397] = 10, [0] = 2000},
        [20212] = {[20397] = 20, [0] = 2000},
        [20213] = {[20397] = 10, [0] = 2000},
        [20214] = {[20396] = 10, [0] = 2000},
        [20215] = {[20396] = 10, [0] = 2000},
        [20216] = {[20396] = 10, [0] = 2000},
        [20217] = {[20396] = 10, [0] = 2000},
        [20218] = {[20396] = 10, [0] = 2000},
    },
    ["3"] = {
        ["name"] = "黄金",
        [20221] = {[20395] = 10, [0] = 5000},
        [20222] = {[20395] = 20, [0] = 5000},
        [20223] = {[20395] = 10, [0] = 5000},
        [20224] = {[20394] = 10, [0] = 5000},
        [20225] = {[20394] = 10, [0] = 5000},
        [20226] = {[20394] = 10, [0] = 5000},
        [20227] = {[20394] = 10, [0] = 5000},
        [20228] = {[20394] = 10, [0] = 5000},
    },
    ["4"] = {
        ["name"] = "钻石",
        [20231] = {[20393] = 10, [0] = 10000},
        [20232] = {[20393] = 20, [0] = 10000},
        [20233] = {[20393] = 10, [0] = 10000},
        [20234] = {[20392] = 10, [0] = 10000},
        [20235] = {[20392] = 10, [0] = 10000},
        [20236] = {[20392] = 10, [0] = 10000},
        [20237] = {[20392] = 10, [0] = 10000},
        [20238] = {[20392] = 10, [0] = 10000},
    },
    ["5"] = {
        ["name"] = "星耀",
        [20241] = {[20391] = 10, [0] = 15000},
        [20242] = {[20391] = 20, [0] = 15000},
        [20243] = {[20391] = 10, [0] = 15000},
        [20244] = {[20390] = 10, [0] = 15000},
        [20245] = {[20390] = 10, [0] = 15000},
        [20246] = {[20390] = 10, [0] = 15000},
        [20247] = {[20390] = 10, [0] = 15000},
        [20248] = {[20390] = 10, [0] = 15000},
    },
    ["6"] = {
        ["name"] = "王者",
        [20251] = {[20389] = 10, [0] = 20000},
        [20252] = {[20389] = 20, [0] = 20000},
        [20253] = {[20389] = 10, [0] = 20000},
        [20254] = {[20388] = 10, [0] = 20000},
        [20255] = {[20388] = 10, [0] = 20000},
        [20256] = {[20388] = 10, [0] = 20000},
        [20257] = {[20388] = 10, [0] = 20000},
        [20258] = {[20388] = 10, [0] = 20000},
    },
    ["7"] = {
        ["name"] = "荣耀",
        [20261] = {[20387] = 10, [0] = 30000},
        [20262] = {[20387] = 20, [0] = 30000},
        [20263] = {[20387] = 10, [0] = 30000},
        [20264] = {[20386] = 10, [0] = 30000},
        [20265] = {[20386] = 10, [0] = 30000},
        [20266] = {[20386] = 10, [0] = 30000},
        [20267] = {[20386] = 10, [0] = 30000},
        [20268] = {[20386] = 10, [0] = 30000},
    },
}

local petSeller = {

}

sellerList = {
    [Const.NpcSeller] = {"宠物装备", petEquipSeller},
    [Const.NpcGoldCard] = {"金币兑换", {}},
    [Const.NpcGoldCard] = {"宠物兑换", petSeller},
}

sellerSkuList = {
}

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
            ["i"] = enemy:getImage(),
            ["n"] = "[宠物]" .. enemy:getName()
        }
    end
end

local function getSellItemImg(sellList)
    local imgList = {}
    for _, itemId in ipairs(sellList) do
        if itemId > 1000000 then
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

local function handleSkuItem(player, item, num)
    if rawget(sellerSkuList, item) == nil then
        player:sysMsg("系统异常，发放物品失败，联系GM")
        return
    end
    local sku = sellerSkuList[item]
    local itemType = sku[1]
    local itemId = sku[2]
    local itemNum = sku[3]
    if Const.SkuTypeGold == itemType then
        player:addMoney(itemNum * num)
    elseif Const.SkuTypeItem == itemType then
        player:addItem(itemId, itemNum * num)
    elseif Const.SkuTypePet == itemType then
        player:givePet(itemId)
    end
end

function buyNpcItem(player, arg)
    logPrint("buyNpcItem", arg)
    local parts = strSplit(arg, "#")
    local npcImg = tonumber(parts[1])
    local sellerList = sellerList[npcImg]
    if sellerList == nil then
        player:sysMsg("系统异常，售卖NPC不存")
        return
    end

    local itemList = sellerList[parts[2]][2]
    local needPayInfo = {}
    local buyInfo = {}
    local sum = 0
    local petSum = 0
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
                needPayInfo[payItem] = payNum
            else
                needPayInfo[payItem] = needPayInfo[payItem] + payNum * buyNum
            end
        end

        buyInfo[buyItem] = buyNum
        local useBagNum = math.ceil(buyNum / getMaxStackCount(buyItem))
        if npcImg == Const.NpcGoldCard then
            useBagNum = 1
        end

        sum = sum + useBagNum
    end
    if sum > player:freeBagNum() then
        player:sysMsg("物品栏空间不足，购买失败")
        return
    end
    logPrint(needPayInfo)
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
    logPrintTbl(buyInfo)
    for item, num in pairs(buyInfo) do
        if item > Const.SkuBaseItemId then
            handleSkuItem(player, item, num)
        else
            player:addItem(item, num)
        end
        if Const.NpcGoldCard == npcImg then
            statsGoldCardTrade(item, num)
        end
    end
    player:flush()
    player:sysMsg("购买成功");
end

local function registerSeller()
    for sellerId, _ in pairs(sellerList) do
        npcDialog[sellerId] = showSeller;
    end
end

ClientEvent["buy_item"] = buyNpcItem;
ClientEvent["init_seller"] = initSeller;
registerSeller()