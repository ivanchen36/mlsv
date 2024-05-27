
--[[ --例子
幸运锤	幸运之锤	501			LUA_useItemcuichui						80400	26021		26		0	1	0	0	1	1	1	1	0	0	0			0	0	0	0	0	0																																																						0	0	1			0	792511	792512	100	0	0			0
幸运锤	强力幸运锤	502			LUA_useItemcuichui						80401	26031		26		0	1	0	0	1	1	1	4	0	0	0			0	0	0	0	0	0																																																						0	0	1			0	792521	792512	100	0	0			0
幸运锤	X型爆破幸运锤	503			LUA_useItemcuichui						80402	26032		26		0	1	0	0	1	1	1	4	0	0	0			0	0	0	0	0	0																																																						0	0	1			0	792531	792512	100	0	0			0
幸运锤	Y型爆破幸运锤	504			LUA_useItemcuichui						80403	26030		26		0	1	0	0	1	1	1	4	0	0	0			0	0	0	0	0	0																																																						0	0	1			0	792541	792512	100	0	0			0
--]]


LuaSetup2 = {}
LuaSetup2.LuckyEggs_defaultimage = 27486;	--默认幸运蛋的图档编号
LuaSetup2.LuckyEggs_gifimage = 110108;	--动态图档编号，就是砸开一瞬间的蛋的图档
LuaSetup2.LuckyEggs_gifimage2 = 110059;	--动态图档编号，彩蛋恢复的时候效果动态图
LuaSetup2.Warp = 1000 --地图编号
LuaSetup2.LuckyEggs_areaset = {226,108,233,115};	--x坐标1、y坐标1，x坐标2、y坐标2，坐标范围设定
LuaSetup2.LimitShop_payitem = 80404; -- 查看彩蛋的道具编号(无效)
LuaSetup2.tNAME = "" --砸蛋名字
LuaSetup2.Msg = "砸到了"  --- 中奖公告
LuaSetup2.LuckyEggs_Item  = {80400,80401,80402,80403} -- 幸运之锤的道具编号  1 为单体 2 为周围 3 为 x  4 为 y
LuaSetup2.LuckyEggs_items = {}--下面为奖励LuaSetup.LuckyEggs_items[ID] = {物品编号 = 50000,数量 = 1,Color=0};
LuaSetup2.LuckyEggs_items[1] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[2] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[3] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[4] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[5] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[6] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[7] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[8] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[9] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[10] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[11] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[12] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[13] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[14] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[15] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[16] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[17] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[18] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[19] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[20] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[21] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[22] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[23] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[24] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[25] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[26] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[27] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[28] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[29] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[30] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[31] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[32] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[33] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[34] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[35] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[36] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[37] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[38] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[39] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[40] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[41] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[42] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[43] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[44] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[45] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[46] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[47] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[48] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[49] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[50] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[51] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[52] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[53] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[54] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[55] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[56] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[57] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[58] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[59] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[60] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[61] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[62] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[63] = {itemid = 9611,rand = 1,Color=0};
LuaSetup2.LuckyEggs_items[64] = {itemid = 9611,rand = 1,Color=0};

