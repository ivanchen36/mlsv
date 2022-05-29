
-- "[qiandao2]"  签到链接
------------------------------------------------------------------------------------------------------------------
QianDaTime2 = 3600 -- 在线时间限制
QianDaAccording = 0 -- 是否显示物品形象 0 关闭  1 开启
QianDaCompensation = {50000,5} -- 补签消耗的道具,数量
QianDaoItem_table2 = {} -- 签到给与的物品  注意 写好 31 个 每个对应每天物品
--  道具编号 ，说明
QianDaoItem_table2[1] =  {100090,{"100W宠物经验丹"}}
QianDaoItem_table2[2] =  {100090,{ "100W宠物经验丹"}}
QianDaoItem_table2[3] =  {100090,{ "100W宠物经验丹"}}
QianDaoItem_table2[4] =  {100090,{"100W宠物经验丹"}}
QianDaoItem_table2[5] =  {100090,{"100W宠物经验丹"}}
QianDaoItem_table2[6] =  {100090,{"100W宠物经验丹"}}
QianDaoItem_table2[7] =  {100090,{"100W宠物经验丹"}}
QianDaoItem_table2[8] =  {666736,{"100W人物经验丹"}}
QianDaoItem_table2[9] =  {666736,{ "100W人物经验丹"}}
QianDaoItem_table2[10] = {666736,{"100W人物经验丹"}}
QianDaoItem_table2[11] = {666736,{"100W人物经验丹"}}
QianDaoItem_table2[12] = {666736,{"100W人物经验丹"}}
QianDaoItem_table2[13] = {666736,{ "100W人物经验丹"}}
QianDaoItem_table2[14] = {666736 ,{"100W人物经验丹"}}
QianDaoItem_table2[15] = {666736,{"100W人物经验丹"}}
QianDaoItem_table2[16] = {100094,{"100积分包"}}
QianDaoItem_table2[17] = {100094,{"100积分包"}}
QianDaoItem_table2[18] = {100094,{"100积分包"}}
QianDaoItem_table2[19] = {100094,{"100积分包"}}
QianDaoItem_table2[20] = {100094,{"100积分包"}}
QianDaoItem_table2[21] = {100094,{ "100积分包"}}
QianDaoItem_table2[22] = {100094,{"100积分包"}}
QianDaoItem_table2[23] = {100094,{"100积分包"}}
QianDaoItem_table2[24] = {100094,{"100积分包"}}
QianDaoItem_table2[25] = {100094,{"100积分包"}}
QianDaoItem_table2[26] = {100094,{"100积分包"}}
QianDaoItem_table2[27] = {88888,{"麦穗赞助金币"}}
QianDaoItem_table2[28] = {88888,{ "麦穗赞助金币"}}
QianDaoItem_table2[29] = {88888,{ "麦穗赞助金币"}}
QianDaoItem_table2[30] = {88888,{ "麦穗赞助金币"}}
QianDaoItem_table2[31] = {88888,{ "麦穗赞助金币"}}


QianDaoCumulative = {}  -- 累计签到奖励 两个  
QianDaoCumulative[1] = {10,{598271,{"青铜会员"}},{88888,{"麦穗赞助金币"}}}  -- 累计天数 {奖励,说明}
QianDaoCumulative[2] = {20,{598272,{"黄金会员"}},{88888,{"麦穗赞助金币"}}}  -- 累计天数 {奖励}

---------------------------------
