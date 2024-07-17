
function addPersonDamage(player, rate)
    local info = vipInfo[player:getRegistNumber()]
    return rate + info["level"]
end
local skillAtkDamage = {
    [30414] = function()
        return 5
    end,
    [30444] = function()
        return 10
    end,
    [30474] = function()
        return 15
    end,
    [30415] = function()
        return math.random(0, 10)
    end,
    [30445] = function()
        return math.random(0, 20)
    end,
    [30475] = function()
        return math.random(0, 30)
    end,
}

local skillDefDamage = {
    [30416] = 5,
    [30446] = 10,
    [30476] = 15,
}

local function getAtkTalent(player)
    local pet = MyPet:new1(player:getObj())
    for i = 1, 10 do
        local skillId = pet:getSkill(i)
        if rawget(skillAtkDamage, skillId) then
            return skillAtkDamage[skillId]()
        end
    end
    return 0
end

local function getDefTalent(player)
    local pet = MyPet:new1(player:getObj())
    for i = 1, 10 do
        local skillId = pet:getSkill(i)
        if rawget(skillDefDamage, skillId) then
            return skillDefDamage[skillId]
        end
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