local homeBaseMapId = 1
local homeMap = {}
--NLG.SetObj(MapID, FloorID, X, Y, Obj)
--NLG.GetFloorPets(MapId, FloorId)

local function createClanMap(player)
    local newFloorID = Map.MakeCopyMap(0, homeBaseMapId);
    if newFloorID == -1 then
        logPrint("createClanMap failed,", player:getRegistNumber());
        return 0
    end

    homeMap[player:getRegistNumber()] = newFloorID
    NLG.SetMapName(0, newFloorID, player:getName() .. "�ļ�")
    return 1
end

local function initClanMap(player)
    createClanMap(player)
end

local function goHome(player, arg)
    local registNumber = player:getRegistNumber()
    local vip = vipInfo[registNumber]
    if vip["home"] ~= 1 then
        player:sysMsg("�㻹û�п�ͨ��԰ϵͳ")
        return
    end

    local homeMapId = homeMap[registNumber]
    if nil == homeMapId and createClanMap(player) > 0 then
        homeMapId = homeMap[registNumber]
        player:warp(0, clanMap[clanId], 10, 10)
    end

end
