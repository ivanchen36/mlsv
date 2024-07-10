local gift = nil
local giftMapId = 1
local giftSwitch = false
local giftEndTime = 0
local rate = 2000
local gitRate = {}
local nextRate = 0

function getGiftDes()
    local str = ""
    for i = 1, #gift do
        local info = gift[i]
        str = str .. info["name"] .. "-" .. info["count"] .. "个 "
    end
    return str
end

function startGift(itemInfo)
    gift = itemInfo
    gitRate = getGiftRate(gift)
    giftSwitch = true
    giftEndTime = os.time() + 7200
    NLG.SystemMessage(-1, "[天降活动] 天降活动盛宴开启，大家踊跃参加，抢夺天降礼包，本次礼包共有" .. getGiftDes() .. ", 惊喜无数，不容错过！")
end

function getGiftRate(itemInfo)
    local rate = {}
    local sum = 0
    for i = 1, #itemInfo do
        sum = itemInfo[i]["count"]
    end
    if sum <= 0 then
        giftSwitch = false
        return rate
    end

    for i = 1, #itemInfo do
        local info = itemInfo[i]
        if info["count"] <= 0 then
            rate[i] = math.floor(info["count"] * 10000 /sum)
        end
    end
    nextRate = math.floor(0.1 * sum)
    if sum <= 100  then
        nextRate = 11
    end
    return rate
end

function getGift()
    local giftIndex = getRandObj(gitRate)
    local info = gift[giftIndex]

    if info["count"] <= 0 then
        gitRate = getGiftRate(gift)
        return nil
    end
    if not isOccur(rate) then
        return nil
    end

    info["count"] = info["count"] - 1
    nextRate = nextRate - 1
    if nextRate <= 0 or info["count"] <= 0 then
        nextRate = 99
        gitRate = getGiftRate(gift)
    end
    return info
end

function distributeGiftByPlayer(player)
    if not player:isValid() or not player:isPerson() then
        return
    end

    local item = getGift()
    if nil == item then
        return
    end

    player:getItem(item["id"])
    NLG.SystemMessage(player,"[天降活动] 恭喜" .. player:getName()  .. "获得" .. item["name"] .. ",剩余" .. item["count"] .. "个");
    if not giftSwitch then
        NLG.SystemMessage(-1, "[天降活动] 物品发放完毕，天降活动结束，祝大家游戏开心!")
    end
end

function distributeGift(battle)
    if not giftSwitch then
        return 1
    end

    if giftEndTime < os.time() then
        giftSwitch = false
        return 1
    end

    logPrint("distributeGift")
    for i=0,9 do
        local player = MyPlayer:new(Battle.GetPlayer(battle,i))
        if player:isPerson() and player:getMapId() ~= giftMapId then
            return 1
        end
        distributeGiftByPlayer(player)
    end

    return 1;
end

function startDistributeGift(regNum, info)
    local arr = strSplit(info, "|")
    local itemInfos = {}

    if math.fmod(#arr, 3) ~= 0 then
        return 1
    end

    for i=1, #arr / 3 do
        itemInfos[i] = {
            ["id"] = tonumber(arr[i * 3 - 2]),
            ["name"] = arr[i * 3 - 1],
            ["count"] = tonumber(arr[i * 3])
        }
    end

    NLG.SystemMessage(-1 , "感谢玩家支持，即将天降礼包，回馈你我，共享喜悦，天降礼包因你们的热情而更加璀璨！")
    startGift(itemInfos)
end

DeinitEvent["battle"] = distributeGift
TaskHandler[6] = startDistributeGift
