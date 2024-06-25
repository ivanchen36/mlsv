
vipTitle = {"value", "", "damage", "luck", "exp", "avoid", "bank", "gift"}
vipTitleVal = {"会员经验:", "", "增伤减伤:", "幸运值数:", "经验加成:", "驱魔时间:", "远程银行:", "天降礼包:"}
vipTextVal = {"", "", "", "", "", "", "VIP7可使用", "VIP8可使用"}
vipBtn = {"valueBtn", "", "", "", "expBtn", "avoidBtn", "bankBtn", "giftBtn"}
vipBtnText = {"领取", "", "", "", "开启", "开启", "开启", "开启"}

local vipWnd = nil
local vipInfo = {}
local vipExp = {120, 1020, 3360, 6720, 13880, 23880, 33600, 67200, 201600}

function collectVip(widget)
    Cli.Send("collect_vip")
    widget:setEnabled(false)
end

function openAvoid(widget)
    widget:setEnabled(false)
    if vipInfo["avoidFlag"] == 1 then
        Cli.Send("close_avoid")
    else
        Cli.Send("open_avoid")
    end
end

function openBank(widget)
    Cli.Send("open_bank")
end

function godGift(widget)
    widget:setEnabled(false)
    Cli.Send("god_gift")
end

function vipWarp(widget)
    Cli.Send("vip_warp")
end

function upGift(widget)
    widget:setEnabled(false)
    Cli.Send("up_gift")
end

function addExp(widget)
    widget:setEnabled(false)
    Cli.Send("open_exp")
end

function upVip(widget)
    widget:setEnabled(false)
    Cli.Send("up_vip")
end

vipEvents = {collectVip, nil, nil, nil, addExp, openAvoid, openBank, godGift}

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
        local tmp = vipInfo["avoid"] - os.time() + vipInfo["avoidTime"]
        if tmp <= 0 then
            tmp = 0
        end
        text:setText("剩余时间 " .. tmp .. "秒")
    else
        text:setText("剩余时间 " .. vipInfo["avoid"] .. "秒")
    end

    if vipInfo["avoid"] <= 0 then
        op:setEnabled(false)
        op:setText("开启")
        return
    end

    op:setEnabled(true)
    if vipInfo["avoidFlag"] == 1 then
        op:setText("关闭")
    else
        op:setText("开启")
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
        text:setText("本周已使用")
        op:setEnabled(false)
        return
    end

    op:setEnabled(true)
end

function showWarp(level, text, op)
    if vipInfo["warp"] ~= 1 then
        text:setText("暂无权限")
        op:setEnabled(false)
        return
    end

    op:setEnabled(true)
    op:setText("开启")
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

local showEvents = {showExp, nil, showDamage, showLuck, showAddExp, showAvoid, showBank, showGift}

function initVipContent()
    local level = vipInfo["level"]
    local vip = vipWnd:getWidget("aLevel")
    local upVip = vipWnd:getWidget("upVip");
    local upGift = vipWnd:getWidget("upGift");

    vip:setImg("vip" .. level .. ".bmp")
    for i=1, #vipTitle do
        if vipTitleVal[i] ~= "" then
            local op = nil
            local text = vipWnd:getWidget(vipTitle[i] .. "Text");

            if vipBtnText[i] ~= "" then
                op = vipWnd:getWidget(vipBtn[i])
            end
            local func = showEvents[i]
            if nil ~= func then
                func(level, text, op)
            end
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
    vipWnd = createWindow("vip", client)
end

function showVip(info)
    if (vipWnd == nil) then
        Cli.Send("vip_client")
        Cli.SysMessage("[系统提示] VIP功能正在加载中，请稍后！",4,3)
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
Cli.Send().wait["FLUSH_VIP"] = flushVipInfo
Cli.Send().wait["SHOW_VIP"] = showVip
Cli.Send().wait["SEND_TAX"] = sendTax
Cli.Send("vip_client")
