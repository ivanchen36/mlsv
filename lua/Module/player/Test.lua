function test1()
    local socket = require("socket")
    local client = socket.tcp()
    client:connect("www.baidu.com", 80)
    client:send("GET / HTTP/1.0\r\nHost: www.baidu.com\r\n\r\n")
    local response = client:receive"*a"
    logPrint(response)
    client:close()
end

function test(player)
    local index = 30413 - 30400
    index = math.mod(index, 30)
    logPrint(index)
end

function test2()

end

TalkEvent["/test"] = test

TalkEvent["/test2"] = function (player)
    player:recoverHp()
end

function testRecv(fd,head,packet)
    logPrint("testRecv", fd,head,packet)
    return 0
end

--InitEvent["server"] = test2
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 1);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 2);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 3);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 4);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 5);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 6);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 7);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 8);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 9);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 10);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 11);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 12);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 13);
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 14);
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
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 37); 
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
Protocol.OnRecv("lua/Module/player/Test.lua", "testRecv", 58); 
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