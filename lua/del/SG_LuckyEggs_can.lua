
--[[ --����
���˴�	����֮��	501			LUA_useItemcuichui						80400	26021		26		0	1	0	0	1	1	1	1	0	0	0			0	0	0	0	0	0																																																						0	0	1			0	792511	792512	100	0	0			0
���˴�	ǿ�����˴�	502			LUA_useItemcuichui						80401	26031		26		0	1	0	0	1	1	1	4	0	0	0			0	0	0	0	0	0																																																						0	0	1			0	792521	792512	100	0	0			0
���˴�	X�ͱ������˴�	503			LUA_useItemcuichui						80402	26032		26		0	1	0	0	1	1	1	4	0	0	0			0	0	0	0	0	0																																																						0	0	1			0	792531	792512	100	0	0			0
���˴�	Y�ͱ������˴�	504			LUA_useItemcuichui						80403	26030		26		0	1	0	0	1	1	1	4	0	0	0			0	0	0	0	0	0																																																						0	0	1			0	792541	792512	100	0	0			0
--]]


LuaSetup2 = {}
LuaSetup2.LuckyEggs_defaultimage = 27486;	--Ĭ�����˵���ͼ�����
LuaSetup2.LuckyEggs_gifimage = 110108;	--��̬ͼ����ţ������ҿ�һ˲��ĵ���ͼ��
LuaSetup2.LuckyEggs_gifimage2 = 110059;	--��̬ͼ����ţ��ʵ��ָ���ʱ��Ч����̬ͼ
LuaSetup2.Warp = 1000 --��ͼ���
LuaSetup2.LuckyEggs_areaset = {226,108,233,115};	--x����1��y����1��x����2��y����2�����귶Χ�趨
LuaSetup2.LimitShop_payitem = 80404; -- �鿴�ʵ��ĵ��߱��(��Ч)
LuaSetup2.tNAME = "" --�ҵ�����
LuaSetup2.Msg = "�ҵ���"  --- �н�����
LuaSetup2.LuckyEggs_Item  = {80400,80401,80402,80403} -- ����֮���ĵ��߱��  1 Ϊ���� 2 Ϊ��Χ 3 Ϊ x  4 Ϊ y
LuaSetup2.LuckyEggs_items = {}--����Ϊ����LuaSetup.LuckyEggs_items[ID] = {��Ʒ��� = 50000,���� = 1,Color=0};
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

