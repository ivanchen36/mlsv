local WelcomeMessage = {};--��ӭ��
table.insert(WelcomeMessage,"bbs.ml30.com");

Delegate.RegDelLoginEvent("Welcome_LoginEvent");

function Welcome_LoginEvent(player)
	if (WelcomeMessage ~= nil) then --��ӭ��
		for _,text in ipairs(WelcomeMessage) do
		      NLG.TalkToCli(player,-1,text,%��ɫ_��ɫ%,%����_С%);
		end
		NLG.TalkToCli(player,-1,"��ӭʹ��GA��Ѱ�windows�����ˡ�GM��������[gm gold 1]",%��ɫ_��ɫ%,%����_С%);
		NLG.TalkToCli(player,-1,"��ǰ�汾Ϊ���԰�,��ҵ����ο�bbs.ml30.com",%��ɫ_��ɫ%,%����_С%);
		NLG.SystemMessage(player,"���������Զ�Ѱ· F3 F4 ����   �Զ�ս��F1 F2 F5");
		NLG.TalkToCli(player,-1,"�����ؾ�ϵͳblock showmj ����Ƶ����������������ɫ�Ա�",%��ɫ_��ɫ%,%����_��%);
	end
	
end