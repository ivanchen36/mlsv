
-- 定义一个名为 MyChar 的表
MyChar = {}
MyChar.__index = MyChar

-- 定义构造函数 new
function MyChar:new(player)
    local newObj = { _player = player }  -- 创建一个新的对象，包含一个名为 data 的字段，其值为 player
    setmetatable(newObj, self)       -- 设置新对象的元表为 MyChar
    return newObj                    -- 返回新创建的对象
end

function MyChar:getObj()
    return self._player
end

-- 定义 get 方法，用于获取玩家数据
function MyChar:get(key)
    return Char.GetData(self._player, key)  -- 使用 Char.GetData 函数获取玩家数据
end

-- 定义 set 方法，用于设置玩家数据
function MyChar:set(key, val)
    Char.SetData(self._player, key, val)  -- 使用 Char.SetData 函数设置玩家数据
end


function MyChar:needHp()
    return self:getHp() < self:getMaxHp()
end

function MyChar:recoverHp()
    self:setHp(self:getMaxHp())
    self:flush()
end

function MyChar:recoverHurt()
    self:setHurtStatus(0)
    NLG.UpdateParty(player);
    self:flush()
    NLG.SendGraphEvent(player, 45, 0);
end

function MyChar:isValid()
    return VaildChar(self._player)
end

--%对象_战死% 4000
function MyChar:getDie()
    return self:get(4000)
end
function MyChar:setDie(val)
    return self:set(4000, val)
end

--%对象_战斗信息开关% 4001
function MyChar:getBattleInfoSwitch()
    return self:get(4001)
end
function MyChar:setBattleInfoSwitch(val)
    return self:set(4001, val)
end

--%对象_登陆富豪榜% 4002
function MyChar:getRichListSwitch()
    return self:get(4002)
end
function MyChar:setRichListSwitch(val)
    return self:set(4002, val)
end

--%对象_组队开关% 4003
function MyChar:getTeamSwitch()
    return self:get(4003)
end
function MyChar:setTeamSwitch(val)
    return self:set(4003, val)
end

--%对象_PK开关% 4004 和 %对象_对战开关% 4004 (两者似乎相同，使用同一个函数)
function MyChar:getPkBattleSwitch()
    return self:get(4004)
end
function MyChar:setPkBattleSwitch(val)
    return self:set(4004, val)
end

--%对象_队聊开关% 4005
function MyChar:getTeamChatSwitch()
    return self:get(4005)
end
function MyChar:setTeamChatSwitch(val)
    return self:set(4005, val)
end

--%对象_名片开关% 4006
function MyChar:getCardSwitch()
    return self:get(4006)
end
function MyChar:setCardSwitch(val)
    return self:set(4006, val)
end

--%对象_交易开关% 4007
function MyChar:getTradeSwitch()
    return self:get(4007)
end
function MyChar:setTradeSwitch(val)
    return self:set(4007, val)
end

--%对象_打卡% 4008
function MyChar:getCheckIn()
    return self:get(4008)
end
function MyChar:setCheckIn(val)
    return self:set(4008, val)
end

--%对象_网络超时% 4009
function MyChar:getNetworkTimeout()
    return self:get(4009)
end
function MyChar:setNetworkTimeout(val)
    return self:set(4009, val)
end

--%对象_家族开关% 4010
function MyChar:getFamilySwitch()
    return self:get(4010)
end
function MyChar:setFamilySwitch(val)
    return self:set(4010, val)
end

--%对象_DEBUG开关% 6000
function MyChar:getDebugSwitch()
    return self:get(6000)
end
function MyChar:setDebugSwitch(val)
    return self:set(6000, val)
end

--%对象_使用MIC% 6001
function MyChar:getMicUsage()
    return self:get(6001)
end
function MyChar:setMicUsage(val)
    return self:set(6001, val)
end

--%对象_已保存% 6002
function MyChar:getSavedStatus()
    return self:get(6002)
end
function MyChar:setSavedStatus(val)
    return self:set(6002, val)
end

--%对象_不遇敌开关% 6003
function MyChar:getEnemyAvoidSwitch()
    return self:get(6003)
end

function MyChar:setEnemyAvoidSwitch(val)
    return self:set(6003, val)
end

--%对象_序% 0
function MyChar:getType()
    return self:get(0)
end
function MyChar:setType(val)
    return self:set(0, val)
end

--%对象_形象% 1
function MyChar:getImage()
    return self:get(1)
end
function MyChar:setImage(val)
    return self:set(1, val)
end

--%对象_可视% 1
function MyChar:isVisible()
    return self:get(1)
end
function MyChar:setVisible(val)
    return self:set(1, val)
end

--%对象_原形% 2
function MyChar:getOriginalForm()
    return self:get(2)
end
function MyChar:setOriginalForm(val)
    return self:set(2, val)
end

--%对象_MAP% 3
function MyChar:getMap()
    return self:get(3)
end
function MyChar:setMap(val)
    return self:set(3, val)
end

--%对象_地图% 4
function MyChar:getMapId()
    return self:get(4)
end
function MyChar:setMapId(val)
    return self:set(4, val)
end

--%对象_X% 5
function MyChar:getX()
    return self:get(5)
end
function MyChar:setX(val)
    return self:set(5, val)
end

--%对象_Y% 6
function MyChar:getY()
    return self:get(6)
end
function MyChar:setY(val)
    return self:set(6, val)
end

--%对象_方向% 7
function MyChar:getDirection()
    return self:get(7)
end
function MyChar:setDirection(val)
    return self:set(7, val)
end

--%对象_等级% 8
function MyChar:getLevel()
    return self:get(8)
end
function MyChar:setLevel(val)
    -- 可以在这里添加一些验证逻辑，比如确保等级不会低于0
    if val < 0 then
        return false, "等级不能低于0"
    end
    return self:set(8, val)
end
--%对象_血% 9
function MyChar:getHp()
    return self:get(9)
end
function MyChar:setHp(val)
    if val < 1 then
        val = 1
    end
    return self:set(9, val)
end
--%对象_魔% 10
function MyChar:getMp()
    return self:get(10)
end
function MyChar:setMp(val)
    if val < 1 then
        val = 1
    end
    return self:set(10, val)
end

--%对象_体力% 11
function MyChar:getStamina()
    return self:get(11)
end
function MyChar:setStamina(val)
    return self:set(11, val)
end

--%对象_力量% 12
function MyChar:getStrength()
    return self:get(12)
end
function MyChar:setStrength(val)
    return self:set(12, val)
end

--%对象_强度% 13
function MyChar:getIntensity()
    return self:get(13)
end
function MyChar:setIntensity(val)
    return self:set(13, val)
end

--%对象_速度% 14
function MyChar:getSpeed()
    return self:get(14)
end
function MyChar:setSpeed(val)
    return self:set(14, val)
end

--%对象_魔法% 15 (与对象_魔重复，考虑重命名或删除一个)

--%对象_运% 16
function MyChar:getLuck()
    return self:get(16)
end
function MyChar:setLuck(val)
    return self:set(16, val)
end

--%对象_种族% 17
function MyChar:getRace()
    return self:get(17)
end
function MyChar:setRace(val)
    return self:set(17, val)
end

--%对象_地属性% 18
function MyChar:getEarthAttribute()
    return self:get(18)
end
function MyChar:setEarthAttribute(val)
    return self:set(18, val)
end

--%对象_水属性% 19
function MyChar:getWaterAttribute()
    return self:get(19)
end
function MyChar:setWaterAttribute(val)
    return self:set(19, val)
end

--%对象_火属性% 20
function MyChar:getFireAttribute()
    return self:get(20)
end
function MyChar:setFireAttribute(val)
    return self:set(20, val)
end

--%对象_风属性% 21
function MyChar:getWindAttribute()
    return self:get(21)
end
function MyChar:setWindAttribute(val)
    return self:set(21, val)
end

--%对象_抗毒% 22
function MyChar:getPoisonResistance()
    return self:get(22)
end
function MyChar:setPoisonResistance(val)
    return self:set(22, val)
end

--%对象_抗睡% 23
function MyChar:getSleepResistance()
    return self:get(23)
end
function MyChar:setSleepResistance(val)
    return self:set(23, val)
end

--%对象_抗石% 24
function MyChar:getPetrifyResistance()
    return self:get(24)
end
function MyChar:setPetrifyResistance(val)
    return self:set(24, val)
end

--%对象_抗醉% 25
function MyChar:getDrunkResistance()
    return self:get(25)
end
function MyChar:setDrunkResistance(val)
    return self:set(25, val)
end

--%对象_抗乱% 26
function MyChar:getChaosResistance()
    return self:get(26)
end
function MyChar:setChaosResistance(val)
    return self:set(26, val)
end
--%对象_抗忘% 27
function MyChar:getForgetResistance()
    return self:get(27)
end
function MyChar:setForgetResistance(val)
    return self:set(27, val)
end

--%对象_必杀% 28
function MyChar:getCriticalHitChance()
    return self:get(28)
end
function MyChar:setCriticalHitChance(val)
    return self:set(28, val)
end

--%对象_反击% 29
function MyChar:getCounterAttackChance()
    return self:get(29)
end
function MyChar:setCounterAttackChance(val)
    return self:set(29, val)
end

--%对象_命中% 30
function MyChar:getHitRate()
    return self:get(30)
end
function MyChar:setHitRate(val)
    return self:set(30, val)
end

--%对象_闪躲% 31
function MyChar:getDodgeRate()
    return self:get(31)
end
function MyChar:setDodgeRate(val)
    return self:set(31, val)
end

--%对象_道具栏% 32
function MyChar:getItemSlots()
    return self:get(32)
end
function MyChar:setItemSlots(val)
    return self:set(32, val)
end

--%对象_技能栏% 33
function MyChar:getSkillSlots()
    return self:get(33)
end
function MyChar:setSkillSlots(val)
    return self:set(33, val)
end

--%对象_死亡数% 34
function MyChar:getDeathCount()
    return self:get(34)
end
function MyChar:setDeathCount(val)
    return self:set(34, val)
end

--%对象_伤害数% 35
function MyChar:getDamageCount()
    return self:get(35)
end
function MyChar:setDamageCount(val)
    return self:set(35, val)
end

--%对象_杀宠数% 36
function MyChar:getKilledPetCount()
    return self:get(36)
end
function MyChar:setKilledPetCount(val)
    return self:set(36, val)
end

--%对象_占卜时间% 37
function MyChar:getDivinationTime()
    return self:get(37)
end
function MyChar:setDivinationTime(val)
    return self:set(37, val)
end

--%对象_受伤% 38
function MyChar:getHurtStatus()
    return self:get(38)
end
function MyChar:setHurtStatus(val)
    return self:set(38, val)
end

--%对象_移间% 39
function MyChar:getMoveSpace()
    return self:get(39)
end
function MyChar:setMoveSpace(val)
    return self:set(39, val)
end

--%对象_循时% 40
function MyChar:getCycleTime()
    return self:get(40)
end
function MyChar:setCycleTime(val)
    return self:set(40, val)
end

--%对象_经验% 41
function MyChar:getExperience()
    return self:get(41)
end
function MyChar:setExperience(val)
    return self:set(41, val)
end

--%对象_升级点% 42
function MyChar:getUpgradePoints()
    return self:get(42)
end
function MyChar:setUpgradePoints(val)
    return self:set(42, val)
end

--%对象_图类% 43
function MyChar:getImageType()
    return self:get(43)
end
function MyChar:setImageType(val)
    return self:set(43, val)
end

--%对象_名色% 44
function MyChar:getNameColor()
    return self:get(44)
end
function MyChar:setNameColor(val)
    return self:set(44, val)
end

--%对象_RegistNumber% 48
function MyChar:getRegistNumber()
    return self:get(48)
end

function MyChar:setRegistNumber(val)
    return self:set(48, val)
end

--%对象_职业% 49
function MyChar:getJob()
    return self:get(49)
end
function MyChar:setJob(val)
    return self:set(49, val)
end

--%对象_职阶% 50
function MyChar:getJobRank()
    return self:get(50)
end
function MyChar:setJobRank(val)
    return self:set(50, val)
end

--%对象_职类ID% 51
function MyChar:getJobClassId()
    return self:get(51)
end
function MyChar:setJobClassId(val)
    return self:set(51, val)
end

--%对象_脸% 52
function MyChar:getFace()
    return self:get(52)
end
function MyChar:setFace(val)
    return self:set(52, val)
end

--%对象_金币% 53
function MyChar:getGold()
    return self:get(53)
end
function MyChar:setGold(val)
    return self:set(53, val)
end

--%对象_银行金币% 54
function MyChar:getBankGold()
    return self:get(54)
end
function MyChar:setBankGold(val)
    return self:set(54, val)
end

--%对象_耐力% 55
function MyChar:getStamina()
    return self:get(55)
end
function MyChar:setStamina(val)
    return self:set(55, val)
end

--%对象_灵巧% 56
function MyChar:getDexterity()
    return self:get(56)
end
function MyChar:setDexterity(val)
    return self:set(56, val)
end

--%对象_智力% 57
function MyChar:getIntelligence()
    return self:get(57)
end
function MyChar:setIntelligence(val)
    return self:set(57, val)
end

--%对象_魅力% 58
function MyChar:getCharm()
    return self:get(58)
end
function MyChar:setCharm(val)
    return self:set(58, val)
end

--%对象_声望% 59
function MyChar:getReputation()
    return self:get(59)
end
function MyChar:setReputation(val)
    return self:set(59, val)
end

--%对象_称号% 60
function MyChar:getTitle()
    return self:get(60)
end
function MyChar:setTitle(val)
    return self:set(60, val)
end

--%对象_记录点% 61
function MyChar:getRecordPoint()
    return self:get(61)
end
function MyChar:setRecordPoint(val)
    return self:set(61, val)
end

--%对象_战宠% 62
function MyChar:getBattlePet()
    return self:get(62)
end
function MyChar:setBattlePet(val)
    return self:set(62, val)
end

--%对象_聊天距离% 63
function MyChar:getChatDistance()
    return self:get(63)
end
function MyChar:setChatDistance(val)
    return self:set(63, val)
end

--%对象_HelpPoint% 64
function MyChar:getHelpPoint()
    return self:get(64)
end
function MyChar:setHelpPoint(val)
    return self:set(64, val)
end

--%对象_登陆次数% 65
function MyChar:getLoginCount()
    return self:get(65)
end
function MyChar:setLoginCount(val)
    return self:set(65, val)
end

--%对象_说次% 66
function MyChar:getTalkCount()
    return self:get(66)
end
function MyChar:setTalkCount(val)
    return self:set(66, val)
end

--%对象_宠得数% 67
function MyChar:getPetAcquireCount()
    return self:get(67)
end
function MyChar:setPetAcquireCount(val)
    return self:set(67, val)
end

--%对象_邮数% 68
function MyChar:getMailCount()
    return self:get(68)
end
function MyChar:setMailCount(val)
    return self:set(68, val)
end

--%对象_生产数% 69
function MyChar:getProductionCount()
    return self:get(69)
end
function MyChar:setProductionCount(val)
    return self:set(69, val)
end

--%对象_走次% 70
function MyChar:getWalkCount()
    return self:get(70)
end
function MyChar:setWalkCount(val)
    return self:set(70, val)
end

--%对象_宠死数% 71
function MyChar:getPetDeathCount()
    return self:get(71)
end
function MyChar:setPetDeathCount(val)
    return self:set(71, val)
end

--%对象_宠复数% 72
function MyChar:getPetRepeatCount()
    return self:get(72)
end
function MyChar:setPetRepeatCount(val)
    return self:set(72, val)
end

--%对象_宠治数% 73
function MyChar:getPetTreatCount()
    return self:get(73)
end
function MyChar:setPetTreatCount(val)
    return self:set(73, val)
end

--%对象_封印数% 74
function MyChar:getSealCount()
    return self:get(74)
end
function MyChar:setSealCount(val)
    return self:set(74, val)
end

--%对象_OtherFlg% 75
function MyChar:getOtherFlag()
    return self:get(75)
end
function MyChar:setOtherFlag(val)
    return self:set(75, val)
end

--%对象_日声望上限% 76
function MyChar:getDailyReputationCap()
    return self:get(76)
end
function MyChar:setDailyReputationCap(val)
    return self:set(76, val)
end

--%对象_声望获取时间% 77
function MyChar:getReputationGainTime()
    return self:get(77)
end
function MyChar:setReputationGainTime(val)
    return self:set(77, val)
end

--%对象_声望下降时间% 78
function MyChar:getReputationLossTime()
    return self:get(78)
end
function MyChar:setReputationLossTime(val)
    return self:set(78, val)
end

--%对象_掉魂% 79
function MyChar:getSoulDrop()
    return self:get(79)
end
function MyChar:setSoulDrop(val)
    return self:set(79, val)
end

--%对象_银行最大宠数% 159
function MyChar:getMaxBankPets()
    return self:get(159)
end
function MyChar:setMaxBankPets(val)
    return self:set(159, val)
end

--%对象_银行最大物数% 160
function MyChar:getMaxBankItems()
    return self:get(160)
end
function MyChar:setMaxBankItems(val)
    return self:set(160, val)
end

--%对象_DP% 161
function MyChar:getDP()
    return self:get(161)
end
function MyChar:setDP(val)
    return self:set(161, val)
end

--%对象_话色% 162
function MyChar:getTalkColor()
    return self:get(162)
end
function MyChar:setTalkColor(val)
    return self:set(162, val)
end

--%对象_位置% 163
function MyChar:getPosition()
    return self:get(163)
end
function MyChar:setPosition(val)
    return self:set(163, val)
end

--%对象_GM% 164
function MyChar:getGm()
    return self:get(164)
end
function MyChar:setGm(val)
    return self:set(164, val and 1 or 0)
end

--%对象_登陆点% 171
function MyChar:getLoginPoint()
    return self:get(171)
end
function MyChar:setLoginPoint(val)
    return self:set(171, val)
end

--%对象_卡时% 173
function MyChar:getStuckTime()
    return self:get(173)
end
function MyChar:setStuckTime(val)
    return self:set(173, val)
end

--%对象_房子ID% 174
function MyChar:getHouseID()
    return self:get(174)
end
function MyChar:setHouseID(val)
    return self:set(174, val)
end

--%对象_房子期限% 175
function MyChar:getHouseExpiration()
    return self:get(175)
end
function MyChar:setHouseExpiration(val)
    return self:set(175, val)
end

--%对象_原始图档% 178
function MyChar:getOriginalImage()
    return self:get(178)
end
function MyChar:setOriginalImage(val)
    return self:set(178, val)
end

--%对象_名字% 2000
function MyChar:getName()
    return self:get(2000)
end
function MyChar:setName(val)
    return self:set(2000, val)
end

--%对象_原名% 2000 (与对象_名字重复，可能是一个错误，这里假设它们是同一个属性)
function MyChar:getOriginalName()
    return self:get(2000)
end
function MyChar:setOriginalName(val)
    return self:set(2000, val)
end

--%对象_玩家称号% 2001
function MyChar:getTitle()
    return self:get(2001)
end
function MyChar:setTitle(val)
    return self:set(2001, val)
end

--%对象_宠名% 2001 (与对象_玩家称号重复，可能是一个错误，这里假设它们是同一个属性)
function MyChar:getPetName()
    return self:get(2001)
end
function MyChar:setPetName(val)
    return self:set(2001, val)
end

--%对象_CDK% 2002
function MyChar:getCdk()
    return self:get(2002)
end
function MyChar:setCdk(val)
    return self:set(2002, val)
end

--%对象_账号% 2002
function MyChar:getAccountId()
    return self:get(2002)
end
function MyChar:setAccountId(val)
    return self:set(2002, val)
end

--%对象_主人CDK% 2003
function MyChar:getOwnerCdk()
    return self:get(2003)
end
function MyChar:setOwnerCdk(val)
    return self:set(2003, val)
end

--%对象_主人名字% 2004
function MyChar:getOwnerName()
    return self:get(2004)
end
function MyChar:setOwnerName(val)
    return self:set(2004, val)
end

--%对象_主人原名% 2004 (与对象_主人名字相同)
function MyChar:getOwnerOriginalName()
    return self:get(2004)
end
function MyChar:setOwnerOriginalName(val)
    return self:set(2004, val)
end

--%对象_战斗中% 8000
function MyChar:isInBattle()
    return self:get(8000)
end
function MyChar:setInBattle(val)
    return self:set(8000, val)
end

--%对象_战斗状态% 8000 (与对象_战斗中相同)
function MyChar:getBattleStatus()
    return self:get(8000)
end
function MyChar:setBattleStatus(val)
    return self:set(8000, val)
end

--%对象_战斗Index% 8001
function MyChar:getBattleIndex()
    return self:get(8001)
end
function MyChar:setBattleIndex(val)
    return self:set(8001, val)
end

--%对象_战斗Side% 8002
function MyChar:getBattleSide()
    return self:get(8002)
end
function MyChar:setBattleSide(val)
    return self:set(8002, val)
end

--%对象_最大血% 8015
function MyChar:getMaxHp()
    return self:get(8015)
end
function MyChar:setMaxHp(val)
    return self:set(8015, val)
end

--%对象_最大魔% 8016
function MyChar:getMaxMp()
    return self:get(8016)
end
function MyChar:setMaxMp(val)
    return self:set(8016, val)
end

--%对象_攻击力% 8017
function MyChar:getAttackPower()
    return self:get(8017)
end
function MyChar:setAttackPower(val)
    return self:set(8017, val)
end

--%对象_防御力% 8018
function MyChar:getDefensePower()
    return self:get(8018)
end
function MyChar:setDefensePower(val)
    return self:set(8018, val)
end

--%对象_敏捷% 8019
function MyChar:getAgility()
    return self:get(8019)
end
function MyChar:setAgility(val)
    return self:set(8019, val)
end

--%对象_魔法攻击力% 8020
function MyChar:getMagicAttackPower()
    return self:get(8020)
end
function MyChar:setMagicAttackPower(val)
    return self:set(8020, val)
end

--%对象_魔强% 8020 (与魔法攻击力似乎是同一个属性，因此使用相同的函数)
function MyChar:getMagicStrength()
    return self:get(8020)
end
function MyChar:setMagicStrength(val)
    return self:set(8020, val)
end

--%对象_回复% 8021
function MyChar:getRecoveryRate()
    return self:get(8021)
end
function MyChar:setRecoveryRate(val)
    return self:set(8021, val)
end

--%对象_OBJ% 8065
function MyChar:getObject()
    return self:get(8065)
end
function MyChar:setObject(val)
    return self:set(8065, val)
end

--%对象_获得经验% 8072 (与战得DP似乎是同一个属性，因此使用相同的函数)
function MyChar:getExperienceGain()
    return self:get(8072)
end
function MyChar:setExperienceGain(val)
    return self:set(8072, val)
end

--%对象_战得DP% 8072 (与获得经验似乎是同一个属性，因此使用相同的函数)
-- 注意：这里不再重复定义函数，因为与上面的获得经验使用相同的函数。
--%对象_组队模式% 8117
function MyChar:getTeamMode()
    return self:get(8117)
end
function MyChar:setTeamMode(val)
    return self:set(8117, val)
end

--%对象_香下限% 8150
function MyChar:getIncenseLowerLimit()
    return self:get(8150)
end
function MyChar:setIncenseLowerLimit(val)
    return self:set(8150, val)
end

--%对象_香上限% 8151
function MyChar:getIncenseUpperLimit()
    return self:get(8151)
end
function MyChar:setIncenseUpperLimit(val)
    return self:set(8151, val)
end

--%对象_香步数% 8152
function MyChar:getIncenseStepCount()
    return self:get(8152)
end
function MyChar:setIncenseStepCount(val)
    return self:set(8152, val)
end

--%BOUNS_DEFENCE% 20000
function MyChar:getBounsDefence()
    return self:get(20000)
end
function MyChar:setBounsDefence(val)
    return self:set(20000, val - (self:getBounsDefence() or 0))
end

--%BOUNS_ATTACK% 20001
function MyChar:getBounsAttack()
    return self:get(20001)
end
function MyChar:setBounsAttack(val)
    return self:set(20001, val - (self:getBounsAttack() or 0))
end

--%BOUNS_AGILITY% 20002
function MyChar:getBounsAgility()
    return self:get(20002)
end
function MyChar:setBounsAgility(val)
    return self:set(20002, val - (self:getBounsAgility() or 0))
end

--%BOUNS_MAGIC% 20003
function MyChar:getBounsMagic()
    return self:get(20003)
end
function MyChar:setBounsMagic(val)
    self:set(20003, val - (self:getBounsMagic() or 0))
    return self:setMp(self:getMp() + val)
end

--%BOUNS_RECOVERY% 20004
function MyChar:getBounsRecovery()
    return self:get(20004)
end
function MyChar:setBounsRecovery(val)
    return self:set(20004, val - (self:getBounsRecovery() or 0))
end

--%BOUNS_HP% 20005
function MyChar:getBounsHp()
    return self:get(20005)
end
function MyChar:setBounsHp(val)
    self:set(20005, val - (self:getBounsHp() or 0))
    return self:setHp(self:getHp() + val)
end

--%BOUNS_FORCEPOINT% 20006
function MyChar:getBounsForcepoint()
    return self:get(20006)
end
function MyChar:setBounsForcepoint(val)
    return self:set(20006, val - (self:getBounsForcepoint() or 0))
end

--%BOUNS_LUCK% 20007
function MyChar:getBounsLuck()
    return self:get(20007)
end
function MyChar:setBounsLuck(val)
    return self:set(20007, val - (self:getBounsLuck() or 0))
end

--%BOUNS_CHARM% 20008
function MyChar:getBounsCharm()
    return self:get(20008)
end
function MyChar:setBounsCharm(val)
    return self:set(20008, val - (self:getBounsCharm() or 0))
end

--%BOUNS_POISON% 20009
function MyChar:getBounsPoison()
    return self:get(20009)
end
function MyChar:setBounsPoison(val)
    return self:set(20009, val - (self:getBounsPoison() or 0))
end

--%BOUNS_SLEEP% 20010
function MyChar:getBounsSleep()
    return self:get(20010)
end
function MyChar:setBounsSleep(val)
    return self:set(20010, val - (self:getBounsSleep() or 0))
end

--%BOUNS_STONE% 20011
function MyChar:getBounsStone()
    return self:get(20011)
end
function MyChar:setBounsStone(val)
    return self:set(20011, val - (self:getBounsStone() or 0))
end

--%BOUNS_DRUNK% 20012
function MyChar:getBounsDrunk()
    return self:get(20012)
end
function MyChar:setBounsDrunk(val)
    return self:set(20012, val - (self:getBounsDrunk() or 0))
end

--%BOUNS_CONFUSION% 20013
function MyChar:getBounsConfusion()
    return self:get(20013)
end
function MyChar:setBounsConfusion(val)
    return self:set(20013, val - (self:getBounsConfusion() or 0))
end

--%BOUNS_AMNESIA% 20014
function MyChar:getBounsAmnesia()
    return self:get(20014)
end
function MyChar:setBounsAmnesia(val)
    return self:set(20014, val - (self:getBounsAmnesia() or 0))
end

--%BOUNS_CRITICAL% 20015
function MyChar:getBounsCritical()
    return self:get(20015)
end
function MyChar:setBounsCritical(val)
    return self:set(20015, val - (self:getBounsCritical() or 0))
end

--%BOUNS_COUNTER% 20016
function MyChar:getBounsCounter()
    return self:get(20016)
end
function MyChar:setBounsCounter(val)
    return self:set(20016, val - (self:getBounsCounter() or 0))
end

--%BOUNS_HITRATE% 20017
function MyChar:getBounsHitrate()
    return self:get(20017)
end
function MyChar:setBounsHitrate(val)
    return self:set(20017, val - (self:getBounsHitrate() or 0))
end

--%BOUNS_AVOID% 20018
function MyChar:getBounsAvoid()
    return self:get(20018)
end
function MyChar:setBounsAvoid(val)
    return self:set(20018, val - (self:getBounsAvoid() or 0))
end

--%BOUNS_STAMINA% 20019
function MyChar:getBounsStamina()
    return self:get(20019)
end
function MyChar:setBounsStamina(val)
    return self:set(20019, val - (self:getBounsStamina() or 0))
end

--%BOUNS_DEX% 20020
function MyChar:getBounsDex()
    return self:get(20020)
end
function MyChar:setBounsDex(val)
    return self:set(20020, val - (self:getBounsDex() or 0))
end

--%BOUNS_INTELLIGENCE% 20021
function MyChar:getBounsIntelligence()
    return self:get(20021)
end
function MyChar:setBounsIntelligence(val)
    return self:set(20021, val - (self:getBounsIntelligence() or 0))
end

--%BOUNS_ADM% 20022
function MyChar:getBounsAdm()
    return self:get(20022)
end
function MyChar:setBounsAdm(val)
    return self:set(20022, val - (self:getBounsAdm() or 0))
end

--%BOUNS_RSS% 20023
function MyChar:getBounsRss()
    return self:get(20023)
end
function MyChar:setBounsRss(val)
    return self:set(20023, val - (self:getBounsRss() or 0))
end

--%BOUNS_LOYALTY% 20024
function MyChar:getBounsLoyalty()
    return self:get(20024)
end
function MyChar:setBounsLoyalty(val)
    return self:set(20024, val - (self:getBounsLoyalty() or 0))
end
