
-- 定义一个名为 MyPlayer 的表
MyPlayer = {}
extendClass(MyPlayer, MyChar)

-- 定义构造函数 new
function MyPlayer:new(player)
    local newObj = MyChar:new(player)  -- 创建一个新的对象，包含一个名为 data 的字段，其值为 player
    setmetatable(newObj, self)       -- 设置新对象的元表为 MyPlayer
    return newObj                    -- 返回新创建的对象
end

function MyPlayer:flush()
    NLG.UpChar(self._player)
end

function MyPlayer:isPerson()
    if (self:getType() == 1) then
        return true
    end

    return false
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

function MyPlayer:havePet(self, petId)
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
    Char.FeverStart(self._player)
    NLG.UpChar(self._player)
    self:sysMsg("恭喜您打卡成功。")
end

function MyPlayer:feverStop()
    Char.FeverStop(self._player)
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

function MyPlayer:recoverHurt()
    self:setHurtStatus(0)
    NLG.UpdateParty(player);
    self:flush()
    NLG.SendGraphEvent(player, 45, 0);
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
        self:sysMsg("扣除" .. amount .. "魔币。")

        return 1
    end

    self:sysMsg("魔币不足" .. amount .. "，扣除失败。")
    return 0
end

function MyPlayer:isLeader()
    return Char.GetPartyMember(self._player, 0) == self._player and self:getPartyNum() > 1
end

function MyPlayer:isGm()
    return self:getGm() == 1
end

function MyPlayer:warp(mapID, floorID, x, y)
    if self:getPartyNum() > 1 then
        if not self:isLeader() then
            self:sysMsg("不是队长，不能够传送")
            return
        end
    end

    Char.Warp(self._player, mapID, floorID, x, y)
end

--%对象_香步数% 8152
function MyPlayer:isYudi()
    return self:getIncenseStepCount() > 1
end

--%对象_香上限% 8151
function MyPlayer:startYudi()
    if self:getEnemyAvoidSwitch() == 1 then
        self:stopAvoid()
    end
    self:setIncenseUpperLimit( 999);
    self:setIncenseStepCount(999);

    self:sysMsg("步步遇敌已经开启！");
end

function MyPlayer:stopYudi()
    self:setIncenseUpperLimit(0);
    self:setIncenseStepCount(0);
    self:sysMsg("步步遇敌已经关闭！");
end

function MyPlayer:startAvoid()
    if self:isYudi() then
        self:stopYudi()
    end
    self:setEnemyAvoidSwitch(1)
    self:sysMsg("不遇敌已经开启")
end

function MyPlayer:stopAvoid()
    self:setEnemyAvoidSwitch(0)
    self:sysMsg("不遇敌已经关闭")
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
