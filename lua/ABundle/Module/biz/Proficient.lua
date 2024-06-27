raceTitle = {"race1", "race2", "race3", "race4", "race5", "race6", "race7", "race8", "race9", "race10"}
raceTitleVal = {"����ϵ", "��ϵ", "����ϵ", "����ϵ", "����ϵ", "ֲ��ϵ", "Ұ��ϵ", "����ϵ", "����ϵ", "аħϵ"}

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
            info:setText("��ս�غ�:" .. infoArr[2] .. "/" .. proficientKill[nextLevel])
        else
            info:setText("��ս�غ�:" .. infoArr[2] .. "/--")
        end
        level:setText("�ȼ�" .. infoArr[1])
        info:setText("��ս�غ�:" .. infoArr[2] .. "/" .. proficientKill[nextLevel])

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
    logPrintTbl(info)
    proficientInfo = info;
    initProficientContent()
end

function loadProficientClient(client)
    logPrint("loadProficientClient")
    logPrintTbl(client)

    local needShow = false
    if nil == proficientWnd and nil ~= proficientInfo then
        needShow = true
    end
    proficientWnd = createWindow("proficient", client)
    if needShow then
        showProficient(proficientInfo)
    end
end

function showProficient(info)
    proficientInfo = info;
    if (proficientWnd == nil) then
        Cli.Send("proficient_client")
        return
    end

    logPrint( 'showProficient1')
    logPrintTbl(info)
    proficientWnd:show()
    initProficientContent()
    logPrint( 'showProficient2')
end

Cli.Send().wait["FLUSH_PROFICIENT"] = flushProficientInfo
Cli.Send().wait["SHOW_PROFICIENT"] = showProficient
Cli.Send().wait["PROFICIENT_CLIENT"] = loadProficientClient
