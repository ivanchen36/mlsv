local proficientInfo = {}
local raceTitle = {"race1", "race2", "race3", "race4", "race5", "race6", "race7", "race8", "race9", "race10"}
local raceTitleVal = {"����ϵ", "��ϵ", "����ϵ", "����ϵ", "����ϵ", "ֲ��ϵ", "Ұ��ϵ", "����ϵ", "����ϵ", "аħϵ"}

local proficientKill = { 99, 399, 999, 2999}
local proficientWnd = nil

function initProficientContent()
    for i=1, #raceTitle do
        local infoArr = strSplit(proficientInfo[i], "|")
        local raceLevel = tonumber(infoArr[1])
        local raceNum = tonumber(infoArr[2])
        local level = proficientWnd:getWidget(raceTitle[i] .. "Level");
        local info = proficientWnd:getWidget(raceTitle[i] .. "Info");
        local up = proficientWnd:getWidget(raceTitle[i] .. "Up");
        local challenge = proficientWnd:getWidget(raceTitle[i] .. "Challenge");

        level:setText("�ȼ�" .. infoArr[1])
        info:setText(raceTitleVal[i] .. "�����ս�غ�:" .. infoArr[2] .. "/" .. proficientKill[raceLevel + 1])

        if raceNum >= proficientKill[raceLevel + 1] then
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
    proficientWnd = createWindow("proficient", client)
end

function showProficient(info)
    if (proficientWnd == nil) then
        Cli.Send("proficient_client")
        Cli.SysMessage("[ϵͳ��ʾ] ����ר���������ڼ����У����Ժ�",4,3)
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