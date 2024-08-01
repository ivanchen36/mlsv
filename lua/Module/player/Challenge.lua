local bossMap = {
    [1] = 1
}

local addBossAttrList = { }

local function modifyAttr(enemyList)

end

function modifyBossAttr(battleIndex)
    if not Battle.IsBossBattle(battleIndex) then
        return
    end

    local isFind = false
    local enemyList = {}
    for i = 10, 19 do
        local enemy = MyEnemy:new(Battle.GetPlayer(battleIndex, i))
        if enemy:isValid() then
            table.insert(enemyList, enemy)
            if rawget(bossMap, enemy:getId()) ~= nil then
                isFind = true
            end
        end
    end
    if isFind then
        modifyAttr(enemyList)
    end
end

InitEvent["battle"] = modifyBossAttr