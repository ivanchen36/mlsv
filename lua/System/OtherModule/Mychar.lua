
-- ����һ����Ϊ MyChar �ı�
MyChar = {}
MyChar.__index = MyChar

-- ���幹�캯�� new
function MyChar:new(player)
    local newObj = { _player = player }  -- ����һ���µĶ��󣬰���һ����Ϊ data ���ֶΣ���ֵΪ player
    setmetatable(newObj, self)       -- �����¶����Ԫ��Ϊ MyChar
    return newObj                    -- �����´����Ķ���
end

function MyChar:getObj()
    return self._player
end

-- ���� get ���������ڻ�ȡ�������
function MyChar:get(key)
    return Char.GetData(self._player, key)  -- ʹ�� Char.GetData ������ȡ�������
end

-- ���� set ���������������������
function MyChar:set(key, val)
    Char.SetData(self._player, key, val)  -- ʹ�� Char.SetData ���������������
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

--%����_ս��% 4000
function MyChar:getDie()
    return self:get(4000)
end
function MyChar:setDie(val)
    return self:set(4000, val)
end

--%����_ս����Ϣ����% 4001
function MyChar:getBattleInfoSwitch()
    return self:get(4001)
end
function MyChar:setBattleInfoSwitch(val)
    return self:set(4001, val)
end

--%����_��½������% 4002
function MyChar:getRichListSwitch()
    return self:get(4002)
end
function MyChar:setRichListSwitch(val)
    return self:set(4002, val)
end

--%����_��ӿ���% 4003
function MyChar:getTeamSwitch()
    return self:get(4003)
end
function MyChar:setTeamSwitch(val)
    return self:set(4003, val)
end

--%����_PK����% 4004 �� %����_��ս����% 4004 (�����ƺ���ͬ��ʹ��ͬһ������)
function MyChar:getPkBattleSwitch()
    return self:get(4004)
end
function MyChar:setPkBattleSwitch(val)
    return self:set(4004, val)
end

--%����_���Ŀ���% 4005
function MyChar:getTeamChatSwitch()
    return self:get(4005)
end
function MyChar:setTeamChatSwitch(val)
    return self:set(4005, val)
end

--%����_��Ƭ����% 4006
function MyChar:getCardSwitch()
    return self:get(4006)
end
function MyChar:setCardSwitch(val)
    return self:set(4006, val)
end

--%����_���׿���% 4007
function MyChar:getTradeSwitch()
    return self:get(4007)
end
function MyChar:setTradeSwitch(val)
    return self:set(4007, val)
end

--%����_��% 4008
function MyChar:getCheckIn()
    return self:get(4008)
end
function MyChar:setCheckIn(val)
    return self:set(4008, val)
end

--%����_���糬ʱ% 4009
function MyChar:getNetworkTimeout()
    return self:get(4009)
end
function MyChar:setNetworkTimeout(val)
    return self:set(4009, val)
end

--%����_���忪��% 4010
function MyChar:getFamilySwitch()
    return self:get(4010)
end
function MyChar:setFamilySwitch(val)
    return self:set(4010, val)
end

--%����_DEBUG����% 6000
function MyChar:getDebugSwitch()
    return self:get(6000)
end
function MyChar:setDebugSwitch(val)
    return self:set(6000, val)
end

--%����_ʹ��MIC% 6001
function MyChar:getMicUsage()
    return self:get(6001)
end
function MyChar:setMicUsage(val)
    return self:set(6001, val)
end

--%����_�ѱ���% 6002
function MyChar:getSavedStatus()
    return self:get(6002)
end
function MyChar:setSavedStatus(val)
    return self:set(6002, val)
end

--%����_�����п���% 6003
function MyChar:getEnemyAvoidSwitch()
    return self:get(6003)
end

function MyChar:setEnemyAvoidSwitch(val)
    return self:set(6003, val)
end

--%����_��% 0
function MyChar:getType()
    return self:get(0)
end
function MyChar:setType(val)
    return self:set(0, val)
end

--%����_����% 1
function MyChar:getImage()
    return self:get(1)
end
function MyChar:setImage(val)
    return self:set(1, val)
end

--%����_����% 1
function MyChar:isVisible()
    return self:get(1)
end
function MyChar:setVisible(val)
    return self:set(1, val)
end

--%����_ԭ��% 2
function MyChar:getOriginalForm()
    return self:get(2)
end
function MyChar:setOriginalForm(val)
    return self:set(2, val)
end

--%����_MAP% 3
function MyChar:getMap()
    return self:get(3)
end
function MyChar:setMap(val)
    return self:set(3, val)
end

--%����_��ͼ% 4
function MyChar:getMapId()
    return self:get(4)
end
function MyChar:setMapId(val)
    return self:set(4, val)
end

--%����_X% 5
function MyChar:getX()
    return self:get(5)
end
function MyChar:setX(val)
    return self:set(5, val)
end

--%����_Y% 6
function MyChar:getY()
    return self:get(6)
end
function MyChar:setY(val)
    return self:set(6, val)
end

--%����_����% 7
function MyChar:getDirection()
    return self:get(7)
end
function MyChar:setDirection(val)
    return self:set(7, val)
end

--%����_�ȼ�% 8
function MyChar:getLevel()
    return self:get(8)
end
function MyChar:setLevel(val)
    -- �������������һЩ��֤�߼�������ȷ���ȼ��������0
    if val < 0 then
        return false, "�ȼ����ܵ���0"
    end
    return self:set(8, val)
end
--%����_Ѫ% 9
function MyChar:getHp()
    return self:get(9)
end
function MyChar:setHp(val)
    if val < 1 then
        val = 1
    end
    return self:set(9, val)
end
--%����_ħ% 10
function MyChar:getMp()
    return self:get(10)
end
function MyChar:setMp(val)
    if val < 1 then
        val = 1
    end
    return self:set(10, val)
end

--%����_����% 11
function MyChar:getStamina()
    return self:get(11)
end
function MyChar:setStamina(val)
    return self:set(11, val)
end

--%����_����% 12
function MyChar:getStrength()
    return self:get(12)
end
function MyChar:setStrength(val)
    return self:set(12, val)
end

--%����_ǿ��% 13
function MyChar:getIntensity()
    return self:get(13)
end
function MyChar:setIntensity(val)
    return self:set(13, val)
end

--%����_�ٶ�% 14
function MyChar:getSpeed()
    return self:get(14)
end
function MyChar:setSpeed(val)
    return self:set(14, val)
end

--%����_ħ��% 15 (�����_ħ�ظ���������������ɾ��һ��)

--%����_��% 16
function MyChar:getLuck()
    return self:get(16)
end
function MyChar:setLuck(val)
    return self:set(16, val)
end

--%����_����% 17
function MyChar:getRace()
    return self:get(17)
end
function MyChar:setRace(val)
    return self:set(17, val)
end

--%����_������% 18
function MyChar:getEarthAttribute()
    return self:get(18)
end
function MyChar:setEarthAttribute(val)
    return self:set(18, val)
end

--%����_ˮ����% 19
function MyChar:getWaterAttribute()
    return self:get(19)
end
function MyChar:setWaterAttribute(val)
    return self:set(19, val)
end

--%����_������% 20
function MyChar:getFireAttribute()
    return self:get(20)
end
function MyChar:setFireAttribute(val)
    return self:set(20, val)
end

--%����_������% 21
function MyChar:getWindAttribute()
    return self:get(21)
end
function MyChar:setWindAttribute(val)
    return self:set(21, val)
end

--%����_����% 22
function MyChar:getPoisonResistance()
    return self:get(22)
end
function MyChar:setPoisonResistance(val)
    return self:set(22, val)
end

--%����_��˯% 23
function MyChar:getSleepResistance()
    return self:get(23)
end
function MyChar:setSleepResistance(val)
    return self:set(23, val)
end

--%����_��ʯ% 24
function MyChar:getPetrifyResistance()
    return self:get(24)
end
function MyChar:setPetrifyResistance(val)
    return self:set(24, val)
end

--%����_����% 25
function MyChar:getDrunkResistance()
    return self:get(25)
end
function MyChar:setDrunkResistance(val)
    return self:set(25, val)
end

--%����_����% 26
function MyChar:getChaosResistance()
    return self:get(26)
end
function MyChar:setChaosResistance(val)
    return self:set(26, val)
end
--%����_����% 27
function MyChar:getForgetResistance()
    return self:get(27)
end
function MyChar:setForgetResistance(val)
    return self:set(27, val)
end

--%����_��ɱ% 28
function MyChar:getCriticalHitChance()
    return self:get(28)
end
function MyChar:setCriticalHitChance(val)
    return self:set(28, val)
end

--%����_����% 29
function MyChar:getCounterAttackChance()
    return self:get(29)
end
function MyChar:setCounterAttackChance(val)
    return self:set(29, val)
end

--%����_����% 30
function MyChar:getHitRate()
    return self:get(30)
end
function MyChar:setHitRate(val)
    return self:set(30, val)
end

--%����_����% 31
function MyChar:getDodgeRate()
    return self:get(31)
end
function MyChar:setDodgeRate(val)
    return self:set(31, val)
end

--%����_������% 32
function MyChar:getItemSlots()
    return self:get(32)
end
function MyChar:setItemSlots(val)
    return self:set(32, val)
end

--%����_������% 33
function MyChar:getSkillSlots()
    return self:get(33)
end
function MyChar:setSkillSlots(val)
    return self:set(33, val)
end

--%����_������% 34
function MyChar:getDeathCount()
    return self:get(34)
end
function MyChar:setDeathCount(val)
    return self:set(34, val)
end

--%����_�˺���% 35
function MyChar:getDamageCount()
    return self:get(35)
end
function MyChar:setDamageCount(val)
    return self:set(35, val)
end

--%����_ɱ����% 36
function MyChar:getKilledPetCount()
    return self:get(36)
end
function MyChar:setKilledPetCount(val)
    return self:set(36, val)
end

--%����_ռ��ʱ��% 37
function MyChar:getDivinationTime()
    return self:get(37)
end
function MyChar:setDivinationTime(val)
    return self:set(37, val)
end

--%����_����% 38
function MyChar:getHurtStatus()
    return self:get(38)
end
function MyChar:setHurtStatus(val)
    return self:set(38, val)
end

--%����_�Ƽ�% 39
function MyChar:getMoveSpace()
    return self:get(39)
end
function MyChar:setMoveSpace(val)
    return self:set(39, val)
end

--%����_ѭʱ% 40
function MyChar:getCycleTime()
    return self:get(40)
end
function MyChar:setCycleTime(val)
    return self:set(40, val)
end

--%����_����% 41
function MyChar:getExperience()
    return self:get(41)
end
function MyChar:setExperience(val)
    return self:set(41, val)
end

--%����_������% 42
function MyChar:getUpgradePoints()
    return self:get(42)
end
function MyChar:setUpgradePoints(val)
    return self:set(42, val)
end

--%����_ͼ��% 43
function MyChar:getImageType()
    return self:get(43)
end
function MyChar:setImageType(val)
    return self:set(43, val)
end

--%����_��ɫ% 44
function MyChar:getNameColor()
    return self:get(44)
end
function MyChar:setNameColor(val)
    return self:set(44, val)
end

--%����_RegistNumber% 48
function MyChar:getRegistNumber()
    return self:get(48)
end

function MyChar:setRegistNumber(val)
    return self:set(48, val)
end

--%����_ְҵ% 49
function MyChar:getJob()
    return self:get(49)
end
function MyChar:setJob(val)
    return self:set(49, val)
end

--%����_ְ��% 50
function MyChar:getJobRank()
    return self:get(50)
end
function MyChar:setJobRank(val)
    return self:set(50, val)
end

--%����_ְ��ID% 51
function MyChar:getJobClassId()
    return self:get(51)
end
function MyChar:setJobClassId(val)
    return self:set(51, val)
end

--%����_��% 52
function MyChar:getFace()
    return self:get(52)
end
function MyChar:setFace(val)
    return self:set(52, val)
end

--%����_���% 53
function MyChar:getGold()
    return self:get(53)
end
function MyChar:setGold(val)
    return self:set(53, val)
end

--%����_���н��% 54
function MyChar:getBankGold()
    return self:get(54)
end
function MyChar:setBankGold(val)
    return self:set(54, val)
end

--%����_����% 55
function MyChar:getStamina()
    return self:get(55)
end
function MyChar:setStamina(val)
    return self:set(55, val)
end

--%����_����% 56
function MyChar:getDexterity()
    return self:get(56)
end
function MyChar:setDexterity(val)
    return self:set(56, val)
end

--%����_����% 57
function MyChar:getIntelligence()
    return self:get(57)
end
function MyChar:setIntelligence(val)
    return self:set(57, val)
end

--%����_����% 58
function MyChar:getCharm()
    return self:get(58)
end
function MyChar:setCharm(val)
    return self:set(58, val)
end

--%����_����% 59
function MyChar:getReputation()
    return self:get(59)
end
function MyChar:setReputation(val)
    return self:set(59, val)
end

--%����_�ƺ�% 60
function MyChar:getTitle()
    return self:get(60)
end
function MyChar:setTitle(val)
    return self:set(60, val)
end

--%����_��¼��% 61
function MyChar:getRecordPoint()
    return self:get(61)
end
function MyChar:setRecordPoint(val)
    return self:set(61, val)
end

--%����_ս��% 62
function MyChar:getBattlePet()
    return self:get(62)
end
function MyChar:setBattlePet(val)
    return self:set(62, val)
end

--%����_�������% 63
function MyChar:getChatDistance()
    return self:get(63)
end
function MyChar:setChatDistance(val)
    return self:set(63, val)
end

--%����_HelpPoint% 64
function MyChar:getHelpPoint()
    return self:get(64)
end
function MyChar:setHelpPoint(val)
    return self:set(64, val)
end

--%����_��½����% 65
function MyChar:getLoginCount()
    return self:get(65)
end
function MyChar:setLoginCount(val)
    return self:set(65, val)
end

--%����_˵��% 66
function MyChar:getTalkCount()
    return self:get(66)
end
function MyChar:setTalkCount(val)
    return self:set(66, val)
end

--%����_�����% 67
function MyChar:getPetAcquireCount()
    return self:get(67)
end
function MyChar:setPetAcquireCount(val)
    return self:set(67, val)
end

--%����_����% 68
function MyChar:getMailCount()
    return self:get(68)
end
function MyChar:setMailCount(val)
    return self:set(68, val)
end

--%����_������% 69
function MyChar:getProductionCount()
    return self:get(69)
end
function MyChar:setProductionCount(val)
    return self:set(69, val)
end

--%����_�ߴ�% 70
function MyChar:getWalkCount()
    return self:get(70)
end
function MyChar:setWalkCount(val)
    return self:set(70, val)
end

--%����_������% 71
function MyChar:getPetDeathCount()
    return self:get(71)
end
function MyChar:setPetDeathCount(val)
    return self:set(71, val)
end

--%����_�踴��% 72
function MyChar:getPetRepeatCount()
    return self:get(72)
end
function MyChar:setPetRepeatCount(val)
    return self:set(72, val)
end

--%����_������% 73
function MyChar:getPetTreatCount()
    return self:get(73)
end
function MyChar:setPetTreatCount(val)
    return self:set(73, val)
end

--%����_��ӡ��% 74
function MyChar:getSealCount()
    return self:get(74)
end
function MyChar:setSealCount(val)
    return self:set(74, val)
end

--%����_OtherFlg% 75
function MyChar:getOtherFlag()
    return self:get(75)
end
function MyChar:setOtherFlag(val)
    return self:set(75, val)
end

--%����_����������% 76
function MyChar:getDailyReputationCap()
    return self:get(76)
end
function MyChar:setDailyReputationCap(val)
    return self:set(76, val)
end

--%����_������ȡʱ��% 77
function MyChar:getReputationGainTime()
    return self:get(77)
end
function MyChar:setReputationGainTime(val)
    return self:set(77, val)
end

--%����_�����½�ʱ��% 78
function MyChar:getReputationLossTime()
    return self:get(78)
end
function MyChar:setReputationLossTime(val)
    return self:set(78, val)
end

--%����_����% 79
function MyChar:getSoulDrop()
    return self:get(79)
end
function MyChar:setSoulDrop(val)
    return self:set(79, val)
end

--%����_����������% 159
function MyChar:getMaxBankPets()
    return self:get(159)
end
function MyChar:setMaxBankPets(val)
    return self:set(159, val)
end

--%����_�����������% 160
function MyChar:getMaxBankItems()
    return self:get(160)
end
function MyChar:setMaxBankItems(val)
    return self:set(160, val)
end

--%����_DP% 161
function MyChar:getDP()
    return self:get(161)
end
function MyChar:setDP(val)
    return self:set(161, val)
end

--%����_��ɫ% 162
function MyChar:getTalkColor()
    return self:get(162)
end
function MyChar:setTalkColor(val)
    return self:set(162, val)
end

--%����_λ��% 163
function MyChar:getPosition()
    return self:get(163)
end
function MyChar:setPosition(val)
    return self:set(163, val)
end

--%����_GM% 164
function MyChar:getGm()
    return self:get(164)
end
function MyChar:setGm(val)
    return self:set(164, val and 1 or 0)
end

--%����_��½��% 171
function MyChar:getLoginPoint()
    return self:get(171)
end
function MyChar:setLoginPoint(val)
    return self:set(171, val)
end

--%����_��ʱ% 173
function MyChar:getStuckTime()
    return self:get(173)
end
function MyChar:setStuckTime(val)
    return self:set(173, val)
end

--%����_����ID% 174
function MyChar:getHouseID()
    return self:get(174)
end
function MyChar:setHouseID(val)
    return self:set(174, val)
end

--%����_��������% 175
function MyChar:getHouseExpiration()
    return self:get(175)
end
function MyChar:setHouseExpiration(val)
    return self:set(175, val)
end

--%����_ԭʼͼ��% 178
function MyChar:getOriginalImage()
    return self:get(178)
end
function MyChar:setOriginalImage(val)
    return self:set(178, val)
end

--%����_����% 2000
function MyChar:getName()
    return self:get(2000)
end
function MyChar:setName(val)
    return self:set(2000, val)
end

--%����_ԭ��% 2000 (�����_�����ظ���������һ�������������������ͬһ������)
function MyChar:getOriginalName()
    return self:get(2000)
end
function MyChar:setOriginalName(val)
    return self:set(2000, val)
end

--%����_��ҳƺ�% 2001
function MyChar:getTitle()
    return self:get(2001)
end
function MyChar:setTitle(val)
    return self:set(2001, val)
end

--%����_����% 2001 (�����_��ҳƺ��ظ���������һ�������������������ͬһ������)
function MyChar:getPetName()
    return self:get(2001)
end
function MyChar:setPetName(val)
    return self:set(2001, val)
end

--%����_CDK% 2002
function MyChar:getCdk()
    return self:get(2002)
end
function MyChar:setCdk(val)
    return self:set(2002, val)
end

--%����_�˺�% 2002
function MyChar:getAccountId()
    return self:get(2002)
end
function MyChar:setAccountId(val)
    return self:set(2002, val)
end

--%����_����CDK% 2003
function MyChar:getOwnerCdk()
    return self:get(2003)
end
function MyChar:setOwnerCdk(val)
    return self:set(2003, val)
end

--%����_��������% 2004
function MyChar:getOwnerName()
    return self:get(2004)
end
function MyChar:setOwnerName(val)
    return self:set(2004, val)
end

--%����_����ԭ��% 2004 (�����_����������ͬ)
function MyChar:getOwnerOriginalName()
    return self:get(2004)
end
function MyChar:setOwnerOriginalName(val)
    return self:set(2004, val)
end

--%����_ս����% 8000
function MyChar:isInBattle()
    return self:get(8000)
end
function MyChar:setInBattle(val)
    return self:set(8000, val)
end

--%����_ս��״̬% 8000 (�����_ս������ͬ)
function MyChar:getBattleStatus()
    return self:get(8000)
end
function MyChar:setBattleStatus(val)
    return self:set(8000, val)
end

--%����_ս��Index% 8001
function MyChar:getBattleIndex()
    return self:get(8001)
end
function MyChar:setBattleIndex(val)
    return self:set(8001, val)
end

--%����_ս��Side% 8002
function MyChar:getBattleSide()
    return self:get(8002)
end
function MyChar:setBattleSide(val)
    return self:set(8002, val)
end

--%����_���Ѫ% 8015
function MyChar:getMaxHp()
    return self:get(8015)
end
function MyChar:setMaxHp(val)
    return self:set(8015, val)
end

--%����_���ħ% 8016
function MyChar:getMaxMp()
    return self:get(8016)
end
function MyChar:setMaxMp(val)
    return self:set(8016, val)
end

--%����_������% 8017
function MyChar:getAttackPower()
    return self:get(8017)
end
function MyChar:setAttackPower(val)
    return self:set(8017, val)
end

--%����_������% 8018
function MyChar:getDefensePower()
    return self:get(8018)
end
function MyChar:setDefensePower(val)
    return self:set(8018, val)
end

--%����_����% 8019
function MyChar:getAgility()
    return self:get(8019)
end
function MyChar:setAgility(val)
    return self:set(8019, val)
end

--%����_ħ��������% 8020
function MyChar:getMagicAttackPower()
    return self:get(8020)
end
function MyChar:setMagicAttackPower(val)
    return self:set(8020, val)
end

--%����_ħǿ% 8020 (��ħ���������ƺ���ͬһ�����ԣ����ʹ����ͬ�ĺ���)
function MyChar:getMagicStrength()
    return self:get(8020)
end
function MyChar:setMagicStrength(val)
    return self:set(8020, val)
end

--%����_�ظ�% 8021
function MyChar:getRecoveryRate()
    return self:get(8021)
end
function MyChar:setRecoveryRate(val)
    return self:set(8021, val)
end

--%����_OBJ% 8065
function MyChar:getObject()
    return self:get(8065)
end
function MyChar:setObject(val)
    return self:set(8065, val)
end

--%����_��þ���% 8072 (��ս��DP�ƺ���ͬһ�����ԣ����ʹ����ͬ�ĺ���)
function MyChar:getExperienceGain()
    return self:get(8072)
end
function MyChar:setExperienceGain(val)
    return self:set(8072, val)
end

--%����_ս��DP% 8072 (���þ����ƺ���ͬһ�����ԣ����ʹ����ͬ�ĺ���)
-- ע�⣺���ﲻ���ظ����庯������Ϊ������Ļ�þ���ʹ����ͬ�ĺ�����
--%����_���ģʽ% 8117
function MyChar:getTeamMode()
    return self:get(8117)
end
function MyChar:setTeamMode(val)
    return self:set(8117, val)
end

--%����_������% 8150
function MyChar:getIncenseLowerLimit()
    return self:get(8150)
end
function MyChar:setIncenseLowerLimit(val)
    return self:set(8150, val)
end

--%����_������% 8151
function MyChar:getIncenseUpperLimit()
    return self:get(8151)
end
function MyChar:setIncenseUpperLimit(val)
    return self:set(8151, val)
end

--%����_�㲽��% 8152
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
