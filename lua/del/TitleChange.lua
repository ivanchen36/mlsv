local bangdingkey = 1 --�Ƿ�󶨱����ӹ��ƺŵ�ˮ�� 1Ϊ�� ����Ϊ���� �����
local renamekey = 1 --�Ƿ��޸ı����ӳƺ�ˮ�������� 1Ϊ�޸� ����Ϊ���޸�
local TitalValue = {}
--TitalValue[t] = {name,x1,k1,y1,x2,k2,y2} 
--tΪ�ƺ�id nameΪ�ƺ����� xϵ��Ϊ�ֶ� kϵ��Ϊ�޸ķ�ʽ 1Ϊ����ʽ 0Ϊ����ʽ yϵ��Ϊ��ֵ
--TitalValue[] = {}
TitalValue[87] = {"��η�ļž�",%����_����%,1,40,%����_����%,1,40,%����_����%,1,40,%����_����%,1,40,%����_����%,1,300}
TitalValue[114] = {"����ʦ��",%����_����%,1,80,%����_����%,1,20,%����_����%,1,200}
TitalValue[124] = {"ս��ʦ��",%����_����%,1,80,%����_����%,1,20,%����_����%,1,200}
TitalValue[134] = {"������ʿ",%����_����%,1,80,%����_����%,1,20,%����_����%,1,200}
TitalValue[144] = {"����ʦ��",%����_����%,1,80,%����_����%,1,20,%����_����%,1,200}
TitalValue[154] = {"ʿ����",%����_����%,1,80,%����_����%,1,20,%����_����%,1,200}
TitalValue[164] = {"����",%����_����%,1,30,%����_�ظ�%,1,20,%����_����%,1,100,%����_ħ��%,1,150}
TitalValue[174] = {"ħ��ʿ",%����_����%,1,60,%����_����%,1,100,%����_ħ��%,1,150}
TitalValue[184] = {"��ͷʦ",%����_����%,1,60,%����_����%,1,100,%����_ħ��%,1,150}
TitalValue[194] = {"��ӡ��ʦ��",%����_����%,1,50,%����_����%,1,300}
TitalValue[224] = {"թ��ʦ",%����_����%,1,60,%����_����%,1,300}
TitalValue[234] = {"������ʦ",%����_����%,1,30,%����_�ظ�%,1,20,%����_����%,1,100,%����_ħ��%,1,150}
TitalValue[244] = {"�񶷼�ʦ��",%����_����%,1,120,%����_����%,1,20,%����_����%,1,100}
TitalValue[254] = {"Ӱ",%����_����%,1,60,%����_����%,1,300}
TitalValue[4048] = {"�ʼұ���ʦ",%����_����%,1,80,%����_����%,1,20,%����_����%,1,200}
TitalValue[5004] = {"Բ����ʿ",%����_����%,1,160,%����_����%,1,20,%����_����%,1,300}
TitalValue[5009] = {"Zeus",%����_����%,1,160,%����_����%,1,20,%����_����%,1,300}
TitalValue[5014] = {"̫����ʦ",%����_����%,1,120,%����_����%,1,150,%����_ħ��%,1,200}
TitalValue[5019] = {"�ޱ���",%����_����%,1,160,%����_����%,1,20,%����_����%,1,300}
TitalValue[5029] = {"��",%����_����%,1,160,%����_����%,1,20,%����_����%,1,300}
TitalValue[5024] = {"����",%����_����%,1,120,%����_����%,1,150,%����_ħ��%,1,200}
TitalValue[5034] = {"��Ҷ������",%����_����%,1,160,%����_����%,1,20,%����_����%,1,200,%����_ħ��%,1,200}
TitalValue[5040] = {"��ʥ��ʦ",%����_����%,1,40,%����_����%,1,40,%����_����%,1,150,%����_ħ��%,1,200}
TitalValue[1009] = {"�����͵ڰ˵Ȅ���",%����_����%,1,50,%����_ħ��%,1,50}
TitalValue[1010] = {"�����͵��ߵȄ���",%����_����%,1,100,%����_ħ��%,1,100}
TitalValue[1011] = {"�����͵����Ȅ���",%����_����%,1,150,%����_ħ��%,1,150}
TitalValue[1012] = {"�����͵���Ȅ���",%����_����%,1,200,%����_ħ��%,1,200}
TitalValue[1013] = {"�����͵��ĵȄ���",%����_����%,1,250,%����_ħ��%,1,250}
TitalValue[1014] = {"�����͵����Ȅ���",%����_����%,1,300,%����_ħ��%,1,300}
TitalValue[1015] = {"�����͵ڶ��Ȅ���",%����_����%,1,20,%����_����%,1,20,%����_�ظ�%,1,20,%����_����%,1,400,%����_ħ��%,1,500}
TitalValue[1016] = {"�����͵�һ�Ȅ���",%����_����%,1,30,%����_����%,1,30,%����_�ظ�%,1,30,%����_����%,1,500,%����_ħ��%,1,600}
TitalValue[1017] = {"�����ڰ˵Ȅ���",%����_����%,1,100}
TitalValue[1018] = {"�������ߵȄ���",%����_����%,1,200}
TitalValue[1019] = {"���������Ȅ���",%����_����%,1,300}
TitalValue[1020] = {"��������Ȅ���",%����_����%,1,400}
TitalValue[1021] = {"�������ĵȄ���",%����_����%,1,500}
TitalValue[1022] = {"���������Ȅ���",%����_����%,1,600}
TitalValue[1023] = {"�����ڶ��Ȅ���",%����_����%,1,20,%����_�ظ�%,1,10,%����_����%,1,800}
TitalValue[1024] = {"������һ�Ȅ���",%����_����%,1,30,%����_�ظ�%,1,20,%����_����%,1,1000}
TitalValue[1043] = {"ħ�����",%����_����%,1,50,%����_����%,1,5,%����_˯��%,1,5,%����_ʯ��%,1,5,%����_��%,1,5,%����_�ҿ�%,1,5,%����_����%,1,5}
TitalValue[1044] = {"��֮������",%����_����%,1,100,%����_����%,1,10,%����_˯��%,1,10,%����_ʯ��%,1,10,%����_��%,1,10,%����_�ҿ�%,1,10,%����_����%,1,10}
TitalValue[1045] = {"��������",%����_����%,1,200,%����_����%,1,15,%����_˯��%,1,15,%����_ʯ��%,1,15,%����_��%,1,15,%����_�ҿ�%,1,15,%����_����%,1,15}
TitalValue[1048] = {"�����",%����_����%,1,300,%����_����%,1,20,%����_˯��%,1,20,%����_ʯ��%,1,20,%����_��%,1,20,%����_�ҿ�%,1,20,%����_����%,1,20}
TitalValue[61] = {"������",%����_����%,1,100,%����_��ɱ%,1,5,%����_����%,1,2,%����_����%,1,2,%����_����%,1,2}
TitalValue[4080] = {"���������",%����_��ɱ%,1,1,%����_����%,1,1,%����_����%,1,1,%����_����%,1,1}
TitalValue[4081] = {"��ӣ�������",%����_��ɱ%,1,2,%����_����%,1,2,%����_����%,1,2,%����_����%,1,2}
TitalValue[4082] = {"�����Ą���",%����_��ɱ%,1,3,%����_����%,1,3,%����_����%,1,3,%����_����%,1,3}
TitalValue[4083] = {"��ӣ���Ą���",%����_��ɱ%,1,4,%����_����%,1,4,%����_����%,1,4,%����_����%,1,4}
TitalValue[4084] = {"����������",%����_��ɱ%,1,5,%����_����%,1,5,%����_����%,1,5,%����_����%,1,5,%����_����%,1,50}
TitalValue[4085] = {"��ӣ��������",%����_��ɱ%,1,6,%����_����%,1,6,%����_����%,1,6,%����_����%,1,6,%����_����%,1,100}
TitalValue[4086] = {"���ڶ�����",%����_��ɱ%,1,7,%����_����%,1,7,%����_����%,1,7,%����_����%,1,7,%����_����%,1,150}
TitalValue[4087] = {"��ӣ�ڶ�����",%����_��ɱ%,1,8,%����_����%,1,8,%����_����%,1,8,%����_����%,1,8,%����_����%,1,200}
TitalValue[4088] = {"����һ����",%����_��ɱ%,1,9,%����_����%,1,9,%����_����%,1,9,%����_����%,1,9,%����_����%,1,250}
TitalValue[4089] = {"��ӣ��һ����",%����_��ɱ%,1,10,%����_����%,1,10,%����_����%,1,10,%����_����%,1,10,%����_����%,1,300}
TitalValue[5035] = {"���̽���",%����_����%,1,240,%����_��ɱ%,5,%����_����%,1,300}
TitalValue[5036] = {"�����һ�",%����_����%,1,50,%����_����%,1,20,%����_����%,1,300}
TitalValue[5041] = {"���紫˵",%����_����%,1,100,%����_����%,1,200}
TitalValue[5042] = {"���紫˵",%����_����%,1,100,%����_����%,1,200}
TitalValue[5043] = {"���紫˵",%����_����%,1,100,%����_����%,1,200}
TitalValue[5044] = {"���紫˵",%����_����%,1,100,%����_����%,1,200}

--[[���������������ֶα�
	%����_����%
	%����_����%
	%����_����%
	%����_����%
	%����_�ظ�%
	%����_��ɱ%
	%����_����%
	%����_����%
	%����_����%
	%����_����%
	%����_ħ��%
	%����_����%
	%����_˯��%
	%����_ʯ��%
	%����_��%
	%����_�ҿ�%
	%����_����%
	%����_ħ��%
]]

--*ע�⣺�����趨Ϊ����ʽʱ��������������ԭ�����ԡ���������������ʱʹ�á����ħ��������ֵ�������⣬����ֻʹ������ʽ��
--*���Ը�����ˮ���ϣ��粻����Ϊ�󶨣��ᵼ�¸��������Ե�ˮ�����׸����˵������
--*ˮ�����ӳƺ�����ʹ���ֶ� %����_���ò���% �����ظ�
--*���޸�ˮ�����֣�ʹ���ֶ� %����_��ǰ��% ��¼����ԭ�� �����ظ�
-------------------------------------------------------------

NL.RegTitleChangedEvent(nil,"TitleChangedEvent");



function TitleChangeValue1(TitleChangeValue8)
	local TitleChangeValue2 = Item.GetData(TitleChangeValue8,3)
	if TitleChangeValue2 == 22 then
		local TitleChangeValue3 = tonumber(Item.GetData(TitleChangeValue8,%����_��ʯ��%))
		if TitleChangeValue3 ~= nil and type(TitalValue[TitleChangeValue3]) == "table" then
			for i = 1,(#TitalValue[TitleChangeValue3]-1)/3 do
				local TitleChangeValue4 = TitalValue[TitleChangeValue3][2+(i-1)*3]
				local TitleChangeValue5 = TitalValue[TitleChangeValue3][3+(i-1)*3]
				local TitleChangeValue6 = TitalValue[TitleChangeValue3][4+(i-1)*3]
				local TitleChangeValue7 = Item.GetData(TitleChangeValue8,TitleChangeValue4)
				if TitleChangeValue5 == 0 then
					Item.SetData(TitleChangeValue8,TitleChangeValue4,0)
				elseif TitleChangeValue5 == 1 then
					Item.SetData(TitleChangeValue8,TitleChangeValue4,TitleChangeValue7-TitleChangeValue6)
				end
			end
			Item.SetData(TitleChangeValue8,%����_��ʯ��%,0)
			if renamekey == 1 then
				Item.SetData(TitleChangeValue8,%����_����%,Item.GetData(TitleChangeValue8,%����_��ǰ��%))
			end
			return 1
		end
	end
	return 0
end
function TitleChangeValue9(TitleChangeValue12,TitleChangeValue8,TitleChangeValue10)
	for i = 1,(#TitalValue[TitleChangeValue10]-1)/3 do
		local TitleChangeValue4 = TitalValue[TitleChangeValue10][2+(i-1)*3]
		local TitleChangeValue5 = TitalValue[TitleChangeValue10][3+(i-1)*3]
		local TitleChangeValue6 = TitalValue[TitleChangeValue10][4+(i-1)*3]
		local TitleChangeValue7 = Item.GetData(TitleChangeValue8,TitleChangeValue4)
		Item.SetData(TitleChangeValue8,TitleChangeValue4,TitleChangeValue7*TitleChangeValue5+TitleChangeValue6)
	end
	--Item.SetData(TitleChangeValue8,%����_���ò���%,TitleChangeValue10)
	Item.SetData(TitleChangeValue8,%����_��ʯ��%,TitleChangeValue10)
	if renamekey == 1 then
		Item.SetData(TitleChangeValue8,%����_��ǰ��%,Item.GetData(TitleChangeValue8,%����_����%))
		Item.SetData(TitleChangeValue8,%����_����%,TitalValue[TitleChangeValue10][1])
	end
	if bangdingkey == 1 then
		Item.SetData(TitleChangeValue8,%����_������ʧ%,1)
		Item.SetData(TitleChangeValue8,%����_����%,0)
	end
	NLG.SystemMessage(TitleChangeValue12,"�õ��� "..TitalValue[TitleChangeValue10][1].." ��������")
end

function TitleChangedEvent(TitleChangeValue12,t1,TitleChangeValue11)
	for i = 7,27 do
		local TitleChangeValue8 = Char.GetItemIndex(TitleChangeValue12,i)
		if TitleChangeValue8 > 0 then
			if TitleChangeValue1(TitleChangeValue8) ~= 0 then
				Item.UpItem(TitleChangeValue12,i)
			end
		end
	end
	if type(TitalValue[TitleChangeValue11]) == "table" then
		local TitleChangeValue8 = Char.GetItemIndex(TitleChangeValue12,7)
		if TitleChangeValue8 > 0 then
			TitleChangeValue9(TitleChangeValue12,TitleChangeValue8,TitleChangeValue11)
			Item.UpItem(TitleChangeValue12,7)
		else
			NLG.SystemMessage(TitleChangeValue12,"���ӳƺ�����ʧ�ܡ���δװ��ˮ����")
		end
	end
	return
end
