--Delegate.RegDelBattleStartEvent("LvOnePet_Event");

NL.RegBattleStartEvent(nil,"LvOnePet_Event");
local PetID = {101501,101313,101320,101324,101321,101721,101722,101723,101724}---����ͼ���趨
local ����ͼ��={}
����ͼ��[101501]={100454}---���ǰ�����ֵ��ԭ��ͼ�����������ֵ��Ҫ����ͼ��
����ͼ��[101313]={116139}---���ǰ�����ֵ��ԭ��ͼ�����������ֵ��Ҫ����ͼ��
����ͼ��[101320]={107910}
����ͼ��[101324]={107911}
����ͼ��[101321]={107912}
����ͼ��[101721]={101721}
����ͼ��[101722]={101722}
����ͼ��[101723]={101723}
����ͼ��[101724]={101724}
function LvOnePet_Event(_battle)
	--NLG.SystemMessage(_battle,"�۳�".._battle);
	if (Battle.GetGainMode(_battle)==%ս��_��ͨ% and Battle.GetType(_battle)==%ս��_��ͨ%) then
		for BWhile=10,19 do
			local PlayerIndex = Battle.GetPlayer(_battle,BWhile);
			if(VaildChar(PlayerIndex)==true) then
				if(Char.GetData(PlayerIndex,%����_�ȼ�%) == 1) then
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
							NLG.TalkToCli(BPlayerIndex,-1,"�����ﲶ׽��ʾ���һ�����"..Char.GetData(PlayerIndex,%����_����%).."�����֣��塾".. TL.."������".. GJ.."������".. FY.."������".. MJ.."��ħ��".. MF.."��",%��ɫ_��ɫ%,%����_��%);					
							local JL1 = NLG.Rand(1,1); ---��ǰ����������֮һ
							local BY = Char.GetData(PlayerIndex,44);
							if JL1 == 1 and BY == 0  then
								local cwname = Char.GetData(PlayerIndex,%����_����%)
								local PetName = Char.SetData(PlayerIndex,2000,("����-"..cwname));
								local BYTL1 = Pet.SetArtRank(PlayerIndex,1, Pet.GetArtRank(PlayerIndex,1) + math.random(1,3)); ------����������Χ
								local BYTL2 = Pet.SetArtRank(PlayerIndex,2, Pet.GetArtRank(PlayerIndex,2) + math.random(1,3));
								local BYTL3 = Pet.SetArtRank(PlayerIndex,3, Pet.GetArtRank(PlayerIndex,3) + math.random(1,3));
								local BYTL4 = Pet.SetArtRank(PlayerIndex,4, Pet.GetArtRank(PlayerIndex,4) + math.random(1,3));
								local BYTL5 = Pet.SetArtRank(PlayerIndex,5, Pet.GetArtRank(PlayerIndex,5) + math.random(1,3));
								local B1 = Char.SetData(PlayerIndex,22,Char.GetData(PlayerIndex,22) + math.random(0,10)); ------�����Ϳ���������Χ
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
								NLG.TalkToCli(BPlayerIndex,-1,"��Ʒ�󱬷���ǰ�����ѱ��졣",%��ɫ_��ɫ%,%����_��%);	
								local TL3 = Pet.GetArtRank(PlayerIndex,1);
								local GJ3 = Pet.GetArtRank(PlayerIndex,2);
								local FY3 = Pet.GetArtRank(PlayerIndex,3);
								local MJ3 = Pet.GetArtRank(PlayerIndex,4);
								local MF3 = Pet.GetArtRank(PlayerIndex,5);
								NLG.TalkToCli(BPlayerIndex,-1,"����ǰ���Σ��塾".. TL2.."������".. GJ2.."������".. FY2.."������".. MJ2.."��ħ��".. MF2.."��",%��ɫ_��ɫ%,%����_��%);	
								NLG.TalkToCli(BPlayerIndex,-1,"����󵵴Σ��塾".. TL3.."������".. GJ3.."������".. FY3.."������".. MJ3.."��ħ��".. MF3.."��",%��ɫ_��ɫ%,%����_��%);
								local PetTD1 = Char.GetData(PlayerIndex,1)
								local PetTD2 = Char.GetData(PlayerIndex,2)
								if PET_CheckInTable(PetID,PetTD1)==true then
									local PetTDH = ����ͼ��[PetTD1][1]
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
function PET_CheckInTable(_idTab, _idVar) ---ѭ������
	for k,v in pairs(_idTab) do
		print(v .. " = " .. _idVar)
		if v==_idVar then
			return true
		end
	end
	return false
end
