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
    logPrint(MyJson.tblToJson(tbl))
end

-- 万分比
function isOccur(permyriad)
    local rand = math.random() * 10000
    return rand <= permyriad
end

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

    local num = #count * 2
    local rs = {}
    local tmp = nil
    for i = 1, num do
        tmp = getRandObj(objList)
        if not isInTable(tmp) then
            table.insert(rs, tmp)
            if #rs == count then
                return rs
            end
        end
    end
    return rs
end

function countKeys(t)
    local count = 0
    for _ in pairs(t) do
        count = count + 1
    end
    return count
end
