                                            ---------------------------------------------------------
                                            -- GA�ṩ��ѽű�--���ṩʹ�ð���--������ο��ű���ע��--
											-- �����Ҫ���ƽű�(��������)  ����ϵQQ:715837         --
                                            ---------------bbs.ml30.com��������----------------------


--20231127�������,������������ ��ҵ����ѯ���� ���ܽ��涨����ϵphoenix QQ715837
--���θ��¸�лluaд�� ���� (QQ158471323) �ṩ����lua���ܽű�
useModule("SG_ga");--Ĭ��֧�ֿ�
useModule("All_canshu");--���ֽű����ò���-ɵ�ϰ�
useModule("user")--��¼ֱ��ע��,mac��д��tbl_user��IP�ֶ�,�޸�����ο�All_canshu.lua
useModule("animesps");--ͼ����Ȩ(����������Ѱ�)
useModule("zdzd_can");--�Զ�ս�����
useModule("zdzd");--�Զ�ս�����
--useModule("xzdzd_can");--�Զ�ս�����
--useModule("xzdzd");--�Զ�ս�����
useModule("Login_can");--ԭ�ص�¼���
useModule("Login");--ԭ�ص�¼���
useModule("getpetBp");--�����㵵 ��ϰ�ť
useModule("shop_canshu");--�����̳������ļ�
useModule("shop");--�����̳����ļ�

useModule("fram");--������ѯ
--useModule("laba");--����
--useModule("wgfy");--������ӡʦ��ѯ���wgfy.php
--useModule("TitleChange");--�ƺŸ�������
--useModule("phb");--���а�
--�������
--��һ��npc ��ҶԻ��������ñ���Ϊnpc����
--[[
block
luac likeme
]]
--�������
--����һ���������Ϊnpc����
--[[
block
luac petme
]]

--��ɫ����,�������
--[[
����	��ɫ����				LUA_useM1						76411	98893	0	26		0	1	0	72	1	1	1	1	0																																																										1	100502					0	0	1	0		0			100	0	0	0	0	0
����	�������				LUA_useM1						76412	98893	0	26		0	1	0	72	1	1	1	1	0																																																										2	100452					0	0	1	0		0			100	0	0	0	0	0
]]
useModule("sellpet");--���ﷷ���۸�
--[[
Ұ�����ȼ�*10
1��BB��
1-100�����̶�100ħ��
101-�������ȼ�*500ħ��
]]--

--[[����endevent��չ,�÷����ٷ�һ�� �������65535   ���Դ�1000��ʼ�����ظ�]]
--[[
block endevent 1001 == 1
endwindow"�Ѿ���ȡ����"
block
endevent 1001 = 1
checktitle
endwindow"��ȡ�ɹ�"

titleconfig.txt
endflg=1001,TITLE=888001

titlename.txt
888001	���Գƺ�
]]

--����lua
useModule("ac");--�ۺ� ����Ƶ�� ��������л�
--useModule("mijing");--�ؾ���ս
--[[block
 showmj
 ]] --���������ο� lua/System/BaseModule/luac.lua
useModule("astarsive_can");--�Զ�Ѱ·F3 ����20221027�����Թ���ͼ-��ʧʱ��
useModule("astarsive");--�Զ�Ѱ·F3
useModule("Team_Service");--���T�˽���
--itemset.txt��,����ϴ����ָ����λ,������lua/System/BaseModule/luac.lua

--useModule("actioninfonpc");--ȫ�ֵ��� �����޶�ʱ�� �޶����� ���� �ȼ�(��������������800��Ҫʹ��)

useModule("SG_Pet_Shop2_can");--�������������ļ�
useModule("SG_Pet_Shop2");--��������
useModule("ShopQuery_can");--�������������ļ�
useModule("ShopQuery");--��������

useModule("Battle_eryebeibao_can") -- ��չ����
useModule("Battle_eryebeibao") -- ��չ����
--20210618����
useModule("ChiBang3_can");--��������ļ�
useModule("ChiBang3");--���
useModule("zuoqi2_can");--�������������ļ�
useModule("zuoqi2");--��������
useModule("qiandao2_can");--ǩ��
useModule("qiandao2");--ǩ��
useModule("shuxing_can");--ְҵBP�л�
useModule("shuxing");--ְҵBP�л�
useModule("Streng_can");--����ǿ��(��ɫ,��������ǿ��)
useModule("Streng");--����ǿ��(��ɫ,��������ǿ��)
useModule("xingxiang_can");--��ɫ״̬�� ����״̬�� �¹�
useModule("xingxiang");--��ɫ״̬�� ����״̬�� �¹�
useModule("xiang_can");--��ħ,��ħ,��ħ,���＼��ѧϰ,��ɫ����ѧϰ
useModule("xiang");--��ħ,��ħ,��ħ,���＼��ѧϰ,��ɫ����ѧϰ
--[[20230222��ħ������ħЧ��
����ˮ	��ħ��L10				LUA_useJuMo						1078	26232	0	26		0	1	0	0	1	1	0	10	0	100	100			0	0	0	0	0	0																																															100	10	10					0	0	1			0	450012	450012	100	0	0			0
--���������д����
--�Ӳ���һ����С��������
--�Ӳ������������������
�㣿	��ħ��3����				LUA_useQuMo						1069	26253	7500	26		0	1	0	0	1	1	1	1		180	180			0	0																																																										0	0	1			0		70001	100	0	0			
--�;ã�����ʱ�䣨��λ�룩
�㣿	��ħ��[100]				LUA_useInTohelos						1072	26256		26		0	1	0	0	1	1	1	1		100	100			0	0																																																										0	0	1			0	70003	70001	100	0	0			0
--�;ã�����
���ܾ�	���＼��ѧϰ��				LUA_usePetAddSkill						106	27815	0	26		0	1	0	0	1	1	1	10	0					0	0																																																			0	7300	14					0	0	1			0	70037	70001	0	0	0			0
--�Ӳ�������Ҫѧϰ��TechID 
��?	���＼��ѧϰ��				LUA_useCharAddSkill						105	27814		26		0	1	0	0	1	1	1	1	0					0	0	0	0	0	0																																															95	0	1					0	1	0			0	945077	945077	100	0	0			0
--�������Ҫѧϰ���ܵ�Skillid
ҩˮ��	��������ҩˮ				LUA_usePetReBirth						108	26206		26		0	1	0	72	1	1	1	1	0					0																																																											0	0	1			0	70019	70001	100	0	0			0

	NL.RegItemString(nil,"Pack","LUA_usePack"); --ע�����ܴ����
	NL.RegItemString(nil,"UnPack","LUA_useUnPack"); --ע�����ܽ����
	NL.RegItemString(nil,"InQuMo2","LUA_useQuMo2"); --ע����ħ�� ����
	NL.RegItemString(nil,"InTohelos","LUA_useInTohelos"); --ע����ħ��
	NL.RegItemString(nil,"InJuMo","LUA_useJuMo"); --ע����ħ��
	NL.RegItemString(nil,"InQuMo","LUA_useQuMo"); --ע����ħ��  ʱ��
	NL.RegItemString(nil,"CharAddSkill","LUA_useCharAddSkill"); -- ���＼�ܿ��ټ���
	NL.RegItemString(nil,"PetAddSkill","LUA_usePetAddSkill"); -- ���＼�ܿ��ټ���
	NL.RegItemString(nil,"PetReBirth","LUA_usePetReBirth"); --ע�����ϴ��ҩˮ

��� ��һ����ȡ��
]]

--[[
block
luac itemreb
#����������Ʒ����һ�����(�ǵ�Ҫ�ж��Ƿ��е��ߺ͵�������)
]]
useModule("zhaxiang");--ȫ�ӱ�ݲ���
--[[
/z   ��������
/g  ��¼��ǰ��Ա
/a	�������
/dak	ȫ�ӿ�����
/dag	ȫ�ӹرմ�
]]

--�����Ӱ�
useModule("reconnection");--����ս����������
useModule("SG_PetDelSkill");--���＼��ɾ��
useModule("ItemPetBP_can");--���ټӵ�
useModule("ItemPetBP");--���ټӵ�
--20231127

useModule("newflg");
useModule("npcms");