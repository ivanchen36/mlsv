--time 2020.08.05
--�����̯
--֧�������Զ���̯ ֧��һ������
--���ܱ�д:QQ501874912
--===================================================================
local TalkEvent = "[2]" 	-- ������������
local DiyStall = {"#jk","#mb"};--���ó����������
local DiyName = {"ħ��","��"};
local DiyItemID = 88888; --�𿨱��
local DiyItemMax = 100000;--Ǯ�����ֵ
local DiyShopPetName = "������[����]"
local DiyStallMap = {1000};--ֻ��������Щ��ͼ��������
local DiyStallGooldMax = 100000000;--ħ���������
local DiyStallLevel = 1;--������߼��������ܽ�������
--local Loyalty = 100 --�������ӵ�ж����ҳϲ�������
local DiyNpc = {1000,231,93,100000,"������۹���",4};--������ȡNPC,˵��:
local Renewal = 100 --	һ������̯����: ÿֻ�������Ѽ۸�
---------------��ͼ���,��ͼX����,��ͼY����,NPC����,NPC����,NPC����-----------------
Global_PetStallData = { DiyStall,DiyName,DiyItemID,DiyItemMax,DiyShopPetName,DiyStallMap,DiyStallGooldMax,DiyStallLevel,DiyNpc,Renewal,TalkEvent }
useModule("PetStallB");
--===================================================================