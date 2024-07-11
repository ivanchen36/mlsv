local taxAmount = {20000, 100000, 200000, 100000000000}
local taxRate = {0,0.2,0.3,0.5}
local playerGold = {}

function getTaxRate(amount)
    for i = 1, #taxRate do
        if amount <= i then
            return taxRate[i]
        end
    end
    return 0.5
end

function payTax(player, arg)
    local cycle = truncDay(os.time());
    local playerRegNum = player:getRegistNumber();
    local mac = player:getMac()
    local amount = player:getGold() - playerGold[player:getObj()]

    playerGold[player:getObj()] = nil
    local sql = string.format( "SELECT Amount, TaxAmount, Cycle, CreateTime FROM tbl_tax_info WHERE RegNum = '%s' and Cycle = %d", playerRegNum, cycle);
    local rs = SQL.Run(sql);
    if type(rs) ~= "table" then
        sql = string.format("INSERT INTO tbl_tax_info (RegNum, Amount, TaxAmount, Cycle, CreateTime) VALUES ('%s', %d, 0, %d, unix_timestamp())",
                playerRegNum, amount, cycle);
        SQL.Run(sql);

        return;
    end
    sql = string.format("UPDATE tbl_tax_info set Amount = Amount + %d, TaxAmount = TaxAmount + %d WHERE RegNum = '%s' and Cycle = %d",
            amount, amount, playerRegNum, cycle);
    SQL.Run(sql);
end

--subMoney
function checkSellAmount(fd, head, packet)
    logPrint("OnRecv ", head, packet)
    local myPlayer = MyPlayer:new(Protocol.GetCharByFd(fd))
    local arr = strSplit(packet, ":")
    if arr[3] == "5o" then
        logPrint("checkSellAmount ", arr[3], "  ", myPlayer:getGold())
        playerGold[myPlayer:getObj()] = myPlayer:getGold()
        Protocol.PowerSend(myPlayer:getObj(), "SEND_TAX", "")
    end
    return 0
end

Protocol.OnRecv(nil, "checkSellAmount", 61);
ClientEvent["pay_tax"] = payTax
