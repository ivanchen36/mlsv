MyJson = {}
----------------------------------------------------------------------------------
-- Lua-Table 与 string 转换
local function objToStr(value, isArray)
    if type(value)=='table' then
        return MyJson.tblToStr(value)
    elseif type(value)=='string' then
        return "\""..value.."\""
    else
        return tostring(value)
    end
end

function MyJson.strToTbl(str)
    if str == nil or type(str) ~= "string" or str == "" then
        return {}
    end
    --若报错bad argument #1 to 'loadstring' ... ，把loadstring改为load即可
    --return loadstring("return " .. str)()
    return load("return " .. str)()
end

function MyJson.tblToStr(t)
    local isArray = isArrayTable(t)
    if t == nil then return "" end
    local sStart = "{"

    local i = 1
    for key,value in pairs(t) do
        local sSplit = ","
        if i==1 then
            sSplit = ""
        end

        if isArray then
            sStart = sStart..sSplit..objToStr(value, isArray)
        else
            if type(key)=='number' or type(key) == 'string' then
                sStart = sStart..sSplit..'['..objToStr(key).."]="..objToStr(value)
            else
                if type(key)=='userdata' then
                    sStart = sStart..sSplit.."*s"..MyJson.tblToStr(getmetatable(key)).."*e".."="..objToStr(value)
                else
                    sStart = sStart..sSplit..key.."="..objToStr(value)
                end
            end
        end

        i = i+1
    end

    sStart = sStart.."}"
    return sStart
end

----------------------------------------------------------------------------------
-- Lua-Table 与 json 转换
local function json2true(str, from, to)
    return true, from + 3
end

local function json2false(str, from, to)
    return false, from + 4
end

local function json2null(str, from, to)
    return nil, from + 3
end

local function json2nan(str, from, to)
    return nil, from + 2
end

local numberchars = {
    ['-'] = true,
    ['+'] = true,
    ['.'] = true,
    ['0'] = true,
    ['1'] = true,
    ['2'] = true,
    ['3'] = true,
    ['4'] = true,
    ['5'] = true,
    ['6'] = true,
    ['7'] = true,
    ['8'] = true,
    ['9'] = true,
}

local function json2number(str, from, to)
    local i = from + 1
    while (i <= to) do
        local char = string.sub(str, i, i)
        if not numberchars[char] then
            break
        end
        i = i + 1
    end
    local num = tonumber(string.sub(str, from, i - 1))
    if not num then
        return
    end
    return num, i - 1
end

local function json2string(str, from, to)
    local ignor = false
    for i = from + 1, to do
        local char = string.sub(str, i, i)
        if not ignor then
            if char == '\"' then
                return string.sub(str, from + 1, i - 1), i
            elseif char == '\\' then
                ignor = true
            end
        else
            ignor = false
        end
    end
end

local function json2array(str, from, to)
    local result = {}
    from = from or 1
    local pos = from + 1
    local to = to or string.len(str)
    while (pos <= to) do
        local char = string.sub(str, pos, pos)
        if char == '\"' then
            result[#result + 1], pos = json2string(str, pos, to)
            --[[    elseif char == ' ' then

            elseif char == ':' then

            elseif char == ',' then]]
        elseif char == '[' then
            result[#result + 1], pos = json2array(str, pos, to)
        elseif char == '{' then
            result[#result + 1], pos = MyJson.jsonToTbl(str, pos, to)
        elseif char == ']' then
            return result, pos
        elseif (char == 'f' or char == 'F') then
            result[#result + 1], pos = json2false(str, pos, to)
        elseif (char == 't' or char == 'T') then
            result[#result + 1], pos = json2true(str, pos, to)
        elseif (char == 'n') then
            result[#result + 1], pos = json2null(str, pos, to)
        elseif (char == 'N') then
            result[#result + 1], pos = json2nan(str, pos, to)
        elseif numberchars[char] then
            result[#result + 1], pos = json2number(str, pos, to)
        end
        pos = pos + 1
    end
end

local function string2json(value)
    return string.format("\"%s\"", value)
end

local function number2json(value)
    return string.format("%s", value)
end

local function boolean2json(value)
    value = value == nil and false or value
    return string.format("%s", tostring(value))
end

local function array2json(value)
    local str = "["
    for _, v in pairs(value) do
        str = str .. MyJson.objToJson(v) .. ","
    end
    if string.len(str) > 1 then
        str = string.sub(str, 1, string.len(str) - 1)
    end
    return str .. "]"
end

local function isArrayTable(t)
    if type(t) ~= "table" then
        return false
    end

    local n = #t
    local len = 0
    local min = 99
    local max = 0
    for i, v in pairs(t) do
        if type(i) ~= "number" then
            return false
        end
        len = len + 1
        if i < min then
            min = i
        end
        if i > max then
            max = i
        end

        if i > n then
            return false
        end
    end
    if min ~= 1 or max ~= len then
        return false
    end
    return true
end

function MyJson.objToJson(v)
    if type(v) == "string" then
        return string2json(v)
    elseif type(v) == "number" then
        return number2json(v)
    elseif type(v) == "boolean" then
        return boolean2json(v)
    elseif type(v) == "table" then
        if isArrayTable(v) then
            return array2json(v)
        else
            return MyJson.tblToJson(v)
        end
    elseif type(v) == "function" then
        return string2json(tostring(v))
    else
        return string2json(type(v))
    end
end

function MyJson.jsonToTbl(str, from, to)
    local result = {}
    from = from or 1
    local pos = from + 1
    local to = to or string.len(str)
    local key
    while (pos <= to) do
        local char = string.sub(str, pos, pos)
        if char == '\"' then
            if not key then
                key, pos = json2string(str, pos, to)
            else
                result[key], pos = json2string(str, pos, to)
                key = nil
            end
            --[[    elseif char == ' ' then

            elseif char == ':' then

            elseif char == ',' then]]
        elseif char == '[' then
            if not key then
                key, pos = json2array(str, pos, to)
            else
                result[key], pos = json2array(str, pos, to)
                key = nil
            end
        elseif char == '{' then
            if not key then
                key, pos = MyJson.jsonToTbl(str, pos, to)
            else
                result[key], pos = MyJson.jsonToTbl(str, pos, to)
                key = nil
            end
        elseif char == '}' then
            return result, pos
        elseif (char == 'f' or char == 'F') then
            result[key], pos = json2false(str, pos, to)
            key = nil
        elseif (char == 't' or char == 'T') then
            result[key], pos = json2true(str, pos, to)
            key = nil
        elseif (char == 'n') then
            result[key], pos = json2null(str, pos, to)
            key = nil
        elseif (char == 'N') then
            result[key], pos = json2nan(str, pos, to)
            key = nil
        elseif numberchars[char] then
            if not key then
                key, pos = json2number(str, pos, to)
            else
                result[key], pos = json2number(str, pos, to)
                key = nil
            end
        end
        pos = pos + 1
    end
end

--json格式中表示字符串不能使用单引号
local jsonfuncs = {
    ['\"'] = json2string,
    ['['] = json2array,
    ['{'] = MyJson.jsonToTbl,
    ['f'] = json2false,
    ['F'] = json2false,
    ['t'] = json2true,
    ['T'] = json2true,
}

function MyJson.jsonToObj(str)
    local char = string.sub(str, 1, 1)
    local func = jsonfuncs[char]
    if func then
        return func(str, 1, string.len(str))
    end
    if numberchars[char] then
        return json2number(str, 1, string.len(str))
    end
end

function MyJson.tblToJson(tab)
    local str = "{"
    for k, v in pairs(tab) do
        str = str .. "\"" .. k .. "\":" .. MyJson.objToJson(v) .. ","
    end
    if string.len(str) > 1 then
        str = string.sub(str, 1, string.len(str) - 1)
    end
    return str .. "}"
end