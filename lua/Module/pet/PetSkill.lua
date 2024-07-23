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
local baseAtkSkillId = 7300
local anshaSkillId = 9609
local remoteBaseId = 1000000

function isUseAnsha(pet, skillId)
	local petId = pet:getId()
	if rawget(anshaEnemy, petId) == nil then
		return false
	end
	if rawget(triggerAnshaSkill, skillId) then
		return isOccur(anshaEnemy[petId])
	end

	return false
end

local function isTriggerAnsha(pet, skillId, battle)
	if not isAnshaBoss and Battle.IsBossBattle(battle) == 1 then
		return false
	end

	if isUseAnsha(pet, skillId) then
		return true
	end

	return false
end

local function getNewTechId(player, pet, skillId, battle)
	if isTriggerAnsha(pet, skillId, battle) then
		return anshaSkillId
	end

	return 0
end

function modifyPetSkill(fd,head,packet)
	logPrint("modifyPetSkill",  head, packet)
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
	local skillSlot = tonumber(SplitArray[2])
	local battle = myPlayer:getBattleIndex()
	local skillId = math.floor(pet:getSkill(skillSlot) / 100)
	local newTechId = getNewTechId(myPlayer, pet, skillId, battle)
	logPrint("modifyPetSkill ", skillId, newTechId)
	if 0 == newTechId then
		return 0
	end

	local pos = attackPos[string.gsub(SplitArray[3], "::", "")]

	local tmpPlayer = MyPlayer:new(Battle.GetPlayer(battle, pos))
	if tmpPlayer:isValid() then
		if newTechId == anshaSkillId then
			if tmpPlayer:getHp() > pet:getMaxHp() * 2 then
				return 0
			end
		end

		Battle.ActionSelect(pet:getObj(), 26, pos, newTechId)
		return 1
	end

	for i = 10, 19 do
		local tmpPlayer = MyPlayer:new(Battle.GetPlayer(battle, i))
		if tmpPlayer:isValid() then
			if newTechId == anshaSkillId then
				if tmpPlayer:getHp() <= pet:getMaxHp() * 2 then
					Battle.ActionSelect(pet:getObj(), 26, i, newTechId)
					return 1
				end
			else
				Battle.ActionSelect(pet:getObj(), 26, i, newTechId)
				return 1
			end
		end
	end

	return 0;
end

Protocol.OnRecv(nil, "modifyPetSkill", 7)