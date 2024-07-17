local earthAttr = 1
local waterAttr = 2
local fireAttr = 3
local windAttr = 4
local awakeningInfo = nil
local awakeningWnd = nil
local select1 = nil
local petNum1 = 0
local itemNum = {99, 399, 999}
local attrField = {"eLevel", "wLevel", "fLevel", "wLevel"}

function awakening(widget)

    if nil ~= select1 then
        Cli.Send("up_awakening|" .. awakeningInfo[select1]["uuid"] .. "," .. awakeningWnd:getWidget("attrType"):getValue())
    end
end

function initAwakeningSelect()
    local next1 = awakeningWnd:getWidget(petTitle[1] .. "Next")
    local prev1 = awakeningWnd:getWidget(petTitle[1] .. "Prev")
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

function showUpAttr(level, attr, curLevel)
    local addAttr = 10
    local addArt = 3
    local upPet = "pet2"
    if level == 2 and level == curLevel then
        addAttr = 20
        addArt = 4
    end
    local cur = awakeningInfo[select1]
    if earthAttr == attr then
        awakeningWnd:getWidget(upPet .. "M"):setText("魔法: " .. (cur.magic + addArt));
        awakeningWnd:getWidget(upPet .. "V"):setText("体力: " .. (cur.vital));
        awakeningWnd:getWidget(upPet .. "S"):setText("力量: " .. (cur.str));
        awakeningWnd:getWidget(upPet .. "Q"):setText("速度: " .. (cur.quick));
        showCharAttr(awakeningWnd, upPet, cur.earth + addAttr, cur.water, cur.fire, cur.wind)
    elseif waterAttr == attr then
        awakeningWnd:getWidget(upPet .. "V"):setText("体力: " .. (cur.vital + addArt));
        awakeningWnd:getWidget(upPet .. "M"):setText("魔法: " .. (cur.magic));
        awakeningWnd:getWidget(upPet .. "S"):setText("力量: " .. (cur.str));
        awakeningWnd:getWidget(upPet .. "Q"):setText("速度: " .. (cur.quick));
        showCharAttr(awakeningWnd, upPet, cur.earth, cur.water + addAttr, cur.fire, cur.wind)
    elseif fireAttr == attr then
        awakeningWnd:getWidget(upPet .. "S"):setText("力量: " .. (cur.str + addArt));
        awakeningWnd:getWidget(upPet .. "M"):setText("魔法: " .. (cur.magic));
        awakeningWnd:getWidget(upPet .. "V"):setText("体力: " .. (cur.vital));
        awakeningWnd:getWidget(upPet .. "Q"):setText("速度: " .. (cur.quick));
        showCharAttr(awakeningWnd, upPet, cur.earth, cur.water, cur.fire + addAttr, cur.wind)
    elseif windAttr == attr then
        awakeningWnd:getWidget(upPet .. "Q"):setText("速度: " .. (cur.quick + addArt));
        awakeningWnd:getWidget(upPet .. "S"):setText("力量: " .. (cur.str));
        awakeningWnd:getWidget(upPet .. "M"):setText("魔法: " .. (cur.magic));
        awakeningWnd:getWidget(upPet .. "V"):setText("体力: " .. (cur.vital));
        showCharAttr(awakeningWnd, upPet, cur.earth, cur.water, cur.fire, cur.wind + addAttr)
    end
end

function selectAttrChanged(widget)
    local attr = tonumber(widget:getValue())
    local nextLevel = 0
    if select1 ~= nil then
        local cur = awakeningInfo[select1]
        nextLevel = cur["level"] + 1
        if nextLevel <=  3 then
            showItem(awakeningWnd, "item1", awakeningInfo["attrImg"][attr], itemNum[nextLevel],  awakeningInfo["attrNum"][attr])
            showItem(awakeningWnd, "item2", cur["itemImg"], 1, cur["itemNum"])
            showUpAttr(cur["level"], attr, cur[attrField[attr]])
            if (cur["itemImg"] ~= 0 and cur["itemNum"] < 1) or (awakeningInfo["attrNum"][attr] < itemNum[nextLevel]) then
                awakeningWnd:getWidget("confirm"):setEnabled(false)
            else
                awakeningWnd:getWidget("confirm"):setEnabled(true)
            end
            return
        end
    end
    awakeningWnd:getWidget("confirm"):setEnabled(false)
    showItem(awakeningWnd, "item1", 0, 0, 0)
    showItem(awakeningWnd, "item2", 0, 0, 0)
end

function showAwakeningInfo()
    local attr = awakeningWnd:getWidget("attrType")
    local confirm = awakeningWnd:getWidget("confirm")

    initAwakeningSelect()
    if nil ~= select1 then
        showPetInfo(awakeningWnd, "pet1", awakeningInfo[select1])
        if awakeningInfo[select1]["level"] < 3 then
            showPetInfo(awakeningWnd,"pet2", awakeningInfo[select1])
        else
            showPetInfo(awakeningWnd, "pet2", nil)
        end
    else
        showPetInfo(awakeningWnd, "pet1", nil)
        showPetInfo(awakeningWnd, "pet2", nil)
    end
    selectAttrChanged(attr)
    awakeningWnd:getWidget("pet2"):setText("觉醒后属性")
end

function awakeningPrev(widget)
    if nil == select1 then
        return
    end
    if select1 <= 1 then
        initAwakeningSelect()
        return
    end
    select1 = select1 - 1
    showAwakeningInfo()
end

function awakeningNext(widget)
    if nil == select1 then
        return
    end
    if select1 >= petNum1 then
        initAwakeningSelect()
        return
    end
    select1 = select1 + 1
    showAwakeningInfo()
end

function initAwakeningContent()
    logPrint("initAwakeningContent")
    select1 = nil
    petNum1 = #awakeningInfo
    if petNum1 >= 1 then
        select1 = 1
        awakeningWnd:getWidget("attrType"):changed(selectAttrChanged)
    end

    showAwakeningInfo()
end

function flushAwakeningInfo(info)
    logPrintTbl(info)
    awakeningInfo = info;
    initAwakeningContent()
end

function loadAwakeningClient(client)
    local needShow = false
    if nil == awakeningWnd and nil ~= awakeningInfo then
        needShow = true
    end
    awakeningWnd = createWindow(1001, "awakening", client)
    addCharAttr(awakeningWnd, petTitle[1])
    addCharAttr(awakeningWnd, petTitle[2])
    addItem(awakeningWnd, "item1")
    addItem(awakeningWnd, "item2")
    if needShow then
        showAwakening(awakeningInfo)
    end
    logPrint("loadAwakeningClient111")
end

function showAwakening(info)
    awakeningInfo = info;
    if (awakeningWnd == nil) then
        Cli.Send("awakening_client")
        return
    end

    logPrint( 'showAwakening1')
    awakeningWnd:show()
    safeCall(initAwakeningContent)
    logPrint( 'showAwakening2')
end

Cli.Send().wait["FLUSH_AWAKENING"] = flushAwakeningInfo
Cli.Send().wait["SHOW_AWAKENING"] = showAwakening
Cli.Send().wait["AWAKENING_CLIENT"] = loadAwakeningClient
