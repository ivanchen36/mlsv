local clanBaseMapId = 1
local clanHome = {}
local clanMap = {}

local function createClanMap(clanId)
    local newFloorID = Map.MakeCopyMap(0, clanBaseMapId);
    if newFloorID == -1 then
        logPrint("createClanMap failed,", clanId);
        return
    end
    clanMap[clanId] = newFloorID
end

local function initClanMap()
    createClanMap(0)
end

local function goClan(player, arg)
    local clanId = 0
    local newFloorID = Map.MakeCopyMap(0, clanBaseMapId);
    if newFloorID == -1 then
        logPrint("createClanMap failed,", clanId);
        return
    end
    player:warp(0, clanMap[clanId], 19 + math.random(0, 15), 24 + math.random(0, 8))
end
