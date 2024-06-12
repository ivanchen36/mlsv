Protocol.OnRecv("lua/Module/ansha.lua", "ansha_zhandouRecv", 7);

-- 出概率 百分比
ansha_tbl= {4,8,12,16,20,24,28,32,36,40};
ansha_tbl2= {5,5,5,5,5,5,5,5,5,100};

function ansha_zhandouRecv(fd,head,packet)
	local player = Protocol.GetCharByFd(fd);
	--NLG.SystemMessage(player,packet.."");
	
	local SplitArray = Split(packet,"|");
	if SplitArray[1] == "W" and  SplitArray[2] ~= "FF" then -- 宠物技能 非什么都不做
		
		local pet = pet_getbattlepet(player);
		
		if pet_isattack(pet,SplitArray[2]) == false then
			return 0;
		end
		
		if Battle.IsBossBattle(Char.GetBattleIndex(player)) == 0 then -- 非boss战
			if Battle.IsWaitingCommand(pet) == 1 then	
				local petskill = pet_ansha(pet);
				--NLG.SystemMessage(player,ansha_tbl[petskill - 9600 + 1] );
				if NLG.Rand(1,100) < ansha_tbl[petskill - 9600 + 1] then		
				--if NLG.Rand(1,100) < 100 then		
					--NLG.SystemMessage(player,SplitArray[3]);
					local rt = pet_getactionpos(SplitArray[3])
					--NLG.SystemMessage(player,rt);
					Battle.ActionSelect(pet, 26, rt, petskill)
					return 1;
				end
			end

		end
		
		if Battle.IsBossBattle(Char.GetBattleIndex(player)) == 1 then -- boss战
			if Battle.IsWaitingCommand(pet) == 1 then	
				local petskill = pet_ansha(pet);
				--NLG.SystemMessage(player,ansha_tbl[petskill - 9600 + 1] );
				if NLG.Rand(1,100) < ansha_tbl2[petskill - 9600 + 1] then		
				--if NLG.Rand(1,100) < 100 then		
					--NLG.SystemMessage(player,SplitArray[3]);
					local rt = pet_getactionpos(SplitArray[3])
					--NLG.SystemMessage(player,rt);
					Battle.ActionSelect(pet, 26, rt, petskill)
					return 1;
				end
			end
		
		end
		return 0;
	end

end

function pet_isattack(pet,tak)
	local techid = Pet.GetSkill(pet, tonumber(tak))
	if techid == 7300 then 
		return true;
	end
	return false;
	
end

function pet_getactionpos(tak)
	tak = string.gsub(tak, "::", "");
	if(tak == "A")then
		return 10
	elseif(tak == "B")then
		return 11
	elseif(tak == "C")then
		return 12
	elseif(tak == "D")then
		return 13
	elseif(tak == "E")then
		return 14
	elseif(tak == "F")then
		return 15
	elseif(tak == "10")then
		return 16
	elseif(tak == "11")then
		return 17
	elseif(tak == "12")then
		return 18
	elseif(tak == "13")then
		return 19
	else
		return tonumber(tak)
	end
	
end

function pet_ansha(pet)
	for k=0,9 do
		local techid = Pet.GetSkill(pet, k)
		if techid >=9600 and techid <=9609 then
			return techid;
		end 
	end
	return -1;
end

function pet_getbattlepet(player)
	
	for k=0,4 do
		if Pet.GetStatus(player, k) == 2 then
			return Char.GetPet(player,k)
		end
	end
	
	return -1;
end