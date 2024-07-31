-- ����һ����Ϊ MyEnemy �ı�
MyEnemy = {}
extendClass(MyEnemy, MyChar)

-- ���幹�캯�� new
function MyEnemy:new(player)
    local newObj = MyChar:new(player)
    setmetatable(newObj, self)       -- �����¶����Ԫ��Ϊ MyEnemy
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
