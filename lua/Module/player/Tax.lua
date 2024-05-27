local taxRate =
{
    [20000] = 0,
    [100000] = 0.2,
    [200000] = 0.3,
    [100000000000] = 0.5
}

function payTax(fd, head, packet)
    local myPlayer = MyPlayer:new(Protocol.GetCharByFd(fd))
    local playerRegNum = myPlayer:getRegistNumber();
    local cycle = truncDay(os.time());

    local sql = string.format( "SELECT Amount, TaxAmount, Cycle, CreateTime FROM tbl_tax_info WHERE RegNum = ? and Cycle = ?", playerRegNum, cycle);
    local rs = SQL.Run(sql);
    if type(rs) ~= "table" then
        sql = string.format("INSERT INTO tbl_tax_info (RegNum, Amount, TaxAmount, Cycle, CreateTime) VALUES (?, 0, 0, ?, unix_timestamp())",
                playerRegNum, cycle);
        SQL.Run(sql);

        return;
    end
end

Protocol.OnRecv(nil, "payTax", 1);
