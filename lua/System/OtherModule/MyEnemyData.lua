-- 定义一个名为 MyEnemyData 的表
MyEnemyData = {}
MyEnemyData.__index = MyEnemyData

-- 定义构造函数 new
function MyEnemyData:new(enemyId)
    local newObj = {
        _enemy = Data.EnemyGetIndex(enemyId),
        _enemyBase = Data.EnemyTempGetIndex(enemyId),
    }
    setmetatable(newObj, self)
    return newObj
end

function MyEnemyData:get(pos)
    return Data.EnemyGetData(self._enemy, pos)
end

function MyEnemyData:get1(pos)
    return Data.EnemyTempGetData(self._enemyBase, pos)
end

--%对象_名字% 2000
function MyEnemyData:getName()
    return self:get1(2000)
end

function MyEnemyData:getImage()
    return self:get1(29)
end

function MyEnemyData:getLevel()
    return self:get(2)
end

function MyEnemyData:getBirthBp()
    return self:get1(1)
end

function MyEnemyData:getVital()
    return self:get1(4)
end

function MyEnemyData:getStr()
    return self:get1(5)
end

function MyEnemyData:getTough()
    return self:get1(6)
end

function MyEnemyData:getQuick()
    return self:get1(7)
end

function MyEnemyData:getMagic()
    return self:get1(8)
end

function MyEnemyData:getImage()
    return self:get1(29)
end

function MyEnemyData:getAttr()
    return calEnemyAttr(self:getLevel(), self:getBirthBp(), self:getVital(),
            self:getStr(), self:getTough(), self:getQuick(), self:getMagic())
end