
function addPersonDamage(player, rate)
    local info = vipInfo[player:getRegistNumber()]
    return rate + info["level"]
end

function addPetDamage(player, rate)
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
    return rate
end

DamageEvent[1] = addPersonDamage
DamageEvent[3] = addPetDamage
DamageEvent[11] = subPersonDamage
DamageEvent[13] = subPetDamage
DamageEvent[21] = subPersonDefDamage
DamageEvent[23] = subPetDefDamage