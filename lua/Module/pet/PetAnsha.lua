local anshaEnemy = {
	[30004] = 900,
	[30008] = 1200,
}
local triggerAnshaSkill = {
 	[1] = 1, -- ÖîÈÐ
	[3] = 1, -- Ç¬À¤
	[5] = 1, -- ±À»÷
	[73] = 1, -- ¹¥»÷
	[262] = 1, -- Ñ¸ËÙ
	[257] = 1, -- ½ä½¾½äÔê
};
local attackPos = {["0"]=0, ["1"]=1, ["2"]=2, ["3"]=3, ["4"]=4, ["5"]=5, ["6"]=6, ["7"]=7, ["8"]=8, ["9"]=9, ["A"]=10, ["B"]=11, ["C"]=12, ["D"]=13, ["E"]=14, ["F"]=15, ["10"]=16, ["11"]=17, ["12"]=18, ["13"]=19};
local isAnshaBoss = true
local anshaSkillId = 9609

function isUseAnsha(pet, slot)
	local petId = pet:getId()
	if rawget(anshaEnemy, petId) == nil then
		return false
	end
	local skillId = math.floor(pet:getSkill(slot) / 100)
	logPrint("useansha ", skillId)
	if rawget(triggerAnshaSkill, skillId) then
		return isOccur(anshaEnemy[petId])
	end

	return false
end

function useAnsha(fd,head,packet)
	logPrint("useAnsha",  head, packet)
	local myPlayer = MyPlayer:new(Protocol.GetCharByFd(fd))

	local SplitArray = Split(packet,"|");
	if SplitArray[1] ~= "W" or  SplitArray[2] == "FF" then -- ³èÎï¼¼ÄÜ ·ÇÊ²Ã´¶¼²»×ö
		return 0
	end

	local pet = myPlayer:getBattlePet()
	if not pet:isValid() then
		return 0
	end
	if Battle.IsWaitingCommand(pet:getObj()) ~= 1 then
		return 0
	end

	local battle = myPlayer:getBattleIndex()
	if not isAnshaBoss and Battle.IsBossBattle(battle) == 1 then
		return 0
	end

	if not isUseAnsha(pet, tonumber(SplitArray[2])) then
		return 0
	end

	local pos = attackPos[string.gsub(SplitArray[3], "::", "")]
	logPrint("useAnsha", 26, SplitArray[3], pos, anshaSkillId)
	local tmpPlayer = MyPlayer:new(Battle.GetPlayer(battle, pos))
	if tmpPlayer:isValid() then
		if tmpPlayer:getHp() > pet:getMaxHp() * 2 then
			return 0
		end

		Battle.ActionSelect(pet:getObj(), 26, pos, anshaSkillId)
		return 1
	end

	for i = 10, 19 do
		local tmpPlayer = MyPlayer:new(Battle.GetPlayer(battle, i))
		if tmpPlayer:isValid() then
			if tmpPlayer:getHp() <= pet:getMaxHp() * 2 then
				Battle.ActionSelect(pet:getObj(), 26, i, anshaSkillId)
				return 1
			end
		end
	end
	return 0;
end

Protocol.OnRecv(nil, "useAnsha", 7)