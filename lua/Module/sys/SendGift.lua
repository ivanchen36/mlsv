
function sendItem(regNum, info)
    local registNumber = player:getRegistNumber()
    local vip = vipInfo[registNumber]
    if vip ~= nil then
        logPrint(registNumber .. "²»ÔÚÏß")
        return
    end
    local arr = strSplit(info, "|")
    local player = MyPlayer:new(vipInfo[regNum]["index"])
    player:addItem(tonumber(info), 1)
    Protocol.PowerSend(player:getObj(),"SHOW_AWAKENING", getAwakeningInfo(player))
end

TaskHandler[100] = sendItem