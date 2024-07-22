
----------------
-- × 禁止修改 ×
----------------
SG_PetSkill = {}
SG_PetSkill.Npc = {metamo = 100602, map = 64124 ,posx = 19 ,posy = 7 ,faceto = 4 ,name= "宠物技能删除" , showname = 1, namecolor=5}
SG_PetSkill.PetKill = 0
SG_PetSkill.Table = {}

function SG_PetSkill_Npc_Talked( _npc, _PlayerIndex)
		local tab={};
		local tabnopet={};
		local petisok=0;
		local buf="";
		for t = 1,5 do		
			local PetIndex =Char.GetPetIndex(_PlayerIndex,t-1);
			if (PetIndex>0) then 
				buf=Char.GetData( PetIndex, %对象_原名%);
			else 
				petisok=petisok+1;
				buf="无宠物";				
			end
			tab[t]=buf;			
		end	
		if(petisok==5)then
			NLG.ShowWindowTalked1(_PlayerIndex,0,2,999,"\n\n\n你身上一只宠物都没有......",_npc);
			return;
		end
		NLG.ShowWindowTalked1(_PlayerIndex,2,2,70,
				"2\n".."请选择"..
				"\n\n".."☆["..tab[1].."]☆"..
				"\n"..  "☆["..tab[2].."]☆"..
				"\n"..  "☆["..tab[3].."]☆"..
				"\n"..  "☆["..tab[4].."]☆"..
				"\n"..  "☆["..tab[5].."]☆",
				_npc);
			
			return -1

end


function SG_PetSkill_Npc_Window(  _npc, _PlayerIndex, _seqno, _select, _data )
	

	if _select == 2 and tonumber(_data)==nil or _select == 2 and tonumber(_data) < 0  then return end
	--if _select == 0 then return end
	local _cdkey = Char.GetData( _PlayerIndex, 2002)
	local _regist = Char.GetData( _PlayerIndex, 48)
	local level = Char.GetData(_PlayerIndex,%对象_等级%)
	if _seqno >= 70 and _seqno <= 75  then -- 宠物技能删除
		if _seqno == 70	then 
			local PetIndex = Char.GetPetIndex(_PlayerIndex,tonumber(_data)-1)
			if PetIndex < 0 then 
				local message = 
				"★★★★★★★★★ 宠物技能删除 ★★★★★★★★★"..
				"\\n---------------------------------------------"..
				"\\n\n\n\n$6该位置没有宠物$0"
				NLG.ShowWindowTalked1(_PlayerIndex,0,2,999,message,_npc);
				return
			end	
			local _msg = "1\n".."请选择要删除的技能\n"
			local Slots = Char.GetData(PetIndex,%对象_技能栏%)
			SG_PetSkill.Table[_PlayerIndex]= {}		
			if Slots >= 0 then    	
      			for i=0,Slots-1 do
           			local tech_id = Pet.GetSkill(PetIndex,i)
           			--print(i,tech_id)
           			if tech_id >= 0 then
	           			_msg = _msg..tbl_Techset[tostring(tech_id)][1].."\n"           			
	           			table.insert(SG_PetSkill.Table[_PlayerIndex],tech_id)	           			
               		else
	               		_msg = _msg.."\n"	
	               		table.insert(SG_PetSkill.Table[_PlayerIndex],"")
           			end
     			end
   			end
   			NLG.ShowWindowTalked1(_PlayerIndex,2,2,70+tonumber(_data),_msg,_npc);
   		end	
   		if _seqno >= 71 and _seqno <= 75 and tonumber(_data) ~= 99 then
			local PetIndex = Char.GetPetIndex(_PlayerIndex,_seqno-71)
			local skill = SG_PetSkill.Table[_PlayerIndex][tonumber(_data)]			
			if skill == nil then 
				local message = 
				"★★★★★★★★★ 宠物技能删除 ★★★★★★★★★"..
				"\\n---------------------------------------------"..
				"\\n\n\n\n$6发现错误 请联系管理1$0"
				NLG.ShowWindowTalked1(_PlayerIndex,0,2,999,message,_npc);
				return
			end	
			local SkillName = tbl_Techset[tostring(skill)][1]
			local delete_slot = Pet.DelSkill(PetIndex,tonumber(_data)-1) 
    		if delete_slot >= 0 then
	    		NLG.UpChar(_PlayerIndex)
	    		Pet.UpPet(_PlayerIndex,PetIndex)	    		
	    		local message = 
				"★★★★★★★★★ 宠物技能删除 ★★★★★★★★★"..
				"\\n---------------------------------------------"..
				"\\n\n\n\n成功删除了宠物技能$6["..SkillName.."]$0"
				NLG.ShowWindowTalked1(_PlayerIndex,0,2,999,message,_npc);
				return
			else
				local message = 
				"★★★★★★★★★ 宠物技能删除 ★★★★★★★★★"..
				"\\n---------------------------------------------"..
				"\\n\n\n\n$6发现错误 请联系管理2$0"
				NLG.ShowWindowTalked1(_PlayerIndex,0,2,999,message,_npc);
				return	
   			end			
		end	
		

end


	return
end



function SG_PetSkill_Npc_Init( _npc )
	Char.SetData(_npc, 1, SG_PetSkill.Npc.metamo)
	Char.SetData(_npc, 2, SG_PetSkill.Npc.metamo)
	Char.SetData(_npc, 3, 0)
	Char.SetData(_npc, 4, SG_PetSkill.Npc.map)
	Char.SetData(_npc, 5, SG_PetSkill.Npc.posx)
	Char.SetData(_npc, 6, SG_PetSkill.Npc.posy)
	Char.SetData(_npc, 7, SG_PetSkill.Npc.faceto)
	Char.SetData(_npc, 2000, SG_PetSkill.Npc.name)
	Char.SetData(_npc, 44, SG_PetSkill.Npc.namecolor)
	NLG.SetShowName(_npc,1)
	if (Char.SetTalkedEvent(nil, "SG_PetSkill_Npc_Talked", _npc) < 0) then
		print("SG_PetSkill_Npc_Talked")
		return false
	end
	if (Char.SetWindowTalkedEvent(nil, "SG_PetSkill_Npc_Window", _npc) < 0) then
		print("SG_PetSkill_Npc_Window")
		return false
	end
	return true
end

if LuaNpcIndex["SG_PetSkill_Npc_Index"] == nil then
	LuaNpcIndex["SG_PetSkill_Npc_Index"] =  NL.CreateNpc(nil,"SG_PetSkill_Npc_Init");
	NLG.UpChar(LuaNpcIndex["SG_PetSkill_Npc_Index"]);
else
	NL.DelNpc(LuaNpcIndex["SG_PetSkill_Npc_Index"])
	LuaNpcIndex["SG_PetSkill_Npc_Index"] =  NL.CreateNpc(nil,"SG_PetSkill_Npc_Init");
	NLG.UpChar(LuaNpcIndex["SG_PetSkill_Npc_Index"]);	
end