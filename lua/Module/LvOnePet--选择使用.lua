--Delegate.RegDelBattleStartEvent("LvOnePet_Event");

NL.RegBattleStartEvent(nil,"LvOnePet_Event");
local PetID = {101501,101313,101320,101324,101321,101721,101722,101723,101724}---限制图档设定
local 宠物图档={}
宠物图档[101501]={100454}---添加前面的数值是原有图档，后面的数值是要变身图档
宠物图档[101313]={116139}---添加前面的数值是原有图档，后面的数值是要变身图档
宠物图档[101320]={107910}
宠物图档[101324]={107911}
宠物图档[101321]={107912}
宠物图档[101721]={101721}
宠物图档[101722]={101722}
宠物图档[101723]={101723}
宠物图档[101724]={101724}
function LvOnePet_Event(_battle)
	--NLG.SystemMessage(_battle,"扣除".._battle);
	if (Battle.GetGainMode(_battle)==%战奖_普通% and Battle.GetType(_battle)==%战斗_普通%) then
		for BWhile=10,19 do
			local PlayerIndex = Battle.GetPlayer(_battle,BWhile);
			if(VaildChar(PlayerIndex)==true) then
				if(Char.GetData(PlayerIndex,%对象_等级%) == 1) then
					for BPWhile=0,4 do
						local BPlayerIndex = Battle.GetPlayer(_battle,BPWhile);
						if(BPlayerIndex >= 0) then
							local TL1 = Pet.FullArtRank(PlayerIndex,1);
							local GJ1 = Pet.FullArtRank(PlayerIndex,2);
							local FY1 = Pet.FullArtRank(PlayerIndex,3);
							local MJ1 = Pet.FullArtRank(PlayerIndex,4);
							local MF1 = Pet.FullArtRank(PlayerIndex,5);
							local TL2 = Pet.GetArtRank(PlayerIndex,1);
							local GJ2 = Pet.GetArtRank(PlayerIndex,2);
							local FY2 = Pet.GetArtRank(PlayerIndex,3);
							local MJ2 = Pet.GetArtRank(PlayerIndex,4);
							local MF2 = Pet.GetArtRank(PlayerIndex,5);	
							local TL = TL2-TL1
							local GJ = GJ2-GJ1
							local FY = FY2-FY1
							local MJ = MJ2-MJ1
							local MF = MF2-MF1		
							NLG.TalkToCli(BPlayerIndex,-1,"【★☆★捕捉提示★☆★】一级宠物【"..Char.GetData(PlayerIndex,%对象_名字%).."】出现！体【".. TL.."】攻【".. GJ.."】防【".. FY.."】敏【".. MJ.."】魔【".. MF.."】",%颜色_黄色%,%字体_中%);					
							local JL1 = NLG.Rand(1,1); ---当前几率是三分之一
							local BY = Char.GetData(PlayerIndex,44);
							if JL1 == 1 and BY == 0  then
								local cwname = Char.GetData(PlayerIndex,%对象_名字%)
								local PetName = Char.SetData(PlayerIndex,2000,("变异-"..cwname));
								local BYTL1 = Pet.SetArtRank(PlayerIndex,1, Pet.GetArtRank(PlayerIndex,1) + math.random(1,3)); ------档次提升范围
								local BYTL2 = Pet.SetArtRank(PlayerIndex,2, Pet.GetArtRank(PlayerIndex,2) + math.random(1,3));
								local BYTL3 = Pet.SetArtRank(PlayerIndex,3, Pet.GetArtRank(PlayerIndex,3) + math.random(1,3));
								local BYTL4 = Pet.SetArtRank(PlayerIndex,4, Pet.GetArtRank(PlayerIndex,4) + math.random(1,3));
								local BYTL5 = Pet.SetArtRank(PlayerIndex,5, Pet.GetArtRank(PlayerIndex,5) + math.random(1,3));
								local B1 = Char.SetData(PlayerIndex,22,Char.GetData(PlayerIndex,22) + math.random(0,10)); ------修正和抗性提升范围
								local B2 = Char.SetData(PlayerIndex,23,Char.GetData(PlayerIndex,23) + math.random(0,10));
								local B3 = Char.SetData(PlayerIndex,24,Char.GetData(PlayerIndex,24) + math.random(0,10));
								local B4 = Char.SetData(PlayerIndex,25,Char.GetData(PlayerIndex,25) + math.random(0,10));
								local B5 = Char.SetData(PlayerIndex,26,Char.GetData(PlayerIndex,26) + math.random(0,10));
								local B6 = Char.SetData(PlayerIndex,27,Char.GetData(PlayerIndex,27) + math.random(0,10));
								local B7 = Char.SetData(PlayerIndex,28,Char.GetData(PlayerIndex,28) + math.random(0,10));
								local B8 = Char.SetData(PlayerIndex,29,Char.GetData(PlayerIndex,29) + math.random(0,10));
								local B9 = Char.SetData(PlayerIndex,30,Char.GetData(PlayerIndex,30) + math.random(0,10));
								local B10 = Char.SetData(PlayerIndex,31,Char.GetData(PlayerIndex,31) + math.random(0,10));
								local B11 = Char.SetData(PlayerIndex,44,Char.GetData(PlayerIndex,44) + math.random(10,10));
								NLG.TalkToCli(BPlayerIndex,-1,"人品大爆发当前宠物已变异。",%颜色_黄色%,%字体_中%);	
								local TL3 = Pet.GetArtRank(PlayerIndex,1);
								local GJ3 = Pet.GetArtRank(PlayerIndex,2);
								local FY3 = Pet.GetArtRank(PlayerIndex,3);
								local MJ3 = Pet.GetArtRank(PlayerIndex,4);
								local MF3 = Pet.GetArtRank(PlayerIndex,5);
								NLG.TalkToCli(BPlayerIndex,-1,"变异前档次：体【".. TL2.."】攻【".. GJ2.."】防【".. FY2.."】敏【".. MJ2.."】魔【".. MF2.."】",%颜色_黄色%,%字体_中%);	
								NLG.TalkToCli(BPlayerIndex,-1,"变异后档次：体【".. TL3.."】攻【".. GJ3.."】防【".. FY3.."】敏【".. MJ3.."】魔【".. MF3.."】",%颜色_黄色%,%字体_中%);
								local PetTD1 = Char.GetData(PlayerIndex,1)
								local PetTD2 = Char.GetData(PlayerIndex,2)
								if PET_CheckInTable(PetID,PetTD1)==true then
									local PetTDH = 宠物图档[PetTD1][1]
									local PetTD11 = Char.SetData(PlayerIndex,1,PetTDH);
									local PetTD22 = Char.SetData(PlayerIndex,2,PetTDH);
								end
							end
						end
					end
				end
			end
		end
	end
end
function PET_CheckInTable(_idTab, _idVar) ---循环函数
	for k,v in pairs(_idTab) do
		print(v .. " = " .. _idVar)
		if v==_idVar then
			return true
		end
	end
	return false
end
