raceTitle = {"race1", "race2", "race3", "race4", "race5", "race6", "race7", "race8", "race9", "race10"}
raceTitleVal = {"人形系", "龙系", "不死系", "飞行系", "昆虫系", "植物系", "野兽系", "特殊系", "金属系", "邪魔系"}

local proficientInfo = nil
local proficientKill = { 99, 399, 999, 2999}
local proficientWnd = nil

function initProficientContent()
    for i, info in pairs(proficientInfo) do
        local infoArr = strSplit(info, "|")
        local raceLevel = tonumber(infoArr[1])
        local nextLevel = raceLevel + 1
        local raceNum = tonumber(infoArr[2])
        local level = proficientWnd:getWidget(raceTitle[i] .. "Level");
        local info = proficientWnd:getWidget(raceTitle[i] .. "Info");
        local up = proficientWnd:getWidget(raceTitle[i] .. "Up");
        local challenge = proficientWnd:getWidget(raceTitle[i] .. "Challenge");

        if nextLevel > 4 then
            nextLevel = 4
            info:setText("参战回合:" .. infoArr[2] .. "/" .. proficientKill[nextLevel])
        else
            info:setText("参战回合:" .. infoArr[2] .. "/--")
        end
        level:setText("等级" .. infoArr[1])
        info:setText("参战回合:" .. infoArr[2] .. "/" .. proficientKill[nextLevel])

        if raceLevel < 4 and raceNum >= proficientKill[nextLevel] then
            up:setEnabled(true)
            up:clicked(function(widget)
                Cli.Send("up_proficient|" .. i)
            end)
        else
            up:setEnabled(false)
        end

        if raceLevel >= 3 then
            challenge:setEnabled(true)
            challenge:clicked(function(widget)
                Cli.Send("race_challenge|" .. i)
            end)
        else
            challenge:setEnabled(false)
        end
    end
end

function flushProficientInfo(info)
    proficientInfo = info;
    initProficientContent()
end

local function loadProficientClient()
    local client = {
        {
            ["type"] = "bg",
            ["img"] = "proficient.bmp",
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
            ["table"] = "9,1",
            ["high"] = 25,
            ["type"] = "img",
            ["title"] = "#raceTitle$line",
            ["x"] = 106,
            ["y"] = 82,
            ["img"] = "line.bmp",
        },
        {
            ["table"] = "0,1",
            ["high"] = 25,
            ["type"] = "lab",
            ["title"] = "#raceTitle$Z",
            ["x"] = 80,
            ["y"] = 62,
            ["text"] = "#raceTitleVal$:",
        },
        {
            ["table"] = "0,1",
            ["high"] = 25,
            ["type"] = "img",
            ["title"] = "#raceTitle$L",
            ["x"] = 70,
            ["y"] = 57,
            ["img"] = "lab.bmp",
        },
        {
            ["table"] = "0,1",
            ["high"] = 25,
            ["type"] = "lab",
            ["title"] = "#raceTitle$Level",
            ["x"] = 145,
            ["y"] = 62,
            ["text"] = "等级1",
        },
        {
            ["table"] = "0,1",
            ["high"] = 25,
            ["type"] = "img",
            ["title"] = "#raceTitle$a",
            ["x"] = 137,
            ["y"] = 59,
            ["img"] = "lab1.bmp",
        },
        {
            ["table"] = "0,1",
            ["high"] = 25,
            ["type"] = "lab",
            ["title"] = "#raceTitle$Info",
            ["x"] = 185,
            ["y"] = 62,
            ["text"] = "--",
        },
        {
            ["table"] = "0,1",
            ["high"] = 25,
            ["type"] = "btn",
            ["title"] = "#raceTitle$Up",
            ["x"] = 325,
            ["y"] = 59,
            ["img"] = "b1.bmp",
            ["active"] = "b2.bmp",
            ["disable"] = "b3.bmp",
            ["text"] = "升级",
            ["click"] = "upProficient",
        },
        {
            ["table"] = "0,1",
            ["high"] = 25,
            ["type"] = "btn",
            ["title"] = "#raceTitle$Challenge",
            ["x"] = 379,
            ["y"] = 59,
            ["img"] = "b1.bmp",
            ["active"] = "b2.bmp",
            ["disable"] = "b3.bmp",
            ["text"] = "挑战",
            ["click"] = "raceChallenge",
        }
    }
    proficientWnd = createWindow(1005, "proficient", client)
end

function showProficient(info)
    proficientInfo = info;
    if (proficientWnd == nil) then
        loadProficientClient()
    end

    proficientWnd:show()
    initProficientContent()
end

Cli.Send().wait["FLUSH_PROFICIENT"] = flushProficientInfo
Cli.Send().wait["SHOW_PROFICIENT"] = showProficient
