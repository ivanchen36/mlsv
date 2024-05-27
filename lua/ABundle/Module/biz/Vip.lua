local vipInfo = {}
local vipClient = nil
local vipExp = {120, 1020, 3360, 6720, 13880, 23880, 33600, 67200, 201600}

local titles = {"会员经验值", "幸运值", "驱魔时间", "远程银行", "天降", "传送"}
local ops = {"领取",  "", "开启", "开启", "开启", "开启"}

local menuPosX = 100
local menuPosY = 50

local startImg = "green.bmp"
local stopImg = "red.bmp"
local disImg = "gray.bmp"
local defImg = "vip0.bmp"
local view1 = nil

function collectVip(object, event)
    if event ~= 1 then
        return
    end

    Cli.Send("collectvip").wait["FLUSH_VIP"] = function(info)
        vipInfo = info
        initVipContent(object.mainview)
    end
end

function openAvoid(object, event)
    if event ~= 1 then
        return
    end
    if vipInfo["avoidFlag"] == 1 then
        Cli.Send("closeavoid")
    else
        Cli.Send("openavoid")
    end
end

function openBank(object, event)
    if event ~= 1 then
        return
    end

    Cli.Send("openbank")
end

function godGift(object, event)
    if event ~= 1 then
        return
    end

    Cli.Send("godgift")
end

function vipWarp(object, event)
    if event ~= 1 then
        return
    end

    Cli.Send("vipwarp")
end

local events = {nil, collectVip, nil, openAvoid, openBank, godGift, vipWarp}

function initVipFrame(view)
    for i=1,#titles do
        -- 摆放锁按钮
        view.add(new.textbox("title".. i));
        view.add(new.textbox("value".. i));
        if ops[i] ~= "" then
            view.add(new.bmpbutton("op".. i, disImg));
            view.add(new.textbox("opT".. i));
        end
    end

    view.add(new.bmpbutton("vip", defImg));
    initBaseFrame(view,"vip")
end

function showExp(level, text, op, opT)
    text.text = vipInfo["exp"] .. " / " .. vipExp[level + 1];

    if isToday(vipInfo["lastTime"]) then
        op.event = nil;
        return
    end
    op.id = startImg

end

function showAvoid(level, text, op, opT)
    if vipInfo["avoidFlag"] == 1 then
        text.text = "驱魔剩余时间 " .. (vipInfo["avoid"] + os.Time() - vipInfo["avoidTime"]) .. "秒";
    else
        text.text = "驱魔剩余时间 " .. (vipInfo["avoid"]) .. "秒";
    end

    if vipInfo["avoid"] <= 0 then
        op.event = nil;
        return
    end

    if vipInfo["avoidFlag"] == 1 then
        op.id = stopImg
        opT.text = "关闭"
    else
        op.id = startImg
        opT.text = "开启"
    end
end

function showBank(level, text, op, opT)
    if vipInfo["bank"] ~= 1 then
        text.text = "暂无权限"
        op.event = nil;
        return
    end

    op.id = startImg
    opT.text = "开启"
end

function showGift(level, text, op, opT)
    if level <= 7 then
        text.text = "暂无权限"
        op.event = nil;
        return
    end

    if vipInfo["gift"] ~= 1 then
        text.text = "本周已使用"
        op.event = nil;
        return
    end

    op.id = startImg
    opT.text = "开启"
end

function showWarp(level, text, op, opT)
    if vipInfo["warp"] ~= 1 then
        text.text = "暂无权限"
        op.event = nil;
        return
    end

    op.id = startImg
    opT.text = "开启"
end

local showEvents = {showExp, nil, showAvoid, showBank, showGift, showWarp}

function initVipContent(view)
    local level = vipInfo["level"]
    local vip = view.find("vip");
    vip.enable = 1;
    vip.xpos = 548;
    vip.ypos = 8;
    vip.id = "vip" .. level .. ".bmp"

    for i=1, #titles do

        local posX = menuPosX + (i - 1) * 60
        local posY = menuPosY + (i - 1) * 60
        local title = view.find("title".. i);
        local value = view.find("value".. i);

        title.enable = 1;
        title.xpos = posX;
        title.ypos = posY;
        title.text = titles[i];

        value.enable = 1;
        value.xpos = posX + 20;
        value.ypos = posY;

        if ops[i] ~= "" then
            local op = view.find("op".. i);
            local opT = view.find("opT".. i);
            op.enable = 1;
            op.xpos = posX + 40;
            op.ypos = posY;
            op.event = events[i];

            opT.enable = 1;
            opT.xpos = posX + 40;
            opT.ypos = posY;
            opT.text = ops[i];

            local func = showEvents[i]
            if nil ~= func then
                func(level, value, op, opT)
            end
        end
    end
    setBaseFrame(view)
end
local lastEvent = -1
function initVipUi(view)
    Cli.SysMessage("initVipUi",4,3);
    local biz = "vip"

    if view.IsInit then
        print("initVipUi1 " .. tostring(view))
        initVipFrame(view)
        return 1
    end

    view1 = view
    print("initVipUi2 " .. tostring(view1))
    initVipContent(view)
    view.sizex = 504;
    view.sizey = 327;
    for key1, value1 in pairs(view) do
        tmp = tmp .. " |  " .. key1 .. ":" .. tostring(value1)
    end
    if (view1.type ~= nil) then
        print("e   " .. tostring(view1.type))
    else
        print("e nil")
    end

    Cli.SysMessage( 'init finish' ,4,3)
    return 1
end

function flushVipInfo(info)
    Cli.SysMessage("flushVipInfo",4,3);
    vipInfo = info;
end

function loadVipClient(client)
    print('loadVipClient')
    vipClient = client
end

function showVip(info)
    Cli.Send("vip_client").wait["VIP_CLIENT"] = loadVipClient
    Cli.SysMessage( 'showVip1' ,4,3)
    vipInfo = info;
    printTbl(vipClient)
    vipWnd = createWindow("vip", vipClient)
    vipWnd:show()
    Cli.SysMessage( 'showVip2' ,4,3)
end

Cli.Send().wait["VIP_CLIENT"] = loadVipClient
Cli.Send().wait["UPDATE_VIP"] = flushVipInfo
Cli.Send().wait["SHOW_VIP"] = showVip
Cli.Send("vip_client")