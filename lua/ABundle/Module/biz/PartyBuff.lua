local partyWnd = nil
local partyBuff = ""

function loadPartyWnd()
    local client = {
        {
            ["type"] = "lab",
            ["title"] = "buff",
            ["x"] = 461,
            ["y"] = 8,
            ["text"] = "",
        }
    }
    partyWnd = createWindow(723, client)
    partyWnd:onShow(function()
        partyWnd:getWidget("partyBuff"):setText(partyBuff)
    end)
end

function flushPartyBuff(info)
    logPrint("flushPartyBuff", info)
    partyBuff = info
    if partyWnd == nil then
        loadPartyWnd()
    end
end

function sendTax(param)
    Cli.Send("pay_tax")
end

Cli.Send().wait["SEND_TAX"] = sendTax
Cli.Send().wait["FLUSH_PARTY_BUFF"] = flushPartyBuff
