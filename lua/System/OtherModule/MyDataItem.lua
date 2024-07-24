-- 定义一个名为 MyDataItem 的表
MyDataItem = {}
MyDataItem.__index = MyDataItem

-- 定义构造函数 new
function MyDataItem:new(itemId)
    local newObj = { _item = Data.ItemsetGetIndex(itemId)}  -- 创建一个新的对象，包含一个名为 data 的字段，其值为 pet
    setmetatable(newObj, self)       -- 设置新对象的元表为 MyDataItem
    return newObj
end

function MyDataItem:getObj()
    return self._item
end

function MyDataItem:get(key)
    return Data.ItemsetGetData(self._item, key)  -- 使用 Char.GetData 函数获取玩家数据
end

-- 定义 set 方法，用于设置玩家数据
function MyDataItem:set(key, val)
    return
end

--%道具_鉴前名%	2000
function MyDataItem:getUnidentifiedName()
    return self:get(2000)
end
function MyDataItem:setUnidentifiedName(val)
    return self:set(2000, val)
end

--%道具_名字%	2001
function MyDataItem:getName()
    return self:get(2001)
end
function MyDataItem:setName(val)
    return self:set(2001, val)
end

--%道具_刻印%	2002
function MyDataItem:getEngraving()
    return self:get(2002)
end
function MyDataItem:setEngraving(val)
    return self:set(2002, val)
end

--%道具_自用参数%	2003
function MyDataItem:getSelfUseParam()
    return self:get(2003)
end
function MyDataItem:setSelfUseParam(val)
    return self:set(2003, val)
end

--%道具_刻印玩家%	2004
function MyDataItem:getEngraverPlayer()
    return self:get(2004)
end
function MyDataItem:setEngraverPlayer(val)
    return self:set(2004, val)
end

--%道具_序%	0
function MyDataItem:getOrder()
    return self:get(0)
end
function MyDataItem:setOrder(val)
    return self:set(0, val)
end

--%道具_ID%	0
function MyDataItem:getID()
    return self:get(0)
end
function MyDataItem:setID(val)
    return self:set(0, val)
end

--%道具_图%	1
function MyDataItem:getImage()
    return self:get(1)
end
function MyDataItem:setImage(val)
    return self:set(1, val)
end

--%道具_价格%	2
function MyDataItem:getPrice()
    return self:get(2)
end
function MyDataItem:setPrice(val)
    return self:set(2, val)
end

--%道具_类型%	3
function MyDataItem:getType()
    return self:get(3)
end
function MyDataItem:setType(val)
    return self:set(3, val)
end

--%道具_双手%	5
function MyDataItem:isTwoHanded()
    return self:get(5) == 1
end
function MyDataItem:setTwoHanded(val)
    return self:set(5, val ~= nil and val ~= 0 and 1 or 0)
end

--%道具_双击%	6
function MyDataItem:isDoubleClick()
    return self:get(6) == 1
end
function MyDataItem:setDoubleClick(val)
    return self:set(6, val ~= nil and val ~= 0 and 1 or 0)
end

--%道具_可双击%	6
function MyDataItem:isDoubleClickable()
    return self:get(6) == 1
end
function MyDataItem:setDoubleClickable(val)
    return self:set(6, val ~= nil and val ~= 0 and 1 or 0)
end

--%道具_战斗可用%	7
function MyDataItem:isBattleUsable()
    return self:get(7) == 1
end
function MyDataItem:setBattleUsable(val)
    return self:set(7, val ~= nil and val ~= 0 and 1 or 0)
end

--%道具_堆叠数%	9
function MyDataItem:getStackCount()
    return self:get(9)
end
function MyDataItem:setStackCount(val)
    return self:set(9, val)
end

--%道具_最大堆叠数%	10
function MyDataItem:getMaxStackCount()
    return self:get(10)
end
function MyDataItem:setMaxStackCount(val)
    return self:set(10, val)
end

--%道具_等级%	11
function MyDataItem:getLevel()
    return self:get(11)
end
function MyDataItem:setLevel(val)
    return self:set(11, val)
end

--%道具_最大耐久%	13
function MyDataItem:getMaxDurability()
    return self:get(13)
end
function MyDataItem:setMaxDurability(val)
    return self:set(13, val)
end

--%道具_最小攻击数量%	14
function MyDataItem:getMinAttackCount()
    return self:get(14)
end
function MyDataItem:setMinAttackCount(val)
    return self:set(14, val)
end

--%道具_最大攻击数量%	15
function MyDataItem:getMaxAttackCount()
    return self:get(15)
end
function MyDataItem:setMaxAttackCount(val)
    return self:set(15, val)
end

--%道具_攻击%	18
function MyDataItem:getAttack()
    return self:get(18)
end
function MyDataItem:setAttack(val)
    return self:set(18, val)
end

--%道具_防御%	19
function MyDataItem:getDefense()
    return self:get(19)
end
function MyDataItem:setDefense(val)
    return self:set(19, val)
end

--%道具_敏捷%	20
function MyDataItem:getAgility()
    return self:get(20)
end
function MyDataItem:setAgility(val)
    return self:set(20, val)
end

--%道具_精神%	21
function MyDataItem:getSpirit()
    return self:get(21)
end
function MyDataItem:setSpirit(val)
    return self:set(21, val)
end

--%道具_回复%	22
function MyDataItem:getRecovery()
    return self:get(22)
end
function MyDataItem:setRecovery(val)
    return self:set(22, val)
end

--%道具_必杀%	23
function MyDataItem:getCritical()
    return self:get(23)
end
function MyDataItem:setCritical(val)
    return self:set(23, val)
end

--%道具_反击%	24
function MyDataItem:getCounter()
    return self:get(24)
end
function MyDataItem:setCounter(val)
    return self:set(24, val)
end

--%道具_命中%	25
function MyDataItem:getHit()
    return self:get(25)
end
function MyDataItem:setHit(val)
    return self:set(25, val)
end

--%道具_闪躲%	26
function MyDataItem:getDodge()
    return self:get(26)
end
function MyDataItem:setDodge(val)
    return self:set(26, val)
end

--%道具_HP%	27
function MyDataItem:getHP()
    return self:get(27)
end
function MyDataItem:setHP(val)
    return self:set(27, val)
end

--%道具_MP%	28
function MyDataItem:getMP()
    return self:get(28)
end
function MyDataItem:setMP(val)
    return self:set(28, val)
end

--%道具_生命%	27
function MyDataItem:getLife()
    return self:get(27)
end
function MyDataItem:setLife(val)
    return self:set(27, val)
end

--%道具_魔力%	28
function MyDataItem:getMana()
    return self:get(28)
end
function MyDataItem:setMana(val)
    return self:set(28, val)
end

--%道具_幸运%	29
function MyDataItem:getLuck()
    return self:get(29)
end
function MyDataItem:setLuck(val)
    return self:set(29, val)
end

--%道具_魅力%	31
function MyDataItem:getCharisma()
    return self:get(31)
end
function MyDataItem:setCharisma(val)
    return self:set(31, val)
end

--%道具_属性一%	32
function MyDataItem:getAttribute1()
    return self:get(32)
end
function MyDataItem:setAttribute1(val)
    return self:set(32, val)
end

--%道具_属性二%	33
function MyDataItem:getAttribute2()
    return self:get(33)
end
function MyDataItem:setAttribute2(val)
    return self:set(33, val)
end

--%道具_属性一值%	34
function MyDataItem:getAttribute1Value()
    return self:get(34)
end
function MyDataItem:setAttribute1Value(val)
    return self:set(34, val)
end

--%道具_属性二值%	35
function MyDataItem:getAttribute2Value()
    return self:get(35)
end
function MyDataItem:setAttribute2Value(val)
    return self:set(35, val)
end

--%道具_耐力%	36
function MyDataItem:getEndurance()
    return self:get(36)
end
function MyDataItem:setEndurance(val)
    return self:set(36, val)
end

--%道具_灵巧%	37
function MyDataItem:getDexterity()
    return self:get(37)
end
function MyDataItem:setDexterity(val)
    return self:set(37, val)
end

--%道具_智力%	38
function MyDataItem:getIntelligence()
    return self:get(38)
end
function MyDataItem:setIntelligence(val)
    return self:set(38, val)
end

--%道具_毒抗%	39
function MyDataItem:getPoisonResistance()
    return self:get(39)
end
function MyDataItem:setPoisonResistance(val)
    return self:set(39, val)
end

--%道具_睡抗%	40
function MyDataItem:getSleepResistance()
    return self:get(40)
end
function MyDataItem:setSleepResistance(val)
    return self:set(40, val)
end

--%道具_石抗%	41
function MyDataItem:getStoneResistance()
    return self:get(41)
end
function MyDataItem:setStoneResistance(val)
    return self:set(41, val)
end

--%道具_醉抗%	42
function MyDataItem:getDrunkResistance()
    return self:get(42)
end
function MyDataItem:setDrunkResistance(val)
    return self:set(42, val)
end

--%道具_乱抗%	43
function MyDataItem:getConfusionResistance()
    return self:get(43)
end
function MyDataItem:setConfusionResistance(val)
    return self:set(43, val)
end

--%道具_忘抗% 44
function MyDataItem:getForgetResistance()
    return self:get(44)
end
function MyDataItem:setForgetResistance(val)
    return self:set(44, val)
end

--%道具_特殊类型% 45
function MyDataItem:getSpecialType()
    return self:get(45)
end
function MyDataItem:setSpecialType(val)
    return self:set(45, val)
end

--%道具_子参一% 46
function MyDataItem:getSubParamOne()
    return self:get(46)
end
function MyDataItem:setSubParamOne(val)
    return self:set(46, val)
end

--%道具_子参二% 47
function MyDataItem:getSubParamTwo()
    return self:get(47)
end
function MyDataItem:setSubParamTwo(val)
    return self:set(47, val)
end

--%道具_宝石武% 48
function MyDataItem:getGemAttack()
    return self:get(48)
end
function MyDataItem:setGemAttack(val)
    return self:set(48, val)
end

--%道具_宝石防% 49
function MyDataItem:getGemDefense()
    return self:get(49)
end
function MyDataItem:setGemDefense(val)
    return self:set(49, val)
end

--%道具_登出消失% 52
function MyDataItem:getDisappearOnLogout()
    return self:get(52)
end
function MyDataItem:setDisappearOnLogout(val)
    return self:set(52, val)
end

--%道具_丢地消失% 53
function MyDataItem:getDisappearOnDrop()
    return self:get(53)
end
function MyDataItem:setDisappearOnDrop(val)
    return self:set(53, val)
end

--%道具_宠邮% 54
function MyDataItem:getPetMail()
    return self:get(54)
end
function MyDataItem:setPetMail(val)
    return self:set(54, val)
end

--%道具_魔抗% 55
function MyDataItem:getMagicResistance()
    return self:get(55)
end
function MyDataItem:setMagicResistance(val)
    return self:set(55, val)
end

--%道具_可出售% 56
function MyDataItem:getSellable()
    return self:get(56)
end
function MyDataItem:setSellable(val)
    return self:set(56, val)
end

--%道具_已鉴定% 63
function MyDataItem:getIdentified()
    return self:get(63)
end
function MyDataItem:setIdentified(val)
    return self:set(63, val)
end

--%道具_耐久% 65
function MyDataItem:getDurability()
    return self:get(65)
end
function MyDataItem:setDurability(val)
    return self:set(65, val)
end

--%道具_Obj索引% 4000
function MyDataItem:getObjectIndex()
    return self:get(4000)
end
function MyDataItem:setObjectIndex(val)
    return self:set(4000, val)
end

--%道具_已装备% 4002
function MyDataItem:getEquipped()
    return self:get(4002)
end
function MyDataItem:setEquipped(val)
    return self:set(4002, val)
end