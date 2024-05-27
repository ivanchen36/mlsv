


--[[
block
luac astar,测试路线,0,1000,242,88


luca.lua 添加 

	if 	string.sub(s,1,#"astar") == "astar" then 
		local a1 = Stringsplitplus(s,",")
		Protocol.PowerSend(_PlayerIndex,"#LuacWarp",{a1[2],tonumber(a1[3]),tonumber(a1[4]),tonumber(a1[5]),tonumber(a1[6])})	
	end




]]

astar_bugWarp = {} -- 特殊点可以走过但自动寻路走不过去的在这里添加坐标
astar_bugWarp[1] = {0,100,683,343,0}
astar_bugWarp[2] = {0,11004,17,17,1}
astar_WarpGold = 0 -- 走路消耗魔币


