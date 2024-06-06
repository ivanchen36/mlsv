local INIT_B_SKILL_RATE = 4;
local INIT_P_SKILL_RATE = 4;

ADD_EXP_RATE = 0;
ADD_B_SKILL_RATE = 0;
ADD_P_SKILL_RATE = 0;

local charEndTime = 0
local charSkillTime = 0
local charProductTime = 0

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

function setCharExp(rate, time)
	if ADD_EXP_RATE > rate then
		return 0
	end
	
	ADD_EXP_RATE = rate;
	charEndTime = os.time() + time;
	NLG.SystemMessage(-1,"[系统加成]系统调整了战斗经验加成，增加"..ADD_EXP_RATE.."%, 加成持续时间".. time / 3600 .. "小时");
	return 1
end

function setSkillExp(rate, time)
	if ADD_B_SKILL_RATE > 0 then
		return 0
	end
	ADD_B_SKILL_RATE = rate
	charSkillTime = os.time() + time;
	NLG.SystemMessage(-1,"[系统加成]系统调整了战斗技能经验加成，增加"..ADD_B_SKILL_RATE.."%, 加成持续时间".. time / 3600 .. "小时");
	return 1
end

function setProductExp(rate, time)
	if ADD_P_SKILL_RATE > 0 then
		return 0
	end
	ADD_P_SKILL_RATE = rate;
	charProductTime = os.time() + time;
	NLG.SystemMessage(-1,"[系统加成]系统调整了生产技能经验加成，增加"..ADD_P_SKILL_RATE.."%, 加成持续时间".. time / 3600 .. "小时");
	return 1
end

SkillExpEvent["sys"] = function (index, skill, rate)
	local exp = 100
	exp = exp * INIT_B_SKILL_RATE;
	if(ADD_B_SKILL_RATE>0) then
		if charSkillTime < os.time() then
			ADD_B_SKILL_RATE = 0;
			charSkillTime = 0
			NLG.SystemMessage(-1,"[系统加成]战斗技能经验加成结束。");
			return rate
		end
		exp = exp * (1 + ADD_B_SKILL_RATE/100);
	end
	
	return rate - 100 + math.floor(exp);
end

ProductExpEvent["sys"] = function (index, skill, rate)
	local exp = 100
	exp = exp * INIT_P_SKILL_RATE;
	if(ADD_P_SKILL_RATE>0) then
		if charProductTime < os.time() then
            ADD_P_SKILL_RATE = 0;
            charProductTime = 0
			NLG.SystemMessage(-1,"[系统加成]生产技能经验加成结束。");
            return rate
        end
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
		if charEndTime < os.time() then
            ADD_EXP_RATE = 0;
            charEndTime = 0
			NLG.SystemMessage(-1,"[系统加成]战斗经验加成结束。");
        end
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

function sysCharExp (regNum, info)
	local param = strSplit(info, "|")
	return setCharExp (tonumber(param[1]), tonumber(param[2]));
end

function sysSkillExp (regNum, info)
	local param = strSplit(info, "|")
	return setSkillExp (tonumber(param[1]), tonumber(param[2]));
end

function sysProductExp (regNum, info)
	local param = strSplit(info, "|")
	return setProductExp (tonumber(param[1]), tonumber(param[2]));
end

TaskHandler[3] = sysCharExp
TaskHandler[4] = sysSkillExp
TaskHandler[5] = sysProductExp