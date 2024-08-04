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
        vital:setText("体力: " .. petInfo.vital)
        str:setText("力量: " .. petInfo.str)
        tough:setText("强度: " .. petInfo.tough)
        quick:setText("速度: " .. petInfo.quick)
        magic:setText("魔法: " .. petInfo.magic)
        showCharAttr(wnd, petNameTitle, petInfo.earth, petInfo.water, petInfo.fire, petInfo.wind)
    else
        name:setText("无可选择宠物")
        img:setImg(0)
        vital:setText("体力: 0")
        str:setText("力量: 0")
        tough:setText("强度: 0")
        quick:setText("速度: 0")
        magic:setText("魔法: 0")
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
    synthesisInfo = info;
    initSynthesisContent()
end

local function loadSynthesisClient()
    local client = {
        {
            ["type"] = "bg",
            ["img"] = "synthesis.bmp",
        },
        {
            ["type"] = "close",
            ["x"] = 461,
            ["y"] = 8,
            ["img"] = 243000,
            ["active"] = 243002,
            ["disable"] = 243001,
        },
        {
            ["table"] = "1,0",
            ["width"] = 220,
            ["high"] = 39,
            ["type"] = "lab",
            ["title"] = "#petTitle",
            ["x"] = 90,
            ["y"] = 68,
            ["text"] = "无可选择宠物",
        },
        {
            ["table"] = "1,0",
            ["width"] = 220,
            ["high"] = 39,
            ["type"] = "btn",
            ["title"] = "#petTitle$Prev",
            ["x"] = 63,
            ["y"] = 65,
            ["img"] = "prev1.bmp",
            ["active"] = "prev2.bmp",
            ["disable"] = "prev3.bmp",
        },
        {
            ["table"] = "1,0",
            ["width"] = 220,
            ["high"] = 39,
            ["type"] = "btn",
            ["title"] = "#petTitle$Next",
            ["x"] = 193,
            ["y"] = 65,
            ["img"] = "next1.bmp",
            ["active"] = "next2.bmp",
            ["disable"] = "next3.bmp",
        },
        {
            ["table"] = "1,0",
            ["width"] = 220,
            ["high"] = 39,
            ["type"] = "img",
            ["title"] = "#petTitle$Frame",
            ["x"] = 75,
            ["y"] = 89,
            ["img"] = "#petFrame",
        },
        {
            ["table"] = "1,0",
            ["width"] = 220,
            ["high"] = 39,
            ["type"] = "ani",
            ["title"] = "#petTitle$ZImg",
            ["x"] = 0,
            ["y"] = 0,
            ["img"] = 0,
            ["bg"] = "#petTitle$Frame",
        },
        {
            ["table"] = "1,0",
            ["width"] = 220,
            ["high"] = 39,
            ["type"] = "lab",
            ["title"] = "#petTitle$V",
            ["x"] = 78,
            ["y"] = 267,
            ["text"] = "体力: 0",
        },
        {
            ["table"] = "1,0",
            ["width"] = 220,
            ["high"] = 39,
            ["type"] = "lab",
            ["title"] = "#petTitle$S",
            ["x"] = 139,
            ["y"] = 267,
            ["text"] = "力量: 0",
        },
        {
            ["table"] = "1,0",
            ["width"] = 220,
            ["high"] = 39,
            ["type"] = "lab",
            ["title"] = "#petTitle$T",
            ["x"] = 78,
            ["y"] = 282,
            ["text"] = "强度: 0",
        },
        {
            ["table"] = "1,0",
            ["width"] = 220,
            ["high"] = 39,
            ["type"] = "lab",
            ["title"] = "#petTitle$Q",
            ["x"] = 139,
            ["y"] = 282,
            ["text"] = "速度: 0",
        },
        {
            ["table"] = "1,0",
            ["width"] = 220,
            ["high"] = 39,
            ["type"] = "lab",
            ["title"] = "#petTitle$M",
            ["x"] = 78,
            ["y"] = 297,
            ["text"] = "魔法: 0",
        },
        {
            ["table"] = "1,0",
            ["width"] = 220,
            ["high"] = 39,
            ["type"] = "img",
            ["title"] = "#petTitle$Earth",
            ["x"] = 76,
            ["y"] = 207,
            ["img"] = 243150,
        },
        {
            ["table"] = "1,0",
            ["width"] = 220,
            ["high"] = 39,
            ["type"] = "img",
            ["title"] = "#petTitle$Water",
            ["x"] = 76,
            ["y"] = 222,
            ["img"] = 243155,
        },
        {
            ["table"] = "1,0",
            ["width"] = 220,
            ["high"] = 39,
            ["type"] = "img",
            ["title"] = "#petTitle$Fire",
            ["x"] = 76,
            ["y"] = 237,
            ["img"] = 243160,
        },
        {
            ["table"] = "1,0",
            ["width"] = 220,
            ["high"] = 39,
            ["type"] = "img",
            ["title"] = "#petTitle$Wind",
            ["x"] = 76,
            ["y"] = 252,
            ["img"] = 243165,
        },
        {
            ["type"] = "lab",
            ["title"] = "mobi",
            ["x"] = 202,
            ["y"] = 218,
            ["text"] = "需要:50000魔币",
        },
        {
            ["type"] = "img",
            ["title"] = "check",
            ["x"] = 228,
            ["y"] = 230,
            ["img"] = "f.bmp",
        },
        {
            ["type"] = "btn",
            ["title"] = "confirm",
            ["x"] = 228,
            ["y"] = 123,
            ["img"] = "y1.bmp",
            ["active"] = "y2.bmp",
            ["disable"] = "y3.bmp",
            ["text"] = "合成",
            ["click"] = "synthesis",
        }
    }
    synthesisWnd = createWindow(1007, "synthesis", client)
    addCharAttr(synthesisWnd, petTitle[1])
    addCharAttr(synthesisWnd, petTitle[2])
end

function showSynthesis(info)
    synthesisInfo = info;
    if (synthesisWnd == nil) then
        loadSynthesisClient()
    end

    select = {nil, nil}
    synthesisWnd:show()
    initSynthesisContent()
end

Cli.Send().wait["FLUSH_SYNTHESIS"] = flushSynthesisInfo
Cli.Send().wait["SHOW_SYNTHESIS"] = showSynthesis
