
function Event.RegMergeItemEvent.doProductItem(CharIndex, SkillID, SkillLv, ItemIndex)
    logPrint("doProductItem", CharIndex, SkillID, SkillLv, ItemIndex)
end

function Event.RegMakeItemStringEvent.genItemStr(CharIndex, ItemSlot, ItemIndex, ItemText, TextLen, TextMaxLen)
    logPrint("genItemStr", CharIndex, ItemSlot, ItemIndex, ItemText, TextLen, TextMaxLen)
end