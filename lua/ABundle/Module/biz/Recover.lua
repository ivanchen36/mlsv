partyTitle = {"title", "member1", "member2", "member3", "member4", "member5"}

local recoverWnd = nil
local recoverInfo = nil

function recover(widget)
    if "confirm" == widget:getTitle() then
        Cli.Send("party_recover")
    end
    recoverWnd:close()
end

function initRecoverContent()
    for i=1, #recoverTitle do
        local title = recoverTitle[i]
        local name = recoverWnd:getWidget(title)
        local health = recoverWnd:getWidget(title .. "H")
        local magic = recoverWnd:getWidget(title .. "M")
        local gold = recoverWnd:getWidget(title .. "G")
        if recoverInfo[i] ~= nil then
            local info = recoverInfo[i]
            name:setText(info[1])
            health:setText(info[2])
            magic:setText(info[3])
            if 1 == i then
                gold:setText(info[4])
            else
                gold:setText(info[4] .. "G")
            end
        else
            name:setText("")
            health:setText("")
            magic:setText("")
            gold:setText("")
        end
    end
end

function loadRecoverClient()
    local client = {
        {
            ["type"] = "bg",
            ["img"] = "recover.bmp",
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
            ["table"] = "0,1",
            ["high"] = 30,
            ["type"] = "lab",
            ["title"] = "#partyTitle",
            ["x"] = 130,
            ["y"] = 94,
            ["text"] = "",
        },
        {
            ["table"] = "0,1",
            ["high"] = 30,
            ["type"] = "lab",
            ["title"] = "#partyTitle$H",
            ["x"] = 210,
            ["y"] = 94,
            ["text"] = "",
        },
        {
            ["table"] = "0,1",
            ["high"] = 30,
            ["type"] = "lab",
            ["title"] = "#partyTitle$M",
            ["x"] = 270,
            ["y"] = 94,
            ["text"] = "",
        },
        {
            ["table"] = "0,1",
            ["width"] = 223,
            ["high"] = 30,
            ["type"] = "lab",
            ["title"] = "#partyTitle$G",
            ["x"] = 316,
            ["y"] = 94,
            ["text"] = "",
        },
        {
            ["type"] = "btn",
            ["title"] = "confirm",
            ["x"] = 166,
            ["y"] = 266,
            ["img"] = "b1.bmp",
            ["active"] = "b2.bmp",
            ["disable"] = "b3.bmp",
            ["text"] = "»Ö¸´",
            ["click"] = "recover",
        },
        {
            ["type"] = "btn",
            ["title"] = "cancel",
            ["x"] = 286,
            ["y"] = 266,
            ["img"] = "b1.bmp",
            ["active"] = "b2.bmp",
            ["disable"] = "b3.bmp",
            ["text"] = "È¡Ïû",
            ["click"] = "recover",
        }
    }
    recoverWnd = createWindow(1013, "recover", client)
end

function showRecover(info)
    recoverInfo = info;
    if (recoverWnd == nil) then
        loadRecoverClient()
    end
    recoverWnd:show()
    initRecoverContent()
end

Cli.Send().wait["SHOW_RECOVER"] = showRecover