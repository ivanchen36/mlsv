synthesisInfo = {}

local pet1 = -1
local pet2 = -1
local petTitle = {"pet1", "pet2"}
local synthesisWnd = nil

function initSynthesisContent()
    local level = synthesisInfo["level"]
    for i=1, #raceTitle do
        local name = proficientWnd:getWidget(#raceTitle .. "Level");
        local level = proficientWnd:getWidget(#raceTitle .. "Level");
    end
end

function flushSynthesisInfo(info)
    logPrintTbl(info)
    synthesisInfo = info;
    initSynthesisContent()
end

function loadSynthesisClient(client)
    logPrint("loadSynthesisClient")
    logPrintTbl(client)
    synthesisWnd = createWindow("synthesis", client)
end

function showSynthesis(info)
    if (synthesisWnd == nil) then
        Cli.Send("Synthesis_client")
        Cli.SysMessage("[系统提示] synthesis系统功能正在加载中，请稍后！",4,3)
        return
    end
    pet1 = -1
    pet2 = -1
    logPrint( 'showSynthesis1')
    logPrintTbl(info)
    synthesisInfo = info;
    synthesisWnd:show()
    initSynthesisContent()
    logPrint( 'showSynthesis2')
end

function synthesis()

end

Cli.Send().wait["FLUSH_SYNTHESIS"] = flushSynthesisInfo
cli.send().wait["SHOW_SYNTHESIS"] = showSynthesis
Cli.Send().wait["SYNTHESIS_CLIENT"] = loadSynthesisClient
Cli.Send("synthesis_client")