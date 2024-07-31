local petSellerId = 104387
local petEquipSeller = {
    ["1"] = {
        ["name"] = "青铜",
        [20201] = {[20399] = 10, [0] = 1000},
        [20202] = {[20399] = 10, [0] = 1000},
        [20203] = {[20399] = 20, [0] = 1000},
        [20204] = {[20398] = 10, [0] = 1000},
        [20205] = {[20398] = 10, [0] = 1000},
        [20206] = {[20398] = 10, [0] = 1000},
        [20207] = {[20398] = 10, [0] = 1000},
        [20208] = {[20398] = 10, [0] = 1000},
    },
    ["2"] = {
        ["name"] = "白银",
        [20211] = {[20397] = 10, [0] = 2000},
        [20212] = {[20397] = 10, [0] = 2000},
        [20213] = {[20397] = 20, [0] = 2000},
        [20214] = {[20396] = 10, [0] = 2000},
        [20215] = {[20396] = 10, [0] = 2000},
        [20216] = {[20396] = 10, [0] = 2000},
        [20217] = {[20396] = 10, [0] = 2000},
        [20218] = {[20396] = 10, [0] = 2000},
    },
    ["3"] = {
        ["name"] = "黄金",
        [20241] = {[20391] = 10, [0] = 15000},
        [20242] = {[20391] = 10, [0] = 15000},
        [20243] = {[20391] = 20, [0] = 15000},
        [20244] = {[20390] = 10, [0] = 15000},
        [20245] = {[20390] = 10, [0] = 15000},
        [20246] = {[20390] = 10, [0] = 15000},
        [20247] = {[20390] = 10, [0] = 15000},
        [20248] = {[20390] = 10, [0] = 15000},
    },
    ["4"] = {
        ["name"] = "铂金",
        [20231] = {[20395] = 10, [0] = 25000},
        [20232] = {[20395] = 10, [0] = 25000},
        [20233] = {[20395] = 20, [0] = 25000},
        [20234] = {[20394] = 10, [0] = 25000},
        [20235] = {[20394] = 10, [0] = 25000},
        [20236] = {[20394] = 10, [0] = 25000},
        [20237] = {[20394] = 10, [0] = 25000},
        [20238] = {[20394] = 10, [0] = 25000},
    },
    ["5"] = {
        ["name"] = "钻石",
        [20251] = {[20393] = 10, [0] = 30000},
        [20252] = {[20393] = 10, [0] = 30000},
        [20253] = {[20393] = 20, [0] = 30000},
        [20254] = {[20392] = 10, [0] = 30000},
        [20255] = {[20392] = 10, [0] = 30000},
        [20256] = {[20392] = 10, [0] = 30000},
        [20257] = {[20392] = 10, [0] = 30000},
        [20258] = {[20392] = 10, [0] = 30000},
    },
    ["6"] = {
        ["name"] = "王者",
        [20251] = {[20389] = 10, [0] = 20000},
        [20252] = {[20389] = 10, [0] = 20000},
        [20253] = {[20389] = 20, [0] = 20000},
        [20254] = {[20388] = 10, [0] = 20000},
        [20255] = {[20388] = 10, [0] = 20000},
        [20256] = {[20388] = 10, [0] = 20000},
        [20257] = {[20388] = 10, [0] = 20000},
        [20258] = {[20388] = 10, [0] = 20000},
    },
    ["7"] = {
        ["name"] = "荣耀",
        [20261] = {[20387] = 10, [0] = 30000},
        [20262] = {[20387] = 10, [0] = 30000},
        [20263] = {[20387] = 20, [0] = 30000},
        [20264] = {[20386] = 10, [0] = 30000},
        [20265] = {[20386] = 10, [0] = 30000},
        [20266] = {[20386] = 10, [0] = 30000},
        [20267] = {[20386] = 10, [0] = 30000},
        [20268] = {[20386] = 10, [0] = 30000},
    },
}
local goldImgId = 27402
local sellerList = {
    [petSellerId] = petEquipSeller
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

local function getSellItemImg(sellList)
    local imgList = {}
    for _, itemId in ipairs(sellList) do
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
    for _, itemId in ipairs(payList) do
        if itemId == 0 then
            payNumList[itemId] = {
                ["c"] = player:getGold(),
                ["i"] = goldImgId,
            }
        else
            payNumList[itemId] = {
                ["c"] = player:getItemNum(itemId),
                ["i"] = getItemImg(itemId),
            }
        end
    end
    return payNumList
end

function showSeller(npc, player, s)
    logPrint("showSeller")

    local imgId = MyPlayer:new(npc):getImage()
    local seller = sellerList[imgId]
    local resp = {}
    local sellList, payList = getSellAndPayItem(seller)

    resp["name"] = "宠物装备"
    resp["id"] = imgId
    resp["good"] = seller
    resp["img"] = getSellItemImg(sellList)
    resp["free"] = player:freeBagNum()
    resp["pay"] = getPayItemNum(player, payList)
    logPrintTbl(resp)
    Protocol.PowerSend(player:getObj(), "SHOW_SELLER", resp)
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