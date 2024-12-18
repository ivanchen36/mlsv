socket = require("socket")

function truncDay(t1)
    return math.floor((t1 + 28800) / 86400) * 86400 - 28800
end

function isToday(t1)
    local ts = os.time()
    if truncDay(t1) == truncDay(ts) then
        return true
    end

    return false
end

function strSplit(src, sep)
    local result = {}
    for match in string.gmatch(src, "([^" .. sep .. "]+)") do
        table.insert(result, match)
    end
    return result
end

function logPrint(...)
    local file = io.open("./log.txt", "a+")
    file:write(os.date("%Y-%m-%d %H:%M:%S ", os.time()))
    -- 检查文件是否成功打开
    if file then
        -- 使用pairs遍历所有传入的参数
        for i, v in ipairs{...} do
            -- 使用tostring将参数转换为字符串
            local str = tostring(v)
            -- 如果这不是第一个参数，添加一个空格分隔
            if i > 1 then str = " " .. str end
            -- 输出字符串
            file:write(str)
        end
        file:write("\n")
        -- 关闭文件
        file:close()
    else
        -- 如果文件无法打开，输出错误信息
        print("Cannot open file")
    end
end

function tblToString(tbl)
    local str = ""
    for i, v in pairs(tbl) do
        if type(v) == "table" then
            str = str .. " { " .. i .. " :{" .. tblToString(v) .. "}},"
        else
            str = str .. " { " .. i .. " : " .. tostring(v) .. "},"
        end
    end
    return str
end

function startsWith(str, prefix)
    return str:sub(1, #prefix) == prefix
end

function logPrintTbl(tbl)
    logPrint(MyJson.objToJson(tbl))
end

-- 万分比
function isOccur(permyriad)
    local rand = math.random() * 10000
    logPrint("isOccur ", rand, permyriad)
    return rand <= permyriad
end

-- 万分比
function getRandObj(objList)
    -- 生成一个0到1之间的随机数
    local randVal = math.random() * 10000

    -- 累积概率
    local cumulativeProb = 0

    -- 遍历概率表，根据累积概率返回字母
    local defObj = nil
    for obj, prob in pairs(objList) do
        if nil ~= obj then
            cumulativeProb = cumulativeProb + prob
            if randVal <= cumulativeProb then
                return obj
            end
        end
        if nil == defObj then
            defObj = obj
        end
    end

    return defObj
end

function copyList(list)
    local tmp = {}
    for _, v in ipairs(list) do
        table.insert(tmp, v)
    end
    return tmp
end

function extendClass(child, parent)
    if nil == parent._extend then
        child._extend = {parent, child}
    else
        child._extend = copyList(parent._extend)
        table.insert(child._extend, child)
    end

    child.__index = function(tbl, key)
        local list = child._extend
        for i = #list, 1, -1 do
            local class = list[i]
            if nil ~= class[key] then
                return class[key]
            end
        end
    end
end

function getMulRandObj(objList, count)
    local function isInArr(arr, key)
        for i = 1, #arr do
            if arr[i] == key then
                return true
            end
        end
        return false
    end

    local num = count * 3
    local rs = {}
    local tmp = nil
    for i = 1, num do
        tmp = getRandObj(objList)
        if not isInArr(rs, tmp) then
            table.insert(rs, tmp)
            if #rs == count then
                return rs
            end
        end
    end
    return rs
end

function getQueryRow(t)
    for i = 0, 9999999 do
        if t[i .. "_0"] == nil then
            return i
        end
    end
    return 0
end

function getItemImg(itemId)
    if 0 == itemId then
        return Const.GoldImgId
    end
    local item = MyDataItem:new(itemId)
    return item:getImage()
end

function getMaxStackCount(itemId)
    local item = MyDataItem:new(itemId)
    return item:getMaxStackCount()
end

function getItemName(itemId)
    local item = MyDataItem:new(itemId)
    return item:getName()
end

function isEmpty(tbl)
    for _ in pairs(tbl) do
        return false
    end
    return true
end

function copyTable(orig, copies)
    copies = copies or {}  -- Table to store copies of tables
    local orig_type = type(orig)
    local copy

    if orig_type == 'table' then
        if copies[orig] then
            return copies[orig]
        end

        copy = {}
        copies[orig] = copy

        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = copyTable(orig_value, copies)
        end

        if getmetatable(orig) then
            setmetatable(copy, copyTable(getmetatable(orig), copies))
        end
    else
        copy = orig
    end

    return copy
end

function checkFreeNum(itemList)
    local itemLen = #itemList
    local goldSum = 0
    local itemSum = 0
    local petSum = 0
    for i = 1, itemLen do
        local item = itemList[i]
        local itemType = item[1]
        local itemId = item[2]
        local itemNum = item[3]

        if Const.SkuTypeItem == itemType then
            local useBagNum = math.ceil(itemNum / getMaxStackCount(itemId))
            itemSum = itemSum + useBagNum
        elseif Const.SkuTypePet == itemType then
            petSum = petSum + itemNum
        elseif Const.SkuTypeGold == itemType then
            goldSum = goldSum + itemNum
        end
    end

    if itemSum > player:freeBagNum() then
        return 1
    end

    if player:getGold() + goldSum > MaxGoldAmount then
        return 2
    end

    if petSum > player:freePetNum() then
        return 3
    end

    return 0
end

function giveItemList(player, itemList)
    local itemLen = #itemList
    for i = 1, itemLen do
        local item = itemList[item]
        local itemType = item[1]
        local itemId = item[2]
        local itemNum = item[3]
        if Const.SkuTypeGold == itemType then
            player:addMoney(itemNum)
        elseif Const.SkuTypeItem == itemType then
            player:addItem(itemId, itemNum)
        elseif Const.SkuTypePet == itemType then
            for i = 1, itemNum do
                player:givePet(itemId)
            end
        end
    end
end
