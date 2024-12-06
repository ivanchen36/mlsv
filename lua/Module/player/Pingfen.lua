
local baseAttrVal = {
    ["x"] = "hp",
    ["m"] = "mp",
    ["g"] = "atk",
    ["f"] = "def",
    ["m"] = "agi",
}

local otherAttrVal = {
    ["x"] = "crit",
    ["m"] = "avoid",
    ["g"] = "hit",
    ["f"] = "spirit",
    ["m"] = "agi",
}

function showPingFen(player)
    logPrint("showPingFen: ")
    local info = {}
    local baseAttr = {}
    local otherAttr = {}
    local sum = 0
    local val = 0
    for k, v in pairs(baseAttrVal) do
        val = getAttr(player, v)
        baseAttr[k] = val
        sum = val + sum
    end
    info["base"] = baseAttr
    for k, v in pairs(otherAttrVal) do
        val = getAttr(player, v)
        otherAttr[k] = val
        sum = val + sum
    end
    info["other"] = otherAttr
    info["pf"] = sum
    logPrintTbl(info)
    Protocol.PowerSend(player:getObj(), "SHOW_PING_FEN", info)
end

TalkEvent["[pf]"] = showPingFen
