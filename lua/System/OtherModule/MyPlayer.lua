
-- ����һ����Ϊ MyPlayer �ı�
MyPlayer = {}
extendClass(MyPlayer, MyChar)

-- ���幹�캯�� new
function MyPlayer:new(player)
    local newObj = MyChar:new(player)  -- ����һ���µĶ��󣬰���һ����Ϊ data ���ֶΣ���ֵΪ player
    setmetatable(newObj, self)       -- �����¶����Ԫ��Ϊ MyPlayer
    return newObj                    -- �����´����Ķ���
end

function MyPlayer:createNpc(image, x, y, mapId, direction, name)
    local myPlayer = MyPlayer:new(NL.CreateNpc(nil, "NPCInit"));
    myPlayer:setImage(image)
    myPlayer:setOriginalForm(image)
    myPlayer:setX(x)
    myPlayer:setY(y)
    myPlayer:setMapId(mapId)
    myPlayer:setDirection(direction)
    myPlayer:setName(name)
    return myPlayer
end

function MyPlayer:flush()
    NLG.UpChar(self._player)
end

function MyPlayer:addItemList(list)
    for key, val in pairs(list) do
        if key > 0 then
            Char.GiveItem(self._player, key, val)
        elseif key == 0 then
            if val > 0 then
                self:setGold( self:getGold() + val)
                self:sysMsg("���" .. val .. "ħ�ҡ�")
            end
        end
    end
    NLG.UpChar(self._player)
end

function MyPlayer:getPetStatus(slot)
    return Pet.GetStatus(self._player, slot)
end

function MyPlayer:getPet(slot)
    return MyPet:new(self._player, Char.GetPet(self._player, slot))
end

function MyPlayer:getBattlePet()
    return self:getPet(self:getBattlePetSlot())
end

function MyPlayer:getPetByUuid(uuid)
    for i = 0, 4 do
        local pet = self:getPet(i)
        if pet:isValid() then
            if uuid == pet:getUuid() then
                return pet
            end
        end
    end

    return MyPet:new(self._player, -1)
end

function MyPlayer:isPerson()
    if (self:getType() == 1) then
        return true
    end

    return false
end

function MyPlayer:freeBagNum()
    return 20 - Char.ItemSlot(self._player)
end

function MyPlayer:getIp()
    return NLG.GetIp(self._player)
end

function MyPlayer:getMac()
    return NLG.GetMAC(self._player)
end

function MyPlayer:getPartyNum()
    return Char.PartyNum(self._player)
end

function MyPlayer:getPartyMember(slot)
    return MyPlayer:new(Char.GetPartyMember(self._player, slot))
end

function MyPlayer:havePet(petId)
    return Char.HavePet(self._player, petId)
end

function MyPlayer:getItemNum(itemId)
    return Char.ItemNum(self._player, itemId)
end

function MyPlayer:addItem(itemId, num)
    return Char.GiveItem(self._player, itemId, num)
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
    self:sysMsg("����������ĳɹ�");
    return 1
end

function MyPlayer:sysMsg(str)
    NLG.SystemMessage(self._player, "[ϵͳ��ʾ]" .. str)
end

function MyPlayer:feverStart()
    Char.FeverStart(self._player)
    NLG.UpChar(self._player)
    self:sysMsg("��ϲ���򿨳ɹ���")
end

function MyPlayer:feverStop()
    Char.FeverStop(self._player)
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

function MyPlayer:recoverHurt()
    self:setHurtStatus(0)
    NLG.UpdateParty(player);
    self:flush()
    NLG.SendGraphEvent(player, 45, 0);
end

--%����_������% 33
function MyPlayer:getSkillSlots()
    return self:get(33)
end
function MyPlayer:setSkillSlots(val)
    return self:set(33, val)
end

--%����_ս��% 62
function MyPlayer:getBattlePetSlot()
    return self:get(62)
end
function MyPlayer:setBattlePetSlot(val)
    return self:set(62, val)
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
        self:sysMsg("�۳�" .. amount .. "ħ�ҡ�")

        return 1
    end

    self:sysMsg("ħ�Ҳ���" .. amount .. "���۳�ʧ�ܡ�")
    return 0
end

function MyPlayer:canWarp()
    return Char.GetPartyMember(self._player, 0) == self._player
end

function MyPlayer:isLeader()
    return Char.GetPartyMember(self._player, 0) == self._player and self:getPartyNum() > 1
end

function MyPlayer:isGm()
    return self:getGm() == 1
end

function MyPlayer:warp(mapID, floorID, x, y)
    if not self:canWarp() then
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
    if self:getEnemyAvoidSwitch() == 1 then
        self:stopAvoid()
    end
    self:setIncenseUpperLimit( 999);
    self:setIncenseStepCount(999);

    self:sysMsg("���������Ѿ�������");
end

function MyPlayer:stopYudi()
    self:setIncenseUpperLimit(0);
    self:setIncenseStepCount(0);
    self:sysMsg("���������Ѿ��رգ�");
end

function MyPlayer:startAvoid()
    if self:isYudi() then
        self:stopYudi()
    end
    self:setEnemyAvoidSwitch(1)
    self:sysMsg("�������Ѿ�����")
end

function MyPlayer:stopAvoid()
    self:setEnemyAvoidSwitch(0)
    self:sysMsg("�������Ѿ��ر�")
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
