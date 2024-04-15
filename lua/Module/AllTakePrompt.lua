


PromptTable = {}

PromptTable.Item = {}
--PromptTable.Item[道具ID] = "提示语"
PromptTable.Item[672355] = "尊贵的☆钻石会员☆"
PromptTable.Item[672356] = "尊贵的★★王者会员★★"
PromptTable.Item[672357] = "尊贵的★☆★依旧王者会员★☆★"
PromptTable.endevent = {}
--PromptTable.endevent[endevent旗杆id] = "提示语"
PromptTable.endevent[20020] = "200"



Delegate.RegDelLoginEvent("Prompt_LoginEvent");

function Prompt_LoginEvent(player)

	for k,v in pairs(PromptTable.Item) do 
		if Char.ItemNum(player,k) > 0 then 
			NLG.SystemMessage(-1,""..v.." "..Char.GetData(player,%对象_名字%).." 上线了..");
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
