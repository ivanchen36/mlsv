local petReplace = {
    [1] = {"宠物晶石", "剑"},
    [2] = {"宠物晶石", "弓"},
    [3] = {"宠物晶石", "仗"},
    [4] = {"宠物饰品", "盔"},
    [5] = {"宠物饰品", "靴"},
    [6] = {"宠物轻装", "盾"},
    [7] = {"宠物项圈", "铠"},
    [8] = {"宠物项圈", "袍"},
 }

function Event.RegMergeItemEvent.doProductItem(index, skillID, skillLv, itemIndex)
    logPrint("doProductItem", index, skillID, skillLv, itemIndex)
end

function Event.RegMakeItemStringEvent.genItemStr(index, itemSlot, itemIndex, itemText, textLen, textMaxLen)
    logPrint("genItemStr", index, itemSlot, itemIndex)
    local item = MyItem:new(itemIndex)
    logPrint(item:getName())
    if item:getId() < 20201 or item:getId() > 20299 then
        return
    end

    local eIndex = math.floor(item:getId() / 10)
    if eIndex < 4 then
        local player = MyPlayer:new(index)
        for i = 0, 4 do
            local pet = player:getPet(i)
            if pet:isValid() then
                if pet:flushAtkModeAndSkill() > 0 then
                    pet:flush()
                end
            end
        end
    end
    if rawget(petReplace, eIndex) == nil then
        return
    end
    logPrint(itemText:gsub(petReplace[eIndex][1], petReplace[eIndex][2]))
    return itemText:gsub(petReplace[eIndex][1], petReplace[eIndex][2])
end