
vipTitle = {"value", "exp", "avoid", "bank", "gift", "warp", "luck"}
vipTitleVal = {"会员经验:", "经验加成:", "驱魔时间:", "远程银行:", "天降礼包:", "会员传送:", "幸运值数:"}
vipText = {"valueText", "expText", "avoidText", "bankText", "giftText", "warpText", "luckText"}
vipTextVal = {"", "", "", "VIP7开启", "VIP8开启", "VIP9开启", ""}
vipBtn = {"valueBtn", "expBtn", "avoidBtn", "bankBtn", "giftBtn", "warpBtn", ""}
vipBtnText = {"领取", "开启", "开启", "开启", "开启", "开启", ""}

local vipWnd = nil
local vipInfo = {}
local vipClient = nil
local vipExp = {120, 1020, 3360, 6720, 13880, 23880, 33600, 67200, 201600}
local ops = {"领取",  "", "开启", "开启", "开启", "开启"}

function collectVip(widget)
    Cli.Send("collect_vip").wait["FLUSH_VIP"] = function(info)
        vipInfo = info
        initVipContent()
    end
end

function openAvoid(widget)
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
    Cli.Send("god_gift")
end

function vipWarp(widget)
    Cli.Send("vip_warp")
end

function upGift(widget)
    Cli.Send("up_gift")
end

vipEvents = {collectVip, nil, openAvoid, openBank, godGift, vipWarp}

function showExp(level, text, op)
    text:setText(vipInfo["exp"] .. " / " .. vipExp[level + 1])

    if isToday(vipInfo["lastTime"]) then
        op:setEnabled(false)
        return
    end
    op:setEnabled(true)
end

function showAvoid(level, text, op)
    if vipInfo["avoidFlag"] == 1 then
        text:setText("驱魔时间 " .. (vipInfo["avoid"] + os.Time() - vipInfo["avoidTime"]) .. "秒")
    else
        text:setText("驱魔时间 " .. (vipInfo["avoid"]) .. "秒")
    end

    if vipInfo["avoid"] <= 0 then
        op:setEnabled(false)
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
        text:setText("暂无权限")
        op:setEnabled(false)
        return
    end

    op:setEnabled(true)
    op:setText("开启")
end

function showGift(level, text, op)
    if level <= 7 then
        text:setText("暂无权限")
        op:setEnabled(false)
        return
    end

    if vipInfo["gift"] ~= 1 then
        text:setText("本周已使用")
        op:setEnabled(false)
        return
    end

    op:setEnabled(true)
    op:setText("开启")
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

function showExp(level, text, op)
    text:setText("+" .. vipInfo["level"] * 10 .. "%")
    if vipInfo["level"] == 1 then
        op:setEnabled(false)
        return
    end

    op:setEnabled(true)
end

local showEvents = {showExp, showExp, showAvoid, showBank, showGift, showWarp, nil}

function initVipContent()
    local level = vipInfo["level"]
    local vip = vipWnd:getWidget("level")
    local upGift = vipWnd:getWidget("upGift");

    vip:setImg("vip" .. level .. ".bmp")
    for i=1, #vipTitle do
        local op = nil
        local text = vipWnd:getWidget(vipText[i]);

        if ops[i] ~= "" then
            op = vipWnd:getWidget(vipBtn[i])
        end
        local func = showEvents[i]
        if nil ~= func then
            func(level, text, op)
        end
    end
    if vipInfo["upGift"] == 1 then
        upGift:setEnabled(true)
    else
        upGift:setEnabled(false)
    end
end

function flushVipInfo(info)
    vipInfo = info;
    initVipContent()
end

function loadVipClient(client)
    print("loadVipClient")
    printTbl(client)
    vipClient = client
    vipWnd = createWindow("vip", vipClient)
end
function showVip1(info)
    print( 'showVip1')
    vipInfo = info;
    vipWnd:show()
    initVipContent()
    print( 'showVip2')
end

function showVip(info)
    try(function()
        showVip1(info)  -- 尝试执行可能会出错的函数
    end, catch)
end


Cli.Send().wait["VIP_CLIENT"] = loadVipClient
Cli.Send().wait["UPDATE_VIP"] = flushVipInfo
Cli.Send().wait["SHOW_VIP"] = showVip
Cli.Send("vip_client")