local bossInfo = nil
local bossWnd = nil
bossAttr = {"hp", "mp", "atk", "spirit", "def", "recover", "agi"}
local bossAttrText = {"生命:", "魔力:", "攻击:", "精神:", "防御:", "恢复:", "敏捷:"}
local levelDesc ={
    {"普通", "1倍属性"},
    {"困难", "1.5倍属性"},
    {"噩梦", "2倍属性"},
}

function challenge(widget)
    if "confirm" == widget:getTitle() then
        if bossInfo["type"] == "jjc" then
            Cli.Send("challenge_boss|" .. bossWnd:getWidget("challengeLevel"):getValue() .. "," .. bossInfo["id"])
        else
            Cli.Send("challenge_boss|1" .. "," .. bossInfo["id"])
        end
    end
    bossWnd:close()
end

local function initBossContent()
    local titleText = "挑战" .. bossInfo["boss"]
    local len = math.ceil(string.len(titleText) / 4 * 20)
    local title = bossWnd:getWidget("title");
    title:setPos(253 - len, 36);
    title:setText(titleText);
    bossWnd:getWidget("pet"):setImg(bossInfo["img"])

    bossWnd:getWidget("name"):setText("尊敬的勇者 " .. bossInfo["name"] .. ":");
    bossWnd:getWidget("amount"):setText("您确定要挑战吗? 需要花费".. bossInfo["amount"] .. "魔币")
    local tip = "请参考挑战boss属性选择难度,加油"
    if bossInfo["type"] ~= "jjc" then
        tip = "请参考挑战boss属性选择,加油"
        bossWnd:getWidget("challengeLevel"):setVisible(false)
    end
    bossWnd:getWidget("tip"):setText(tip)

    bossWnd:getWidget("level"):setText("等级: Lv" .. (bossInfo["level"]));
    for _, attr in pairs(bossAttr) do
        bossWnd:getWidget(attr .. "Val"):setText(bossInfo[attr]);
    end
end

local function showChallengeLevel(w)
    local level = tonumber(w:getValue())
    local desc = levelDesc[level]
    bossWnd:getWidget("levelName"):setText(desc[1]);
    bossWnd:getWidget("add"):setText(desc[2]);
    for _, attr in pairs(bossAttr) do
        bossWnd:getWidget(attr .. "Val"):setText(tostring(math.floor(bossInfo[attr] * (level + 1) * 0.5)));
    end
end

local function loadBossClient()
    local client = {
        {
            ["type"] = "bg",
            ["img"] = "boss.bmp",
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
            ["x"] = 200,
            ["y"] = 40,
            ["text"] = "",
            ["font"] = 3,
        },
        {
            ["type"] = "lab",
            ["title"] = "levelName",
            ["x"] = 129,
            ["y"] = 80,
            ["text"] = "普通",
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
            ["title"] = "add",
            ["x"] = 121,
            ["y"] = 263,
            ["text"] = "1倍属性",
        },
        {
            ["type"] = "lab",
            ["title"] = "name",
            ["x"] = 220,
            ["y"] = 82,
            ["text"] = "",
        },
        {
            ["type"] = "lab",
            ["title"] = "amount",
            ["x"] = 233,
            ["y"] = 100,
            ["text"] = "",
        },
        {
            ["type"] = "lab",
            ["title"] = "tip",
            ["x"] = 233,
            ["y"] = 118,
            ["text"] = "",
        },
        {
            ["type"] = "lab",
            ["title"] = "level",
            ["x"] = 220,
            ["y"] = 136,
            ["text"] = "",
            ["color"] = 4,
        },
        {
            ["table"] = "0,2",
            ["width"] = 90,
            ["high"] = 18,
            ["type"] = "lab",
            ["title"] = "#bossAttr",
            ["x"] = 220,
            ["y"] = 154,
            ["text"] = "",
        },
        {
            ["table"] = "0,2",
            ["width"] = 90,
            ["high"] = 18,
            ["type"] = "lab",
            ["title"] = "#bossAttr$Val",
            ["x"] = 258,
            ["y"] = 154,
            ["text"] = "",
            ["color"] = 6,
        },
        {
            ["type"] = "radio",
            ["title"] = "challengeLevel",
            ["x"] = 220,
            ["y"] = 228,
            ["img1"] = 244258,
            ["img2"] = 244257,
            ["layout"] = "1,3",
            ["width"] = 70,
            ["high"] = 0,
            ["texts"] = "普通,困难,噩梦",
            ["values"] = "1,2,3",
        },
        {
            ["type"] = "btn",
            ["title"] = "confirm",
            ["x"] = 238,
            ["y"] = 258,
            ["img"] = "b1.bmp",
            ["active"] = "b2.bmp",
            ["disable"] = "b3.bmp",
            ["text"] = "确定",
            ["click"] = "challenge",
        },
        {
            ["type"] = "btn",
            ["title"] = "cancel",
            ["x"] = 339,
            ["y"] = 258,
            ["img"] = "b1.bmp",
            ["active"] = "b2.bmp",
            ["disable"] = "b3.bmp",
            ["text"] = "取消",
            ["click"] = "challenge",
        }
    }
    bossWnd = createWindow(1017, "boss", client)
    bossWnd:getWidget("challengeLevel"):changed(showChallengeLevel)
    for i, attr in pairs(bossAttr) do
        bossWnd:getWidget(attr):setText(bossAttrText[i])
    end
end

function showBoss(info)
    bossInfo = info;
    if (bossWnd == nil) then
        loadBossClient()
    end

    bossWnd:show()
    initBossContent()
end

Cli.Send().wait["SHOW_BOSS"] = showBoss
