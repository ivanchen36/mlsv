admMap = {}

local function calAdm(player)
    local adm = 0;
    for i = 0, 7 do
        local item = MyItem:getItem(player:getObj(), i);
        if item:isValid() then
            local tmp = item:getAdm()
            if tmp > 0 then
                adm = adm + tmp
            end
        end
    end
    return adm;
end

function loadAdm(player)
    admMap[player:getObj()] = calAdm(player)
end

function unloadAdm(player)
    admMap[player:getObj()] = nil
end

function equipmentChange(fd, head, packet)
    logPrint("equipmentChange OnRecv ", head, packet)
    local myPlayer = MyPlayer:new(Protocol.GetCharByFd(fd))
    equipmentChangeHandle[myPlayer:getObj()] = os.time() + 2
    return 0
end

function handleEquipmentChange()
    local now = os.time()
    local deleteList = {}
    for index, exeTime in pairs(equipmentChangeHandle) do
        if exeTime <= now then
            local player = MyPlayer:new(index)
            loadAdm(player)
            for i = 0, 4 do
                local pet = player:getPet(i)
                if pet:isValid() then
                    if pet:flushAtkModeAndSkill() > 0 then
                        pet:flush()
                    end
                end
            end
            table.insert(deleteList, index)
        end
    end

    for _, index in ipairs(deleteList) do
        equipmentChangeHandle[index] = nil
    end
end

function detachPetEquip(index, item)
    local pet = MyPet:new(index)
    pet:changeMelee()
    pet:flush()
    return 0
end

Protocol.OnRecv(nil, "equipmentChange", 8);
Protocol.OnRecv(nil, "equipmentChange", 14);
InitEvent["char"] = loadAdm
DeinitEvent["char"] = unloadAdm
addTimerTask(handleEquipmentChange)
NL.RegItemString(nil, "detachPetEquip", "LUA_detPetEquip")