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

function getItemInfo(player, arg)
    local arr = strSplit(arg, ",")
    logPrintTbl(arr)
    local itemId = tonumber(arr[2]);
    if rawget(itemInfoMap, itemId) ~= nil then
        logPrintTbl(itemInfoMap[itemId])
        Protocol.PowerSend(player:getObj(), arr[1], itemInfoMap[itemId])
        return
    end

    local resp = {}
    local item = getItem(itemId)
    logPrintTbl(item)
    for k, v in pairs(attrFunc) do
        local method = MyItem[v]
        logPrint("method: ", v)
        local val = method(item) or 0
        if val > 0 then
            resp[k] = val
        end
    end
    resp["name"] = item:getName()
    resp["id"] = itemId
    itemInfoMap[itemId] = resp
    logPrintTbl(resp)
    Protocol.PowerSend(player:getObj(), arr[1], resp)
end

ClientEvent["item_info"] = getItemInfo;