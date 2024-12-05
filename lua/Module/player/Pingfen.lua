
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

function getPingFenAmount(player)
    local gold = player:getMaxMp() - player:getMp()
    local gold1 = math.floor((player:getMaxHp() - player:getHp()) / 2)
    if gold1 > gold then
        gold = gold1
    end
    if player:getJob() == 1 or (player:getJob() > 200 and player:getJob() < 500) then
        return gold
    end
    local gold2 = (player:getLevel() - 1) * 15 + 1375
    if gold2 < gold then
        gold = gold2
    end

    return gold
end

function partyPingFen(player, arg)
    local num = player:getPartyNum()

    for i = 1, num do
        local member = player:getPartyMember(i - 1)
        local amount = getPingFenAmount(member)
        if player:subMoney(amount) > 0 then
            player:PingFenHp()
            player:PingFenMp()
            for i = 0, 4 do
                local pet = player:getPet(i)
                if pet:isValid() then
                    pet:PingFenHp()
                    pet:PingFenMp()
                    pet:flush()
                end
            end
            player:flush()
            player:sysMsg("恢复成功，您的生命和魔力已经恢复。")
            return
        else
            player:sysMsg("恢复失败，您的魔币不足" .. amount .. "G。")
        end
    end
end

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

TalkEvent["[pk]"] = showPingFen
