-- ����һ����Ϊ MyLimit �ı�
MyLimit = {}
MyLimit.__index = MyLimit

-- ���幹�캯�� new
function MyLimit:new(idStr, type)
    local newObj = { _idStr = idStr, _type = type }
    setmetatable(newObj, self)       -- �����¶����Ԫ��Ϊ MyLimit
    return newObj
end

function MyLimit:init(cycle, count)
    local sql = string.format("insert into  tbl_user_limit (UserId,Type,Count,Used,Cycle,CreateTime) VALUES ('?',?,?,0,?, UNIX_TIMESTAMP())",
            self._idStr, self._type, count, cycle)
    Sql.RUN(sql)
end

function MyLimit:deduct(count)
    local sql = string.format("update tbl_user_limit set Used = IF(FLOOR((UNIX_TIMESTAMP(UpdateTime) + 28800) / Cycle) * Cycle - 28800 < FLOOR((UNIX_TIMESTAMP() + 28800) / Cycle) * Cycle - 28800, 1, Used + 1) where UserId = '?' and Type = ? and ((FLOOR((UNIX_TIMESTAMP(UpdateTime) + 28800) / Cycle) * Cycle - 28800) < (FLOOR((UNIX_TIMESTAMP() + 28800) / Cycle) * Cycle - 28800) or Used < Count);",
            self._idStr, self._type)
    Sql.RUN(sql)
end

function MyLimit:getAvailable(idStr, type)
    local sql = string.format("select IF(FLOOR((UNIX_TIMESTAMP(UpdateTime) + 28800) / Cycle) * Cycle - 28800 < FLOOR((UNIX_TIMESTAMP() + 28800) / Cycle) * Cycle - 28800, Count, Count - Used) from  tbl_user_limit where UserId = '?' and Type = ?",
            idStr, type)
    local rs = Sql.RUN(sql)
    if type(rs) ~= "table" then
        return nil
    end

    return tonumber(rs["0_0"])
end