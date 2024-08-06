
local petInfo = nil
local itemInfo = nil
local talentWnd = nil
local select1 = nil
local petNum1 = 0

talentBtnText = {"领悟", "重置", "重置", "重置"}
local skillName = {
    "百毒不侵","悬梁刺股","镜盾反射","众人皆醉","乱中有序","永生难忘","生命脉动","魔力共鸣","防御壁垒","迅捷疾风","致命打击","心灵之眼","生命不息","致命绽放","混沌波动","永恒之壁"
}
local skillDesc = {
    "抗毒增加","抗睡增加","抗石增加","抗醉增加","抗混乱增加","抗遗忘增加","生命增加","魔力增加","防御增加","敏捷增加","攻击增加","精神增加","回复增加","伤害增加","伤害增加","受到伤害减少"
}
local skillVal = {
    30, 30, 30, 30, 30, 30, 5, 5, 5, 5, 5, 5, 5, 5, 10, 5
}

local function initTalentSelect()
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
    initTalentSelect()
    for i = 0, 3 do
        local item = itemInfo[tostring(i)]
        showItem(talentWnd, "item" .. (i + 1), item["img"], item["need"], item["num"])
    end
    if nil == select1 then
        talentWnd:getWidget("petName"):setText("无可选择宠物")
        talentWnd:getWidget("pet"):setImg(0)
        talentWnd:getWidget("talent"):setText("")
        talentWnd:getWidget("desc"):setText("")
        for i = 1, 4 do
            talentWnd:getWidget("confirm" .. i):setEnabled(false)
        end
        return
    end
    local pet = petInfo[tostring(select1)]
    local skillId = pet["talent"]
    local index = skillId - 30400
    local level = math.floor(index / 30) + 1
    index = math.fmod(index, 30)
    talentWnd:getWidget("petName"):setText(pet["name"])
    talentWnd:getWidget("pet"):setImg(pet["img"])
    if 0 == index then
        talentWnd:getWidget("talent"):setText("天赋技能")
        talentWnd:getWidget("desc"):setText("待领悟领悟技能")
        local item = itemInfo["1"]
        if item["num"] >= item["need"] then
            talentWnd:getWidget("confirm" .. 1):setEnabled(true)
        end
        talentWnd:getWidget("confirm" .. 2):setEnabled(false)
        talentWnd:getWidget("confirm" .. 3):setEnabled(false)
        talentWnd:getWidget("confirm" .. 4):setEnabled(false)
    else
        talentWnd:getWidget("talent"):setText(skillName[index]  .. "Lv" .. level)
        if index >= 1 and index <= 6 then
            talentWnd:getWidget("desc"):setText(skillDesc[index] .. skillVal[index] * level .. "点")
        elseif index == 15 then
            talentWnd:getWidget("desc"):setText(skillDesc[index] .. "0% - " .. skillVal[index] * level .. "%")
        elseif index >= 7 and index <= 13 then
            talentWnd:getWidget("desc"):setText(skillDesc[index] .. skillVal[index] * level .. "%")
        end

        talentWnd:getWidget("confirm" .. 1):setEnabled(false)
        for i = 2, 4 do
            local item = itemInfo[tostring(i - 1)]
            if item["num"] >= item["need"] then
                talentWnd:getWidget("confirm" .. i):setEnabled(true)
            end
        end
    end
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
    initTalentSelect()
    select1 = select1 + 1
    showTalentInfo()
end

function initTalentContent()
    logPrint("initTalentContent")
    select1 = nil
    for i = 1, 5 do
        if petInfo[tostring(i)] ~= nil then
            petNum1 = i
        end
    end
    if petNum1 >= 1 then
        select1 = 1
    end
    initTalentSelect()
    showTalentInfo()
end

function flushTalentInfo(info)
    logPrintTbl(info)
    petInfo = info["pet"]
    itemInfo = info["item"]
    for i = 1, 5 do
        if petInfo[tostring(i)] ~= nil then
            petNum1 = i
        end
    end
    if select1 > petNum1 then
        select1 = 1
    end
    showTalentInfo()
end

local function loadTalentClient()
    local client = {
        {
            ["type"] = "bg",
            ["img"] = "bg.bmp",
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
            ["type"] = "lab",
            ["title"] = "title",
            ["x"] = 210,
            ["y"] = 35,
            ["text"] = "宠物天赋",
            ["font"] = 10,
            ["font"] = 3,
        },
        {
            ["type"] = "lab",
            ["title"] = "petName",
            ["x"] = 94,
            ["y"] = 73,
            ["text"] = "无可选择宠物",
        },
        {
            ["type"] = "btn",
            ["title"] = "prev",
            ["x"] = 67,
            ["y"] = 70,
            ["img"] = "prev1.bmp",
            ["active"] = "prev2.bmp",
            ["disable"] = "prev3.bmp",
            ["click"] = "talentPrev",
        },
        {
            ["type"] = "btn",
            ["title"] = "next",
            ["x"] = 197,
            ["y"] = 70,
            ["img"] = "next1.bmp",
            ["active"] = "next2.bmp",
            ["disable"] = "next3.bmp",
            ["click"] = "talentNext",
        },
        {
            ["type"] = "img",
            ["title"] = "zF",
            ["x"] = 80,
            ["y"] = 92,
            ["img"] = "k3.bmp",
        },
        {
            ["type"] = "ani",
            ["title"] = "pet",
            ["x"] = 0,
            ["y"] = 0,
            ["img"] = 0,
            ["bg"] = "zF",
        },
        {
            ["type"] = "lab",
            ["title"] = "t1",
            ["x"] = 95,
            ["y"] = 265,
            ["text"] = "天赋:",
        },
        {
            ["type"] = "lab",
            ["title"] = "talent",
            ["x"] = 125,
            ["y"] = 265,
            ["text"] = "天赋技能",
            ["color"] = 2,
        },
        {
            ["type"] = "lab",
            ["title"] = "desc",
            ["x"] = 90,
            ["y"] = 280,
            ["text"] = "待领悟天赋属性",
            ["color"] = 4,
        },
        {
            ["table"] = "2,2",
            ["width"] = 100,
            ["high"] = 93,
            ["type"] = "img",
            ["title"] = "item&F",
            ["x"] = 226,
            ["y"] = 108,
            ["img"] = 244284,
        },
        {
            ["table"] = "2,2",
            ["width"] = 100,
            ["high"] = 93,
            ["type"] = "btn",
            ["title"] = "confirm&",
            ["x"] = 288,
            ["y"] = 120,
            ["img"] = "y1.bmp",
            ["active"] = "y2.bmp",
            ["disable"] = "y3.bmp",
            ["text"] = "#talentBtnText",
        }
    }

    talentWnd = createWindow(1021, "talent", client)
    addItem(talentWnd, "item1")
    addItem(talentWnd, "item2")
    addItem(talentWnd, "item3")
    addItem(talentWnd, "item4")

    for i = 1, 4 do
        talentWnd:getWidget("confirm" .. i):clicked(function(widget)
            if nil ~= select1 then
                Cli.Send("get_talent|" .. petInfo[tostring(select1)]["uuid"] .. "," .. (i - 1))
            end
        end)
    end
    logPrint("loadTalentClient111")
end

function showTalent(info)
    logPrintTbl(info)
    petInfo = info["pet"]
    itemInfo = info["item"]
    if (talentWnd == nil) then
        loadTalentClient()
    end

    logPrint( 'showTalent1')
    talentWnd:show()
    safeCall(initTalentContent)
    logPrint( 'showTalent2')
end

Cli.Send().wait["FLUSH_TALENT"] = flushTalentInfo
Cli.Send().wait["SHOW_TALENT"] = showTalent
Cli.Send().wait["TALENT_CLIENT"] = loadTalentClient
