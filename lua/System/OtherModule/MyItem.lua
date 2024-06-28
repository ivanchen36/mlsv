-- ����һ����Ϊ MyItem �ı�
MyItem = {}
MyItem.__index = MyItem

-- ���幹�캯�� new
function MyItem:new(itemIndex)
    local newObj = { _item = itemIndex}  -- ����һ���µĶ��󣬰���һ����Ϊ data ���ֶΣ���ֵΪ pet
    setmetatable(newObj, self)       -- �����¶����Ԫ��Ϊ MyItem
    return newObj
end

function MyItem:create(itemID)
    return MyItem:new(Data.ItemsetGetIndex(itemID))
end

function MyItem:getObj()
    return self._item
end

function MyItem:get(key)
    return Item.GetData(self._item, key)  -- ʹ�� Char.GetData ������ȡ�������
end

-- ���� set ���������������������
function MyItem:set(key, val)
    Item.SetData(self._item, key, val)  -- ʹ�� Char.SetData ���������������
end

--%����_��ǰ��%	2000
function MyItem:getUnidentifiedName()
    return self:get(2000)
end
function MyItem:setUnidentifiedName(val)
    return self:set(2000, val)
end

--%����_����%	2001
function MyItem:getName()
    return self:get(2001)
end
function MyItem:setName(val)
    return self:set(2001, val)
end

--%����_��ӡ%	2002
function MyItem:getEngraving()
    return self:get(2002)
end
function MyItem:setEngraving(val)
    return self:set(2002, val)
end

--%����_���ò���%	2003
function MyItem:getSelfUseParam()
    return self:get(2003)
end
function MyItem:setSelfUseParam(val)
    return self:set(2003, val)
end

--%����_��ӡ���%	2004
function MyItem:getEngraverPlayer()
    return self:get(2004)
end
function MyItem:setEngraverPlayer(val)
    return self:set(2004, val)
end

--%����_��%	0
function MyItem:getOrder()
    return self:get(0)
end
function MyItem:setOrder(val)
    return self:set(0, val)
end

--%����_ID%	0
function MyItem:getID()
    return self:get(0)
end
function MyItem:setID(val)
    return self:set(0, val)
end

--%����_ͼ%	1
function MyItem:getImage()
    return self:get(1)
end
function MyItem:setImage(val)
    return self:set(1, val)
end

--%����_�۸�%	2
function MyItem:getPrice()
    return self:get(2)
end
function MyItem:setPrice(val)
    return self:set(2, val)
end

--%����_����%	3
function MyItem:getType()
    return self:get(3)
end
function MyItem:setType(val)
    return self:set(3, val)
end

--%����_˫��%	5
function MyItem:isTwoHanded()
    return self:get(5) == 1
end
function MyItem:setTwoHanded(val)
    return self:set(5, val and 1 or 0)
end

--%����_˫��%	6
function MyItem:isDoubleClick()
    return self:get(6) == 1
end
function MyItem:setDoubleClick(val)
    return self:set(6, val and 1 or 0)
end

--%����_��˫��%	6
function MyItem:isDoubleClickable()
    return self:get(6) == 1
end
function MyItem:setDoubleClickable(val)
    return self:set(6, val and 1 or 0)
end

--%����_ս������%	7
function MyItem:isBattleUsable()
    return self:get(7) == 1
end
function MyItem:setBattleUsable(val)
    return self:set(7, val and 1 or 0)
end

--%����_�ѵ���%	9
function MyItem:getStackCount()
    return self:get(9)
end
function MyItem:setStackCount(val)
    return self:set(9, val)
end

--%����_���ѵ���%	10
function MyItem:getMaxStackCount()
    return self:get(10)
end
function MyItem:setMaxStackCount(val)
    return self:set(10, val)
end

--%����_�ȼ�%	11
function MyItem:getLevel()
    return self:get(11)
end
function MyItem:setLevel(val)
    return self:set(11, val)
end

--%����_����;�%	13
function MyItem:getMaxDurability()
    return self:get(13)
end
function MyItem:setMaxDurability(val)
    return self:set(13, val)
end

--%����_��С��������%	14
function MyItem:getMinAttackCount()
    return self:get(14)
end
function MyItem:setMinAttackCount(val)
    return self:set(14, val)
end

--%����_��󹥻�����%	15
function MyItem:getMaxAttackCount()
    return self:get(15)
end
function MyItem:setMaxAttackCount(val)
    return self:set(15, val)
end

--%����_����%	18
function MyItem:getAttack()
    return self:get(18)
end
function MyItem:setAttack(val)
    return self:set(18, val)
end

--%����_����%	19
function MyItem:getDefense()
    return self:get(19)
end
function MyItem:setDefense(val)
    return self:set(19, val)
end

--%����_����%	20
function MyItem:getAgility()
    return self:get(20)
end
function MyItem:setAgility(val)
    return self:set(20, val)
end

--%����_����%	21
function MyItem:getSpirit()
    return self:get(21)
end
function MyItem:setSpirit(val)
    return self:set(21, val)
end

--%����_�ظ�%	22
function MyItem:getRecovery()
    return self:get(22)
end
function MyItem:setRecovery(val)
    return self:set(22, val)
end

--%����_��ɱ%	23
function MyItem:getCritical()
    return self:get(23)
end
function MyItem:setCritical(val)
    return self:set(23, val)
end

--%����_����%	24
function MyItem:getCounter()
    return self:get(24)
end
function MyItem:setCounter(val)
    return self:set(24, val)
end

--%����_����%	25
function MyItem:getHit()
    return self:get(25)
end
function MyItem:setHit(val)
    return self:set(25, val)
end

--%����_����%	26
function MyItem:getDodge()
    return self:get(26)
end
function MyItem:setDodge(val)
    return self:set(26, val)
end

--%����_HP%	27
function MyItem:getHP()
    return self:get(27)
end
function MyItem:setHP(val)
    return self:set(27, val)
end

--%����_MP%	28
function MyItem:getMP()
    return self:get(28)
end
function MyItem:setMP(val)
    return self:set(28, val)
end

--%����_����%	27
function MyItem:getLife()
    return self:get(27)
end
function MyItem:setLife(val)
    return self:set(27, val)
end

--%����_ħ��%	28
function MyItem:getMana()
    return self:get(28)
end
function MyItem:setMana(val)
    return self:set(28, val)
end

--%����_����%	29
function MyItem:getLuck()
    return self:get(29)
end
function MyItem:setLuck(val)
    return self:set(29, val)
end

--%����_����%	31
function MyItem:getCharisma()
    return self:get(31)
end
function MyItem:setCharisma(val)
    return self:set(31, val)
end

--%����_����һ%	32
function MyItem:getAttribute1()
    return self:get(32)
end
function MyItem:setAttribute1(val)
    return self:set(32, val)
end

--%����_���Զ�%	33
function MyItem:getAttribute2()
    return self:get(33)
end
function MyItem:setAttribute2(val)
    return self:set(33, val)
end

--%����_����һֵ%	34
function MyItem:getAttribute1Value()
    return self:get(34)
end
function MyItem:setAttribute1Value(val)
    return self:set(34, val)
end

--%����_���Զ�ֵ%	35
function MyItem:getAttribute2Value()
    return self:get(35)
end
function MyItem:setAttribute2Value(val)
    return self:set(35, val)
end

--%����_����%	36
function MyItem:getEndurance()
    return self:get(36)
end
function MyItem:setEndurance(val)
    return self:set(36, val)
end

--%����_����%	37
function MyItem:getDexterity()
    return self:get(37)
end
function MyItem:setDexterity(val)
    return self:set(37, val)
end

--%����_����%	38
function MyItem:getIntelligence()
    return self:get(38)
end
function MyItem:setIntelligence(val)
    return self:set(38, val)
end

--%����_����%	39
function MyItem:getPoisonResistance()
    return self:get(39)
end
function MyItem:setPoisonResistance(val)
    return self:set(39, val)
end

--%����_˯��%	40
function MyItem:getSleepResistance()
    return self:get(40)
end
function MyItem:setSleepResistance(val)
    return self:set(40, val)
end

--%����_ʯ��%	41
function MyItem:getStoneResistance()
    return self:get(41)
end
function MyItem:setStoneResistance(val)
    return self:set(41, val)
end

--%����_��%	42
function MyItem:getDrunkResistance()
    return self:get(42)
end
function MyItem:setDrunkResistance(val)
    return self:set(42, val)
end

--%����_�ҿ�%	43
function MyItem:getConfusionResistance()
    return self:get(43)
end
function MyItem:setConfusionResistance(val)
    return self:set(43, val)
end

--%����_����% 44
function MyItem:getForgetResistance()
    return self:get(44)
end
function MyItem:setForgetResistance(val)
    return self:set(44, val)
end

--%����_��������% 45
function MyItem:getSpecialType()
    return self:get(45)
end
function MyItem:setSpecialType(val)
    return self:set(45, val)
end

--%����_�Ӳ�һ% 46
function MyItem:getSubParamOne()
    return self:get(46)
end
function MyItem:setSubParamOne(val)
    return self:set(46, val)
end

--%����_�Ӳζ�% 47
function MyItem:getSubParamTwo()
    return self:get(47)
end
function MyItem:setSubParamTwo(val)
    return self:set(47, val)
end

--%����_��ʯ��% 48
function MyItem:getGemAttack()
    return self:get(48)
end
function MyItem:setGemAttack(val)
    return self:set(48, val)
end

--%����_��ʯ��% 49
function MyItem:getGemDefense()
    return self:get(49)
end
function MyItem:setGemDefense(val)
    return self:set(49, val)
end

--%����_�ǳ���ʧ% 52
function MyItem:getDisappearOnLogout()
    return self:get(52)
end
function MyItem:setDisappearOnLogout(val)
    return self:set(52, val)
end

--%����_������ʧ% 53
function MyItem:getDisappearOnDrop()
    return self:get(53)
end
function MyItem:setDisappearOnDrop(val)
    return self:set(53, val)
end

--%����_����% 54
function MyItem:getPetMail()
    return self:get(54)
end
function MyItem:setPetMail(val)
    return self:set(54, val)
end

--%����_ħ��% 55
function MyItem:getMagicResistance()
    return self:get(55)
end
function MyItem:setMagicResistance(val)
    return self:set(55, val)
end

--%����_�ɳ���% 56
function MyItem:getSellable()
    return self:get(56)
end
function MyItem:setSellable(val)
    return self:set(56, val)
end

--%����_�Ѽ���% 63
function MyItem:getIdentified()
    return self:get(63)
end
function MyItem:setIdentified(val)
    return self:set(63, val)
end

--%����_�;�% 65
function MyItem:getDurability()
    return self:get(65)
end
function MyItem:setDurability(val)
    return self:set(65, val)
end

--%����_Obj����% 4000
function MyItem:getObjectIndex()
    return self:get(4000)
end
function MyItem:setObjectIndex(val)
    return self:set(4000, val)
end

--%����_��װ��% 4002
function MyItem:getEquipped()
    return self:get(4002)
end
function MyItem:setEquipped(val)
    return self:set(4002, val)
end