
local petInfo = nil
local itemInfo = nil
local talentWnd = nil
local select1 = nil
local petNum1 = 0

talentBtnText = {"领悟", "重置", "重置", "重置"}

function talent(widget)
    if nil ~= select1 then
        Cli.Send("get_talent|" .. talentInfo[tostring(select1)]["uuid"] .. "," .. 1)
    end
end

function initTalentSelect()
    local next1 = talentWnd:getWidget("next")
    local prev1 = talentWnd:getWidget("prev")
    if select1 == nil then
        next1:setEnabled(false)
        prev1:setEnabled(false)
        return
    end
    next1:setEnabled(true)
    prev1:setEnabled(true)
    if select1 == 1 then
        prev1:setEnabled(false)
    end
    if select1 == petNum1 then
        next1:setEnabled(false)
    end
end


function showTalentInfo()
    local attr = talentWnd:getWidget("attrType")
    local confirm = talentWnd:getWidget("confirm")

    initTalentSelect()
    if nil ~= select1 then
        showPetInfo(talentWnd, "pet1", talentInfo[select1])
        if talentInfo[select1]["level"] < 3 then
            showPetInfo(talentWnd,"pet2", talentInfo[select1])
        else
            showPetInfo(talentWnd, "pet2", nil)
        end
    else
        showPetInfo(talentWnd, "pet1", nil)
        showPetInfo(talentWnd, "pet2", nil)
    end
    selectAttrChanged(attr)
    talentWnd:getWidget("pet2"):setText("觉醒后属性")
end

function talentPrev(widget)
    if nil == select1 then
        return
    end
    if select1 <= 1 then
        initTalentSelect()
        return
    end
    select1 = select1 - 1
    showTalentInfo()
end

function talentNext(widget)
    if nil == select1 then
        return
    end
    if select1 >= petNum1 then
        initTalentSelect()
        return
    end
    select1 = select1 + 1
    showTalentInfo()
end

function initTalentContent()
    logPrint("initTalentContent")
    select1 = nil
    petNum1 = #talentInfo
    if petNum1 >= 1 then
        select1 = 1
        talentWnd:getWidget("attrType"):changed(selectAttrChanged)
    end

    showTalentInfo()
end

function flushTalentInfo(info)
    logPrintTbl(info)
    talentInfo[select1] = info;
    showTalentInfo()
end

function loadTalentClient(client)
    local needShow = false
    if nil == talentWnd and nil ~= talentInfo then
        needShow = true
    end

    talentWnd = createWindow(1021, "talent", client)
    addItem(talentWnd, "item1")
    addItem(talentWnd, "item2")
    addItem(talentWnd, "item3")
    addItem(talentWnd, "item4")
    if needShow then
        showTalent(talentInfo)
    end
    logPrint("loadTalentClient111")
end

function showTalent(info)
    petInfo = info["pet"]
    itemInfo = info["item"];
    if (talentWnd == nil) then
        Cli.Send("talent_client")
        return
    end

    logPrint( 'showTalent1')
    talentWnd:show()
    safeCall(initTalentContent)
    logPrint( 'showTalent2')
end

Cli.Send().wait["FLUSH_TALENT"] = flushTalentInfo
Cli.Send().wait["SHOW_TALENT"] = showTalent
Cli.Send().wait["TALENT_CLIENT"] = loadTalentClient
