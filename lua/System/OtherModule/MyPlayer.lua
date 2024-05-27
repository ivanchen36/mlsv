
-- 定义一个名为 MyPlayer 的表
MyPlayer = {}
MyPlayer.__index = MyPlayer

-- 定义构造函数 new
function MyPlayer:new(player)
    local newObj = { _player = player }  -- 创建一个新的对象，包含一个名为 data 的字段，其值为 player
    setmetatable(newObj, self)       -- 设置新对象的元表为 MyPlayer
    return newObj                    -- 返回新创建的对象
end

-- 定义 get 方法，用于获取玩家数据
function MyPlayer:get(key)
    return Char.GetData(self._player, key)  -- 使用 Char.GetData 函数获取玩家数据
end

-- 定义 set 方法，用于设置玩家数据
function MyPlayer:set(key, val)
    Char.SetData(self._player, key, val)  -- 使用 Char.SetData 函数设置玩家数据
end

function MyPlayer:flush()
    NLG.UpChar(self._player)
end

function MyPlayer:getObj()
    return self._player
end

function MyPlayer:isPerson()
    if (self:getType() == 1) then
        return true
    end

    return false
end

function MyPlayer:havePet(petId)
    return Char.HavePet(self._player, petId)
end

function MyPlayer:getItemNum(itemId)
    return Char.ItemNum(self._player, itemId)
end

function MyPlayer:getItem(itemId)
    return Char.GiveItem(self._player, itemId, 1)
end

function MyPlayer:delItem(itemId, count)
    return Char.DelItem(self._player, itemId, count);
end

function MyPlayer:changeIamge(image)
    if not self:isValid() then
        return 0
    end

    self:setImage(image)
    self:setOriginalForm(image)
    self:setOriginalImage(image)
    NLG.UpChar(self._player);
    sysMsg("人物形象更改成功");
    return 1
end

function MyPlayer:sysMsg(str)
    NLG.SystemMessage(self._player, "[系统提示]" .. str)
end

function MyPlayer:feverStart()
    Char.FeverStop(self._player)
    NLG.UpChar(self._player)
    self:sysMsg("恭喜您打卡成功。")
end

function MyPlayer:feverStop()
    Char.FeverStart(self._player)
    NLG.UpChar(self._player)
    self:sysMsg("恭喜您关闭打卡成功。")
end

function MyPlayer:needHp()
    return self:getHp() < self:getMaxHp()
end

function MyPlayer:recoverHp()
    self:setHp(self:getMaxHp())
    self:flush()
end

function MyPlayer:isValid()
    return VaildChar(self._player)
end

--%对象_金币% 53
function MyPlayer:addMoney(amount)
    self:setGold( self:getGold() + amount)
    NLG.UpChar(self._player)
    self:sysMsg("获得" .. amount .. "魔币。")

    return 1
end

function MyPlayer:subMoney(amount)
    local cur = self:getGold()
    if cur >= amount then
        self:setGold( cur - amount)
        self:sysMsg("获得" .. amount .. "魔币。")

        return 1
    end

    self:sysMsg("魔币不足" .. amount .. "，扣除失败。")
    return 0
end

function MyPlayer:isLeader()
    return Char.GetPartyMember(self._player, 0) == self._player
end

function MyPlayer:isGm()
    return self:getGm() == 1
end

function MyPlayer:warp(mapID, floorID, x, y)
    if not self:isLeader() then
        self:sysMsg("不是队长，不能够传送")
        return
    end

    Char.Warp(self._player, mapID, floorID, x, y)
end

--%对象_香步数% 8152
function MyPlayer:isYudi()
    return self:getIncenseStepCount() > 1
end

--%对象_香上限% 8151
function MyPlayer:startYudi()
    self:setIncenseStepCount(999);
    self:setIncenseUpperLimit( 999);
    self:sysMsg("步步遇敌已经开启！");
end

function MyPlayer:stopYudi()
    self:setIncenseStepCount(0);
    self:setIncenseUpperLimit(0);
    self:sysMsg("步步遇敌已经关闭！");
end

function MyPlayer:isBuYudi()
    return self:getEnemyAvoidSwitch() == 1
end

function MyPlayer:startBuYudi()
    self:set(6003,1);
    self:sysMsg("不遇敌已经开启！");
end

function MyPlayer:stopBuYudi()
    self:set(6003,0);
    self:sysMsg("不遇敌已经关闭！");
end

function MyPlayer:switchQietu()
    Protocol.SendLuaCustomPacket(self._player, "diyng", "GSQT");
end

function MyPlayer:switchZhizao()
    Protocol.SendLuaCustomPacket(self._player, "diyng", "GSZZ");
end

function MyPlayer:switchCaiji()
    Protocol.SendLuaCustomPacket(self._player, "diyng", "GSCJ");
end

--%对象_战死% 4000
function MyPlayer:getDie()
    return self:get(4000)
end
function MyPlayer:setDie(val)
    return self:set(4000, val)
end

--%对象_战斗信息开关% 4001
function MyPlayer:getBattleInfoSwitch()
    return self:get(4001)
end
function MyPlayer:setBattleInfoSwitch(val)
    return self:set(4001, val)
end

--%对象_登陆富豪榜% 4002
function MyPlayer:getRichListSwitch()
    return self:get(4002)
end
function MyPlayer:setRichListSwitch(val)
    return self:set(4002, val)
end

--%对象_组队开关% 4003
function MyPlayer:getTeamSwitch()
    return self:get(4003)
end
function MyPlayer:setTeamSwitch(val)
    return self:set(4003, val)
end

--%对象_PK开关% 4004 和 %对象_对战开关% 4004 (两者似乎相同，使用同一个函数)
function MyPlayer:getPkBattleSwitch()
    return self:get(4004)
end
function MyPlayer:setPkBattleSwitch(val)
    return self:set(4004, val)
end

--%对象_队聊开关% 4005
function MyPlayer:getTeamChatSwitch()
    return self:get(4005)
end
function MyPlayer:setTeamChatSwitch(val)
    return self:set(4005, val)
end

--%对象_名片开关% 4006
function MyPlayer:getCardSwitch()
    return self:get(4006)
end
function MyPlayer:setCardSwitch(val)
    return self:set(4006, val)
end

--%对象_交易开关% 4007
function MyPlayer:getTradeSwitch()
    return self:get(4007)
end
function MyPlayer:setTradeSwitch(val)
    return self:set(4007, val)
end

--%对象_打卡% 4008
function MyPlayer:getCheckIn()
    return self:get(4008)
end
function MyPlayer:setCheckIn(val)
    return self:set(4008, val)
end

--%对象_网络超时% 4009
function MyPlayer:getNetworkTimeout()
    return self:get(4009)
end
function MyPlayer:setNetworkTimeout(val)
    return self:set(4009, val)
end

--%对象_家族开关% 4010
function MyPlayer:getFamilySwitch()
    return self:get(4010)
end
function MyPlayer:setFamilySwitch(val)
    return self:set(4010, val)
end

--%对象_DEBUG开关% 6000
function MyPlayer:getDebugSwitch()
    return self:get(6000)
end
function MyPlayer:setDebugSwitch(val)
    return self:set(6000, val)
end

--%对象_使用MIC% 6001
function MyPlayer:getMicUsage()
    return self:get(6001)
end
function MyPlayer:setMicUsage(val)
    return self:set(6001, val)
end

--%对象_已保存% 6002
function MyPlayer:getSavedStatus()
    return self:get(6002)
end
function MyPlayer:setSavedStatus(val)
    return self:set(6002, val)
end

--%对象_不遇敌开关% 6003
function MyPlayer:getEnemyAvoidSwitch()
    return self:get(6003)
end

function MyPlayer:setEnemyAvoidSwitch(val)
    return self:set(6003, val)
end

--%对象_序% 0
function MyPlayer:getType()
    return self:get(0)
end
function MyPlayer:setType(val)
    return self:set(0, val)
end

--%对象_形象% 1
function MyPlayer:getImage()
    return self:get(1)
end
function MyPlayer:setImage(val)
    return self:set(1, val)
end

--%对象_可视% 1
function MyPlayer:isVisible()
    return self:get(1)
end
function MyPlayer:setVisible(val)
    return self:set(1, val)
end

--%对象_原形% 2
function MyPlayer:getOriginalForm()
    return self:get(2)
end
function MyPlayer:setOriginalForm(val)
    return self:set(2, val)
end

--%对象_MAP% 3
function MyPlayer:getMap()
    return self:get(3)
end
function MyPlayer:setMap(val)
    return self:set(3, val)
end

--%对象_地图% 4
function MyPlayer:getMapId()
    return self:get(4)
end
function MyPlayer:setMapId(val)
    return self:set(4, val)
end

--%对象_X% 5
function MyPlayer:getX()
    return self:get(5)
end
function MyPlayer:setX(val)
    return self:set(5, val)
end

--%对象_Y% 6
function MyPlayer:getY()
    return self:get(6)
end
function MyPlayer:setY(val)
    return self:set(6, val)
end

--%对象_方向% 7
function MyPlayer:getDirection()
    return self:get(7)
end
function MyPlayer:setDirection(val)
    return self:set(7, val)
end

--%对象_等级% 8
function MyPlayer:getLevel()
    return self:get(8)
end
function MyPlayer:setLevel(val)
    -- 可以在这里添加一些验证逻辑，比如确保等级不会低于0
    if val < 0 then
        return false, "等级不能低于0"
    end
    return self:set(8, val)
end
--%对象_血% 9
function MyPlayer:getHp()
    return self:get(9)
end
function MyPlayer:setHp(val)
    return self:set(9, val)
end
--%对象_魔% 10
function MyPlayer:getMp()
    return self:get(10)
end
function MyPlayer:setMp(val)
    return self:set(10, val)
end

--%对象_体力% 11
function MyPlayer:getStamina()
    return self:get(11)
end
function MyPlayer:setStamina(val)
    return self:set(11, val)
end

--%对象_力量% 12
function MyPlayer:getStrength()
    return self:get(12)
end
function MyPlayer:setStrength(val)
    return self:set(12, val)
end

--%对象_强度% 13
function MyPlayer:getIntensity()
    return self:get(13)
end
function MyPlayer:setIntensity(val)
    return self:set(13, val)
end

--%对象_速度% 14
function MyPlayer:getSpeed()
    return self:get(14)
end
function MyPlayer:setSpeed(val)
    return self:set(14, val)
end

--%对象_魔法% 15 (与对象_魔重复，考虑重命名或删除一个)

--%对象_运% 16
function MyPlayer:getLuck()
    return self:get(16)
end
function MyPlayer:setLuck(val)
    return self:set(16, val)
end

--%对象_种族% 17
function MyPlayer:getRace()
    return self:get(17)
end
function MyPlayer:setRace(val)
    return self:set(17, val)
end

--%对象_地属性% 18
function MyPlayer:getEarthAttribute()
    return self:get(18)
end
function MyPlayer:setEarthAttribute(val)
    return self:set(18, val)
end

--%对象_水属性% 19
function MyPlayer:getWaterAttribute()
    return self:get(19)
end
function MyPlayer:setWaterAttribute(val)
    return self:set(19, val)
end

--%对象_火属性% 20
function MyPlayer:getFireAttribute()
    return self:get(20)
end
function MyPlayer:setFireAttribute(val)
    return self:set(20, val)
end

--%对象_风属性% 21
function MyPlayer:getWindAttribute()
    return self:get(21)
end
function MyPlayer:setWindAttribute(val)
    return self:set(21, val)
end

--%对象_抗毒% 22
function MyPlayer:getPoisonResistance()
    return self:get(22)
end
function MyPlayer:setPoisonResistance(val)
    return self:set(22, val)
end

--%对象_抗睡% 23
function MyPlayer:getSleepResistance()
    return self:get(23)
end
function MyPlayer:setSleepResistance(val)
    return self:set(23, val)
end

--%对象_抗石% 24
function MyPlayer:getPetrifyResistance()
    return self:get(24)
end
function MyPlayer:setPetrifyResistance(val)
    return self:set(24, val)
end

--%对象_抗醉% 25
function MyPlayer:getDrunkResistance()
    return self:get(25)
end
function MyPlayer:setDrunkResistance(val)
    return self:set(25, val)
end

--%对象_抗乱% 26
function MyPlayer:getChaosResistance()
    return self:get(26)
end
function MyPlayer:setChaosResistance(val)
    return self:set(26, val)
end
--%对象_抗忘% 27
function MyPlayer:getForgetResistance()
    return self:get(27)
end
function MyPlayer:setForgetResistance(val)
    return self:set(27, val)
end

--%对象_必杀% 28
function MyPlayer:getCriticalHitChance()
    return self:get(28)
end
function MyPlayer:setCriticalHitChance(val)
    return self:set(28, val)
end

--%对象_反击% 29
function MyPlayer:getCounterAttackChance()
    return self:get(29)
end
function MyPlayer:setCounterAttackChance(val)
    return self:set(29, val)
end

--%对象_命中% 30
function MyPlayer:getHitRate()
    return self:get(30)
end
function MyPlayer:setHitRate(val)
    return self:set(30, val)
end

--%对象_闪躲% 31
function MyPlayer:getDodgeRate()
    return self:get(31)
end
function MyPlayer:setDodgeRate(val)
    return self:set(31, val)
end

--%对象_道具栏% 32
function MyPlayer:getItemSlots()
    return self:get(32)
end
function MyPlayer:setItemSlots(val)
    return self:set(32, val)
end

--%对象_技能栏% 33
function MyPlayer:getSkillSlots()
    return self:get(33)
end
function MyPlayer:setSkillSlots(val)
    return self:set(33, val)
end

--%对象_死亡数% 34
function MyPlayer:getDeathCount()
    return self:get(34)
end
function MyPlayer:setDeathCount(val)
    return self:set(34, val)
end

--%对象_伤害数% 35
function MyPlayer:getDamageCount()
    return self:get(35)
end
function MyPlayer:setDamageCount(val)
    return self:set(35, val)
end

--%对象_杀宠数% 36
function MyPlayer:getKilledPetCount()
    return self:get(36)
end
function MyPlayer:setKilledPetCount(val)
    return self:set(36, val)
end

--%对象_占卜时间% 37
function MyPlayer:getDivinationTime()
    return self:get(37)
end
function MyPlayer:setDivinationTime(val)
    return self:set(37, val)
end

--%对象_受伤% 38
function MyPlayer:getHurtStatus()
    return self:get(38)
end
function MyPlayer:setHurtStatus(val)
    return self:set(38, val)
end

--%对象_移间% 39
function MyPlayer:getMoveSpace()
    return self:get(39)
end
function MyPlayer:setMoveSpace(val)
    return self:set(39, val)
end

--%对象_循时% 40
function MyPlayer:getCycleTime()
    return self:get(40)
end
function MyPlayer:setCycleTime(val)
    return self:set(40, val)
end

--%对象_经验% 41
function MyPlayer:getExperience()
    return self:get(41)
end
function MyPlayer:setExperience(val)
    return self:set(41, val)
end

--%对象_升级点% 42
function MyPlayer:getUpgradePoints()
    return self:get(42)
end
function MyPlayer:setUpgradePoints(val)
    return self:set(42, val)
end

--%对象_图类% 43
function MyPlayer:getImageType()
    return self:get(43)
end
function MyPlayer:setImageType(val)
    return self:set(43, val)
end

--%对象_名色% 44
function MyPlayer:getNameColor()
    return self:get(44)
end
function MyPlayer:setNameColor(val)
    return self:set(44, val)
end

--%对象_RegistNumber% 48
function MyPlayer:getRegistNumber()
    return self:get(48)
end
function MyPlayer:setRegistNumber(val)
    return self:set(48, val)
end

--%对象_职业% 49
function MyPlayer:getJob()
    return self:get(49)
end
function MyPlayer:setJob(val)
    return self:set(49, val)
end

--%对象_职阶% 50
function MyPlayer:getJobRank()
    return self:get(50)
end
function MyPlayer:setJobRank(val)
    return self:set(50, val)
end

--%对象_职类ID% 51
function MyPlayer:getJobClassId()
    return self:get(51)
end
function MyPlayer:setJobClassId(val)
    return self:set(51, val)
end

--%对象_脸% 52
function MyPlayer:getFace()
    return self:get(52)
end
function MyPlayer:setFace(val)
    return self:set(52, val)
end

--%对象_金币% 53
function MyPlayer:getGold()
    return self:get(53)
end
function MyPlayer:setGold(val)
    return self:set(53, val)
end

--%对象_银行金币% 54
function MyPlayer:getBankGold()
    return self:get(54)
end
function MyPlayer:setBankGold(val)
    return self:set(54, val)
end

--%对象_耐力% 55
function MyPlayer:getStamina()
    return self:get(55)
end
function MyPlayer:setStamina(val)
    return self:set(55, val)
end

--%对象_灵巧% 56
function MyPlayer:getDexterity()
    return self:get(56)
end
function MyPlayer:setDexterity(val)
    return self:set(56, val)
end

--%对象_智力% 57
function MyPlayer:getIntelligence()
    return self:get(57)
end
function MyPlayer:setIntelligence(val)
    return self:set(57, val)
end

--%对象_魅力% 58
function MyPlayer:getCharm()
    return self:get(58)
end
function MyPlayer:setCharm(val)
    return self:set(58, val)
end

--%对象_声望% 59
function MyPlayer:getReputation()
    return self:get(59)
end
function MyPlayer:setReputation(val)
    return self:set(59, val)
end

--%对象_称号% 60
function MyPlayer:getTitle()
    return self:get(60)
end
function MyPlayer:setTitle(val)
    return self:set(60, val)
end

--%对象_记录点% 61
function MyPlayer:getRecordPoint()
    return self:get(61)
end
function MyPlayer:setRecordPoint(val)
    return self:set(61, val)
end

--%对象_战宠% 62
function MyPlayer:getBattlePet()
    return self:get(62)
end
function MyPlayer:setBattlePet(val)
    return self:set(62, val)
end

--%对象_聊天距离% 63
function MyPlayer:getChatDistance()
    return self:get(63)
end
function MyPlayer:setChatDistance(val)
    return self:set(63, val)
end

--%对象_HelpPoint% 64
function MyPlayer:getHelpPoint()
    return self:get(64)
end
function MyPlayer:setHelpPoint(val)
    return self:set(64, val)
end

--%对象_登陆次数% 65
function MyPlayer:getLoginCount()
    return self:get(65)
end
function MyPlayer:setLoginCount(val)
    return self:set(65, val)
end

--%对象_说次% 66
function MyPlayer:getTalkCount()
    return self:get(66)
end
function MyPlayer:setTalkCount(val)
    return self:set(66, val)
end

--%对象_宠得数% 67
function MyPlayer:getPetAcquireCount()
    return self:get(67)
end
function MyPlayer:setPetAcquireCount(val)
    return self:set(67, val)
end

--%对象_邮数% 68
function MyPlayer:getMailCount()
    return self:get(68)
end
function MyPlayer:setMailCount(val)
    return self:set(68, val)
end

--%对象_生产数% 69
function MyPlayer:getProductionCount()
    return self:get(69)
end
function MyPlayer:setProductionCount(val)
    return self:set(69, val)
end

--%对象_走次% 70
function MyPlayer:getWalkCount()
    return self:get(70)
end
function MyPlayer:setWalkCount(val)
    return self:set(70, val)
end

--%对象_宠死数% 71
function MyPlayer:getPetDeathCount()
    return self:get(71)
end
function MyPlayer:setPetDeathCount(val)
    return self:set(71, val)
end

--%对象_宠复数% 72
function MyPlayer:getPetRepeatCount()
    return self:get(72)
end
function MyPlayer:setPetRepeatCount(val)
    return self:set(72, val)
end

--%对象_宠治数% 73
function MyPlayer:getPetTreatCount()
    return self:get(73)
end
function MyPlayer:setPetTreatCount(val)
    return self:set(73, val)
end

--%对象_封印数% 74
function MyPlayer:getSealCount()
    return self:get(74)
end
function MyPlayer:setSealCount(val)
    return self:set(74, val)
end

--%对象_OtherFlg% 75
function MyPlayer:getOtherFlag()
    return self:get(75)
end
function MyPlayer:setOtherFlag(val)
    return self:set(75, val)
end

--%对象_日声望上限% 76
function MyPlayer:getDailyReputationCap()
    return self:get(76)
end
function MyPlayer:setDailyReputationCap(val)
    return self:set(76, val)
end

--%对象_声望获取时间% 77
function MyPlayer:getReputationGainTime()
    return self:get(77)
end
function MyPlayer:setReputationGainTime(val)
    return self:set(77, val)
end

--%对象_声望下降时间% 78
function MyPlayer:getReputationLossTime()
    return self:get(78)
end
function MyPlayer:setReputationLossTime(val)
    return self:set(78, val)
end

--%对象_掉魂% 79
function MyPlayer:getSoulDrop()
    return self:get(79)
end
function MyPlayer:setSoulDrop(val)
    return self:set(79, val)
end

--%对象_银行最大宠数% 159
function MyPlayer:getMaxBankPets()
    return self:get(159)
end
function MyPlayer:setMaxBankPets(val)
    return self:set(159, val)
end

--%对象_银行最大物数% 160
function MyPlayer:getMaxBankItems()
    return self:get(160)
end
function MyPlayer:setMaxBankItems(val)
    return self:set(160, val)
end

--%对象_DP% 161
function MyPlayer:getDP()
    return self:get(161)
end
function MyPlayer:setDP(val)
    return self:set(161, val)
end

--%对象_话色% 162
function MyPlayer:getTalkColor()
    return self:get(162)
end
function MyPlayer:setTalkColor(val)
    return self:set(162, val)
end

--%对象_位置% 163
function MyPlayer:getPosition()
    return self:get(163)
end
function MyPlayer:setPosition(val)
    return self:set(163, val)
end

--%对象_GM% 164
function MyPlayer:getGm()
    return self:get(164)
end
function MyPlayer:setGm(val)
    return self:set(164, val and 1 or 0)
end

--%对象_登陆点% 171
function MyPlayer:getLoginPoint()
    return self:get(171)
end
function MyPlayer:setLoginPoint(val)
    return self:set(171, val)
end

--%对象_卡时% 173
function MyPlayer:getStuckTime()
    return self:get(173)
end
function MyPlayer:setStuckTime(val)
    return self:set(173, val)
end

--%对象_房子ID% 174
function MyPlayer:getHouseID()
    return self:get(174)
end
function MyPlayer:setHouseID(val)
    return self:set(174, val)
end

--%对象_房子期限% 175
function MyPlayer:getHouseExpiration()
    return self:get(175)
end
function MyPlayer:setHouseExpiration(val)
    return self:set(175, val)
end

--%对象_原始图档% 178
function MyPlayer:getOriginalImage()
    return self:get(178)
end
function MyPlayer:setOriginalImage(val)
    return self:set(178, val)
end

--%对象_名字% 2000
function MyPlayer:getName()
    return self:get(2000)
end
function MyPlayer:setName(val)
    return self:set(2000, val)
end

--%对象_原名% 2000 (与对象_名字重复，可能是一个错误，这里假设它们是同一个属性)
function MyPlayer:getOriginalName()
    return self:get(2000)
end
function MyPlayer:setOriginalName(val)
    return self:set(2000, val)
end

--%对象_玩家称号% 2001
function MyPlayer:getTitle()
    return self:get(2001)
end
function MyPlayer:setTitle(val)
    return self:set(2001, val)
end

--%对象_宠名% 2001 (与对象_玩家称号重复，可能是一个错误，这里假设它们是同一个属性)
function MyPlayer:getPetName()
    return self:get(2001)
end
function MyPlayer:setPetName(val)
    return self:set(2001, val)
end

--%对象_CDK% 2002
function MyPlayer:getCdk()
    return self:get(2002)
end
function MyPlayer:setCdk(val)
    return self:set(2002, val)
end

--%对象_账号% 2002
function MyPlayer:getAccountId()
    return self:get(2002)
end
function MyPlayer:setAccountId(val)
    return self:set(2002, val)
end

--%对象_主人CDK% 2003
function MyPlayer:getOwnerCdk()
    return self:get(2003)
end
function MyPlayer:setOwnerCdk(val)
    return self:set(2003, val)
end

--%对象_主人名字% 2004
function MyPlayer:getOwnerName()
    return self:get(2004)
end
function MyPlayer:setOwnerName(val)
    return self:set(2004, val)
end

--%对象_主人原名% 2004 (与对象_主人名字相同)
function MyPlayer:getOwnerOriginalName()
    return self:get(2004)
end
function MyPlayer:setOwnerOriginalName(val)
    return self:set(2004, val)
end

--%对象_战斗中% 8000
function MyPlayer:isInBattle()
    return self:get(8000)
end
function MyPlayer:setInBattle(val)
    return self:set(8000, val)
end

--%对象_战斗状态% 8000 (与对象_战斗中相同)
function MyPlayer:getBattleStatus()
    return self:get(8000)
end
function MyPlayer:setBattleStatus(val)
    return self:set(8000, val)
end

--%对象_战斗Index% 8001
function MyPlayer:getBattleIndex()
    return self:get(8001)
end
function MyPlayer:setBattleIndex(val)
    return self:set(8001, val)
end

--%对象_战斗Side% 8002
function MyPlayer:getBattleSide()
    return self:get(8002)
end
function MyPlayer:setBattleSide(val)
    return self:set(8002, val)
end

--%对象_最大血% 8015
function MyPlayer:getMaxHp()
    return self:get(8015)
end
function MyPlayer:setMaxHp(val)
    return self:set(8015, val)
end

--%对象_最大魔% 8016
function MyPlayer:getMaxMp()
    return self:get(8016)
end
function MyPlayer:setMaxMp(val)
    return self:set(8016, val)
end

--%对象_攻击力% 8017
function MyPlayer:getAttackPower()
    return self:get(8017)
end
function MyPlayer:setAttackPower(val)
    return self:set(8017, val)
end

--%对象_防御力% 8018
function MyPlayer:getDefensePower()
    return self:get(8018)
end
function MyPlayer:setDefensePower(val)
    return self:set(8018, val)
end

--%对象_敏捷% 8019
function MyPlayer:getAgility()
    return self:get(8019)
end
function MyPlayer:setAgility(val)
    return self:set(8019, val)
end

--%对象_魔法攻击力% 8020
function MyPlayer:getMagicAttackPower()
    return self:get(8020)
end
function MyPlayer:setMagicAttackPower(val)
    return self:set(8020, val)
end

--%对象_魔强% 8020 (与魔法攻击力似乎是同一个属性，因此使用相同的函数)
function MyPlayer:getMagicStrength()
    return self:get(8020)
end
function MyPlayer:setMagicStrength(val)
    return self:set(8020, val)
end

--%对象_回复% 8021
function MyPlayer:getRecoveryRate()
    return self:get(8021)
end
function MyPlayer:setRecoveryRate(val)
    return self:set(8021, val)
end

--%对象_OBJ% 8065
function MyPlayer:getObject()
    return self:get(8065)
end
function MyPlayer:setObject(val)
    return self:set(8065, val)
end

--%对象_获得经验% 8072 (与战得DP似乎是同一个属性，因此使用相同的函数)
function MyPlayer:getExperienceGain()
    return self:get(8072)
end
function MyPlayer:setExperienceGain(val)
    return self:set(8072, val)
end

--%对象_战得DP% 8072 (与获得经验似乎是同一个属性，因此使用相同的函数)
-- 注意：这里不再重复定义函数，因为与上面的获得经验使用相同的函数。
--%对象_组队模式% 8117
function MyPlayer:getTeamMode()
    return self:get(8117)
end
function MyPlayer:setTeamMode(val)
    return self:set(8117, val)
end

--%对象_香下限% 8150
function MyPlayer:getIncenseLowerLimit()
    return self:get(8150)
end
function MyPlayer:setIncenseLowerLimit(val)
    return self:set(8150, val)
end

--%对象_香上限% 8151
function MyPlayer:getIncenseUpperLimit()
    return self:get(8151)
end
function MyPlayer:setIncenseUpperLimit(val)
    return self:set(8151, val)
end

--%对象_香步数% 8152
function MyPlayer:getIncenseStepCount()
    return self:get(8152)
end
function MyPlayer:setIncenseStepCount(val)
    return self:set(8152, val)
end