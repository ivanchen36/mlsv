proficientInfo = {}
local races = {"����ϵ", "��ϵ", "����ϵ", "����ϵ", "����ϵ", "ֲ��ϵ", "Ұ��ϵ", "����ϵ", "����ϵ", "аħϵ"}
local proficientKill = { 99, 399, 999, 2999}

local menuPosX = 111
local menuPosY = 111

local startImg = chx.Uwait("green.bmp")
local fightImg = chx.Uwait("red.bmp")
local disImg = chx.Uwait("gray.bmp")

function upProficient(object, event)
    if event ~= 1 then
        return
    end
    Cli.Send("upproficient|" .. object._select1[0])
end

function initProficientFrame(view)
    initBaseFrame(view,"proficient")
    for i=1,#races do
        -- �ڷ�����ť
        view.add(new.textbox("title".. i));
        view.add(new.textbox("value".. i));
        view.add(new.bmpbutton("op".. i, disImg));
        local opT = new.textbox("opT".. i)
        opT.text = "����"
        view.add(opT);
        view.add(new.bmpbutton("fight".. i, fightImg));
        local fightT = new.textbox("fightT".. i)
        fightT.text = "��ս�ؾ�"
        view.add(new.textbox("fightT".. i));
    end
end

function initPkContent(view)
    setBaseFrame(view)

    for i=1, #races do
        local posX = menuPosX + (i - 1) * 60
        local posY = menuPosY+ (i - 1) * 60
        local title = view.find("title".. i);
        local value = view.find("value".. i);

        title.enable = 1;
        title.xpos = posX;
        title.ypos = posY;
        title.text = races[i] .. "ר��:";

        local arr = strSplit(proficientInfo[i], "|")
        local level = arr[1]
        local kill = arr[2]

        value.enable = 1;
        value.xpos = posX + 20;
        value.ypos = posY;
        value.text = "�ȼ�" .. level .. "  ����ϵ�����ս�غ�:" .. kill  .. "/" .. proficientKill[level + 1];

        local op = view.find("op".. i);
        op.enable = 1;
        op.xpos = posX + 40;
        op.ypos = posY;
        op._select1[0] = i
        if kill >= proficientKill[level + 1] then
            op.id = startImg
            op.event = upProficient
        else
            op.event = nil
        end
        
    end
end

function initProficientUi(view)
    if not view.IsInit then
        initProficientFrame(view)
        return
    end
    initVipContent(view)
end

function flushVipInfo(info)
    vipInfo = info;
end

function showVipFrame(info)
    new.ShowView(902, initProficientUi)
end

Cli.Send().wait["FLUSH_VIP"] = flushVipInfo
Cli.Send().wait["SHOW_VIP"] = showVipFrame