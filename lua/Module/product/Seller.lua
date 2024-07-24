local petSellerId = 111
local petEquipSeller = {
    ["1"] = {
        ["name"] = "青铜",
        [40201] = {40299, 10},
        [40202] = {40299, 10},
        [40203] = {40299, 20},
        [40204] = {40298, 10},
        [40205] = {40298, 10},
        [40206] = {40298, 10},
        [40207] = {40298, 10},
        [40208] = {40298, 10},
    },
    ["2"] = {
        ["name"] = "白银",
        [40211] = {40297, 10},
        [40212] = {40297, 10},
        [40213] = {40297, 20},
        [40214] = {40296, 10},
        [40215] = {40296, 10},
        [40216] = {40296, 10},
        [40217] = {40296, 10},
        [40218] = {40296, 10},
    },
    ["3"] = {
        ["name"] = "黄金",
        [40221] = {40295, 10},
        [40222] = {40295, 10},
        [40223] = {40295, 20},
        [40224] = {40294, 10},
        [40225] = {40294, 10},
        [40226] = {40294, 10},
        [40227] = {40294, 10},
        [40228] = {40294, 10},
    },
    ["4"] = {
        ["name"] = "钻石",
        [40231] = {40293, 10},
        [40232] = {40293, 10},
        [40233] = {40293, 20},
        [40234] = {40292, 10},
        [40235] = {40292, 10},
        [40236] = {40292, 10},
        [40237] = {40292, 10},
        [40238] = {40292, 10},
    },
    ["5"] = {
        ["name"] = "星耀",
        [40241] = {40291, 10},
        [40242] = {40291, 10},
        [40243] = {40291, 20},
        [40244] = {40290, 10},
        [40245] = {40290, 10},
        [40246] = {40290, 10},
        [40247] = {40290, 10},
        [40248] = {40290, 10},
    },
    ["6"] = {
        ["name"] = "王者",
        [40251] = {40289, 10},
        [40252] = {40289, 10},
        [40253] = {40289, 20},
        [40254] = {40288, 10},
        [40255] = {40288, 10},
        [40256] = {40288, 10},
        [40257] = {40288, 10},
        [40258] = {40288, 10},
    },
    ["7"] = {
        ["name"] = "荣耀",
        [40261] = {40287, 10},
        [40262] = {40287, 10},
        [40263] = {40287, 20},
        [40264] = {40286, 10},
        [40265] = {40286, 10},
        [40266] = {40286, 10},
        [40267] = {40286, 10},
        [40268] = {40286, 10},
    },
}

local sellerList = {
    [petSellerId] = petEquipSeller
}

local function getSellAndPayItem(seller)
    local sellList = {}
    local payList = {}
    for _, tmpList in pairs(seller) do
        for k, v in pairs(tmpList) do
            if k ~= "name" then
                if rawget(sellList, k) == nil then
                    table.insert(sellList, k)
                end
                if rawget(payList, v[1]) == nil then
                    table.insert(payList, v[1])
                end
            end
        end
    end

    return sellList, payList
end

local function getSellItemImg(sellList)
    local imgList = {}
    for itemId in ipairs(sellList) do
        local item = MyDataItem:new(itemId)
        imgList[itemId] = {
            ["i"] = item:getImage(),
            ["n"] = item:getName()
        }
    end
    return imgList
end

local function getPayItemNum(player, payList)
    local payNumList = {}
    for itemId in ipairs(payList) do
        payNumList[itemId] = {
            ["c"] = player:getItemNum(itemId),
            ["i"] = getItemImg(itemId),
        }
    end
    return payNumList
end

function showSeller(npc, player, s)
    local imgId = MyPlayer:new(npc):getImage()
    local seller = sellerList[imgId]
    local resp = {}
    local sellList, payList = getSellAndPayItem(seller)
    resp["name"] = "宠物装备兑换"
    resp["id"] = imgId
    resp[imgId] = seller
    resp["img"] = getSellItemImg(sellList)
    resp["free"] = player:freeBagNum()
    resp["pay"] = getPayItemNum(player, payList)

    Protocol.PowerSend(player:getObj(), "SHOW_WARP", resp)
end

function buyNpcItem(player, arg)
    local parts = strSplit(arg, "#")
    local npcImg = tonumber(parts[1])
    local sellerList = sellerItemList[npcImg]
    if sellerList == nil then
        player:sysMsg("系统异常，售卖NPC不存")
        return
    end

    local itemList = sellerList[parts[2]]
    local needPayInfo = {}
    local buyInfo = {}
    local sum = 0
    for i = 3, #parts do
        local itemArr = strSplit(parts[i], ",")
        local buyItem = tonumber(itemArr[1])
        local buyNum = tonumber(itemArr[2])
        if rawget(itemList, buyItem) == nil then
            player:sysMsg("系统异常，您购买的商品不存在")
            return
        end
        local payInfo = itemList[buyItem]
        local payItem =  payInfo[1]
        local payNum =  payInfo[2] * buyNum
        if rawget(needPayInfo, payItem) == nil then
            needPayInfo[payItem] = payNum
        else
            needPayInfo[payItem] = needPayInfo[payItem] + payNum
        end
        buyInfo[buyItem] = buyNum
        sum = sum + buyNum
    end
    if sum > player:freeBagNum() then
        player:sysMsg("物品栏空间不足，购买失败")
        return
    end
    for item, num in pairs(needPayInfo) do
        if player:getItemNum(item) < num then
            player:sysMsg("您需要的道具" .. getItemName(item) .. "不足" .. num .. "个")
            return
        end
    end
    for item, num in pairs(needPayInfo) do
        if player:delItem(item, num) <= 0 then
            player:sysMsg("扣除 " .. getItemName(item) .. " 失败");
            return 0
        end
    end

    for item, num in pairs(buyInfo) do
        player:addItem(item, num)
    end
    player:sysMsg("购买成功");
end

ClientEvent["buy_item"] = buyNpcItem;
npcDialog[petSellerId] = showSeller;