local bossMap = {
    [imgId] = {encountId, enemyId, amount}
}

local encountTpl = "3|0,0,0,0||0|||||0|%d|||||||||"
local addBossAttrList = { }
local bossBattleMap = {}
local bossAddRate = {0, 100 ,200}

local function modifyAttr(bossId, challengeLevel)
    for i = 10, 19 do
        local enemy = MyEnemy:new(Battle.GetPlayer(battleIndex, i))
        if enemy:isValid() then

        end
    end
end

function modifyBossAttr(battleIndex)
    if rawget(bossBattleMap, battleIndex) == nil then
        return
    end

    local arr = bossBattleMap[battleIndex]
    local bossId = arr[1]
    local challengeLevel = arr[2]
    bossBattleMap[battleIndex] = nil
    modifyAttr(bossId, challengeLevel)
end

function challengeBoss(player, arg)
    local arr = split(arg, ",")
    local challengeLevel = tonumber(arr[1])
    local bossId = tonumber(arr[2])
    local bossInfo = bossMap[bossId]
    if player:subMoney(bossInfo[3]) <= 0 then
        player:sysMsg("金币不足，挑战失败。")
        return
    end
    local battleIndex = Battle.Encount(player:getObj(), player:getObj(), string.format(encountTpl, bossInfo[1]))
    if battleIndex < 0 then
        player:sysMsg("系统异常，挑战失败。")
        return
    end

    bossBattleMap[battleIndex] = {bossId, challengeLevel}
end

function showChallenge(npc, player, s)
    local resp = {}
    local npcPlayer = MyPlayer:new(npc)
    local imgId = npcPlayer:getImage()

    local bossInfo = bossMap[imgId]
    local enemy = MyEnemyData:new(bossInfo[2])
    local attr = enemy:getAttr()

    resp["id"] = imgId
    resp["amount"] = bossInfo[3]
    resp["name"] = enemy:getName()
    for k, v in pairs(attr) do
        resp[k] = v
    end

    Protocol.PowerSend(player:getObj(), "INIT_SELLER", resp)
end

local function registerChallenge()
    for bossId, _ in pairs(bossMap) do
        npcDialog[bossId] = showChallenge;
    end
end

clientEvent["challenge_boss"] = challengeBoss
InitEvent["battle"] = modifyBossAttr
registerChallenge()