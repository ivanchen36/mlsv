







Delegate.RegDelBattleStartEvent("EnemyExtension_s_BattleEvent");--进入战斗
Delegate.RegDelBattleOverEvent("EnemyExtension_s_BattleoverEvent");--进入战斗
local BossXM_ = {}
function EnemyExtension_s_BattleoverEvent(BattleIndex)--战斗结
--print("清空")
	BossXM_[tostring(BattleIndex)] = nil 


end	
function EnemyExtension_s_BattleEvent(BattleIndex)
	if BossXM_[tostring(BattleIndex)] == nil then 
		BossXM_[tostring(BattleIndex)] = {} 
	end	
	local lei = Battle.GetType(BattleIndex)
	if lei == %战斗_普通% then 
		local _LZ = Battle.GetNextBattle(BattleIndex,20)
		local huihe = Battle.GetTurn(BattleIndex)
		if BossXM_[tostring(BattleIndex)][tostring(huihe)] == nil then 
			BossXM_[tostring(BattleIndex)][tostring(huihe)] = 1
			for i = 10,19 do 
				local player = Battle.GetPlayer(BattleIndex,i)
				if player >= 0 then 
					local _tbl = {}
					_tbl["生命"] =	%BOUNS_HP%
					_tbl["魔法"] =	%BOUNS_FORCEPOINT%
					
					_tbl["防御"] =	%BOUNS_DEFENCE%
					_tbl["攻击"] =	%BOUNS_ATTACK%
					_tbl["敏捷"] =	%BOUNS_AGILITY%
					_tbl["精神"] =	%BOUNS_MAGIC%
					_tbl["回复"] =	%BOUNS_RECOVERY%				
					_tbl["抗毒"] =	%BOUNS_POISON%
					_tbl["抗睡"] =	%BOUNS_SLEEP%
					_tbl["抗石"] =	%BOUNS_STONE%
					_tbl["抗醉"] =	%BOUNS_DRUNK%
					_tbl["抗混"] =	%BOUNS_CONFUSION%
					_tbl["抗遗"] =	%BOUNS_AMNESIA%
					_tbl["必杀"] =	%BOUNS_CRITICAL%
					_tbl["反击"] =	%BOUNS_COUNTER%
					_tbl["命中"] =	%BOUNS_HITRATE%
					_tbl["闪躲"] =	%BOUNS_AVOID%
					_tbl["魔攻"] =	%BOUNS_ADM%
					_tbl["魔抗"] =	%BOUNS_RSS%
					local name = Char.GetData(player,2000)
					local id = Char.GetData(player,68);
		
					if EnemyExtension_s[id] then
						for q = 1,#EnemyExtension_s[id] do 
							local a1 = Stringsplitplus(EnemyExtension_s[id][q],"|")
							if _tbl[a1[1]] and tonumber(a1[2]) then 
								if Char.GetData(player,_tbl[a1[1]]) == 0 then 
									Char.SetData(player,_tbl[a1[1]],tonumber(a1[2]))
									if a1[1] == "生命" then 								
										Char.SetData(player,%对象_血%,Char.GetData(player,%对象_血%)+tonumber(a1[2]))
								elseif a1[1] == "魔法" then 			
										Char.SetData(player,%对象_魔%,Char.GetData(player,%对象_魔%)+tonumber(a1[2]))
									end
								end		
							end		
						end	
						NLG.UpChar(player)
					end	
				end
			end	
		end		
	end
end		

function SG_NPCBossXM_Loop_s(_npc)
	for k,v in pairs(BossXM_) do 
		local _LZ = Battle.GetNextBattle(tonumber(k),0)
		local huihe = Battle.GetTurn(tonumber(k))
		if BossXM_[k] and BossXM_[k][tostring(huihe)] == nil then 
			EnemyExtension_s_BattleEvent(tonumber(k))	
			--print("赋予属性")
		end	
	end
end	




function SG_BossXMNPC_Index_s(_npc)
	
	Char.SetData(_npc,常量.对象.形象,100000);
	Char.SetData(_npc,常量.对象.原形,100000);
	Char.SetData(_npc,常量.对象.地图类型,0);
	Char.SetData(_npc,常量.对象.地图,555);
	Char.SetData(_npc,常量.对象.X,0);
	Char.SetData(_npc,常量.对象.Y,0);
	Char.SetData(_npc,常量.对象.方向,0);
	Char.SetData(_npc,常量.对象.原名,"loop");
	if Char.SetLoopEvent(nil,"SG_NPCBossXM_Loop_s",_npc,1000) < 0 then 
		print("SG_NPCBossXM_Loop_s")
		return false
	end

	return true
end

if LuaNpcIndex["SG_BossXMNPC_s"] == nil then 
	LuaNpcIndex["SG_BossXMNPC_s"] = NL.CreateNpc(nil,"SG_BossXMNPC_Index_s")
	NLG.UpChar(LuaNpcIndex["SG_BossXMNPC_s"])
else
	NL.DelNpc(LuaNpcIndex["SG_BossXMNPC_s"])	
	LuaNpcIndex["SG_BossXMNPC_s"]  =  NL.CreateNpc(nil, "SG_BossXMNPC_Index_s")
	NLG.UpChar(LuaNpcIndex["SG_BossXMNPC_s"] );
end