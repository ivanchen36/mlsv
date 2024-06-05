
function addPersonDamage(rate)
    return rate + 100
end

function addPetDamage(rate)
    return rate + 100
end

function subPersonDamage(rate)
    return rate - 50
end

function subPetDamage(rate)
    return rate - 50
end

DamageEvent[1] = addPersonDamage
DamageEvent[3] = addPetDamage
DamageEvent[11] = subPersonDamage
DamageEvent[13] = subPetDamage
DamageEvent[21] = subPersonDefDamage
DamageEvent[23] = subPetDefDamage