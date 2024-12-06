--[[
���ű�ֻ����GA���漰������
�벻Ҫ�޸�һ���κ��ļ���˳��
��������չ�������Config.lua������
]]

-- ����Ҫ������Event����ע�͵��ر�
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
TBL_AllOCEV["RegAllOutEvent"] = 1;   -- ����˳��¼���������ǳ�����ߣ�
TBL_AllOCEV["ScriptCall"] = 1;       -- luac.lua���Էֱ�ע����

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

gadofile("lua/System/OtherModule/TaskHandler.lua");--��ʱ������
gadofile("lua/System/OtherModule/CommonEventHandler.lua");--ͨ���¼�����

--�ͻ��˽���
--gadofile("lua/Module/client/BossClient.lua");

gadofile("lua/Module/sys/CharEquip.lua");
--ҵ����
gadofile("lua/Module/player/PartyBuff.lua");--��Ӽӳ�
gadofile("lua/Module/pet/PetAwakening.lua"); -- �������
gadofile("lua/Module/pet/PetProficient.lua"); -- ����ר��&�ؾ�
gadofile("lua/Module/pet/PetSynthesis.lua"); -- �����ں�
gadofile("lua/Module/pet/PetTalent.lua"); -- �����츳
gadofile("lua/Module/pet/PetSkill.lua"); -- ���＼��
gadofile("lua/Module/player/RoutineTask.lua"); -- �ճ�����
gadofile("lua/Module/player/WorldBoss.lua"); --����boss
gadofile("lua/Module/player/GodGift.lua");--�콵���
gadofile("lua/Module/player/Pk.lua");--�Ŷ���̭��
gadofile("lua/Module/player/SinglePk.lua");--���˻�����
gadofile("lua/Module/player/Vip.lua");--vipϵͳ
gadofile("lua/Module/player/Tax.lua");--˰��ϵͳ
gadofile("lua/Module/player/Recover.lua");--��Ӽӳ�
gadofile("lua/Module/player/Warp.lua");--����
gadofile("lua/Module/player/Clan.lua");--�������
gadofile("lua/Module/player/Home.lua");--��԰
gadofile("lua/Module/player/Challenge.lua");--BOSS��ս
gadofile("lua/Module/player/Test.lua");
gadofile("lua/Module/player/PingFen.lua");

gadofile("lua/Module/product/ItemManager.lua");--��Ʒ��Ϣ������������
gadofile("lua/Module/product/AutoProduct.lua");--�Զ�����
gadofile("lua/Module/product/ProductEquip.lua");--����װ��
gadofile("lua/Module/product/SellerConfig.lua");--��������
gadofile("lua/Module/product/Seller.lua");--��������
gadofile("lua/Module/product/GoldCardTrade.lua"); --�𿨶һ�

--ϵͳͨ���¼�
gadofile("lua/Module/sys/Damage.lua");
gadofile("lua/Module/sys/Exp.lua");--ϵͳ����
gadofile("lua/Module/sys/GeneralCommand.lua");--ͨ������
gadofile("lua/Module/sys/GmCommand.lua");--gm����
gadofile("lua/Module/sys/CharInit.lua");--��ɫ��ʼ��
gadofile("lua/Module/sys/BattleInit.lua");--ս����ʼ��

dofile("lua/Config.lua");

-- ����Delegate
for key,Func in ipairs(tbl_delegate_Init) do
	local f = loadstring(Func.."()");
	f();
end

-- ABundle 3.1
gadofile("lua/ABundle/Core31.lua");
gadofile("lua/ABundle/gacenter.lua");
gadofile("lua/ABundle/Config.lua");
GAcenterOpen = true
