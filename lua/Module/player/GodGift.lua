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
        str = str .. info["name"] .. "-" .. info["count"] .. "�� "
    end
    return str
end

function startGift(itemInfo)
    gift = itemInfo
    gitRate = getGiftRate(gift)
    giftSwitch = true
    giftEndTime = os.time() + 7200
    NLG.SystemMessage(-1, "[�콵�] �콵�ʢ�翪�������ӻԾ�μӣ������콵����������������" .. getGiftDes() .. ", ��ϲ���������ݴ����")
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
    NLG.SystemMessage(player,"[�콵�] ��ϲ" .. player:getName()  .. "���" .. item["name"] .. ",ʣ��" .. item["count"] .. "��");
    if not giftSwitch then
        NLG.SystemMessage(-1, "[�콵�] ��Ʒ������ϣ��콵�������ף�����Ϸ����!")
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

    NLG.SystemMessage(-1 , "��л���֧�֣������콵������������ң�����ϲ�ã��콵��������ǵ�����������貣�")
    startGift(itemInfos)
end

DeinitEvent["battle"] = distributeGift
TaskHandler[6] = startDistributeGift
