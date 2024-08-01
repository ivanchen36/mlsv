                                            ---------------------------------------------------------
                                            -- GA提供免费脚本--不提供使用帮助--具体请参考脚本内注释--
											-- 如果需要定制脚本(包括界面)  请联系QQ:715837         --
                                            ---------------bbs.ml30.com发布最新----------------------


--20231127整理更新,内容在最下面 商业版咨询购买 功能界面定制联系phoenix QQ715837
--本次更新感谢lua写手 无语 (QQ158471323) 提供大量lua功能脚本
useModule("SG_ga");--默认支持库
useModule("All_canshu");--部分脚本配置参数-傻瓜版
useModule("user")--登录直接注册,mac会写在tbl_user的IP字段,修改密码参考All_canshu.lua
useModule("animesps");--图档授权(仅限用于免费版)
useModule("zdzd_can");--自动战斗相关
useModule("zdzd");--自动战斗相关
--useModule("xzdzd_can");--自动战斗相关
--useModule("xzdzd");--自动战斗相关
useModule("Login_can");--原地登录相关
useModule("Login");--原地登录相关
useModule("getpetBp");--宠物算档 配合按钮
useModule("shop_canshu");--道具商城配置文件
useModule("shop");--道具商城主文件

useModule("fram");--声望查询
--useModule("laba");--喇叭
--useModule("wgfy");--王宫封印师查询配合wgfy.php
--useModule("TitleChange");--称号附加属性
--useModule("phb");--排行榜
--形象变身
--做一个npc 玩家对话可以永久变身为npc形象
--[[
block
luac likeme
]]
--宠物变身
--将第一栏宠物变身为npc形象
--[[
block
luac petme
]]

--角色变身卡,宠物变身卡
--[[
包？	角色变身卡				LUA_useM1						76411	98893	0	26		0	1	0	72	1	1	1	1	0																																																										1	100502					0	0	1	0		0			100	0	0	0	0	0
包？	宠物变身卡				LUA_useM1						76412	98893	0	26		0	1	0	72	1	1	1	1	0																																																										2	100452					0	0	1	0		0			100	0	0	0	0	0
]]
useModule("sellpet");--宠物贩卖价格
--[[
野生：等级*10
1级BB：
1-100级，固定100魔币
101-满级，等级*500魔币
]]--

--[[无限endevent扩展,用法跟官方一样 最大数量65535   可以从1000开始避免重复]]
--[[
block endevent 1001 == 1
endwindow"已经获取过了"
block
endevent 1001 = 1
checktitle
endwindow"获取成功"

titleconfig.txt
endflg=1001,TITLE=888001

titlename.txt
888001	测试称号
]]

--界面lua
useModule("ac");--综合 家族频道 聊天框内切换
--useModule("mijing");--秘境挑战
--[[block
 showmj
 ]] --其他参数参考 lua/System/BaseModule/luac.lua
useModule("astarsive_can");--自动寻路F3 配置20221027更新迷宫地图-消失时间
useModule("astarsive");--自动寻路F3
useModule("Team_Service");--组队T人界面
--itemset.txt内,宠物洗挡卷指定档位,配置在lua/System/BaseModule/luac.lua

--useModule("actioninfonpc");--全局掉落 可以限定时间 限定个数 几率 等级(服务器人数高于800不要使用)

useModule("SG_Pet_Shop2_can");--宠物自售配置文件
useModule("SG_Pet_Shop2");--宠物自售
useModule("ShopQuery_can");--宠物自售配置文件
useModule("ShopQuery");--宠物自售

useModule("Battle_eryebeibao_can") -- 扩展背包
useModule("Battle_eryebeibao") -- 扩展背包
--20210618更新
useModule("ChiBang3_can");--翅膀配置文件
useModule("ChiBang3");--翅膀
useModule("zuoqi2_can");--虚拟坐骑配置文件
useModule("zuoqi2");--虚拟坐骑
useModule("qiandao2_can");--签到
useModule("qiandao2");--签到
useModule("shuxing_can");--职业BP切换
useModule("shuxing");--职业BP切换
useModule("Streng_can");--属性强化(角色,宠物形象强化)
useModule("Streng");--属性强化(角色,宠物形象强化)
useModule("xingxiang_can");--角色状态栏 宠物状态栏 衣柜
useModule("xingxiang");--角色状态栏 宠物状态栏 衣柜
useModule("xiang_can");--诱魔,驱魔,聚魔,宠物技能学习,角色技能学习
useModule("xiang");--诱魔,驱魔,聚魔,宠物技能学习,角色技能学习
--[[20230222聚魔增加诱魔效果
引怪水	聚魔香L10				LUA_useJuMo						1078	26232	0	26		0	1	0	0	1	1	0	10	0	100	100			0	0	0	0	0	0																																															100	10	10					0	0	1			0	450012	450012	100	0	0			0
--特殊类别：填写几率
--子参数一：最小遇敌数量
--子参数二：最大遇敌数量
香？	驱魔香3分钟				LUA_useQuMo						1069	26253	7500	26		0	1	0	0	1	1	1	1		180	180			0	0																																																										0	0	1			0		70001	100	0	0			
--耐久：等于时间（单位秒）
香？	诱魔香[100]				LUA_useInTohelos						1072	26256		26		0	1	0	0	1	1	1	1		100	100			0	0																																																										0	0	1			0	70003	70001	100	0	0			0
--耐久：步数
技能卷？	宠物技能学习卷				LUA_usePetAddSkill						106	27815	0	26		0	1	0	0	1	1	1	10	0					0	0																																																			0	7300	14					0	0	1			0	70037	70001	0	0	0			0
--子参数二：要学习的TechID 
信?	人物技能学习卷				LUA_useCharAddSkill						105	27814		26		0	1	0	0	1	1	1	1	0					0	0	0	0	0	0																																															95	0	1					0	1	0			0	945077	945077	100	0	0			0
--特殊类别：要学习技能的Skillid
药水？	宠物重生药水				LUA_usePetReBirth						108	26206		26		0	1	0	72	1	1	1	1	0					0																																																											0	0	1			0	70019	70001	100	0	0			0

	NL.RegItemString(nil,"Pack","LUA_usePack"); --注册万能打包器
	NL.RegItemString(nil,"UnPack","LUA_useUnPack"); --注册万能解包器
	NL.RegItemString(nil,"InQuMo2","LUA_useQuMo2"); --注册驱魔香 步数
	NL.RegItemString(nil,"InTohelos","LUA_useInTohelos"); --注册诱魔香
	NL.RegItemString(nil,"InJuMo","LUA_useJuMo"); --注册诱魔香
	NL.RegItemString(nil,"InQuMo","LUA_useQuMo"); --注册驱魔香  时间
	NL.RegItemString(nil,"CharAddSkill","LUA_useCharAddSkill"); -- 人物技能快速技能
	NL.RegItemString(nil,"PetAddSkill","LUA_usePetAddSkill"); -- 宠物技能快速技能
	NL.RegItemString(nil,"PetReBirth","LUA_usePetReBirth"); --注册宠物洗点药水

打包 可一组组取出
]]

--[[
block
luac itemreb
#完美修理物品栏第一格道具(记得要判断是否有道具和道具类型)
]]
useModule("zhaxiang");--全队便捷操作
--[[
/z   集合命令
/g  记录当前队员
/a	快速组队
/dak	全队开启打卡
/dag	全队关闭打卡
]]

--杂七杂八
useModule("reconnection");--断线战斗重连道具
useModule("SG_PetDelSkill");--宠物技能删除
useModule("ItemPetBP_can");--快速加点
useModule("ItemPetBP");--快速加点
--20231127

useModule("newflg");
useModule("npcms");