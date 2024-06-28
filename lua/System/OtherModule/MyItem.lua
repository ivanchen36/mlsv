-- 定义一个名为 MyItem 的表
MyItem = {}
MyItem.__index = MyItem

-- 定义构造函数 new
function MyItem:new(itemIndex)
    local newObj = { _item = itemIndex}  -- 创建一个新的对象，包含一个名为 data 的字段，其值为 pet
    setmetatable(newObj, self)       -- 设置新对象的元表为 MyItem
    return newObj
end

function MyItem:create(itemID)
    return MyItem:new(Data.ItemsetGetIndex(itemID))
end

function MyItem:getObj()
    return self._item
end

function MyItem:get(key)
    return Item.GetData(self._item, key)  -- 使用 Char.GetData 函数获取玩家数据
end

-- 定义 set 方法，用于设置玩家数据
function MyItem:set(key, val)
    Item.SetData(self._item, key, val)  -- 使用 Char.SetData 函数设置玩家数据
end

--%道具_鉴前名%	2000
function MyItem:getUnidentifiedName()
    return self:get(2000)
end
function MyItem:setUnidentifiedName(val)
    return self:set(2000, val)
end

--%道具_名字%	2001
function MyItem:getName()
    return self:get(2001)
end
function MyItem:setName(val)
    return self:set(2001, val)
end

--%道具_刻印%	2002
function MyItem:getEngraving()
    return self:get(2002)
end
function MyItem:setEngraving(val)
    return self:set(2002, val)
end

--%道具_自用参数%	2003
function MyItem:getSelfUseParam()
    return self:get(2003)
end
function MyItem:setSelfUseParam(val)
    return self:set(2003, val)
end

--%道具_刻印玩家%	2004
function MyItem:getEngraverPlayer()
    return self:get(2004)
end
function MyItem:setEngraverPlayer(val)
    return self:set(2004, val)
end

--%道具_序%	0
function MyItem:getOrder()
    return self:get(0)
end
function MyItem:setOrder(val)
    return self:set(0, val)
end

--%道具_ID%	0
function MyItem:getID()
    return self:get(0)
end
function MyItem:setID(val)
    return self:set(0, val)
end

--%道具_图%	1
function MyItem:getImage()
    return self:get(1)
end
function MyItem:setImage(val)
    return self:set(1, val)
end

--%道具_价格%	2
function MyItem:getPrice()
    return self:get(2)
end
function MyItem:setPrice(val)
    return self:set(2, val)
end

--%道具_类型%	3
function MyItem:getType()
    return self:get(3)
end
function MyItem:setType(val)
    return self:set(3, val)
end

--%道具_双手%	5
function MyItem:isTwoHanded()
    return self:get(5) == 1
end
function MyItem:setTwoHanded(val)
    return self:set(5, val and 1 or 0)
end

--%道具_双击%	6
function MyItem:isDoubleClick()
    return self:get(6) == 1
end
function MyItem:setDoubleClick(val)
    return self:set(6, val and 1 or 0)
end

--%道具_可双击%	6
function MyItem:isDoubleClickable()
    return self:get(6) == 1
end
function MyItem:setDoubleClickable(val)
    return self:set(6, val and 1 or 0)
end

--%道具_战斗可用%	7
function MyItem:isBattleUsable()
    return self:get(7) == 1
end
function MyItem:setBattleUsable(val)
    return self:set(7, val and 1 or 0)
end

--%道具_堆叠数%	9
function MyItem:getStackCount()
    return self:get(9)
end
function MyItem:setStackCount(val)
    return self:set(9, val)
end

--%道具_最大堆叠数%	10
function MyItem:getMaxStackCount()
    return self:get(10)
end
function MyItem:setMaxStackCount(val)
    return self:set(10, val)
end

--%道具_等级%	11
function MyItem:getLevel()
    return self:get(11)
end
function MyItem:setLevel(val)
    return self:set(11, val)
end

--%道具_最大耐久%	13
function MyItem:getMaxDurability()
    return self:get(13)
end
function MyItem:setMaxDurability(val)
    return self:set(13, val)
end

--%道具_最小攻击数量%	14
function MyItem:getMinAttackCount()
    return self:get(14)
end
function MyItem:setMinAttackCount(val)
    return self:set(14, val)
end

--%道具_最大攻击数量%	15
function MyItem:getMaxAttackCount()
    return self:get(15)
end
function MyItem:setMaxAttackCount(val)
    return self:set(15, val)
end

--%道具_攻击%	18
function MyItem:getAttack()
    return self:get(18)
end
function MyItem:setAttack(val)
    return self:set(18, val)
end

--%道具_防御%	19
function MyItem:getDefense()
    return self:get(19)
end
function MyItem:setDefense(val)
    return self:set(19, val)
end

--%道具_敏捷%	20
function MyItem:getAgility()
    return self:get(20)
end
function MyItem:setAgility(val)
    return self:set(20, val)
end

--%道具_精神%	21
function MyItem:getSpirit()
    return self:get(21)
end
function MyItem:setSpirit(val)
    return self:set(21, val)
end

--%道具_回复%	22
function MyItem:getRecovery()
    return self:get(22)
end
function MyItem:setRecovery(val)
    return self:set(22, val)
end

--%道具_必杀%	23
function MyItem:getCritical()
    return self:get(23)
end
function MyItem:setCritical(val)
    return self:set(23, val)
end

--%道具_反击%	24
function MyItem:getCounter()
    return self:get(24)
end
function MyItem:setCounter(val)
    return self:set(24, val)
end

--%道具_命中%	25
function MyItem:getHit()
    return self:get(25)
end
function MyItem:setHit(val)
    return self:set(25, val)
end

--%道具_闪躲%	26
function MyItem:getDodge()
    return self:get(26)
end
function MyItem:setDodge(val)
    return self:set(26, val)
end

--%道具_HP%	27
function MyItem:getHP()
    return self:get(27)
end
function MyItem:setHP(val)
    return self:set(27, val)
end

--%道具_MP%	28
function MyItem:getMP()
    return self:get(28)
end
function MyItem:setMP(val)
    return self:set(28, val)
end

--%道具_生命%	27
function MyItem:getLife()
    return self:get(27)
end
function MyItem:setLife(val)
    return self:set(27, val)
end

--%道具_魔力%	28
function MyItem:getMana()
    return self:get(28)
end
function MyItem:setMana(val)
    return self:set(28, val)
end

--%道具_幸运%	29
function MyItem:getLuck()
    return self:get(29)
end
function MyItem:setLuck(val)
    return self:set(29, val)
end

--%道具_魅力%	31
function MyItem:getCharisma()
    return self:get(31)
end
function MyItem:setCharisma(val)
    return self:set(31, val)
end

--%道具_属性一%	32
function MyItem:getAttribute1()
    return self:get(32)
end
function MyItem:setAttribute1(val)
    return self:set(32, val)
end

--%道具_属性二%	33
function MyItem:getAttribute2()
    return self:get(33)
end
function MyItem:setAttribute2(val)
    return self:set(33, val)
end

--%道具_属性一值%	34
function MyItem:getAttribute1Value()
    return self:get(34)
end
function MyItem:setAttribute1Value(val)
    return self:set(34, val)
end

--%道具_属性二值%	35
function MyItem:getAttribute2Value()
    return self:get(35)
end
function MyItem:setAttribute2Value(val)
    return self:set(35, val)
end

--%道具_耐力%	36
function MyItem:getEndurance()
    return self:get(36)
end
function MyItem:setEndurance(val)
    return self:set(36, val)
end

--%道具_灵巧%	37
function MyItem:getDexterity()
    return self:get(37)
end
function MyItem:setDexterity(val)
    return self:set(37, val)
end

--%道具_智力%	38
function MyItem:getIntelligence()
    return self:get(38)
end
function MyItem:setIntelligence(val)
    return self:set(38, val)
end

--%道具_毒抗%	39
function MyItem:getPoisonResistance()
    return self:get(39)
end
function MyItem:setPoisonResistance(val)
    return self:set(39, val)
end

--%道具_睡抗%	40
function MyItem:getSleepResistance()
    return self:get(40)
end
function MyItem:setSleepResistance(val)
    return self:set(40, val)
end

--%道具_石抗%	41
function MyItem:getStoneResistance()
    return self:get(41)
end
function MyItem:setStoneResistance(val)
    return self:set(41, val)
end

--%道具_醉抗%	42
function MyItem:getDrunkResistance()
    return self:get(42)
end
function MyItem:setDrunkResistance(val)
    return self:set(42, val)
end

--%道具_乱抗%	43
function MyItem:getConfusionResistance()
    return self:get(43)
end
function MyItem:setConfusionResistance(val)
    return self:set(43, val)
end

--%道具_忘抗% 44
function MyItem:getForgetResistance()
    return self:get(44)
end
function MyItem:setForgetResistance(val)
    return self:set(44, val)
end

--%道具_特殊类型% 45
function MyItem:getSpecialType()
    return self:get(45)
end
function MyItem:setSpecialType(val)
    return self:set(45, val)
end

--%道具_子参一% 46
function MyItem:getSubParamOne()
    return self:get(46)
end
function MyItem:setSubParamOne(val)
    return self:set(46, val)
end

--%道具_子参二% 47
function MyItem:getSubParamTwo()
    return self:get(47)
end
function MyItem:setSubParamTwo(val)
    return self:set(47, val)
end

--%道具_宝石武% 48
function MyItem:getGemAttack()
    return self:get(48)
end
function MyItem:setGemAttack(val)
    return self:set(48, val)
end

--%道具_宝石防% 49
function MyItem:getGemDefense()
    return self:get(49)
end
function MyItem:setGemDefense(val)
    return self:set(49, val)
end

--%道具_登出消失% 52
function MyItem:getDisappearOnLogout()
    return self:get(52)
end
function MyItem:setDisappearOnLogout(val)
    return self:set(52, val)
end

--%道具_丢地消失% 53
function MyItem:getDisappearOnDrop()
    return self:get(53)
end
function MyItem:setDisappearOnDrop(val)
    return self:set(53, val)
end

--%道具_宠邮% 54
function MyItem:getPetMail()
    return self:get(54)
end
function MyItem:setPetMail(val)
    return self:set(54, val)
end

--%道具_魔抗% 55
function MyItem:getMagicResistance()
    return self:get(55)
end
function MyItem:setMagicResistance(val)
    return self:set(55, val)
end

--%道具_可出售% 56
function MyItem:getSellable()
    return self:get(56)
end
function MyItem:setSellable(val)
    return self:set(56, val)
end

--%道具_已鉴定% 63
function MyItem:getIdentified()
    return self:get(63)
end
function MyItem:setIdentified(val)
    return self:set(63, val)
end

--%道具_耐久% 65
function MyItem:getDurability()
    return self:get(65)
end
function MyItem:setDurability(val)
    return self:set(65, val)
end

--%道具_Obj索引% 4000
function MyItem:getObjectIndex()
    return self:get(4000)
end
function MyItem:setObjectIndex(val)
    return self:set(4000, val)
end

--%道具_已装备% 4002
function MyItem:getEquipped()
    return self:get(4002)
end
function MyItem:setEquipped(val)
    return self:set(4002, val)
end