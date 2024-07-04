-- 定义一个名为 MyLimit 的表
MyLimit = {}
MyLimit.__index = MyLimit

-- 定义构造函数 new
function MyLimit:new(idStr, type)
    local newObj = { _idStr = idStr, _type = type }
    setmetatable(newObj, self)       -- 设置新对象的元表为 MyLimit
    return newObj
end

function MyLimit:init(cycle, count)
    local sql = string.format("insert into  tbl_user_limit (UserId,Type,Count,Used,Cycle,CreateTime) VALUES ('%s',%d,%d,0,%d, UNIX_TIMESTAMP())",
            self._idStr, self._type, count, cycle)
    SQL.Run(sql)
end

function MyLimit:deduct(count)
    if self:getAvailable() <= 0 then
        return 0
    end

    local sql = string.format("update tbl_user_limit set Used = IF(FLOOR((UNIX_TIMESTAMP(UpdateTime) + 28800) / Cycle) * Cycle - 28800 < FLOOR((UNIX_TIMESTAMP() + 28800) / Cycle) * Cycle - 28800, 1, Used + 1) where UserId = '%s' and Type = %d and ((FLOOR((UNIX_TIMESTAMP(UpdateTime) + 28800) / Cycle) * Cycle - 28800) < (FLOOR((UNIX_TIMESTAMP() + 28800) / Cycle) * Cycle - 28800) or Used < Count);",
            self._idStr, self._type)
    SQL.Run(sql)
    return 1
end

function MyLimit:getAvailable()
    local sql = string.format("select IF(FLOOR((UNIX_TIMESTAMP(UpdateTime) + 28800) / Cycle) * Cycle - 28800 < FLOOR((UNIX_TIMESTAMP() + 28800) / Cycle) * Cycle - 28800, Count, Count - Used) from  tbl_user_limit where UserId = '%s' and Type = %d",
            self._idStr, self._type)
    local rs = SQL.Run(sql)
    if type(rs) ~= "table" then
        return 0
    end

    return tonumber(rs["0_0"])
end