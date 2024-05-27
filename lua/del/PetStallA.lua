--time 2020.08.05
--宠物摆摊
--支持重启自动摆摊 支持一键续期
--功能编写:QQ501874912
--===================================================================
local TalkEvent = "[2]" 	-- 呼出命令设置
local DiyStall = {"#jk","#mb"};--设置宠物出售特征
local DiyName = {"魔币","金卡"};
local DiyItemID = 88888; --金卡编号
local DiyItemMax = 100000;--钱箱最大值
local DiyShopPetName = "被购买[寄售]"
local DiyStallMap = {1000};--只允许在哪些地图进行自售
local DiyStallGooldMax = 100000000;--魔币最高上限
local DiyStallLevel = 1;--设置最高几级宠物能进行自售
--local Loyalty = 100 --设置最低拥有多少忠诚才能自售
local DiyNpc = {1000,231,93,100000,"宠物寄售管理",4};--设置领取NPC,说明:
local Renewal = 100 --	一键续摆摊费用: 每只宠物续费价格
---------------地图编号,地图X坐标,地图Y坐标,NPC形象,NPC名称,NPC面向-----------------
Global_PetStallData = { DiyStall,DiyName,DiyItemID,DiyItemMax,DiyShopPetName,DiyStallMap,DiyStallGooldMax,DiyStallLevel,DiyNpc,Renewal,TalkEvent }
useModule("PetStallB");
--===================================================================