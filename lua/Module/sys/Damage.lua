local spirit = {123,143,162,182,202,222,242,262,282,302}
local adm = {14,48,82,116,150,184,218,252,286,320}
local baseSpirit = spirit[10]
local baseAdm = adm[10]

function addPersonDamage(player, rate)
    local info = vipInfo[player:getRegistNumber()]
    return rate + info["level"]
end

local function getAtkTalent(player)
    local pet = MyPet:new1(player:getObj())
    if rawget(petTalentAtkMap, pet:getUuid()) then
        return petTalentAtkMap[pet:getUuid()]()
    end
    return 0
end

local function getDefTalent(player)
    local pet = MyPet:new1(player:getObj())
    if rawget(petTalentDefMap, pet:getUuid()) then
        return petTalentDefMap[pet:getUuid()]
    end
    return 0
end

function addPetDamage(player, rate)
    rate = rate + getAtkTalent(player)
    return rate
end

function subPersonDamage(player, rate)
    return rate
end

function subPetDamage(player, rate)
    return rate - getDefTalent(player)
end

function subPersonDefDamage(player, rate)
    local info = vipInfo[player:getRegistNumber()]
    return rate - info["level"]
end

function subPetDefDamage(player, rate)
    rate = rate - addPetDamage(player)
    return rate
end

DamageEvent[1] = addPersonDamage
DamageEvent[3] = addPetDamage
DamageEvent[11] = subPersonDamage
DamageEvent[13] = subPetDamage
DamageEvent[21] = subPersonDefDamage
DamageEvent[23] = subPetDefDamage

InitEvent["char"] = loadAdm
DeinitEvent["char"] = unloadAdm