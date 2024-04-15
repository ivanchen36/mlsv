

PetLoyalty = {50000}  -- 增加宠物忠诚的道具ID






-------------------------------------------------------------------------------
Delegate.RegDelBattleStartEvent("PetLoyalty_BattleEvent");

local PetLoyaltyTable = {}
function PetLoyalty_BattleEvent(BattleIndex)

		for i = 0,19 do 
			local player = Battle.GetPlayer(BattleIndex,i)
			if player >= 0 and Char.GetData(player,0) == 3 then 
				local key = Pet.GetUUID(player)
				local _PlayerIndex = Pet.GetOwner(player)
				local _OK = PetLoyalty_ItemNum(_PlayerIndex)
				if 	_OK == 1 then 
					PetLoyaltyTable[key] = true
					Char.SetData(player,%BOUNS_LOYALTY%,100)
					Pet.UpPet(_PlayerIndex, player)	
					--print("+++++++++++++++++++++++++")
				else
					if PetLoyaltyTable[key] then 				
						PetLoyaltyTable[key] = nil
						Char.SetData(player,%BOUNS_LOYALTY%,0)
						Pet.UpPet(_PlayerIndex, player)
						--print("--------------------")	
					end
				end	
			end
		end		
	
end		

function PetLoyalty_ItemNum(_PlayerIndex)
	for i = 1,#PetLoyalty do 
		if Char.ItemNum(_PlayerIndex,PetLoyalty[i]) > 0 then 
			return 1
		end
	end
	return 0
end			