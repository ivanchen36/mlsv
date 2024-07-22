local partyWnd = nil
local partyInfo = ""

local function loadPartyWnd()
    local client = {
        {
            ["type"] = "lab",
            ["title"] = "buff",
            ["x"] = 96,
            ["y"] = 86,
            ["text"] = "",
        }
    }
    for i = 1, 5 do
        table.insert(client, {
            ["type"] = "img",
            ["title"] = "m" .. i,
            ["x"] = 96 + (i - 1) * 110,
            ["y"] = 99,
            ["img"] = 0,
        })
    end
    partyWnd = createWindow(723, "", client)
end

function flushPartyBuff(info)
    logPrint("flushPartyBuff")
    logPrintTbl(info)
    partyInfo = info
    if partyWnd == nil then
        loadPartyWnd()
        partyWnd:onShow(function()
            partyWnd:getWidget("buff"):setText(partyInfo["buff"])
            local vipInfo = partyInfo["vip"]
            if vipInfo == nil then
                vipInfo = {}
            end
            for i = 1, 5 do
                local img = partyWnd:getWidget("m" .. i)
                logPrint(vipInfo[tostring(i)])
                if vipInfo[tostring(i)] ~= nil then
                    img:setImg("v" .. vipInfo[tostring(i)] .. ".bmp")
                else
                    img:setImg(0)
                end
                logPrintTbl(img)
            end
        end)
    end
    logPrintTbl(partyWnd)
end

function sendTax(param)
    Cli.Send("pay_tax")
end

Cli.Send().wait["SEND_TAX"] = sendTax
Cli.Send().wait["FLUSH_PARTY_BUFF"] = flushPartyBuff
