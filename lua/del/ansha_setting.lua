-- 出概率 百分比
ansha_tbl= {4,8,12,16,20,24,28,32,36,40};

-- 计算暗杀几率
-- pet 释放暗杀的宠物
-- deobject 被暗杀的对象
-- 暗杀等级 1~10
-- 返回值：几率 譬如返回40% 即有40%的几率出暗杀 返回100表示100%出暗杀
function select_ansha(pet,deobject,techlv)
	
	-- 在这里可以计算双方的属性、等级或各种关系，自行定义出暗杀的几率
	-- 演示版就直接固定暗杀几率为ansha_tbl
	
	local player = Pet.GetOwner(pet)
	if Battle.IsBossBattle(Char.GetBattleIndex(player)) == 1 then -- boss战，默认不出
		return 0;
	end
	
	return ansha_tbl[techlv];
end