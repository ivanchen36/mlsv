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
    ["name"] = "getName",
    ["type"] = "getType",
}

local function getItem(itemId)
    if rawget(itemMap, itemId) == nil then
        return itemMap[itemId]
    end

    local item = MyItem:create(itemId)
    itemMap[itemId] = item
    return item;
end

function getItemInfo(player, arg)
    local arr = strSplit(arg, ",")
    local itemId = tonumber(arr[2]);
    if rawget(itemInfoMap, itemId) ~= nil then
        Protocol.PowerSend(player:getObj(), arr[1], itemInfoMap[itemId])
        return
    end

    local resp = {}
    local item = getItem(itemId)
    for k, v in pairs(attrFunc) do
        local method = MyItem[v]
        local val = method(item) or 0
        if val > 0 then
            resp[k] = val
        end
    end
    resp["id"] = itemId
    itemInfoMap[itemId] = resp
    Protocol.PowerSend(player:getObj(), arr[1], resp)
end

ClientEvent["item_info"] = getItemInfo;