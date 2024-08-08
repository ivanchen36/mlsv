local bossMap = {
    [101934] = {30001, 35001, 1000}
}

local encountTpl = "3|0,0,0,0||0|||||0|%d|||||||||"
local addBossAttrList = {"hp","atk","def","agi","mp","recover","spirit"}
local bossBattleMap = {}
local bossAddRate = {0, 50 ,100}

local function modifyAttr(battleIndex, enemyId, challengeLevel)
    local addRate = bossAddRate[challengeLevel]
    for i = 10, 19 do
        local enemy = MyEnemy:new(Battle.GetPlayer(battleIndex, i))
        if enemy:isValid() then
            local buffList= {
                ["hp"] = math.floor(enemy:getMaxHp() * addRate),
                ["mp"] = math.floor(enemy:getMaxMp() * addRate),
                ["atk"] = math.floor(enemy:getAttackPower() * addRate),
                ["def"] = math.floor(enemy:getDefensePower() * addRate),
                ["agi"] = math.floor(enemy:getAgility() * addRate),
                ["spirit"] = math.floor(enemy:getMagicStrength() * addRate),
                ["recover"] = math.floor(enemy:getRecoveryRate() * addRate),
            }
            addBuff(enemy, buffList)
            logPrint(enemy:getMaxHp())
            logPrint(enemy:getMaxMp())
            logPrint(enemy:getAttackPower())
            logPrint(enemy:getDefensePower())
            logPrint(enemy:getAgility())
            logPrint(enemy:getRecoveryRate())
            logPrint(enemy:getMagicStrength())
        end
    end
end

function modifyBossAttr(battleIndex)
    if rawget(bossBattleMap, battleIndex) == nil then
        return
    end

    local arr = bossBattleMap[battleIndex]
    local enemyId = arr[1]
    local challengeLevel = arr[2]
    bossBattleMap[battleIndex] = nil
    if challengeLevel > 1 then
        modifyAttr(battleIndex, enemyId, challengeLevel)
    end
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

    bossBattleMap[battleIndex] = {bossInfo[2], challengeLevel}
end

function showChallenge(npc, player, s)
    logPrint("showChallenge")
    local resp = {}
    local npcPlayer = MyPlayer:new(npc)
    local imgId = npcPlayer:getImage()

    local bossInfo = bossMap[imgId]
    local enemy = MyEnemyData:new(bossInfo[2])
    local attr = enemy:getAttr()

    resp["id"] = imgId
    resp["type"] = "jjc"
    resp["amount"] = bossInfo[3]
    resp["name"] = player:getName()
    resp["level"] = enemy:getLevel()
    resp["boss"] = npcPlayer:getName()
    resp["img"] = npcPlayer:getImage()
    for k, v in pairs(attr) do
        resp[k] = v
    end
    
    Protocol.PowerSend(player:getObj(), "SHOW_BOSS", resp)
end

local function registerChallenge()
    for bossId, _ in pairs(bossMap) do
        npcDialog[bossId] = showChallenge;
    end
end

ClientEvent["challenge_boss"] = challengeBoss
InitEvent["battle"] = modifyBossAttr
registerChallenge()