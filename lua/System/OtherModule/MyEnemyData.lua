-- 定义一个名为 MyEnemyData 的表
MyEnemyData = {}
MyEnemyData.__index = MyEnemyData

-- 定义构造函数 new
function MyEnemyData:new(enemyId)
    local enemyIndex = Data.EnemyGetIndex(enemyId)
    local newObj = {
        _enemy = enemyIndex,
        _enemyBase = Data.EnemyGetIndex(Data.EnemyGetData(enemyIndex, 1)),
    }
    setmetatable(newObj, self)
    return newObj
end

function MyEnemyData:get(pos)
    return Data.EnemyGetData(self._enemy, pos)
end

function MyEnemyData:get1()
    return Data.EnemyTempGetData(self._enemyBase, pos)
end

function MyEnemyData:getLevel()
    return self:get(1)
end

function MyEnemyData:getBirthBp()
    return self:get(1)
end

function MyEnemyData:getVital()
    return self:get(self._player, 1)
end

function MyEnemyData:getStr()
    return self:get(self._player, 2)
end

function MyEnemyData:getTough()
    return self:get(self._player, 3)
end

function MyEnemyData:getQuick()
    return self:get(self._player, 4)
end

function MyEnemyData:getMagic()
    return self:get(self._player, 5)
end

function MyEnemyData:getImage()
    return self:get(self._player, 5)
end

function MyEnemyData:getName()
    return self:get(self._player, 5)
end

function MyEnemyData:getAttr()
    return calEnemyAttr(self:getLevel(), self:getBirthBp(), self:getVital(),
            self:getStr(), self:getTough(), self:getQuick(), self:getMagic())
end