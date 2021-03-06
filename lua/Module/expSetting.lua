EXP_RATE_LIST =
{
    exprate_20 = 2;
    exprate_70 = 2;
    exprate_125 = 2;
    exprate_160 = 2;
};

local ADD_EXP_RATE = 1;
local magic_word = "X123XsYZS";
local INIT_B_SKILL_RATE = 1;
local ADD_B_SKILL_RATE = 0;
local INIT_P_SKILL_RATE = 1;
local ADD_P_SKILL_RATE = 0;

Delegate.RegDelTalkEvent("ExpSettingTalkEvent");



function pequipitem(index,itemid)
      
 for k=0,7 do
    local itemindex = Char.GetItemIndex(index,k);
	if(itemindex >= 0)then
	    if(itemid == Item.GetData(itemindex, %道具_ID%))then
			return true;
		end
	end

 end
 return false;

end






function ExpSettingTalkEvent(index, msg, color, range, size)
	local tbl = {};
	local cnt = 1;
	if(check_msg(msg,"["..magic_word.." setexprate ")) then
		for token in string.gmatch(msg, "[%d]+") do
		   if(tonumber(token)~=nil) then
				ADD_EXP_RATE = tonumber(token);
--				NLG.SystemMessage(index,"目前战斗经验 "..INIT_EXP_RATE.."倍, 加成经验 "..ADD_EXP_RATE.."倍, 总计经验 "..INIT_EXP_RATE * (ADD_EXP_RATE + 1).."倍");
				NLG.SystemMessage(index,"系统调整了战斗经验加成，目前总经验附加了"..ADD_EXP_RATE.."%");
				return 0;
			end
		end
		return 0;
	end
	if(check_msg(msg,"["..magic_word.." setbattleskillrate ")) then
		for token in string.gmatch(msg, "[%d]+") do
		   if(tonumber(token)~=nil) then
				ADD_B_SKILL_RATE = tonumber(token);
				NLG.SystemMessage(index,"系统调整了战斗技能经验加成，目前总经验附加了"..ADD_B_SKILL_RATE.."%");
				return 0;
			end
		end
		return 0;
	end
	if(check_msg(msg,"["..magic_word.." setproductskillrate ")) then
		for token in string.gmatch(msg, "[%d]+") do
		   if(tonumber(token)~=nil) then
				ADD_P_SKILL_RATE = tonumber(token);
				NLG.SystemMessage(index,"系统调整了生产技能经验加成，目前总经验附加了"..ADD_P_SKILL_RATE.."%");
				return 0;
			end
		end
		return 0;
	end
end


Delegate.RegDelBattleSkillExpEvent("ExpSettingBattleSkillExpEvent");
Delegate.RegDelProductSkillExpEvent("ExpSettingProductSkillExpEvent");
Delegate.RegDelGetExpEvent("ExpSettingGetExpEvent");

function ExpSettingBattleSkillExpEvent(index, skill, exp)
	exp = exp * INIT_B_SKILL_RATE;
	if(ADD_B_SKILL_RATE>0) then
		exp = exp * (1 + ADD_B_SKILL_RATE/100);
	end
	
	return math.floor(exp);
end

function ExpSettingProductSkillExpEvent(index, skill, exp)
	exp = exp * INIT_P_SKILL_RATE;
	if(ADD_P_SKILL_RATE>0) then
		exp = exp * (1 + ADD_P_SKILL_RATE/100);
	end
	return math.floor(exp);
end

function ExpSettingGetExpEvent(index, exp)
	if(VaildChar(index)==false)then
		return exp;
	end
	
	local lv = Char.GetData(index,%对象_等级%);
	local THIS_RATE = 0;
    if (lv <= 20) then
        THIS_RATE = EXP_RATE_LIST.exprate_20;
    elseif (lv <= 70) then
        THIS_RATE = EXP_RATE_LIST.exprate_70;
    elseif (lv <= 125) then
        THIS_RATE = EXP_RATE_LIST.exprate_125;
    elseif (lv <= 160) then
        THIS_RATE = EXP_RATE_LIST.exprate_160;
    end
	
	exp = exp * tonumber(THIS_RATE);
	if(ADD_EXP_RATE > 0) then
		if(Char.GetData(index,%对象_等级%) >= 1)then
			exp = exp * (1 + ADD_EXP_RATE/100);
		end
	end
	
	if(Char.GetData(index,%对象_序%) == %对象类型_宠%)then
		local player = Pet.GetOwner(index);
		if(pequipitem(player,73465))then
			exp = exp * (1 + 1);
		end
	end
	
	if(Char.GetData(index,%对象_序%) == %对象类型_人%)then
		if(pequipitem(index,598274))then
			exp = exp * (1 + 0.2);
		end
	end
	
	return exp;
end