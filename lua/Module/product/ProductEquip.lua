local petReplace = {
    [1] = {"���ﾧʯ", "��"},
    [2] = {"���ﾧʯ", "��"},
    [3] = {"���ﾧʯ", "��"},
    [4] = {"������Ʒ", "��"},
    [5] = {"������Ʒ", "ѥ"},
    [6] = {"������װ", "��"},
    [7] = {"������Ȧ", "��"},
    [8] = {"������Ȧ", "��"},
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