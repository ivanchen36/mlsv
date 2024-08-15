function test1()
    local socket = require("socket")
    local client = socket.tcp()
    client:connect("www.baidu.com", 80)
    client:send("GET / HTTP/1.0\r\nHost: www.baidu.com\r\n\r\n")
    local response = client:receive"*a"
    logPrint(response)
    client:close()
end
local userInfo1 = {}
function test(player)
    --getTalentClient(player, "")
    local enemy = MyEnemyData:new(30007)
    print_stack_trace()
    --logPrintTbl(enemy:getAttr())
    --logPrintTbl( calEnemyAttr(30, enemy:getBirthBp(), enemy:getVital(),
    --       enemy:getStr(), enemy:getTough(), enemy:getQuick(), enemy:getMagic()))
end

function showWelcome(adImg)
    local co = coroutine.create(function()
        logPrint("111")
    end)
    coroutine.resume(co)
end

local function parseFunction(func_name)
    local func = _G[func_name]
    if type(func) ~= "function" then
        logPrint(func_name .. " is not a function in _G")
        return
    end

    local info = debug.getinfo(func)
    logPrint("Function: " .. func_name)
    logPrint("Number of parameters: " .. info.nparams)

    for i = 1, info.nparams do
        local param_name = debug.getlocal(func, i)
        logPrint("Parameter " .. i .. ": " .. (param_name or "unknown"))
    end
    local lines_executed = {}
    debug.sethook(function()
        local info = debug.getinfo(2, "Sl")
        if info.what == "Lua" then
            lines_executed[info.currentline] = (lines_executed[info.currentline] or 0) + 1
        end
    end, "l")
    func(1, 1, 1)
    debug.sethook()
    logPrint("Lines executed in " .. func_name .. ":")
    for line, count in pairs(lines_executed) do
        logPrint(string.format("Line %d: executed %d times", line, count))
    end
end

function print_stack_trace()
    logPrint("Stack trace:")
    local level = 1
    while true do
        local info = debug.getinfo(level, "Sln")
        if not info then break end

        if info.what == "C" then
            logPrint(string.format("%d: [C]: in function '%s'", level, info.name or "?"))
        else
            logPrint(string.format("%d: %s:%d: in function '%s'",
                    level, info.short_src, info.currentline, info.name or "?"))
        end

        level = level + 1
    end
end

local function getFuncName(func)
    for key, val in pairs(_G) do
        if val == func then
            return key
        end
    end
end

function test2()
    logPrintTbl(NL)
    logPrintTbl(NLG)
    logPrintTbl(Char)
    logPrintTbl(Data)
end

TalkEvent["/test"] = test

TalkEvent["/test2"] = function (player)
    player:recoverHp()
end

function testRecv(fd,head,packet)
    logPrint("testRecv", fd,head,packet)
    return 0
end

InitEvent["server"] = test2
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 1);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 2);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 3);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 4);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 5);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 6);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 7);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 9);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 10);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 11);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 12);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 13);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 15);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 16);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 17);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 18);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 19);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 20);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 21);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 22);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 23);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 24);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 25);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 26);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 27);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 28);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 29);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 30);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 31);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 32);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 33);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 34);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 35); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 36); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 38);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 39); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 40); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 41); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 42); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 43); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 44); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 45); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 46); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 47); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 48); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 49); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 50); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 51); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 52); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 53); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 54); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 55); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 56); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 57);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 59); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 60); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 62);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 63); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 64); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 65); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 66); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 67); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 68); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 69); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 70); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 71); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 72); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 73); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 74); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 75); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 76); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 77); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 78); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 79); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 80); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 81); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 82); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 83); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 84); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 85); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 86); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 87); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 88); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 89); 
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 90);