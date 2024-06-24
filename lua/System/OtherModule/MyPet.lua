randFy = 15;		--�������/����

-- ����һ����Ϊ MyPet �ı�
MyPet = {}
MyPet.__index = MyPet

-- ���幹�캯�� new
function MyPet:new(player, slot)
    local newObj = { _player = player, _pet = Char.GetPet(player, slot) }  -- ����һ���µĶ��󣬰���һ����Ϊ data ���ֶΣ���ֵΪ pet
    setmetatable(newObj, self)       -- �����¶����Ԫ��Ϊ MyPet
    return newObj
end

-- %����״̬_ս��% 2
function MyPet:getBattlePet(player)
    return self:new(player,  Char.GetData(self.player, 62))
end

function MyPet:getByUuid(player, uuid)
    for i = 0, 4 do
        local pet = MyPet:new(player:getObj(), i)
        if pet:isValid() then
            if uuid == pet:getUuid() then
                return pet
            end
        end
    end
    return nil
end

function MyPet:isValid()
    return VaildChar(self._pet)
end

function MyPet:getOwner()
    return Pet.GetOwner(self._pet)
end

function MyPet:getId()
    return self:get(57)
end

function MyPet:getUuid()
    return Pet.GetUUID(self._pet)
end

function MyPet:getSkill(slot)
    return Pet.GetSkill(self._pet, slot)
end

function MyPet:delSkill(slot)
    return Pet.DelSkill(self._pet, slot)
end

function MyPet:addSkill(skillId)
    return Pet.AddSkill(self._pet, skillId)
end

function MyPet:delete()
    local uuid = self:getUuid()
    for i = 0, 4 do
        local pet = MyPet:new(self._player:getObj(), i)
        if pet:isValid() then
            if uuid == pet:getUuid() then
                return Char.DelSlotPet(self._player:getObj(), i)
            end
        end
    end

    return 0
end

-- ���� get ���������ڻ�ȡ�������
function MyPet:get(key)
    return Char.GetData(self._pet, key)  -- ʹ�� Char.GetData ������ȡ�������
end

-- ���� set ���������������������
function MyPet:set(key, val)
    Char.SetData(self._pet, key, val)  -- ʹ�� Char.SetData ���������������
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

    self:flush()
    self:sysMsg("��������������ʼ��")
end

function MyPet:getVital()
    return Pet.FullArtRank(self._pet, 1)
end

function MyPet:getStr()
    return Pet.FullArtRank(self._pet, 2)
end

function MyPet:getTough()
    return Pet.FullArtRank(self._pet, 3)
end

function MyPet:getQuick()
    return Pet.FullArtRank(self._pet, 4)
end

function MyPet:getMagic()
    return Pet.FullArtRank(self._pet, 5)
end

--%�赵_���% 1
--%�赵_����% 2
--%�赵_ǿ��% 3
--%�赵_����% 4
--%�赵_ħ��% 5
function MyPet:initDang(art1, art2, art3, art4, art5)
    Pet.SetArtRank(self._pet,1,Pet.FullArtRank(self._pet,1) - art1);
    Pet.SetArtRank(self._pet,2,Pet.FullArtRank(self._pet,2) - art2);
    Pet.SetArtRank(self._pet,3,Pet.FullArtRank(self._pet,3) - art3);
    Pet.SetArtRank(self._pet,4,Pet.FullArtRank(self._pet,4) - art4);
    Pet.SetArtRank(self._pet,5,Pet.FullArtRank(self._pet,5) - art5);
    Pet.UpPet(self._player,self._pet);
    Pet.ReBirth(self._player,self._pet);
    NLG.SystemMessage(player,"[ϴ���ɹ�]����:"..art1..","..art2..","..art3..","..art4..","..art5
            ..",�ܼ�:-"..art1 + art2 + art3 + art4 + art5.."��");
end

function MyPet:reinitDang(art1, art2, art3, art4, art5)
    if not self:isValid() then
        NLG.SystemMessage(self._player,"[����ϴ��]ϴ��ʧ�ܣ���������һ��û�г���");
        return 0
    end

    if self:getLevel() > 1 then
        NLG.SystemMessage(self._player,"[����ϴ��]���ﲢ��һ�����޷�ϴ��");
        return 0
    end

    initDang(self, art1, art2, art3, art4, art5)
    return 1
end

function MyPet:changeIamge(image)
    if not self:isValid() then
        return 0
    end
    self:setImage(image)
    self:setOriginalForm(image)
    self:setOriginalImage(image)
    Pet.UpPet(self._player, self._pet);
    NLG.UpChar(self._player);
    NLG.SystemMessage(self._player,"[����ϵͳ]����������ĳɹ�");
    return 1
end

function MyPet:isValid()
    return VaildChar(self._pet)
end

function MyPet:getObj()
    return self._pet
end

function MyPet:flush()
    Pet.UpPet(self._player, self._pet)
    NLG.UpChar(self._pet)
end

function MyPet:getLevel()
    return self:get(8)
end
function MyPet:setLevel(val)
    -- �������������һЩ��֤�߼�������ȷ���ȼ��������0
    if val < 0 then
        return false, "�ȼ����ܵ���0"
    end
    return self:set(8, val)
end

--%����_����% 1
function MyPet:getImage()
    return self:get(1)
end
function MyPet:setImage(val)
    return self:set(1, val)
end

--%����_����% 1
function MyPet:isVisible()
    return self:get(1)
end
function MyPet:setVisible(val)
    return self:set(1, val)
end

--%����_ԭ��% 2
function MyPet:getOriginalForm()
    return self:get(2)
end
function MyPet:setOriginalForm(val)
    return self:set(2, val)
end

--%����_ԭʼͼ��% 178
function MyPet:getOriginalImage()
    return self:get(178)
end
function MyPet:setOriginalImage(val)
    return self:set(178, val)
end

--%����_����% 17
function MyPet:getRace()
    return self:get(17)
end
function MyPet:setRace(val)
    return self:set(17, val)
end

--%����_����% 2000
function MyPet:getName()
    return self:get(2000)
end
function MyPet:setName(val)
    return self:set(2000, val)
end
--%����_������% 18
function MyPet:getEarthAttribute()
    return self:get(18)
end
function MyPet:setEarthAttribute(val)
    return self:set(18, val)
end

--%����_ˮ����% 19
function MyPet:getWaterAttribute()
    return self:get(19)
end
function MyPet:setWaterAttribute(val)
    return self:set(19, val)
end

--%����_������% 20
function MyPet:getFireAttribute()
    return self:get(20)
end
function MyPet:setFireAttribute(val)
    return self:set(20, val)
end

--%����_������% 21
function MyPet:getWindAttribute()
    return self:get(21)
end
function MyPet:setWindAttribute(val)
    return self:set(21, val)
end