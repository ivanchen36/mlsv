--[[
本脚本只用于GA引擎及其框架内
请不要修改一下任何文件或顺序
第三方扩展类库请在Config.lua中引用
]]

-- 不需要开启的Event可以注释掉关闭
TBL_AllOCEV = {}
TBL_AllOCEV["RegVSEnemyCreateEvent"] = 1;
TBL_AllOCEV["RegLoginEvent"] = 1;
TBL_AllOCEV["RegBattleActionEvent"] = 1;
TBL_AllOCEV["RegLogoutEvent"] = 1;
TBL_AllOCEV["RegBattleNextEnemyEvent"] = 1;
TBL_AllOCEV["RegBattleSkillExpEvent"] = 1;
TBL_AllOCEV["RegItemOverLapEvent"] = 1;
TBL_AllOCEV["RegLoginGateEvent"] = 1;
TBL_AllOCEV["RegLevelUpEvent"] = 1;
TBL_AllOCEV["RegGetNextLevelExpEvent"] = 1;
TBL_AllOCEV["RegAfterWarpEvent"] = 1;
TBL_AllOCEV["RegBattleOverEvent"] = 1;
TBL_AllOCEV["RegDamageCalculateEvent"] = 1;
TBL_AllOCEV["RegBattlePVPMaxHpEvent"] = 1;
TBL_AllOCEV["RegNpcCreatedEvent"] = 1;
TBL_AllOCEV["RegRightClickEvent"] = 1;
TBL_AllOCEV["RegEquipmentLevelEvent"] = 1;
TBL_AllOCEV["RegSealEvent"] = 1;
TBL_AllOCEV["RegPetRideImageEvent"] = 1;
TBL_AllOCEV["RegWarpEvent"] = 1;
TBL_AllOCEV["RegDropEvent"] = 1;
TBL_AllOCEV["RegGetExpEvent"] = 1;
TBL_AllOCEV["RegTalkEvent"] = 1;
TBL_AllOCEV["RegPetLevelUpEvent"] = 1;
TBL_AllOCEV["RegGetLoginPointEvent"] = 1;
TBL_AllOCEV["RegBattleStartEvent"] = 1;
TBL_AllOCEV["RegHeadCoverEvent"] = 1;
TBL_AllOCEV["RegMergeItemEvent"] = 1;
TBL_AllOCEV["RegCharActionEvent"] = 1;
TBL_AllOCEV["RegBattleSurpriseEvent"] = 1;
TBL_AllOCEV["RegBattleExitEvent"] = 1;
TBL_AllOCEV["RegPartyEvent"] = 1;
TBL_AllOCEV["RegShutDownEvent"] = 1;
TBL_AllOCEV["RegProductSkillExpEvent"] = 1;
TBL_AllOCEV["RegTechOptionEvent"] = 1;
TBL_AllOCEV["RegTitleChangedEvent"] = 1;
TBL_AllOCEV["RegMakeItemStringEvent"] = 1;
TBL_AllOCEV["RegAllOutEvent"] = 1;   -- 玩家退出事件（包括大登出与掉线）
TBL_AllOCEV["ScriptCall"] = 1;       -- luac.lua可以分别注册了

dofile("lua/System/BaseModule/Base.lua");

dofile("lua/System/OtherModule/PetCal.lua");
dofile("lua/System/OtherModule/Const.lua");
dofile("lua/System/OtherModule/MyJson.lua");
dofile("lua/System/OtherModule/Util.lua");
dofile("lua/System/OtherModule/MyChar.lua");
dofile("lua/System/OtherModule/MyPet.lua");
dofile("lua/System/OtherModule/MyPlayer.lua");
dofile("lua/System/OtherModule/MyEnemy.lua");
dofile("lua/System/OtherModule/MyEnemyData.lua");
dofile("lua/System/OtherModule/MyItem.lua");
dofile("lua/System/OtherModule/MyDataItem.lua");
dofile("lua/System/OtherModule/MyLimit.lua");

dofile("lua/System/BaseModule/luac.lua");

gadofile("lua/System/BaseModule/NEvent.lua");
gadofile("lua/System/BaseModule/powersend.lua");
gadofile("lua/System/BaseModule/trycatch.lua");
gadofile("lua/System/BaseModule/newflg.lua");
gadofile("lua/System/BaseModule/newrecipe.lua");

gadofile("lua/System/OtherModule/TaskHandler.lua");--定时任务处理
gadofile("lua/System/OtherModule/CommonEventHandler.lua");--通用事件处理

--客户端界面
--gadofile("lua/Module/client/BossClient.lua");

gadofile("lua/Module/sys/CharEquip.lua");
--业务功能
gadofile("lua/Module/player/PartyBuff.lua");--组队加成
gadofile("lua/Module/pet/PetAwakening.lua"); -- 宠物觉醒
gadofile("lua/Module/pet/PetProficient.lua"); -- 种族专精&秘境
gadofile("lua/Module/pet/PetSynthesis.lua"); -- 宠物融合
gadofile("lua/Module/pet/PetTalent.lua"); -- 宠物天赋
gadofile("lua/Module/pet/PetSkill.lua"); -- 宠物技能
gadofile("lua/Module/player/RoutineTask.lua"); -- 日常任务
gadofile("lua/Module/player/WorldBoss.lua"); --世界boss
gadofile("lua/Module/player/GodGift.lua");--天降礼包
gadofile("lua/Module/player/Pk.lua");--团队淘汰赛
gadofile("lua/Module/player/SinglePk.lua");--个人积分赛
gadofile("lua/Module/player/Vip.lua");--vip系统
gadofile("lua/Module/player/Tax.lua");--税务系统
gadofile("lua/Module/player/Recover.lua");--组队加成
gadofile("lua/Module/player/Warp.lua");--传送
gadofile("lua/Module/player/Clan.lua");--家族帮派
gadofile("lua/Module/player/Home.lua");--家园
gadofile("lua/Module/player/Challenge.lua");--BOSS挑战
gadofile("lua/Module/player/Test.lua");
gadofile("lua/Module/player/PingFen.lua");

gadofile("lua/Module/product/ItemManager.lua");--物品信息管理，包括宠物
gadofile("lua/Module/product/AutoProduct.lua");--自动制造
gadofile("lua/Module/product/ProductEquip.lua");--制造装备
gadofile("lua/Module/product/SellerConfig.lua");--售卖配置
gadofile("lua/Module/product/Seller.lua");--售卖商人
gadofile("lua/Module/product/GoldCardTrade.lua"); --金卡兑换

--系统通用事件
gadofile("lua/Module/sys/Damage.lua");
gadofile("lua/Module/sys/Exp.lua");--系统经验
gadofile("lua/Module/sys/GeneralCommand.lua");--通用命令
gadofile("lua/Module/sys/GmCommand.lua");--gm命令
gadofile("lua/Module/sys/CharInit.lua");--角色初始化
gadofile("lua/Module/sys/BattleInit.lua");--战斗初始化

dofile("lua/Config.lua");

-- 兼容Delegate
for key,Func in ipairs(tbl_delegate_Init) do
	local f = loadstring(Func.."()");
	f();
end

-- ABundle 3.1
gadofile("lua/ABundle/Core31.lua");
gadofile("lua/ABundle/gacenter.lua");
gadofile("lua/ABundle/Config.lua");
GAcenterOpen = true
