anshaEnemy = {
	[4] = 1500,
	[12] = 2000,
}
triggerAnshaSkill = {5,5,5,5,5,5,5,5,5,100};
attackPos = {["0"]=0, ["1"]=1, ["2"]=2, ["3"]=3, ["4"]=4, ["5"]=5, ["6"]=6, ["7"]=7, ["8"]=8, ["9"]=9, ["A"]=10, ["B"]=11, ["C"]=12, ["D"]=13, ["E"]=14, ["F"]=15, ["10"]=16, ["11"]=17, ["12"]=18, ["13"]=19};
isAnshaBoss = true
anshaSkillId = 9609

function isUseAnsha(pet)
	local petId = pet:getId()
	if rawget(anshaEnemy, petId) == nil then
		return false
	end
	local skillId = pet:getSkill(slot)
	for _, v in ipairs(triggerAnshaSkill) do
		if v == skillId then
			return isOccur(anshaEnemy[petId])
		end
	end

	return false
end

function useAnsha(fd,head,packet)
	logPrint("useAnsha")
	local myPlayer = MyPlayer:new(Protocol.GetCharByFd(fd))
	local SplitArray = Split(packet,"|");
	if SplitArray[1] == "W" and  SplitArray[2] ~= "FF" then -- 宠物技能 非什么都不做
		logPrint("useAnsha1")
		local pet = MyPet:getBattlePet(myPlayer:getObj())

		if not isUseAnsha(pet) then
			return 0
		end
		logPrint("useAnsha2")
		if not isAnshaBoss and Battle.IsBossBattle(myPlayer:getBattleIndex()) == 1 then
			return 0
		end
		logPrint("useAnsha3")
		if Battle.IsWaitingCommand(pet:getObj()) ~= 1 then
			return 0
		end
		logPrint("useAnsha4")
		Battle.ActionSelect(pet:getObj(), 26, attackPos[SplitArray[3]], anshaSkillId)
		return 1;
	end
end

--Protocol.OnRecv(nil, "useAnsha", 7)