Delegate.RegDelTalkEvent("ng_TalkEvent");
Delegate.RegDelLoginEvent("button_LoginEvent");
Delegate.RegDelLoginEvent("skillset_LoginEvent");
Delegate.RegDelLoginEvent("chibangset_LoginEvent");
Delegate.RegDelLoginEvent("toushi_nilset_LoginEvent");

function skillset_LoginEvent(player)
--tech_ԭͼ��&��ͼ��, --Ϊ�����ֹٷ� techβ������λ Ϊ51��ʼ����Ч ����Ǭ�� 351~399 ��֧�ָ�����ͼ��
local skillset = "481_111055&111252,6381_110085&111154,6681_111019&111199,6681_110168&111019,"

	Protocol.SendLuaCustomPacket(player,"diyskill", skillset);

end

function chibangset_LoginEvent(player)
--���س��ͼ��
local chibangset = "119750,119751,"

	Protocol.SendLuaCustomPacket(player,"diychibang", chibangset);

end

function toushi_nilset_LoginEvent(player)
--����������Ĭ��ƫ��-65_-1ΪĬ��, -200_119751Ϊ�������� ������������ƺ�ͼ�� ֱ�Ӻ��� ƫ��_���
local chibangset = "-65_-1,-200_119751,"

	Protocol.SendLuaCustomPacket(player,"diytoushinil", chibangset);

end


function button_LoginEvent(player)

	Protocol.SendLuaCustomPacket(player,"diy6", "��ʾ���ص��ϵĳ���&|���T��&[TEAM]|�����㵵&[1]|��������&[2]|���͹�ս����&[3]|���߹һ�&[5]|test&[t3]|test&[t4]|test&[t5]|test&[t6]|�����̳�&[shop]|��ϵ�ͷ�&[6]|����QQȺ&[7]");

end

function open_url(player,link)
	Protocol.SendLuaCustomPacket(player,"openurl", link);
end

local GuanZhanPlayer = "";
function ng_TalkEvent(player,msg,color,range,size)
	
	if(msg == "/1")then
		local getXiangVar1 = Char.GetData(player,%����_�㲽��%);
		local getXiangVar2 = Char.GetData(player,%����_������%);
		if(getXiangVar1 > 0)then
			Char.SetData(player,%����_�㲽��%,0);
			Char.SetData(player,%����_������%,0);
			NLG.SystemMessage(player,"���������Ѿ��رգ�");
		else
			Char.SetData(player,%����_�㲽��%,999);
			Char.SetData(player,%����_������%,999);
			NLG.SystemMessage(player,"���������Ѿ�������");
		end
	end
	
	if(msg == "/2")then
		local getXiangVar1 = Char.GetData(player,%����_�����п���%);
		if(getXiangVar1 == 1)then
			Char.SetData(player,%����_�����п���%,0);
			NLG.SystemMessage(player,"�������Ѿ��رգ�");
		else
			Char.SetData(player,%����_�����п���%,1);
			NLG.SystemMessage(player,"�������Ѿ�������");
		end
	end
	
	if(msg == "/3")then
		--����������ͼ
		Protocol.SendLuaCustomPacket(player,"diyng", "GSQT");
	end

	if(msg == "/4")then
		--������������
		Protocol.SendLuaCustomPacket(player,"diyng", "GSZZ");
	end
	
	if(msg == "/5")then
		--�������ٲɼ�
		Protocol.SendLuaCustomPacket(player,"diyng", "GSCJ");
	end
	
	if(msg == "/6")then
		--��������ս��
		Protocol.SendLuaCustomPacket(player,"diyng", "GSZD");
	end
	
	if(msg == "/hc" or msg == "/HC" )then
		if Char.GetPartyMember(player,0) == player then
			Char.Warp(player,0,1000,240,80);
		else
			NLG.SystemMessage(player,"�Բ���ֻ�жӳ�����ʹ�ã�");	
		end
	end

	if msg == "/dk" then   ---��ݴ�
		local daka = Char.GetData(player, %����_��%);
		local money = Char.GetData(player,%����_���%);
		if daka == 0 and money >= 200 then
			Char.SetData(player,%����_���%,money-200);
			Char.FeverStart(player);
			NLG.UpChar(player);
			NLG.SystemMessage(player, "�۳�ħ��200G��");	
			NLG.SystemMessage(player, "��ϲ���򿨳ɹ���");	
			return ;
		end
		if daka == 1 and money >= 200 then
			Char.SetData(player,%����_���%,money-200);
			Char.FeverStop(player);
			NLG.UpChar(player);
			NLG.SystemMessage(player, "�۳�ħ��200G��");
			NLG.SystemMessage(player, "��ϲ���رմ򿨳ɹ���");	
			return ;
		end
		if money < 200 then
			NLG.SystemMessage(player, "����ħ�Ҳ������޷�ʹ�á�");	
			return ;
		end
	end
	
	if msg == "/jd" then  ----����
		local Count = 0
		for ItemSlot = 8,27 do
			local ItemIndex = Char.GetItemIndex(player, ItemSlot)
			local money = Char.GetData(player,%����_���%);
			local djdj = Item.GetData(ItemIndex,%����_�ȼ�%);
			local kcmb = djdj*200;
			if Item.GetData(ItemIndex, %����_�Ѽ���%)==0 and money >= (djdj*200) then
				Count = Count + 1
				Char.SetData(player,%����_���%,money-kcmb);
				Item.SetData(ItemIndex, %����_�Ѽ���%, 1)
				NLG.SystemMessage(player,"[ϵͳ] �������ĵ��ߵȼ�Ϊ"..djdj.."�����۳�ħ��"..kcmb.."G");
				NLG.SystemMessage(player,"[ϵͳ] �����ϵ� " .. Item.GetData(ItemIndex, %����_��ǰ��%) .. "�Ѽ���Ϊ " .. Item.GetData(ItemIndex, %����_����%))
				Item.UpItem(player, ItemSlot);
				NLG.UpChar(player);
				return ;
			end
		end
		if Count==0 then
			NLG.SystemMessage(player,"[ϵͳ] ������û����Ҫ��������Ʒ�������Ǯ�����Լ����˵��ߡ�");
			return;
		end
		return 0
	end
	
	if (msg == "/zl")then ---��������
		local CdKey = Char.GetData(player,2002);
		local shoushang = Char.GetData(player,%����_����%);
		local money = Char.GetData(player,%����_���%);
		for i = 0,4 do 
			local _petindex = Char.GetPet(player,i)
			if _petindex > 0 then 
				Char.SetData(_petindex,%����_����%,0);
				Pet.UpPet(player, _petindex)
			end	
		end	
		if(Char.GetData(player,%����_����%)<1) then
			NLG.SystemMessage(player,"��δ���ˡ�");
			return;
		end
		if(money>=200) and (Char.GetData(player,%����_����%)>0 and Char.GetData(player,%����_����%)<26) then
			Char.SetData(player,%����_����%,shoushang-shoushang);
			Char.SetData(player,%����_���%,money-200);
			NLG.UpdateParty(player);
			NLG.UpChar(player);
			NLG.SystemMessage(player,"��ϲ��������ϡ�");
			NLG.SendGraphEvent(player, 45, 0);
			NLG.SystemMessage(player,"�۳�200ħ�ҡ�");
			return;	
		end
		if(money>=400) and (Char.GetData(player,%����_����%)>24 and Char.GetData(player,%����_����%)<51) then
			Char.SetData(player,%����_����%,shoushang-shoushang);
			Char.SetData(player,%����_���%,money-400);
			NLG.UpdateParty(player);
			NLG.UpChar(player);
			NLG.SystemMessage(player,"��ϲ��������ϡ�");
			NLG.SendGraphEvent(player, 45, 0);
			NLG.SystemMessage(player,"�۳�400ħ�ҡ�");
			return;	
		end
		if(money>=800) and (Char.GetData(player,%����_����%)>49 and Char.GetData(player,%����_����%)<76) then
			Char.SetData(player,%����_����%,shoushang-shoushang);
			Char.SetData(player,%����_���%,money-800);
			NLG.UpdateParty(player);
			NLG.UpChar(player);
			NLG.SystemMessage(player,"��ϲ��������ϡ�");
			NLG.SendGraphEvent(player, 45, 0);
			NLG.SystemMessage(player,"�۳�800ħ�ҡ�");
			return;	
		end
		if(money>=1500) and (Char.GetData(player,%����_����%)>74 and Char.GetData(player,%����_����%)<101) then
			Char.SetData(player,%����_����%,shoushang-shoushang);
			Char.SetData(player,%����_���%,money-1500);
			NLG.UpdateParty(player);
			NLG.UpChar(player);
			NLG.SystemMessage(player,"��ϲ��������ϡ�");
			NLG.SendGraphEvent(player, 45, 0);
			NLG.SystemMessage(player,"�۳�1500ħ�ҡ�");
			return;	
		else
			NLG.SystemMessage(player,"�Բ�������ħ�Ҳ��㣬���Ƽ۸�Ϊ������200��������400��������800��������1500����");	
			return;
		end
		return 0
	end
	
	if(msg == "[pay]")then
		NLG.SystemMessage(player,"��ǰû�п�ͨ������ֵ,����ϵ�ͷ���");	
	end
	
	if(msg=="[3]") then 
		local money = Char.GetData(player,%����_���%);
		if(money>=100)then
			Char.SetData(player,%����_���%,money-100);
			NLG.UpChar(player);

			GuanZhanPlayer = player;
			NLG.SystemMessage(-1,"��"..Char.GetData(player,%����_����%).."������Զ�̹�սģʽ�ˡ�������/gz "..GuanZhanPlayer.."�ۿ�ս����");
			NLG.SystemMessage(player,"�۳�100ħ�ҡ�");
			return;	
		else
			NLG.SystemMessage(player,"�Բ�������ħ�Ҳ���100��");	
		end
	end

	if( check_msg(msg,"/gz ") ) then
		GuanZhanPlayer = tonumber(string.sub(msg,5))
		NLG.WatchBattle(player,GuanZhanPlayer);
	end	
	

	
	if(msg == "[5]")then
		NLG.SetOfflinePlayer(player, 9999999);
	end

	if(msg == "[lxgj]")then
		NLG.SetOfflinePlayer(player, 9999999);
	end

	if msg=="[6]" then
		open_url(player,"http://bbs.ml30.com");
	end
	if msg=="[7]" then
		open_url(player,"http://bbs.ml30.com");
	end
	
	
end
