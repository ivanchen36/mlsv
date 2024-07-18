







Delegate.RegDelBattleStartEvent("EnemyExtension_s_BattleEvent");--����ս��
Delegate.RegDelBattleOverEvent("EnemyExtension_s_BattleoverEvent");--����ս��
local BossXM_ = {}
function EnemyExtension_s_BattleoverEvent(BattleIndex)--ս����
--print("���")
	BossXM_[tostring(BattleIndex)] = nil 


end	
function EnemyExtension_s_BattleEvent(BattleIndex)
	if BossXM_[tostring(BattleIndex)] == nil then 
		BossXM_[tostring(BattleIndex)] = {} 
	end	
	local lei = Battle.GetType(BattleIndex)
	if lei == %ս��_��ͨ% then 
		local _LZ = Battle.GetNextBattle(BattleIndex,20)
		local huihe = Battle.GetTurn(BattleIndex)
		if BossXM_[tostring(BattleIndex)][tostring(huihe)] == nil then 
			BossXM_[tostring(BattleIndex)][tostring(huihe)] = 1
			for i = 10,19 do 
				local player = Battle.GetPlayer(BattleIndex,i)
				if player >= 0 then 
					local _tbl = {}
					_tbl["����"] =	%BOUNS_HP%
					_tbl["ħ��"] =	%BOUNS_FORCEPOINT%
					
					_tbl["����"] =	%BOUNS_DEFENCE%
					_tbl["����"] =	%BOUNS_ATTACK%
					_tbl["����"] =	%BOUNS_AGILITY%
					_tbl["����"] =	%BOUNS_MAGIC%
					_tbl["�ظ�"] =	%BOUNS_RECOVERY%				
					_tbl["����"] =	%BOUNS_POISON%
					_tbl["��˯"] =	%BOUNS_SLEEP%
					_tbl["��ʯ"] =	%BOUNS_STONE%
					_tbl["����"] =	%BOUNS_DRUNK%
					_tbl["����"] =	%BOUNS_CONFUSION%
					_tbl["����"] =	%BOUNS_AMNESIA%
					_tbl["��ɱ"] =	%BOUNS_CRITICAL%
					_tbl["����"] =	%BOUNS_COUNTER%
					_tbl["����"] =	%BOUNS_HITRATE%
					_tbl["����"] =	%BOUNS_AVOID%
					_tbl["ħ��"] =	%BOUNS_ADM%
					_tbl["ħ��"] =	%BOUNS_RSS%
					local name = Char.GetData(player,2000)
					local id = Char.GetData(player,68);
		
					if EnemyExtension_s[id] then
						for q = 1,#EnemyExtension_s[id] do 
							local a1 = Stringsplitplus(EnemyExtension_s[id][q],"|")
							if _tbl[a1[1]] and tonumber(a1[2]) then 
								if Char.GetData(player,_tbl[a1[1]]) == 0 then 
									Char.SetData(player,_tbl[a1[1]],tonumber(a1[2]))
									if a1[1] == "����" then 								
										Char.SetData(player,%����_Ѫ%,Char.GetData(player,%����_Ѫ%)+tonumber(a1[2]))
								elseif a1[1] == "ħ��" then 			
										Char.SetData(player,%����_ħ%,Char.GetData(player,%����_ħ%)+tonumber(a1[2]))
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
			--print("��������")
		end	
	end
end	




function SG_BossXMNPC_Index_s(_npc)
	
	Char.SetData(_npc,����.����.����,100000);
	Char.SetData(_npc,����.����.ԭ��,100000);
	Char.SetData(_npc,����.����.��ͼ����,0);
	Char.SetData(_npc,����.����.��ͼ,555);
	Char.SetData(_npc,����.����.X,0);
	Char.SetData(_npc,����.����.Y,0);
	Char.SetData(_npc,����.����.����,0);
	Char.SetData(_npc,����.����.ԭ��,"loop");
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