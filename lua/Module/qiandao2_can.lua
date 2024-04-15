
-- "[qiandao2]"  签到链接
------------------------------------------------------------------------------------------------------------------
QianDaTime2 = 3600 -- 在线时间限制
QianDlevel = 100; --最低签到等级
QianDaAccording = 0 -- 是否显示物品形象 0 关闭  1 开启
QianDaCompensation = {50000,5} -- 补签消耗的道具,数量
QianDaoItem_table2 = {} -- 签到给与的物品  注意 写好 31 个 每个对应每天物品
--  道具编号 ，说明
QianDaoItem_table2[1] =  {9612,{"声望增加100*1","增加打卡时间1小时","增加打卡时间1小时","增加打卡时间1小时"}}
QianDaoItem_table2[2] =  {9611,{ "增加打卡时间1小时"}}
QianDaoItem_table2[3] =  {9611,{ "诱魔香50步"}}
QianDaoItem_table2[4] =  {9611,{"声望增加100*1"}}
QianDaoItem_table2[5] =  {9611,{"宠物洗档卷*1"}}
QianDaoItem_table2[6] =  {9611,{"驱魔香3分钟"}}
QianDaoItem_table2[7] =  {9611,{"签到首饰1级：攻击15 敏捷15 必杀5 耐久100"}}
QianDaoItem_table2[8] =  {9611,{"声望增加100*1"}}
QianDaoItem_table2[9] =  {9611,{ "增加打卡时间1小时"}}
QianDaoItem_table2[10] = {9611,{"诱魔香50步*1"}}
QianDaoItem_table2[11] = {9611,{"声望增加100*1"}}
QianDaoItem_table2[12] = {9611,{"宠物洗档卷*1*1"}}
QianDaoItem_table2[13] = {9611,{ "驱魔香3分钟"}}
QianDaoItem_table2[14] = {9611 ,{"签到首饰2级：攻击20 敏捷20 必杀6 耐久100"}}
QianDaoItem_table2[15] = {9611,{"声望增加100*1"}}
QianDaoItem_table2[16] = {9611,{"增加打卡时间1小时"}}
QianDaoItem_table2[17] = {9611,{"诱魔香50步*1"}}
QianDaoItem_table2[18] = {9611,{"声望增加100*1"}}
QianDaoItem_table2[19] = {9611,{"宠物洗档卷*1"}}
QianDaoItem_table2[20] = {9611,{"驱魔香3分钟"}}
QianDaoItem_table2[21] = {9611,{ "签到首饰3级：攻击30 敏捷30 必杀6 命中5 耐久100"}}
QianDaoItem_table2[22] = {9611,{"声望增加100*1"}}
QianDaoItem_table2[23] = {9611,{"增加打卡时间3小时*1*1"}}
QianDaoItem_table2[24] = {9611,{"诱魔香50步*1"}}
QianDaoItem_table2[25] = {9611,{"声望增加100*1"}}
QianDaoItem_table2[26] = {9611,{"宠物洗档卷*1"}}
QianDaoItem_table2[27] = {9611,{"驱魔香3分钟"}}
QianDaoItem_table2[28] = {9611,{ "签到首饰4级：攻击35 敏捷35 必杀7 命中6 闪避5 耐久100"}}
QianDaoItem_table2[29] = {9611,{ "宠物洗档卷*1"}}
QianDaoItem_table2[30] = {9611,{ "宠物洗档卷*1"}}
QianDaoItem_table2[31] = {9611,{ "宠物洗档卷*1"}}


QianDaoCumulative = {}  -- 累计签到奖励 两个  
QianDaoCumulative[1] = {10,{9612,{"宠物洗档卷1","宠物洗档卷1","宠物洗档卷1"}},{9613,{"宠物洗档卷2","宠物洗档卷2","宠物洗档卷2"}}}  -- 累计天数 {奖励,说明}
QianDaoCumulative[2] = {20,{9614,{"宠物洗档卷3","宠物洗档卷3","宠物洗档卷3"}},{9615,{"宠物洗档卷4","宠物洗档卷4","宠物洗档卷4"}}}  -- 累计天数 {奖励}

---------------------------------
