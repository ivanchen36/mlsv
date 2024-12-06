
local pingFenWnd = nil
local pingFenInfo = nil
baseAttr = {"x", "m", "g", "j", "f", "h", "mj", "mg", "mk"}
otherAttr = {"kd", "ks", "kl", "ks", "kz", "kw", "bs", "mz", "tx", "fj","ds", "jy", "nl", "lq", "ml", "zl", "ys"}

function initPingFenContent()
    local base = pingFenInfo["base"]
    local other = pingFenInfo["other"]
    local pf = pingFenInfo["pf"]
    for i=1, #baseAttr do
        local title = baseAttr[i]
        local val = pingFenWnd:getWidget(title)
        if base == nil or base[i] == nil then
            val:setText("0")
        else
            val:setText(tostring(base[i]))
        end
    end
    for i=1, #otherAttr do
        local title = otherAttr[i]
        local val = pingFenWnd:getWidget(title)
        if other == nil or other[i] == nil then
            val:setText("0")
        else
            val:setText(tostring(other[i]))
        end
    end
    if pf ~= nil then
        pingFenWnd:getWidget("pf"):setText(tostring(pingFenInfo["pf"]))
    else
        pingFenWnd:getWidget("pf"):setText("0")
    end
end

function loadPingFenClient()
    local client = {
        {
            ["type"] = "bg",
            ["img"] = "synthesis.bmp",
        },
        {
            ["type"] = "close",
            ["x"] = 312,
            ["y"] = 4,
            ["img"] = 243000,
            ["active"] = 243002,
            ["disable"] = 243001,
        },
        {
            ["type"] = "img",
            ["title"] = "img",
            ["x"] = 312,
            ["y"] = 4,
            ["img"] = "prev2.bmp"
        },
        {
            ["table"] = "0,2",
            ["width"] = 100,
            ["high"] = 20,
            ["type"] = "lab",
            ["title"] = "#baseAttr",
            ["x"] = 47,
            ["y"] = 18,
            ["text"] = "0",
        },
        {
            ["table"] = "0,3",
            ["width"] = 100,
            ["high"] = 20,
            ["type"] = "lab",
            ["title"] = "#otherAttr",
            ["x"] = 47,
            ["y"] = 120,
            ["text"] = "0",
        },
        {
            ["type"] = "lab",
            ["title"] = "pf",
            ["x"] = 248,
            ["y"] = 222,
            ["text"] = "0",
            ["font"] = 3,
        }
    }
    pingFenWnd = createWindow(1023, "pingFen", client)
end

function showPingFen(info)
    logPrintTbl(info)
    pingFenInfo = info;
    if (pingFenWnd == nil) then
        loadPingFenClient()
    end
    pingFenWnd:show()
    initPingFenContent()
end

Cli.Send().wait["SHOW_PING_FEN"] = showPingFen