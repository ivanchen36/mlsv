
-- ����һ����Ϊ MyPlayer �ı�
MyPlayer = {}
MyPlayer.__index = MyPlayer

-- ���幹�캯�� new
function MyPlayer:new(player)
    local newObj = { _player = player }  -- ����һ���µĶ��󣬰���һ����Ϊ data ���ֶΣ���ֵΪ player
    setmetatable(newObj, self)       -- �����¶����Ԫ��Ϊ MyPlayer
    return newObj                    -- �����´����Ķ���
end

-- ���� get ���������ڻ�ȡ�������
function MyPlayer:get(key)
    return Char.GetData(self._player, key)  -- ʹ�� Char.GetData ������ȡ�������
end

-- ���� set ���������������������
function MyPlayer:set(key, val)
    Char.SetData(self._player, key, val)  -- ʹ�� Char.SetData ���������������
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
    sysMsg("����������ĳɹ�");
    return 1
end

function MyPlayer:sysMsg(str)
    NLG.SystemMessage(self._player, "[ϵͳ��ʾ]" .. str)
end

function MyPlayer:feverStart()
    Char.FeverStop(self._player)
    NLG.UpChar(self._player)
    self:sysMsg("��ϲ���򿨳ɹ���")
end

function MyPlayer:feverStop()
    Char.FeverStart(self._player)
    NLG.UpChar(self._player)
    self:sysMsg("��ϲ���رմ򿨳ɹ���")
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

--%����_���% 53
function MyPlayer:addMoney(amount)
    self:setGold( self:getGold() + amount)
    NLG.UpChar(self._player)
    self:sysMsg("���" .. amount .. "ħ�ҡ�")

    return 1
end

function MyPlayer:subMoney(amount)
    local cur = self:getGold()
    if cur >= amount then
        self:setGold( cur - amount)
        self:sysMsg("���" .. amount .. "ħ�ҡ�")

        return 1
    end

    self:sysMsg("ħ�Ҳ���" .. amount .. "���۳�ʧ�ܡ�")
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
        self:sysMsg("���Ƕӳ������ܹ�����")
        return
    end

    Char.Warp(self._player, mapID, floorID, x, y)
end

--%����_�㲽��% 8152
function MyPlayer:isYudi()
    return self:getIncenseStepCount() > 1
end

--%����_������% 8151
function MyPlayer:startYudi()
    self:setIncenseStepCount(999);
    self:setIncenseUpperLimit( 999);
    self:sysMsg("���������Ѿ�������");
end

function MyPlayer:stopYudi()
    self:setIncenseStepCount(0);
    self:setIncenseUpperLimit(0);
    self:sysMsg("���������Ѿ��رգ�");
end

function MyPlayer:isBuYudi()
    return self:getEnemyAvoidSwitch() == 1
end

function MyPlayer:startBuYudi()
    self:set(6003,1);
    self:sysMsg("�������Ѿ�������");
end

function MyPlayer:stopBuYudi()
    self:set(6003,0);
    self:sysMsg("�������Ѿ��رգ�");
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

--%����_ս��% 4000
function MyPlayer:getDie()
    return self:get(4000)
end
function MyPlayer:setDie(val)
    return self:set(4000, val)
end

--%����_ս����Ϣ����% 4001
function MyPlayer:getBattleInfoSwitch()
    return self:get(4001)
end
function MyPlayer:setBattleInfoSwitch(val)
    return self:set(4001, val)
end

--%����_��½������% 4002
function MyPlayer:getRichListSwitch()
    return self:get(4002)
end
function MyPlayer:setRichListSwitch(val)
    return self:set(4002, val)
end

--%����_��ӿ���% 4003
function MyPlayer:getTeamSwitch()
    return self:get(4003)
end
function MyPlayer:setTeamSwitch(val)
    return self:set(4003, val)
end

--%����_PK����% 4004 �� %����_��ս����% 4004 (�����ƺ���ͬ��ʹ��ͬһ������)
function MyPlayer:getPkBattleSwitch()
    return self:get(4004)
end
function MyPlayer:setPkBattleSwitch(val)
    return self:set(4004, val)
end

--%����_���Ŀ���% 4005
function MyPlayer:getTeamChatSwitch()
    return self:get(4005)
end
function MyPlayer:setTeamChatSwitch(val)
    return self:set(4005, val)
end

--%����_��Ƭ����% 4006
function MyPlayer:getCardSwitch()
    return self:get(4006)
end
function MyPlayer:setCardSwitch(val)
    return self:set(4006, val)
end

--%����_���׿���% 4007
function MyPlayer:getTradeSwitch()
    return self:get(4007)
end
function MyPlayer:setTradeSwitch(val)
    return self:set(4007, val)
end

--%����_��% 4008
function MyPlayer:getCheckIn()
    return self:get(4008)
end
function MyPlayer:setCheckIn(val)
    return self:set(4008, val)
end

--%����_���糬ʱ% 4009
function MyPlayer:getNetworkTimeout()
    return self:get(4009)
end
function MyPlayer:setNetworkTimeout(val)
    return self:set(4009, val)
end

--%����_���忪��% 4010
function MyPlayer:getFamilySwitch()
    return self:get(4010)
end
function MyPlayer:setFamilySwitch(val)
    return self:set(4010, val)
end

--%����_DEBUG����% 6000
function MyPlayer:getDebugSwitch()
    return self:get(6000)
end
function MyPlayer:setDebugSwitch(val)
    return self:set(6000, val)
end

--%����_ʹ��MIC% 6001
function MyPlayer:getMicUsage()
    return self:get(6001)
end
function MyPlayer:setMicUsage(val)
    return self:set(6001, val)
end

--%����_�ѱ���% 6002
function MyPlayer:getSavedStatus()
    return self:get(6002)
end
function MyPlayer:setSavedStatus(val)
    return self:set(6002, val)
end

--%����_�����п���% 6003
function MyPlayer:getEnemyAvoidSwitch()
    return self:get(6003)
end

function MyPlayer:setEnemyAvoidSwitch(val)
    return self:set(6003, val)
end

--%����_��% 0
function MyPlayer:getType()
    return self:get(0)
end
function MyPlayer:setType(val)
    return self:set(0, val)
end

--%����_����% 1
function MyPlayer:getImage()
    return self:get(1)
end
function MyPlayer:setImage(val)
    return self:set(1, val)
end

--%����_����% 1
function MyPlayer:isVisible()
    return self:get(1)
end
function MyPlayer:setVisible(val)
    return self:set(1, val)
end

--%����_ԭ��% 2
function MyPlayer:getOriginalForm()
    return self:get(2)
end
function MyPlayer:setOriginalForm(val)
    return self:set(2, val)
end

--%����_MAP% 3
function MyPlayer:getMap()
    return self:get(3)
end
function MyPlayer:setMap(val)
    return self:set(3, val)
end

--%����_��ͼ% 4
function MyPlayer:getMapId()
    return self:get(4)
end
function MyPlayer:setMapId(val)
    return self:set(4, val)
end

--%����_X% 5
function MyPlayer:getX()
    return self:get(5)
end
function MyPlayer:setX(val)
    return self:set(5, val)
end

--%����_Y% 6
function MyPlayer:getY()
    return self:get(6)
end
function MyPlayer:setY(val)
    return self:set(6, val)
end

--%����_����% 7
function MyPlayer:getDirection()
    return self:get(7)
end
function MyPlayer:setDirection(val)
    return self:set(7, val)
end

--%����_�ȼ�% 8
function MyPlayer:getLevel()
    return self:get(8)
end
function MyPlayer:setLevel(val)
    -- �������������һЩ��֤�߼�������ȷ���ȼ��������0
    if val < 0 then
        return false, "�ȼ����ܵ���0"
    end
    return self:set(8, val)
end
--%����_Ѫ% 9
function MyPlayer:getHp()
    return self:get(9)
end
function MyPlayer:setHp(val)
    return self:set(9, val)
end
--%����_ħ% 10
function MyPlayer:getMp()
    return self:get(10)
end
function MyPlayer:setMp(val)
    return self:set(10, val)
end

--%����_����% 11
function MyPlayer:getStamina()
    return self:get(11)
end
function MyPlayer:setStamina(val)
    return self:set(11, val)
end

--%����_����% 12
function MyPlayer:getStrength()
    return self:get(12)
end
function MyPlayer:setStrength(val)
    return self:set(12, val)
end

--%����_ǿ��% 13
function MyPlayer:getIntensity()
    return self:get(13)
end
function MyPlayer:setIntensity(val)
    return self:set(13, val)
end

--%����_�ٶ�% 14
function MyPlayer:getSpeed()
    return self:get(14)
end
function MyPlayer:setSpeed(val)
    return self:set(14, val)
end

--%����_ħ��% 15 (�����_ħ�ظ���������������ɾ��һ��)

--%����_��% 16
function MyPlayer:getLuck()
    return self:get(16)
end
function MyPlayer:setLuck(val)
    return self:set(16, val)
end

--%����_����% 17
function MyPlayer:getRace()
    return self:get(17)
end
function MyPlayer:setRace(val)
    return self:set(17, val)
end

--%����_������% 18
function MyPlayer:getEarthAttribute()
    return self:get(18)
end
function MyPlayer:setEarthAttribute(val)
    return self:set(18, val)
end

--%����_ˮ����% 19
function MyPlayer:getWaterAttribute()
    return self:get(19)
end
function MyPlayer:setWaterAttribute(val)
    return self:set(19, val)
end

--%����_������% 20
function MyPlayer:getFireAttribute()
    return self:get(20)
end
function MyPlayer:setFireAttribute(val)
    return self:set(20, val)
end

--%����_������% 21
function MyPlayer:getWindAttribute()
    return self:get(21)
end
function MyPlayer:setWindAttribute(val)
    return self:set(21, val)
end

--%����_����% 22
function MyPlayer:getPoisonResistance()
    return self:get(22)
end
function MyPlayer:setPoisonResistance(val)
    return self:set(22, val)
end

--%����_��˯% 23
function MyPlayer:getSleepResistance()
    return self:get(23)
end
function MyPlayer:setSleepResistance(val)
    return self:set(23, val)
end

--%����_��ʯ% 24
function MyPlayer:getPetrifyResistance()
    return self:get(24)
end
function MyPlayer:setPetrifyResistance(val)
    return self:set(24, val)
end

--%����_����% 25
function MyPlayer:getDrunkResistance()
    return self:get(25)
end
function MyPlayer:setDrunkResistance(val)
    return self:set(25, val)
end

--%����_����% 26
function MyPlayer:getChaosResistance()
    return self:get(26)
end
function MyPlayer:setChaosResistance(val)
    return self:set(26, val)
end
--%����_����% 27
function MyPlayer:getForgetResistance()
    return self:get(27)
end
function MyPlayer:setForgetResistance(val)
    return self:set(27, val)
end

--%����_��ɱ% 28
function MyPlayer:getCriticalHitChance()
    return self:get(28)
end
function MyPlayer:setCriticalHitChance(val)
    return self:set(28, val)
end

--%����_����% 29
function MyPlayer:getCounterAttackChance()
    return self:get(29)
end
function MyPlayer:setCounterAttackChance(val)
    return self:set(29, val)
end

--%����_����% 30
function MyPlayer:getHitRate()
    return self:get(30)
end
function MyPlayer:setHitRate(val)
    return self:set(30, val)
end

--%����_����% 31
function MyPlayer:getDodgeRate()
    return self:get(31)
end
function MyPlayer:setDodgeRate(val)
    return self:set(31, val)
end

--%����_������% 32
function MyPlayer:getItemSlots()
    return self:get(32)
end
function MyPlayer:setItemSlots(val)
    return self:set(32, val)
end

--%����_������% 33
function MyPlayer:getSkillSlots()
    return self:get(33)
end
function MyPlayer:setSkillSlots(val)
    return self:set(33, val)
end

--%����_������% 34
function MyPlayer:getDeathCount()
    return self:get(34)
end
function MyPlayer:setDeathCount(val)
    return self:set(34, val)
end

--%����_�˺���% 35
function MyPlayer:getDamageCount()
    return self:get(35)
end
function MyPlayer:setDamageCount(val)
    return self:set(35, val)
end

--%����_ɱ����% 36
function MyPlayer:getKilledPetCount()
    return self:get(36)
end
function MyPlayer:setKilledPetCount(val)
    return self:set(36, val)
end

--%����_ռ��ʱ��% 37
function MyPlayer:getDivinationTime()
    return self:get(37)
end
function MyPlayer:setDivinationTime(val)
    return self:set(37, val)
end

--%����_����% 38
function MyPlayer:getHurtStatus()
    return self:get(38)
end
function MyPlayer:setHurtStatus(val)
    return self:set(38, val)
end

--%����_�Ƽ�% 39
function MyPlayer:getMoveSpace()
    return self:get(39)
end
function MyPlayer:setMoveSpace(val)
    return self:set(39, val)
end

--%����_ѭʱ% 40
function MyPlayer:getCycleTime()
    return self:get(40)
end
function MyPlayer:setCycleTime(val)
    return self:set(40, val)
end

--%����_����% 41
function MyPlayer:getExperience()
    return self:get(41)
end
function MyPlayer:setExperience(val)
    return self:set(41, val)
end

--%����_������% 42
function MyPlayer:getUpgradePoints()
    return self:get(42)
end
function MyPlayer:setUpgradePoints(val)
    return self:set(42, val)
end

--%����_ͼ��% 43
function MyPlayer:getImageType()
    return self:get(43)
end
function MyPlayer:setImageType(val)
    return self:set(43, val)
end

--%����_��ɫ% 44
function MyPlayer:getNameColor()
    return self:get(44)
end
function MyPlayer:setNameColor(val)
    return self:set(44, val)
end

--%����_RegistNumber% 48
function MyPlayer:getRegistNumber()
    return self:get(48)
end
function MyPlayer:setRegistNumber(val)
    return self:set(48, val)
end

--%����_ְҵ% 49
function MyPlayer:getJob()
    return self:get(49)
end
function MyPlayer:setJob(val)
    return self:set(49, val)
end

--%����_ְ��% 50
function MyPlayer:getJobRank()
    return self:get(50)
end
function MyPlayer:setJobRank(val)
    return self:set(50, val)
end

--%����_ְ��ID% 51
function MyPlayer:getJobClassId()
    return self:get(51)
end
function MyPlayer:setJobClassId(val)
    return self:set(51, val)
end

--%����_��% 52
function MyPlayer:getFace()
    return self:get(52)
end
function MyPlayer:setFace(val)
    return self:set(52, val)
end

--%����_���% 53
function MyPlayer:getGold()
    return self:get(53)
end
function MyPlayer:setGold(val)
    return self:set(53, val)
end

--%����_���н��% 54
function MyPlayer:getBankGold()
    return self:get(54)
end
function MyPlayer:setBankGold(val)
    return self:set(54, val)
end

--%����_����% 55
function MyPlayer:getStamina()
    return self:get(55)
end
function MyPlayer:setStamina(val)
    return self:set(55, val)
end

--%����_����% 56
function MyPlayer:getDexterity()
    return self:get(56)
end
function MyPlayer:setDexterity(val)
    return self:set(56, val)
end

--%����_����% 57
function MyPlayer:getIntelligence()
    return self:get(57)
end
function MyPlayer:setIntelligence(val)
    return self:set(57, val)
end

--%����_����% 58
function MyPlayer:getCharm()
    return self:get(58)
end
function MyPlayer:setCharm(val)
    return self:set(58, val)
end

--%����_����% 59
function MyPlayer:getReputation()
    return self:get(59)
end
function MyPlayer:setReputation(val)
    return self:set(59, val)
end

--%����_�ƺ�% 60
function MyPlayer:getTitle()
    return self:get(60)
end
function MyPlayer:setTitle(val)
    return self:set(60, val)
end

--%����_��¼��% 61
function MyPlayer:getRecordPoint()
    return self:get(61)
end
function MyPlayer:setRecordPoint(val)
    return self:set(61, val)
end

--%����_ս��% 62
function MyPlayer:getBattlePet()
    return self:get(62)
end
function MyPlayer:setBattlePet(val)
    return self:set(62, val)
end

--%����_�������% 63
function MyPlayer:getChatDistance()
    return self:get(63)
end
function MyPlayer:setChatDistance(val)
    return self:set(63, val)
end

--%����_HelpPoint% 64
function MyPlayer:getHelpPoint()
    return self:get(64)
end
function MyPlayer:setHelpPoint(val)
    return self:set(64, val)
end

--%����_��½����% 65
function MyPlayer:getLoginCount()
    return self:get(65)
end
function MyPlayer:setLoginCount(val)
    return self:set(65, val)
end

--%����_˵��% 66
function MyPlayer:getTalkCount()
    return self:get(66)
end
function MyPlayer:setTalkCount(val)
    return self:set(66, val)
end

--%����_�����% 67
function MyPlayer:getPetAcquireCount()
    return self:get(67)
end
function MyPlayer:setPetAcquireCount(val)
    return self:set(67, val)
end

--%����_����% 68
function MyPlayer:getMailCount()
    return self:get(68)
end
function MyPlayer:setMailCount(val)
    return self:set(68, val)
end

--%����_������% 69
function MyPlayer:getProductionCount()
    return self:get(69)
end
function MyPlayer:setProductionCount(val)
    return self:set(69, val)
end

--%����_�ߴ�% 70
function MyPlayer:getWalkCount()
    return self:get(70)
end
function MyPlayer:setWalkCount(val)
    return self:set(70, val)
end

--%����_������% 71
function MyPlayer:getPetDeathCount()
    return self:get(71)
end
function MyPlayer:setPetDeathCount(val)
    return self:set(71, val)
end

--%����_�踴��% 72
function MyPlayer:getPetRepeatCount()
    return self:get(72)
end
function MyPlayer:setPetRepeatCount(val)
    return self:set(72, val)
end

--%����_������% 73
function MyPlayer:getPetTreatCount()
    return self:get(73)
end
function MyPlayer:setPetTreatCount(val)
    return self:set(73, val)
end

--%����_��ӡ��% 74
function MyPlayer:getSealCount()
    return self:get(74)
end
function MyPlayer:setSealCount(val)
    return self:set(74, val)
end

--%����_OtherFlg% 75
function MyPlayer:getOtherFlag()
    return self:get(75)
end
function MyPlayer:setOtherFlag(val)
    return self:set(75, val)
end

--%����_����������% 76
function MyPlayer:getDailyReputationCap()
    return self:get(76)
end
function MyPlayer:setDailyReputationCap(val)
    return self:set(76, val)
end

--%����_������ȡʱ��% 77
function MyPlayer:getReputationGainTime()
    return self:get(77)
end
function MyPlayer:setReputationGainTime(val)
    return self:set(77, val)
end

--%����_�����½�ʱ��% 78
function MyPlayer:getReputationLossTime()
    return self:get(78)
end
function MyPlayer:setReputationLossTime(val)
    return self:set(78, val)
end

--%����_����% 79
function MyPlayer:getSoulDrop()
    return self:get(79)
end
function MyPlayer:setSoulDrop(val)
    return self:set(79, val)
end

--%����_����������% 159
function MyPlayer:getMaxBankPets()
    return self:get(159)
end
function MyPlayer:setMaxBankPets(val)
    return self:set(159, val)
end

--%����_�����������% 160
function MyPlayer:getMaxBankItems()
    return self:get(160)
end
function MyPlayer:setMaxBankItems(val)
    return self:set(160, val)
end

--%����_DP% 161
function MyPlayer:getDP()
    return self:get(161)
end
function MyPlayer:setDP(val)
    return self:set(161, val)
end

--%����_��ɫ% 162
function MyPlayer:getTalkColor()
    return self:get(162)
end
function MyPlayer:setTalkColor(val)
    return self:set(162, val)
end

--%����_λ��% 163
function MyPlayer:getPosition()
    return self:get(163)
end
function MyPlayer:setPosition(val)
    return self:set(163, val)
end

--%����_GM% 164
function MyPlayer:getGm()
    return self:get(164)
end
function MyPlayer:setGm(val)
    return self:set(164, val and 1 or 0)
end

--%����_��½��% 171
function MyPlayer:getLoginPoint()
    return self:get(171)
end
function MyPlayer:setLoginPoint(val)
    return self:set(171, val)
end

--%����_��ʱ% 173
function MyPlayer:getStuckTime()
    return self:get(173)
end
function MyPlayer:setStuckTime(val)
    return self:set(173, val)
end

--%����_����ID% 174
function MyPlayer:getHouseID()
    return self:get(174)
end
function MyPlayer:setHouseID(val)
    return self:set(174, val)
end

--%����_��������% 175
function MyPlayer:getHouseExpiration()
    return self:get(175)
end
function MyPlayer:setHouseExpiration(val)
    return self:set(175, val)
end

--%����_ԭʼͼ��% 178
function MyPlayer:getOriginalImage()
    return self:get(178)
end
function MyPlayer:setOriginalImage(val)
    return self:set(178, val)
end

--%����_����% 2000
function MyPlayer:getName()
    return self:get(2000)
end
function MyPlayer:setName(val)
    return self:set(2000, val)
end

--%����_ԭ��% 2000 (�����_�����ظ���������һ�������������������ͬһ������)
function MyPlayer:getOriginalName()
    return self:get(2000)
end
function MyPlayer:setOriginalName(val)
    return self:set(2000, val)
end

--%����_��ҳƺ�% 2001
function MyPlayer:getTitle()
    return self:get(2001)
end
function MyPlayer:setTitle(val)
    return self:set(2001, val)
end

--%����_����% 2001 (�����_��ҳƺ��ظ���������һ�������������������ͬһ������)
function MyPlayer:getPetName()
    return self:get(2001)
end
function MyPlayer:setPetName(val)
    return self:set(2001, val)
end

--%����_CDK% 2002
function MyPlayer:getCdk()
    return self:get(2002)
end
function MyPlayer:setCdk(val)
    return self:set(2002, val)
end

--%����_�˺�% 2002
function MyPlayer:getAccountId()
    return self:get(2002)
end
function MyPlayer:setAccountId(val)
    return self:set(2002, val)
end

--%����_����CDK% 2003
function MyPlayer:getOwnerCdk()
    return self:get(2003)
end
function MyPlayer:setOwnerCdk(val)
    return self:set(2003, val)
end

--%����_��������% 2004
function MyPlayer:getOwnerName()
    return self:get(2004)
end
function MyPlayer:setOwnerName(val)
    return self:set(2004, val)
end

--%����_����ԭ��% 2004 (�����_����������ͬ)
function MyPlayer:getOwnerOriginalName()
    return self:get(2004)
end
function MyPlayer:setOwnerOriginalName(val)
    return self:set(2004, val)
end

--%����_ս����% 8000
function MyPlayer:isInBattle()
    return self:get(8000)
end
function MyPlayer:setInBattle(val)
    return self:set(8000, val)
end

--%����_ս��״̬% 8000 (�����_ս������ͬ)
function MyPlayer:getBattleStatus()
    return self:get(8000)
end
function MyPlayer:setBattleStatus(val)
    return self:set(8000, val)
end

--%����_ս��Index% 8001
function MyPlayer:getBattleIndex()
    return self:get(8001)
end
function MyPlayer:setBattleIndex(val)
    return self:set(8001, val)
end

--%����_ս��Side% 8002
function MyPlayer:getBattleSide()
    return self:get(8002)
end
function MyPlayer:setBattleSide(val)
    return self:set(8002, val)
end

--%����_���Ѫ% 8015
function MyPlayer:getMaxHp()
    return self:get(8015)
end
function MyPlayer:setMaxHp(val)
    return self:set(8015, val)
end

--%����_���ħ% 8016
function MyPlayer:getMaxMp()
    return self:get(8016)
end
function MyPlayer:setMaxMp(val)
    return self:set(8016, val)
end

--%����_������% 8017
function MyPlayer:getAttackPower()
    return self:get(8017)
end
function MyPlayer:setAttackPower(val)
    return self:set(8017, val)
end

--%����_������% 8018
function MyPlayer:getDefensePower()
    return self:get(8018)
end
function MyPlayer:setDefensePower(val)
    return self:set(8018, val)
end

--%����_����% 8019
function MyPlayer:getAgility()
    return self:get(8019)
end
function MyPlayer:setAgility(val)
    return self:set(8019, val)
end

--%����_ħ��������% 8020
function MyPlayer:getMagicAttackPower()
    return self:get(8020)
end
function MyPlayer:setMagicAttackPower(val)
    return self:set(8020, val)
end

--%����_ħǿ% 8020 (��ħ���������ƺ���ͬһ�����ԣ����ʹ����ͬ�ĺ���)
function MyPlayer:getMagicStrength()
    return self:get(8020)
end
function MyPlayer:setMagicStrength(val)
    return self:set(8020, val)
end

--%����_�ظ�% 8021
function MyPlayer:getRecoveryRate()
    return self:get(8021)
end
function MyPlayer:setRecoveryRate(val)
    return self:set(8021, val)
end

--%����_OBJ% 8065
function MyPlayer:getObject()
    return self:get(8065)
end
function MyPlayer:setObject(val)
    return self:set(8065, val)
end

--%����_��þ���% 8072 (��ս��DP�ƺ���ͬһ�����ԣ����ʹ����ͬ�ĺ���)
function MyPlayer:getExperienceGain()
    return self:get(8072)
end
function MyPlayer:setExperienceGain(val)
    return self:set(8072, val)
end

--%����_ս��DP% 8072 (���þ����ƺ���ͬһ�����ԣ����ʹ����ͬ�ĺ���)
-- ע�⣺���ﲻ���ظ����庯������Ϊ������Ļ�þ���ʹ����ͬ�ĺ�����
--%����_���ģʽ% 8117
function MyPlayer:getTeamMode()
    return self:get(8117)
end
function MyPlayer:setTeamMode(val)
    return self:set(8117, val)
end

--%����_������% 8150
function MyPlayer:getIncenseLowerLimit()
    return self:get(8150)
end
function MyPlayer:setIncenseLowerLimit(val)
    return self:set(8150, val)
end

--%����_������% 8151
function MyPlayer:getIncenseUpperLimit()
    return self:get(8151)
end
function MyPlayer:setIncenseUpperLimit(val)
    return self:set(8151, val)
end

--%����_�㲽��% 8152
function MyPlayer:getIncenseStepCount()
    return self:get(8152)
end
function MyPlayer:setIncenseStepCount(val)
    return self:set(8152, val)
end