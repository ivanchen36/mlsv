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

    -- ����ļ��Ƿ�ɹ���
    if file then
        -- ʹ��pairs�������д���Ĳ���
        for i, v in ipairs{...} do
            -- ʹ��tostring������ת��Ϊ�ַ���
            local str = tostring(v)
            -- ����ⲻ�ǵ�һ�����������һ���ո�ָ�
            if i > 1 then str = " " .. str end
            -- ����ַ���
            file:write(str)
        end
        file:write("\n")
        -- �ر��ļ�
        file:close()
    else
        -- ����ļ��޷��򿪣����������Ϣ
        print("Cannot open file")
    end
end

function isOccur(permyriad)
    local probability = permyriad
    local rand = math.random() * 10000
    return rand <= probability
end

function getRandObj(objList)
    -- ����һ��0��1֮��������
    local randVal = math.random() * 10000

    -- �ۻ�����
    local cumulativeProb = 0

    -- �������ʱ������ۻ����ʷ�����ĸ
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
