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

function showPetInfo(wnd, petNameTitle, petInfo)
    local name = wnd:getWidget(petNameTitle);
    local img = wnd:getWidget(petNameTitle .. "ZImg");
    local vital = wnd:getWidget(petNameTitle .. "V");
    local str = wnd:getWidget(petNameTitle .. "S");
    local tough = wnd:getWidget(petNameTitle .. "T");
    local quick = wnd:getWidget(petNameTitle .. "Q");
    local magic = wnd:getWidget(petNameTitle .. "M");

    if nil ~= petInfo then
        name:setText(string.sub(petInfo.name, 1, 16))
        img:setImg(petInfo.img)
        vital:setText("����: " .. petInfo.vital)
        str:setText("����: " .. petInfo.str)
        tough:setText("ǿ��: " .. petInfo.tough)
        quick:setText("�ٶ�: " .. petInfo.quick)
        magic:setText("ħ��: " .. petInfo.magic)
        showCharAttr(wnd, petNameTitle, petInfo.earth, petInfo.water, petInfo.fire, petInfo.wind)
    else
        name:setText("�޿�ѡ�����")
        img:setImg(0)
        vital:setText("����: 0")
        str:setText("����: 0")
        tough:setText("ǿ��: 0")
        quick:setText("�ٶ�: 0")
        magic:setText("ħ��: 0")
        showCharAttr(wnd, petNameTitle, 0, 0, 0, 0)
    end
end

function synthesis(widget)
    if nil ~= select[1] and nil ~= select[2] then
        Cli.Send("pet_synthesis|" .. synthesisInfo[select[1]]["uuid"] .. "," .. synthesisInfo[select[2]]["uuid"])
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
    for i=1, #petTitle do
        if nil ~= select[i] then
            showPetInfo(synthesisWnd, petTitle[i], synthesisInfo[select[i]])
        else
            showPetInfo(synthesisWnd, petTitle[i], nil)
        end
        local next = synthesisWnd:getWidget(petTitle[i] .. "Next")
        local prev = synthesisWnd:getWidget(petTitle[i] .. "Prev")
        next:clicked(function(w)
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
                    showPetInfo(synthesisWnd, petTitle[i], synthesisInfo[j])
                    initSelectButton()
                    return
                end
                if j == petNum then
                    select[other] = j - 1
                    select[i] = j
                    showPetInfo(synthesisWnd, petTitle[i], synthesisInfo[j])
                    showPetInfo(synthesisWnd, petTitle[other], synthesisInfo[j - 1])
                    initSelectButton()
                    return
                end
            end
        end)
        prev:clicked(function(w)
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
                    showPetInfo(synthesisWnd, petTitle[i], synthesisInfo[j])
                    initSelectButton()
                    return
                end
                if j == 1 then
                    select[other] = j + 1
                    select[i] = j
                    showPetInfo(synthesisWnd, petTitle[i], synthesisInfo[j])
                    showPetInfo(synthesisWnd, petTitle[other], synthesisInfo[j + 1])
                    initSelectButton()
                    return
                end
            end
        end)
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
    synthesisWnd = createWindow(1007, "synthesis", client)
    addCharAttr(synthesisWnd, petTitle[1])
    addCharAttr(synthesisWnd, petTitle[2])
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
    initSynthesisContent()
    logPrintTbl(synthesisWnd)
    logPrint( 'showSynthesis2')
end

Cli.Send().wait["FLUSH_SYNTHESIS"] = flushSynthesisInfo
Cli.Send().wait["SHOW_SYNTHESIS"] = showSynthesis
Cli.Send().wait["SYNTHESIS_CLIENT"] = loadSynthesisClient
