


PromptTable = {}

PromptTable.Item = {}
--PromptTable.Item[����ID] = "��ʾ��"
PromptTable.Item[672355] = "���ġ���ʯ��Ա��"
PromptTable.Item[672356] = "���ġ�����߻�Ա���"
PromptTable.Item[672357] = "���ġ����������߻�Ա����"
PromptTable.endevent = {}
--PromptTable.endevent[endevent���id] = "��ʾ��"
PromptTable.endevent[20020] = "200"



Delegate.RegDelLoginEvent("Prompt_LoginEvent");

function Prompt_LoginEvent(player)

	for k,v in pairs(PromptTable.Item) do 
		if Char.ItemNum(player,k) > 0 then 
			NLG.SystemMessage(-1,""..v.." "..Char.GetData(player,%����_����%).." ������..");
			break
		end
	end		
	for k,v in pairs(PromptTable.endevent) do 
		if Char.EndEvent(player,k) == 1 then 
			NLG.SystemMessage(-1,Char.GetData(player,2000)..v);
			break
		end
	end	

end
