local taxRate =
{
    [20000] = 0,
    [100000] = 0.2,
    [200000] = 0.3,
    [100000000000] = 0.5
}
local playerGold = {}

function payTax(player, arg)
    local cycle = truncDay(os.time());
    local playerRegNum = player:getRegistNumber();
    local amount = player:getGold() - playerGold[player:getObj()]
    logPrint("sell ", amount)
    playerGold[player:getObj()] = nil

    local sql = string.format( "SELECT Amount, TaxAmount, Cycle, CreateTime FROM tbl_tax_info WHERE RegNum = %d and Cycle = %d", playerRegNum, cycle);
    local rs = SQL.Run(sql);
    if type(rs) ~= "table" then
        sql = string.format("INSERT INTO tbl_tax_info (RegNum, Amount, TaxAmount, Cycle, CreateTime) VALUES (%d, 0, 0, %d, unix_timestamp())",
                playerRegNum, cycle);
        SQL.Run(sql);

        return;
    end
    sql = string.format("UPDATE tbl_tax_info set TaxAmount = TaxAmount + %d WHERE RegNum = %d and Cycle = %d",
            amount, playerRegNum, cycle);
    SQL.Run(sql);
end
--subMoney
function checkSellAmount(fd, head, packet)
    local myPlayer = MyPlayer:new(Protocol.GetCharByFd(fd))
    local arr = strSplit(packet, ":")
    logPrint("checkSellAmount ", arr[3], "  ", myPlayer:getGold())
    if arr[3] == "5o" then
        playerGold[myPlayer:getObj()] = myPlayer:getGold()
        Protocol.PowerSend(myPlayer:getObj(), "SEND_TAX", "")
    end
    return 0
end

Protocol.OnRecv(nil, "checkSellAmount", 61);
ClientEvent["pay_tax"] = payTax