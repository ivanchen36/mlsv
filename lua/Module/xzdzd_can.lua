

-- 界面：凤凰
-- 编写：无语

-------------------------------------------------------------------------------------
----------------------------原地登录系统-----------------------------------------
-------------------------------------------------------------------------------------

Login_MaxPlayer_PC = 999 --总窗口
Login_MaxPlayer_PC_zhandou = 6 --战斗窗口
Login_MaxPlayer_PC_shengchan = 888 --生产窗口
Login_Num = 10
Login_ls_table = Login_ls_table or {}
Login_ls_table1 = Login_ls_table1 or  {}
战斗职业表 = {
	10,20,30,40,50,60,70,80,90,100,110,130,140,150,160,170,180,190
};
生产职业表 = {
	120,200,210,220,230,240,250,260,270,280,290,300,310,320,330,340,350,360,370,380,390,400,410,420,430,440,450,460,470,480
};

-------------------------------------------------------------------------------------
----------------------------自动战斗辅助系统-----------------------------------------
-------------------------------------------------------------------------------------

xzdzd_SetComSkill ={}
xzdzd_SetComSkill.WaitingTime = 60   -- 每回合出手等待时间（60 等于1秒） 注：此项很重要 根据自己服务器配置 调节 适合自己的速度
xzdzd_SetComSkill.zdsitu = {1,100}  -- 是否开启原地走路 1开启 0 关闭 ，间隔时间（60 等于1秒）  
-----------------------反挂设置---------------
xzdzd_SetComSkill.speed_production = 0   --反高速制作  1 开启， 0 关闭 (注意：开启后 刻印技能无法使用了)
xzdzd_SetComSkill.speed_fighting = 1    -- 反高速战斗
xzdzd_SetComSkill.MovementSpeed = 1  	-- 反高移动加速   测试中 如果有问题 请修改为 0
xzdzd_SetComSkill.validation = 0 -- npc 对话验证码   0 关闭 其他为时间间隔 分钟
xzdzd_SetComSkill.YanZeng = {    -- 验证码设置
{20000,  20200, 20400, 20600,20800, 21200,  21400, 21432, 21627, 21650, 21700, 21840, 21882, 25000,25202, 25401, 25600, 25800, 26035}, --验证码显示图档
{" 剑 "," 斧 "," 枪 "," 杖 "," 弓 ","回力"," 盔 "," 帽 "," 甲 "," 衣 "," 袍 "," 鞋 "," 靴 "," 盾 ","戒指","耳环","项链","手镯","乐器"}} -- 文字

xzdzd_SetComSkill.MPHP = {0.05,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.75,0.80} -- 血魔池注入比例 必须10个内容 一次对应10个等级的料理血瓶 
xzdzd_SetComSkill.Msg = {
"$7点击补充血魔池",
"会自动将包裹内的料理血瓶转换为血魔",
"10级                "..(xzdzd_SetComSkill.MPHP[10]*100).."%",
"9 级                "..(xzdzd_SetComSkill.MPHP[9]*100).."%",
"8 级                "..(xzdzd_SetComSkill.MPHP[8]*100).."%",
"7 级                "..(xzdzd_SetComSkill.MPHP[7]*100).."%",
"6 级                "..(xzdzd_SetComSkill.MPHP[6]*100).."%",
"5 级                "..(xzdzd_SetComSkill.MPHP[5]*100).."%",
"4 级                "..(xzdzd_SetComSkill.MPHP[4]*100).."%",
"3 级                "..(xzdzd_SetComSkill.MPHP[3]*100).."%",	
"2 级                "..(xzdzd_SetComSkill.MPHP[2]*100).."%",	
"1 级                "..(xzdzd_SetComSkill.MPHP[1]*100).."%",	
}

xzdzd_SetComSkill.xs = 1  -- 是否显示所有血量
xzdzd_SetComSkill.figure = 1  -- 是开启切图
xzdzd_SetComSkill.lv1 = 1  -- 是否显示一级宠物血量

------------------------------------------------------
xzdzd_SetComSkill.accelerating = 2  -- 战斗加速倍率 当 设置为1时 为没有任何加速战斗效果并且 反加速战斗生效 其他值 为加速比例 例如 2 为战斗加速2倍
------------------------------------------------------
xzdzd_SetComSkill.cqms = 0  -- 0 为 虚拟坐骑 1 为 技能坐骑
xzdzd_SetComSkill.Nr = 60  -- 心跳包时间  不可以小于 30  根据服务网络的 速度 自行调整


