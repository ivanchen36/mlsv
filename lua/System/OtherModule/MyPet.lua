randFy = 15;		--最高修正/抗性

-- 定义一个名为 MyPet 的表
MyPet = {}
MyPet.__index = MyPet

-- 定义构造函数 new
function MyPet:new(player, slot)
    local newObj = { _player = player, _pet = Char.GetPet(player, slot) }  -- 创建一个新的对象，包含一个名为 data 的字段，其值为 pet
    setmetatable(newObj, self)       -- 设置新对象的元表为 MyPet
    return newObj
end

-- %宠物状态_战斗% 2
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

-- 定义 get 方法，用于获取玩家数据
function MyPet:get(key)
    return Char.GetData(self._pet, key)  -- 使用 Char.GetData 函数获取玩家数据
end

-- 定义 set 方法，用于设置玩家数据
function MyPet:set(key, val)
    Char.SetData(self._pet, key, val)  -- 使用 Char.SetData 函数设置玩家数据
end

--%对象_抗毒%	22
--%对象_抗睡%	23
--%对象_抗石%	24
--%对象_抗醉%	25
--%对象_抗乱%	26
--%对象_抗忘%	27
--%对象_必杀%	28
--%对象_反击%	29
--%对象_命中%	30
--%对象_闪躲%	31
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
    self:sysMsg("宠物属性修正初始化")
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

--%宠档_体成% 1
--%宠档_力成% 2
--%宠档_强成% 3
--%宠档_敏成% 4
--%宠档_魔成% 5
function MyPet:initDang(art1, art2, art3, art4, art5)
    Pet.SetArtRank(self._pet,1,Pet.FullArtRank(self._pet,1) - art1);
    Pet.SetArtRank(self._pet,2,Pet.FullArtRank(self._pet,2) - art2);
    Pet.SetArtRank(self._pet,3,Pet.FullArtRank(self._pet,3) - art3);
    Pet.SetArtRank(self._pet,4,Pet.FullArtRank(self._pet,4) - art4);
    Pet.SetArtRank(self._pet,5,Pet.FullArtRank(self._pet,5) - art5);
    Pet.UpPet(self._player,self._pet);
    Pet.ReBirth(self._player,self._pet);
    NLG.SystemMessage(player,"[洗档成功]掉档:"..art1..","..art2..","..art3..","..art4..","..art5
            ..",总计:-"..art1 + art2 + art3 + art4 + art5.."档");
end

function MyPet:reinitDang(art1, art2, art3, art4, art5)
    if not self:isValid() then
        NLG.SystemMessage(self._player,"[宠物洗档]洗档失败，宠物栏第一栏没有宠物");
        return 0
    end

    if self:getLevel() > 1 then
        NLG.SystemMessage(self._player,"[宠物洗档]宠物并非一级，无法洗档");
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
    NLG.SystemMessage(self._player,"[宠物系统]宠物形象更改成功");
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
    -- 可以在这里添加一些验证逻辑，比如确保等级不会低于0
    if val < 0 then
        return false, "等级不能低于0"
    end
    return self:set(8, val)
end

--%对象_形象% 1
function MyPet:getImage()
    return self:get(1)
end
function MyPet:setImage(val)
    return self:set(1, val)
end

--%对象_可视% 1
function MyPet:isVisible()
    return self:get(1)
end
function MyPet:setVisible(val)
    return self:set(1, val)
end

--%对象_原形% 2
function MyPet:getOriginalForm()
    return self:get(2)
end
function MyPet:setOriginalForm(val)
    return self:set(2, val)
end

--%对象_原始图档% 178
function MyPet:getOriginalImage()
    return self:get(178)
end
function MyPet:setOriginalImage(val)
    return self:set(178, val)
end

--%对象_种族% 17
function MyPet:getRace()
    return self:get(17)
end
function MyPet:setRace(val)
    return self:set(17, val)
end

--%对象_名字% 2000
function MyPet:getName()
    return self:get(2000)
end
function MyPet:setName(val)
    return self:set(2000, val)
end
--%对象_地属性% 18
function MyPet:getEarthAttribute()
    return self:get(18)
end
function MyPet:setEarthAttribute(val)
    return self:set(18, val)
end

--%对象_水属性% 19
function MyPet:getWaterAttribute()
    return self:get(19)
end
function MyPet:setWaterAttribute(val)
    return self:set(19, val)
end

--%对象_火属性% 20
function MyPet:getFireAttribute()
    return self:get(20)
end
function MyPet:setFireAttribute(val)
    return self:set(20, val)
end

--%对象_风属性% 21
function MyPet:getWindAttribute()
    return self:get(21)
end
function MyPet:setWindAttribute(val)
    return self:set(21, val)
end