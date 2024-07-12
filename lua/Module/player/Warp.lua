local faWarp = {
    [1] = { 0, 1000, 240, 80, 40 },
}
local aiWarp = {}
local suWarp = {}
local levelWarp = {}
local warpList = { faWarp, aiWarp, suWarp, levelWarp }

function showWarp(npc, player, s)
    Protocol.PowerSend(player:getObj(), "SHOW_WARP", 0)
end

function warp(npc, player, s)
    local myPlayer = MyPlayer:new(player)
    myPlayer:warp(0,1000,240,80)
end

scriptEvent["show_warp"] = showWarp;