local itemMap = {}
local itemInfoMap = {}
local attrFunc = {
    ["hp"] = "getHP",
    ["mp"] = "getMP",
    ["atk"] = "getAttack",
    ["def"] = "getDefense",
    ["agi"] = "getAgility",
    ["crit"] = "getCritical",
    ["avoid"] = "getDodge",
    ["hit"] = "getHit",
    ["counter"] = "getCounter",
    ["spirit"] = "getSpirit",
    ["recover"] = "getRecovery",
    ["adm"] = "getAdm",
    ["poison"] = "getPoisonResistance",
    ["sleep"] = "getSleepResistance",
    ["stone"] = "getStoneResistance",
    ["drunk"] = "getDrunkResistance",
    ["confusion"] = "getConfusionResistance",
    ["amnesia"] = "getForgetResistance",
    ["rss"] = "getMagicResistance",
    ["level"] = "getLevel",
    ["remain"] = "getMaxDurability",
    ["type"] = "getType",
}

local function getItem(itemId)
    if rawget(itemMap, itemId) ~= nil then
        return itemMap[itemId]
    end
    logPrint("item not found: ", itemId)
    local item = MyDataItem:new(itemId)
    itemMap[itemId] = item
    return item;
end

local function getItemInfo(itemId, resp)
    local item = getItem(itemId)
    for k, v in pairs(attrFunc) do
        local method = MyItem[v]
        local val = method(item) or 0
        if val > 0 then
            resp[k] = val
        end
    end
    resp["name"] = item:getName()
end

local function getSkuItemInfo(item, resp)
    if rawget(sellerSkuList, item) == nil then
        player:sysMsg("ÏµÍ³Òì³£")
        return getItemInfo(29999, resp)
    end

    local sku = sellerSkuList[item]
    local itemType = sku[1]
    local itemId = sku[2]
    local itemNum = sku[3]
    if Const.SkuTypeGold == itemType then
        resp["name"] = tostring(itemNum) .. "GÄ§±Ò"
        resp["level"] = 1
        resp["remain"] = 1
        resp["type"] = 98
    elseif Const.SkuTypeItem == itemType then
        getItemInfo(itemId, resp)
    elseif Const.SkuTypePet == itemType then
        local enemy = MyEnemyData:new(itemId)
        resp["vital"] = enemy:getVital()
        resp["str"] = enemy:getStr()
        resp["tough"] = enemy:getTough()
        resp["quick"] = enemy:getQuick()
        resp["magic"] = enemy:getMagic()
        resp["art"] = enemy:getVital() + enemy:getStr() + enemy:getTough() + enemy:getQuick() + enemy:getMagic()
        resp["level"] = 1
        resp["remain"] = 1
        resp["type"] = 99
    end
end

function getSellItemInfo(player, arg)
    local arr = strSplit(arg, ",")
    logPrintTbl(arr)
    local itemId = tonumber(arr[2]);
    if rawget(itemInfoMap, itemId) ~= nil then
        Protocol.PowerSend(player:getObj(), arr[1], itemInfoMap[itemId])
        return
    end

    local resp = {}
    resp["id"] = itemId
    if itemId > 1000000 then
        getSkuItemInfo(itemId, resp)
    else
        getItemInfo(itemId, resp)
    end

    itemInfoMap[itemId] = resp
    Protocol.PowerSend(player:getObj(), arr[1], resp)
end

ClientEvent["item_info"] = getSellItemInfo;