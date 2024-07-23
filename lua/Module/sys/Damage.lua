local spiritList = {123,143,162,182,202,222,242,262,282,302}
local admList = {14,48,82,116,150,184,218,252,286,320}
local baseSpirit = spiritList[10] * 2
local baseAdm = admList[10] * 2

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
    logPrint("getDefTalent", player:getName())
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
    return rate
end

function subPersonDefDamage(player, rate)
    local info = vipInfo[player:getRegistNumber()]
    return rate - info["level"]
end

function subPetDefDamage(player, rate)
    rate = rate - getDefTalent(player)
    return rate
end

function magicAtkDamage(skillId, level, damage, atkIndex, defIndex)
    local atkPlayer = MyPlayer:new(atkIndex)
    local maxSpirit = spiritList[level]
    local spirit = atkPlayer:getMagicStrength()
    if spirit <= maxSpirit then
        return damage
    end

    local newDamage = damage + math.floor(damage * (spirit - maxSpirit) / baseSpirit)
    if atkPlayer:getType() == 3 then
        return newDamage
    end
    if rawget(admMap, atkIndex) == nil then
        return newDamage
    end

    local maxAdm = admList[level]
    return newDamage + math.floor(damage * (admMap[atkIndex] - maxAdm) / baseAdm)
end

function modifyMaxDamage()
    logPrint("modifyMaxDamage")
    for i = 19, 31 do
        SkillDamageEvent[i * 10] = magicAtkDamage
        SkillDamageEvent[i * 10 + 3] = magicAtkDamage
    end
end




DamageEvent[1] = addPersonDamage
DamageEvent[3] = addPetDamage
DamageEvent[11] = subPersonDamage
DamageEvent[13] = subPetDamage
DamageEvent[21] = subPersonDefDamage
DamageEvent[23] = subPetDefDamage
modifyMaxDamage()