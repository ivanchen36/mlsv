local INIT_B_SKILL_RATE = 4;
local INIT_P_SKILL_RATE = 4;

local ADD_EXP_RATE = 0;
local ADD_B_SKILL_RATE = 0;
local ADD_P_SKILL_RATE = 0;

-- 道具_ID 0
function pequipitem(index,itemid)
 for k=0,7 do
    local itemindex = Char.GetItemIndex(index,k);
	if(itemindex >= 0)then
	    if(itemid == Item.GetData(itemindex, 0))then
			return true;
		end
	end

 end
 return false;
end

GetSysExpRate = function(player)
	local lv = player:getLevel();

	if (lv <= 40) then
		sysRate = 10;
	elseif (lv <= 70) then
		sysRate = 5;
	elseif (lv <= 100) then
		sysRate = 4;
	else
		sysRate = 3;
	end
	logPrint("sysRate:", sysRate)
end

function setCharExp(rate)
	ADD_EXP_RATE = rate;
	NLG.SystemMessage(-1,"系统调整了战斗经验加成，增加"..ADD_EXP_RATE.."%");
end

function setSkillExp(rate)
	ADD_B_SKILL_RATE = rate
	NLG.SystemMessage(-1,"系统调整了战斗技能经验加成，增加"..ADD_B_SKILL_RATE.."%");
end

function setProductExp(rate)
	ADD_P_SKILL_RATE = rate;
	NLG.SystemMessage(-1,"系统调整了生产技能经验加成，增加"..ADD_P_SKILL_RATE.."%");
end

ProductExpEvent["sys"] = function (index, skill, rate)
	local exp = 100
	exp = exp * INIT_B_SKILL_RATE;
	if(ADD_B_SKILL_RATE>0) then
		exp = exp * (1 + ADD_B_SKILL_RATE/100);
	end
	
	return rate - 100 + math.floor(exp);
end

ProductExpEvent["sys"] = function (index, skill, rate)
	local exp = 100
	exp = exp * INIT_P_SKILL_RATE;
	if(ADD_P_SKILL_RATE>0) then
		exp = exp * (1 + ADD_P_SKILL_RATE/100);
	end
	return rate - 100 + math.floor(exp);
end

CharExpEvent["sys"] = function(player, rate)
	local exp = 100
	if(not player:isValid())then
		return rate;
	end

	if(ADD_EXP_RATE > 0) then
		exp = exp * (1 + ADD_EXP_RATE/100);
	end
	
	if player:isPerson() then
		local player = Pet.GetOwner(index);
		if(pequipitem(player,73465))then
			exp = exp * (1 + 1);
		end
		return rate - 100 + exp;
	end
	
	if not player:isPerson() then
		if(pequipitem(index,598274))then
			exp = exp * (1 + 1);
		end
	end
	
	return rate - 100 + exp;
end