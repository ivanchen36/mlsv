
vipTitle = {"value", "damage", "luck", "exp", "avoid", "bank", "gift"}
vipTitleVal = {"��Ա����:", "���˼���:", "����ֵ��:", "����ӳ�:", "��ħʱ��:", "Զ������:", "�콵���:"}
vipText = {"valueText", "damageText", "luckText", "expText", "avoidText", "bankText", "giftText"}
vipTextVal = {"", "", "", "", "", "VIP7��ʹ��", "VIP8��ʹ��"}
vipBtn = {"valueBtn", "", "", "expBtn", "avoidBtn", "bankBtn", "giftBtn"}
vipBtnText = {"��ȡ", "", "", "����", "����", "����", "����"}

local vipWnd = nil
local vipInfo = {}
local vipClient = nil
local vipExp = {120, 1020, 3360, 6720, 13880, 23880, 33600, 67200, 201600}

function collectVip(widget)
    Cli.Send("collect_vip").wait["FLUSH_VIP"] = function(info)
        vipInfo = info
        initVipContent()
    end
end

function openAvoid(widget)
    if vipInfo["avoidFlag"] == 1 then
        Cli.Send("close_avoid")
        op:setText("����")
    else
        Cli.Send("open_avoid")
        op:setText("�ر�")
    end
end

function openBank(widget)
    Cli.Send("open_bank")
end

function godGift(widget)
    Cli.Send("god_gift")
end

function vipWarp(widget)
    Cli.Send("vip_warp")
end

function upGift(widget)
    Cli.Send("up_gift")
end

function addExp(widget)
    Cli.Send("open_exp")
end

function upVip(widget)
    Cli.Send("up_vip")
end

function upGift(widget)
    Cli.Send("up_gift")
end

vipEvents = {collectVip, nil, nil, addExp, openAvoid, openBank, godGift}

function showExp(level, text, op)
    local nextLevel = level + 1
    if nextLevel > 9  then
        nextLevel = 9
    end
    text:setText(vipInfo["exp"] .. " / " .. vipExp[nextLevel])
    if isToday(vipInfo["lastTime"]) or level >= 9 then
        op:setEnabled(false)
        return
    end
    op:setEnabled(true)
end

function showAvoid(level, text, op)
    if vipInfo["avoidFlag"] == 1 then
        local tmp = vipInfo["avoid"] + os.Time() - vipInfo["avoidTime"]
        if tmp <= 0 then
            tmp = 0
        end
        text:setText("ʣ��ʱ�� " .. tmp .. "��")
    else
        text:setText("ʣ��ʱ�� " .. vipInfo["avoid"] .. "��")
    end

    if vipInfo["avoid"] <= 0 then
        op:setEnabled(false)
        return
    end

    op:setEnabled(true)
    if vipInfo["avoidFlag"] == 1 then
        op:setText("�ر�")
    else
        op:setText("����")
    end
end

function showBank(level, text, op)
    if vipInfo["bank"] ~= 1 then
        op:setEnabled(false)
        return
    end

    op:setEnabled(true)
end

function showGift(level, text, op)
    if level <= 7 then
        op:setEnabled(false)
        return
    end

    if vipInfo["gift"] ~= 1 then
        text:setText("������ʹ��")
        op:setEnabled(false)
        return
    end

    op:setEnabled(true)
end

function showWarp(level, text, op)
    if vipInfo["warp"] ~= 1 then
        text:setText("����Ȩ��")
        op:setEnabled(false)
        return
    end

    op:setEnabled(true)
    op:setText("����")
end

function showAddExp(level, text, op)
    text:setText("+" .. vipInfo["level"] * 10 .. "%")
    if vipInfo["addExp"] == 0 then
        op:setEnabled(false)
        return
    end
    op:setEnabled(true)
end

function showDamage(level, text, op)
    text:setText("+" .. vipInfo["level"] .. "%")
end

function showLuck(level, text, op)
    text:setText(tostring(vipInfo["luck"]))
end

local showEvents = {showExp, showDamage, showLuck, showAddExp, showAvoid, showBank, showGift}

function initVipContent()
    local level = vipInfo["level"]
    local vip = vipWnd:getWidget("level")
    local upVip = vipWnd:getWidget("upVip");
    local upGift = vipWnd:getWidget("upGift");

    vip:setImg("vip" .. level .. ".bmp")
    for i=1, #vipTitle do
        local op = nil
        local text = vipWnd:getWidget(vipText[i]);

        if vipBtnText[i] ~= "" then
            op = vipWnd:getWidget(vipBtn[i])
        end
        local func = showEvents[i]
        if nil ~= func then
            func(level, text, op)
        end
    end
    local nextLevel = level + 1
    if nextLevel > 9  then
        nextLevel = 9
    end
    if vipInfo["exp"] >= vipExp[nextLevel] and level < 9 then
        upVip:setEnabled(true)
    else
        upVip:setEnabled(false)
    end
    if vipInfo["upGift"] == 1 then
        upGift:setEnabled(true)
    else
        upGift:setEnabled(false)
    end
end

function flushVipInfo(info)
    logPrintTbl(info)
    vipInfo = info;
    initVipContent()
end

function loadVipClient(client)
    logPrint("loadVipClient")
    logPrintTbl(client)
    vipClient = client
    vipWnd = createWindow("vip", vipClient)
end

function showVip(info)
    if (vipWnd == nil) then
        Cli.Send("vip_client")
        Cli.SysMessage("[ϵͳ��ʾ] VIP�������ڼ����У����Ժ�",4,3)
        return
    end
    logPrint( 'showVip1')
    logPrintTbl(info)
    vipInfo = info;
    vipWnd:show()
    initVipContent()
    logPrint( 'showVip2')
end

function sendTax(param)
    Cli.Send("pay_tax")
end

Cli.Send().wait["VIP_CLIENT"] = loadVipClient
Cli.Send().wait["UPDATE_VIP"] = flushVipInfo
Cli.Send().wait["SHOW_VIP"] = showVip
Cli.Send().wait["SEND_TAX"] = sendTax
Cli.Send("vip_client")
