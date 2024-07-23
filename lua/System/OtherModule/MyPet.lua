randFy = 10;		--�������/����

-- ����һ����Ϊ MyPet �ı�
MyPet = {}
extendClass(MyPet, MyChar)

-- ���幹�캯�� new
function MyPet:new(player, pet)
    local newObj = MyChar:new(pet)
    newObj._owner = player
    setmetatable(newObj, self)       -- �����¶����Ԫ��Ϊ MyPet
    return newObj
end

function MyPet:new1(pet)
    return MyPet:new(Pet.GetOwner(pet), pet)
end

function MyPet:getOwner()
    return self._owner
end

function MyPet:changeRemote()
    if self:getId() > Const.RemoteId then
        return 0
    end

    self:setId(self:getId() + Const.RemoteId)
    local slots = self:getSkillSlots() - 2
    for i = 0, slots do
        local techId = self:getSkill(i)
        if techId >= Const.RemoteId then
            techId = techId - Const.RemoteId
        end
        local skillId = math.floor(techId / 100)
        if rawget(Const.remoteForbiddenSkill, skillId) ~= nil then
            techId = techId + Const.RemoteId
        end
        if techId ~= self:getSkill(i) then
            self:setSkill(i, techId)
        end
    end
    return 1
end

function MyPet:changeMelee()
    if self:getId() < Const.RemoteId then
        return 0
    end

    self:setId(self:getId() - Const.RemoteId)
    local slots = self:getSkillSlots() - 2
    for i = 0, slots do
        local techId = self:getSkill(i)
        if techId >= Const.RemoteId then
            techId = techId - Const.RemoteId
        end
        local skillId = math.floor(techId / 100)
        if rawget(Const.meleeForbiddenSkill, skillId) ~= nil then
            techId = techId + Const.RemoteId
        end
        if techId ~= self:getSkill(i) then
            self:setSkill(i, techId)
        end
    end
    return 1
end

function MyPet:flushAtkModeAndSkill()
    for i = 0, 4 do
        local item = MyItem:new(Char.GetItemIndex(self._player, i))
        if item:isValid() then
            if (rawget(Const.RemotePetEquip, item:ggetId())) ~= nil then
                return self:changeRemote()
            end
        end
    end
    return self:changeMelee()
end

function MyPet:getId()
    return self:get(68)
end

function MyPet:setId(id)
    return self:set(68, id)
end

function MyPet:getUuid()
    return Pet.GetUUID(self._player)
end

function MyPet:getSkill(slot)
    return Pet.GetSkill(self._player, slot)
end

function MyPet:delSkill(slot)
    return Pet.DelSkill(self._player, slot)
end

function MyPet:addSkill(skillId)
    return Pet.AddSkill(self._player, skillId)
end

function MyPet:setSkill(slot, skillId)
    local neeDelSlot = {}
    local slots = self:getSkillSlots() - 1
    for i = 0, slots do
        if i == slot then
            if self:getSkill(i) > 0 then
                self:delSkill(i)
            end
            self:addSkill(skillId)
            for _, index in ipairs(neeDelSlot) do
                self:delSkill(index)
            end
            return
        else
            if self:getSkill(i) <= 0 then
                self:addSkill(skillId)
                table.insert(neeDelSlot, i)
            end
        end
    end
end

function MyPet:delete()
    local uuid = self:getUuid()
    for i = 0, 4 do
        local pet = MyPet:new(self._owner, Char.GetPet(self._owner, i))
        if pet:isValid() then
            if uuid == pet:getUuid() then
                return Char.DelSlotPet(self._owner, i)
            end
        end
    end

    return 0
end

--%����_����%	22
--%����_��˯%	23
--%����_��ʯ%	24
--%����_����%	25
--%����_����%	26
--%����_����%	27
--%����_��ɱ%	28
--%����_����%	29
--%����_����%	30
--%����_����%	31
function MyPet:initXz()
    local xz =	self:get(28) + self:get(29) + self:get(30) + self:get(31);

    if(xz > 0) then
        return
    end

    self:set(22,NLG.Rand(0, randFy))
    self:set(23,NLG.Rand(0, randFy))
    self:set(24,NLG.Rand(0, randFy))
    self:set(25,NLG.Rand(0, randFy))
    self:set(26,NLG.Rand(0, randFy))
    self:set(27,NLG.Rand(0, randFy))
    self:set(28,NLG.Rand(0, randFy))
    self:set(29,NLG.Rand(0, randFy))
    self:set(30,NLG.Rand(0, randFy))
    self:set(31,NLG.Rand(0, randFy))
end

--%����_������% 51
function MyPet:getSkillSlots()
    return self:get(51)
end
function MyPet:setSkillSlots(val)
    return self:set(51, val)
end

function MyPet:getVital()
    return Pet.GetArtRank(self._player, 1)
end

function MyPet:getStr()
    return Pet.GetArtRank(self._player, 2)
end

function MyPet:getTough()
    return Pet.GetArtRank(self._player, 3)
end

function MyPet:getQuick()
    return Pet.GetArtRank(self._player, 4)
end

function MyPet:getMagic()
    return Pet.GetArtRank(self._player, 5)
end

function MyPet:setVital(val)
    return Pet.SetArtRank(self._player, 1, val)
end

function MyPet:setStr(val)
    return Pet.SetArtRank(self._player, 2, val)
end

function MyPet:setTough(val)
    return Pet.SetArtRank(self._player, 3, val)
end

function MyPet:setQuick(val)
    return Pet.SetArtRank(self._player, 4, val)
end

function MyPet:setMagic(val)
    return Pet.SetArtRank(self._player, 5, val)
end

function MyPet:getFullVital()
    return Pet.FullArtRank(self._player, 1)
end

function MyPet:getFullStr()
    return Pet.FullArtRank(self._player, 2)
end

function MyPet:getFullTough()
    return Pet.FullArtRank(self._player, 3)
end

function MyPet:getFullQuick()
    return Pet.FullArtRank(self._player, 4)
end

function MyPet:reBirth()
    return Pet.ReBirth(self._owner, self._player)
end

function MyPet:getFullMagic()
    return Pet.FullArtRank(self._player, 5)
end

--%�赵_���% 1
--%�赵_����% 2
--%�赵_ǿ��% 3
--%�赵_����% 4
--%�赵_ħ��% 5
function MyPet:initDang(art1, art2, art3, art4, art5)
    Pet.SetArtRank(self._player,1,Pet.FullArtRank(self._player,1) - art1);
    Pet.SetArtRank(self._player,2,Pet.FullArtRank(self._player,2) - art2);
    Pet.SetArtRank(self._player,3,Pet.FullArtRank(self._player,3) - art3);
    Pet.SetArtRank(self._player,4,Pet.FullArtRank(self._player,4) - art4);
    Pet.SetArtRank(self._player,5,Pet.FullArtRank(self._player,5) - art5);
    Pet.UpPet(self._owner,self._player);
    Pet.ReBirth(self._owner,self._player);
    NLG.SystemMessage(player,"[ϴ���ɹ�]����:"..art1..","..art2..","..art3..","..art4..","..art5
            ..",�ܼ�:-"..art1 + art2 + art3 + art4 + art5.."��");
end

function MyPet:reinitDang(art1, art2, art3, art4, art5)
    if not self:isValid() then
        NLG.SystemMessage(self._owner,"[����ϴ��]ϴ��ʧ�ܣ�������Ч");
        return 0
    end

    if self:getLevel() > 1 then
        NLG.SystemMessage(self._owner,"[����ϴ��]���ﲢ��һ�����޷�ϴ��");
        return 0
    end

    self:initDang(art1, art2, art3, art4, art5)
    return 1
end

function MyPet:changeIamge(image)
    if not self:isValid() then
        return 0
    end
    self:setImage(image)
    self:setOriginalForm(image)
    self:setOriginalImage(image)
    Pet.UpPet(self._owner, self._player);
    NLG.UpChar(self._owner);
    NLG.SystemMessage(self._owner,"[����ϵͳ]����������ĳɹ�");
    return 1
end

function MyPet:flush()
    Pet.UpPet(self._owner, self._player)
    NLG.UpChar(self._player)
end
