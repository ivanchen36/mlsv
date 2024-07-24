admMap = {}
local function calAdm(player, addItem, replaceItems)
    local adm = 0;
    for i = 0, 7 do
        local item = player:getItem(i);
        if item:isValid() then
            if rawget(replaceItems, i) == nil then
                local tmp = item:getAdm()
                if tmp > 0 then
                    adm = adm + tmp
                end
            end
        end
    end
    if nil ~= addItem then
        local tmp = addItem:getAdm()
        if tmp > 0 then
            adm = adm + tmp
        end
    end
    return adm;
end

function loadAdm(player)
    admMap[player:getObj()] = calAdm(player, nil, {})
end

function unloadAdm(player)
    admMap[player:getObj()] = nil
end

local function getReplaceItem(player, item, attachPos)
    if 2 == attachPos then
        if item:isTwoHanded() then
            return {[attachPos] = 1, [attachPos + 1] = 1}
        end
        local item1 = player:getItem(attachPos)
        local item2 = player:getItem(attachPos + 1)
        if item1:isValid() then
            if math.floor(item:getType() / 7) == math.floor(item1:getType() / 7) then
                return {[attachPos] = 1}
            end

            return {[attachPos + 1] = 1}
        end
        if item2:isValid() then
            if math.floor(item:getType() / 7) == math.floor(item2:getType() / 7) then
                return {[attachPos + 1] = 1}
            end
        end
        return {}
    end
    if 5 == attachPos then
        local item1 = player:getItem(attachPos)
        local item2 = player:getItem(attachPos + 1)
        if item2:isValid() then
            if item2:getType() ~= item:getType() then
                return {[attachPos] = 1}
            end
            if not item1:isValid() then
                return nil
            end
            return {[attachPos + 1] = 1}
        end
        if item1:isValid() then
            if item1:getType() == item:getType() then
                return {[attachPos] = 1}
            end
            return {}
        end
        return {}
    end
    return {[attachPos] = 1}
end

local function personAttach(player, item, attachPos)
    local replaceItems = getReplaceItem(player, item, attachPos)
    if nil == replaceItems then
        return
    end
    admMap[player:getObj()] = calAdm(player, item, replaceItems)
end

local function petAttach(pet, item, attachPos)
    attachPos = attachPos - 10
    logPrint("petAttach ", item:getName(), attachPos, item:getType())
    if Const.PetWeapon == item:getType() then
        if (rawget(Const.RemotePetEquip, item:getId())) ~= nil then
            if pet:changeRemote() > 0 then
                pet:flush()
            end
        else
            if pet:changeMelee() > 0 then
                pet:flush()
            end
        end
    end
    if Const.PetJewelry == item:getType() then
        local item1 = pet:getItem(attachPos)
        local item2 = pet:getItem(attachPos + 1)
        if item1:isValid() then
            logPrint("replace item1: ", math.fmod(item1:getId(), 10), math.fmod(item:getId(), 10))
            if math.fmod(item1:getId(), 10) == math.fmod(item:getId(), 10) then
                return -1
            end
        end
        if item2:isValid() then
            logPrint("replace item2: ", math.fmod(item1:getId(), 10), math.fmod(item:getId(), 10))
            if math.fmod(item2:getId(), 10) == math.fmod(item:getId(), 10) then
                return -1
            end
        end
    end

    return 0
end

--8 3S:1n:9:0:: 第三格是装备的位置 第四个是使用的角色
function attachEquip(fd, head, packet)
    logPrint("attachEquip OnRecv ", head, packet)
    local player = MyPlayer:new(Protocol.GetCharByFd(fd))
    local arr = strSplit(packet, ":")
    local item = player:getItem(Const.dataBitMap[arr[3]])
    if not item:isValid() then
        return 0
    end

    local itemType  = item:getType()
    local attachPos = Const.EquipPosition[itemType]
    local useChar = tonumber(arr[4])
    logPrint("attachEquip ", item:getName(), attachPos, useChar)
    if useChar == 0 and attachPos >= 10 then
        return 0
    end
    if attachPos < 10 then
        useChar = 0
    end

    if useChar == 0 then
        personAttach(player, item, attachPos)
    else
        local pet = player:getPet(useChar - 1)
        if not pet:isValid() then
            return 0
        end
        if petAttach(pet, item, attachPos) < 0 then
            player:sysMsg("存在同类型装备，请先取下已装备的宠物装备。")
            return 1
        end
    end

    return 0
end

--8 14 1:d:-1:: 第1格是脱下装备的位置 第2格是放装备的位置
function detachEquip(fd, head, packet)
    logPrint("attachEquip OnRecv ", head, packet)
    local myPlayer = MyPlayer:new(Protocol.GetCharByFd(fd))
    equipmentChangeHandle[myPlayer:getObj()] = os.time() + 2
    return 0
end


Protocol.OnRecv(nil, "attachEquip", 8);
Protocol.OnRecv(nil, "detachEquip", 14);
InitEvent["char"] = loadAdm
DeinitEvent["char"] = unloadAdm
--NL.RegPetEquipCheckEvent(nil, "checkPetEquip")
