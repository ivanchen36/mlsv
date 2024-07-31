-- 定义一个名为 MyEnemy 的表
MyEnemy = {}
extendClass(MyEnemy, MyChar)

-- 定义构造函数 new
function MyEnemy:new(player)
    local newObj = MyChar:new(player)
    setmetatable(newObj, self)       -- 设置新对象的元表为 MyEnemy
    return newObj
end

function MyEnemy:getId()
    return self:get(68)
end

function MyEnemy:setId(id)
    return self:set(68, id)
end

function MyEnemy:flush()
    NLG.UpChar(self._player)
end
