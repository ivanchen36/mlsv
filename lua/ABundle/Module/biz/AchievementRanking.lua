proficientInfo = {}
local raceTitle = {"race1", "race2", "race3", "race4", "race5", "race6", "race7", "race8", "race9", "race10"}
local raceTitleVal = {"人形系专精:", "龙系专精:", "不死系专精:", "飞行系专精:", "昆虫系专精:", "植物系专精:", "野兽系专精:", "特殊系专精:", "金属系专精:", "邪魔系专精:"}
local raceLevel = {"rece1Lever", "rece2Lever", "rece3Lever", "rece4Lever", "rece5Lever", "rece6Lever", "rece7Lever", "rece8Lever", "rece9Lever", "rece10Lever"}
local raceInfo = {"race1Info", "race2Info", "race3Info", "race4Info", "race5Info", "race6Info", "race7Info", "race8Info", "race9Info", "race10Info"}
local raceUp = {"rece1Up", "rece2Up", "rece3Up", "rece4Up", "rece5Up", "rece6Up", "rece7Up", "rece8Up", "rece9Up", "rece10Up"}
local raceChallenge = {"rece1Challenge", "rece2Challenge", "rece3Challenge", "rece4Challenge", "rece5Challenge", "rece6Challenge", "rece7Challenge", "rece8Challenge", "rece9Challenge", "rece10Challenge"}

local proficientKill = { 99, 399, 999, 2999}
local proficientWnd = nil
local proficientClient = nil
local proficientWnd = nil

function upProficient(widget)
    if event ~= 1 then
        return
    end
    Cli.Send("up_proficient|" .. race)
end

function raceChallenge(widget)
    if event ~= 1 then
        return
    end
    Cli.Send("race_challenge|" .. race)
end

function initProficientContent()
    local level = ProficientInfo["level"]
    local Proficient = ProficientWnd:getWidget("level")
    local upProficient = ProficientWnd:getWidget("upProficient");
    local upGift = ProficientWnd:getWidget("upGift");

    Proficient:setImg("Proficient" .. level .. ".bmp")
    for i=1, #ProficientTitle do
        local op = nil
        local text = ProficientWnd:getWidget(ProficientText[i]);

        if ProficientBtnText[i] ~= "" then
            op = ProficientWnd:getWidget(ProficientBtn[i])
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
    if ProficientInfo["exp"] >= ProficientExp[nextLevel] and level < 9 then
        upProficient:setEnabled(true)
    else
        upProficient:setEnabled(false)
    end
    if ProficientInfo["upGift"] == 1 then
        upGift:setEnabled(true)
    else
        upGift:setEnabled(false)
    end
end

function flushProficientInfo(info)
    logPrintTbl(info)
    ProficientInfo = info;
    initProficientContent()
end

function loadProficientClient(client)
    logPrint("loadProficientClient")
    logPrintTbl(client)
    proficientClient = client
    proficientWnd = createWindow("proficient", proficientClient)
end

function showProficient(info)
    if (proficientWnd == nil) then
        Cli.Send("proficient_client")
        Cli.SysMessage("[系统提示] 种族专精功能正在加载中，请稍后！",4,3)
        return
    end
    logPrint( 'showProficient1')
    logPrintTbl(info)
    proficientInfo = info;
    proficientWnd:show()
    initProficientContent()
    logPrint( 'showProficient2')
end

Cli.Send().wait["FLUSH_PROFICIENT"] = flushProficientInfo
Cli.Send().wait["SHOW_PROFICIENT"] = showProficient
Cli.Send().wait["PROFICIENT_CLIENT"] = loadProficientClient
Cli.Send("proficient_client")