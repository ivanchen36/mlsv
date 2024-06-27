petTitle = {"pet1", "pet2"}
petFrame = {"k1.bmp", "k2.bmp"}
local synthesisInfo = nil
local petNum = 0
local select = {nil, nil}
local synthesisWnd = nil

function getShowInfo()
    local select1 = nil
    local select2 = nil
    for i = 1, #synthesisInfo do
        if synthesisInfo[i] ~= nil then
            if nil == select1 then
                select1 = i
            elseif nil == select2 then
                select2 = i
                return {select1, select2}
            end
        end
    end
    return {select1, select2}
end

function showSynthesisInfo(index, petInfo)
    logPrint("2221")
    local name = synthesisWnd:getWidget(petTitle[index]);
    local img = synthesisWnd:getWidget(petTitle[index] .. "Img");
    local vital = synthesisWnd:getWidget(petTitle[index] .. "V");
    local str = synthesisWnd:getWidget(petTitle[index] .. "S");
    local tough = synthesisWnd:getWidget(petTitle[index] .. "T");
    local quick = synthesisWnd:getWidget(petTitle[index] .. "Q");
    local magic = synthesisWnd:getWidget(petTitle[index] .. "M");
    logPrint("2222")

    name:setText(string.sub(petInfo.name, 1, 16))
    logPrint("2223")
    img:setImg(petInfo.img)
    logPrintTbl(img)
    vital:setText("体力: " .. petInfo.vital)
    str:setText("力量: " .. petInfo.str)
    tough:setText("强度: " .. petInfo.tough)
    quick:setText("速度: " .. petInfo.quick)
    magic:setText("魔法: " .. petInfo.magic)
    showCharAttr(synthesisWnd, petTitle[index], petInfo.earth, petInfo.water, petInfo.fire, petInfo.wind)
    logPrint("222")
    logPrintTbl(synthesisWnd:getWidget(petTitle[index] .. "Earth"))
    logPrintTbl(synthesisWnd:getWidget(petTitle[index] .. "Ea"))
end

function synthesis(widget)
    if nil ~= select[1] and nil ~= select[2] then
        Cli.Send("pet_synthesis|" .. select[1] .. "," .. select[2])
    end
end

function initSelectButton()
    local select1 = select[1]
    local select2 = select[2]
    local next1 = synthesisWnd:getWidget(petTitle[1] .. "Next")
    local prev1 = synthesisWnd:getWidget(petTitle[1] .. "Prev")
    local next2 = synthesisWnd:getWidget(petTitle[2] .. "Next")
    local prev2 = synthesisWnd:getWidget(petTitle[2] .. "Prev")
    if select2 == nil then
        next1:setEnabled(false)
        prev1:setEnabled(false)
        next2:setEnabled(false)
        prev2:setEnabled(false)
        return
    end
    next1:setEnabled(true)
    prev1:setEnabled(true)
    next2:setEnabled(true)
    prev2:setEnabled(true)

    if select1 == 1 then
        prev1:setEnabled(false)
    end

    if select2 == 1 then
        prev2:setEnabled(false)
    end

    if select1 == petNum then
        next1:setEnabled(false)
    end

    if select2 == petNum then
        next2:setEnabled(false)
    end
end

function initSynthesisContent()
    petNum = #synthesisInfo
    select = getShowInfo()
    initSelectButton()
    local confirm = synthesisWnd:getWidget("confirm")
    local check = synthesisWnd:getWidget("check")
    if synthesisInfo["amount"] == 1 then
        check:setImg("t.bmp")
    else
        check:setImg("f.bmp")
    end
    if synthesisInfo["amount"] == 1 and petNum >= 2 then
        confirm:setEnabled(true)
    else
        confirm:setEnabled(false)
    end
    logPrint("111")
    for i=1, #petTitle do
        if nil ~= select[i] then
            showSynthesisInfo(i, synthesisInfo[select[i]])
        end
        local next = synthesisWnd:getWidget(petTitle[i] .. "Next")
        local prev = synthesisWnd:getWidget(petTitle[i] .. "Prev")
        next:clicked(function()
            local select1 = select[i]
            if nil == select1 then
                return
            end
            if select1 >= petNum then
                initSelectButton()
                return
            end
            local other = (1 == i) and 2 or 1
            local select2 = select[other]
            for j = select1 + 1, petNum do
                if j ~= select2 then
                    select[i] = j
                    showSynthesisInfo(i, synthesisInfo[select[i]])
                    initSelectButton()
                    return
                end
                if j == petNum then
                    select[other] = j - 1
                    showSynthesisInfo(i, synthesisInfo[select[i]])
                    showSynthesisInfo(other, synthesisInfo[select[other]])
                    initSelectButton()
                    return
                end
            end
        end)
        logPrint("3344")
        prev:clicked(function()
            local select1 = select[i]
            if nil == select1 then
                return
            end
            if select1 <= 1 then
                initSelectButton()
                return
            end

            local other = (1 == i) and 2 or 1
            local select2 = select[other]

            for j = select1 - 1, 1, -1 do
                if j ~= select2 then
                    select[i] = j
                    showSynthesisInfo(i, synthesisInfo[select[i]])
                    initSelectButton()
                    return
                end
                if j == 1 then
                    select[other] = j + 1
                    showSynthesisInfo(i, synthesisInfo[select[i]])
                    showSynthesisInfo(other, synthesisInfo[select[other]])
                    initSelectButton()
                    return
                end
            end
        end)
        logPrint("33144")
    end
end

function flushSynthesisInfo(info)
    logPrintTbl(info)
    synthesisInfo = info;
    initSynthesisContent()
end

function loadSynthesisClient(client)
    logPrint("loadSynthesisClient")
    logPrintTbl(client)

    local needShow = false
    if nil == synthesisWnd and nil ~= synthesisInfo then
        needShow = true
    end
    synthesisWnd = createWindow("synthesis", client)
    addCharAttr(synthesisWnd, petTitle[1])
    addCharAttr(synthesisWnd, petTitle[2])
    logPrintTbl(synthesisWnd)
    if needShow then
        showSynthesis(synthesisInfo)
    end
    logPrint("loadSynthesisClient2")
end

function showSynthesis(info)
    synthesisInfo = info;
    if (synthesisWnd == nil) then
        Cli.Send("synthesis_client")
        return
    end

    select = {nil, nil}
    logPrint( 'showSynthesis1')
    logPrintTbl(info)
    synthesisWnd:show()
    logPrintTbl(synthesisWnd)
    initSynthesisContent()
    logPrint( 'showSynthesis2')
end

Cli.Send().wait["FLUSH_SYNTHESIS"] = flushSynthesisInfo
Cli.Send().wait["SHOW_SYNTHESIS"] = showSynthesis
Cli.Send().wait["SYNTHESIS_CLIENT"] = loadSynthesisClient
