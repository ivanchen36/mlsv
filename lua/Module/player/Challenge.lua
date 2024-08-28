local bossMap = {
    --[imgId] = {encountId, enemyId, gold, {hp, atk,def,agi, mp,recover,spirit}}
    [109345] = {30001, 35002, 1000, {1000, 800, 500, 500, 1000, 100, 100}},--��Ӱ����
    [110760] = {30002, 35007, 1000, {1000, 800, 500, 500, 1000, 100, 100}},--ɭ�ְ���
    [120084] = {30003, 35012, 1000, {1000, 800, 500, 500, 1000, 100, 100}},--������ħ
    [101782] = {30004, 35017, 1000, {1000, 800, 500, 500, 1000, 100, 100}},--��˪����
    [120076] = {30005, 35022, 1000, {1000, 800, 500, 500, 1000, 100, 100}},--��ʯ����
    [108331] = {30006, 35027, 1000, {1000, 800, 500, 500, 1000, 100, 100}},--����ս��
    [108035] = {30007, 35032, 1000, {1000, 800, 500, 500, 1000, 100, 100}},--�����
    [109258] = {30008, 35037, 1000, {1000, 800, 500, 500, 1000, 100, 100}},--������
    [104803] = {30009, 35042, 1000, {1000, 800, 500, 500, 1000, 100, 100}},--����ħ��ʦ

    [104931] = {30010, 35047, 1000, {1000, 800, 500, 500, 1000, 100, 100}},--��������
    [115118] = {30011, 35052, 1000, {1000, 800, 500, 500, 1000, 100, 100}},--��Ӱ����
    [104840] = {30012, 35057, 1000, {1000, 800, 500, 500, 1000, 100, 100}},--��ʯ����
    [104964] = {30013, 35062, 1000, {1000, 800, 500, 500, 1000, 100, 100}},--����ʥ��ʿ
    [120096] = {30014, 35067, 1000, {1000, 800, 500, 500, 1000, 100, 100}},--���鴬��
    [115063] = {30015, 35072, 1000, {1000, 800, 500, 500, 1000, 100, 100}},--��ѩŮ��
    [115093] = {30016, 35077, 1000, {1000, 800, 500, 500, 1000, 100, 100}},--����ħ��
    [109351] = {30017, 35082, 1000, {1000, 800, 500, 500, 1000, 100, 100}},--����ʥ��
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
        player:sysMsg("��Ҳ��㣬��սʧ�ܡ�")
        return
    end
    local battleIndex = Battle.Encount(player:getObj(), player:getObj(), string.format(encountTpl, bossInfo[1]))
    if battleIndex < 0 then
        player:sysMsg("ϵͳ�쳣����սʧ�ܡ�")
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