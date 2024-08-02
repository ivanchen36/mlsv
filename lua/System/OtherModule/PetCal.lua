local function getGrowRate(artRank)
    local fiveTimes = math.floor(artRank / 5)

    return fiveTimes * 0.045 + (artRank - fiveTimes) * 0.04
end

local function calPetBp(artRank, birthBp, level, growRate)
    return artRank * birthBp / 100 + growRate * (level - 1)
end

function calEnemyAttr(level, birthBp, vital, str, tough, quick, magic)
    local growArr = {getGrowRate(vital), getGrowRate(str), getGrowRate(tough), getGrowRate(quick), getGrowRate(magic)}
    local bpArr = {calPetBp(vital, birthBp, level, growArr[1]),
                   calPetBp(str, birthBp, level, growArr[2]),
                   calPetBp(tough, birthBp, level, growArr[3]),
                   calPetBp(quick, birthBp, level, growArr[4]),
                   calPetBp(magic, birthBp, level, growArr[5])}

    return {
        ["hp"] = math.ceil(bpArr[1] * 8 + bpArr[2] * 2 + bpArr[3] * 3 + bpArr[4] * 3 + bpArr[5] * 1 + 20),
        ["atk"] = math.ceil(bpArr[1] * 0.1 + bpArr[2] * 2 + bpArr[3] * 0.2 + bpArr[4] * 0.2 + bpArr[5] * 0.1 + 20),
        ["def"] = math.ceil(bpArr[1] * 0.1 + bpArr[2] * 0.2 + bpArr[3] * 3 + bpArr[4] * 0.2 + bpArr[5] * 0.1 + 20),
        ["agi"] = math.ceil(bpArr[1] * 0.1 + bpArr[2] * 0.2 + bpArr[3] * 0.2 + bpArr[4] * 2 + bpArr[5] * 0.1 + 20),
        ["mp"] = math.ceil(bpArr[1] * 1 + bpArr[2] * 2 + bpArr[3] * 2 + bpArr[4] * 2 + bpArr[5] * 10 + 20),
        ["recover"] = math.ceil(bpArr[1] * 0.8 + bpArr[2] * -0.1 + bpArr[3] * -0.1 + bpArr[4] * 0.2 + bpArr[5] * -0.3 + 100),
        ["spirit"] = math.ceil(bpArr[1] * -0.3 + bpArr[2] * -0.1 + bpArr[3] * 0.2 + bpArr[4] * -0.1 + bpArr[5] * 0.8 + 100),
    }
end
