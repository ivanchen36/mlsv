local DailyEventName = "�ճ�����" --npc�Դ˳ƺ�
local DailyEventMsg = "    �������ڴ���ȡ�ճ�����ÿ��һ��,�������" --����˵��
local DailyEventMax = 1 --ÿ�տ����������
local DailyEventDays = {0,1,2,3,4,5,6} --�������񿪷����� 0-6��ʾ����-��6
local DailyEventGiveItem = 0 --���һ�����������߽�����itemid�����ж�����߻�ħ���������������ʽ Ϊ0����ʱ���������
local DailyEventGiveItemLast = 196921 --���ȫ�����������߽�����itemid�����ж�����߻�ħ���������������ʽ Ϊ0����ʱ���������
local DailyEventGiveExp = 0 --���һ��������辭�齱������ Ϊ0����ʱ��������
local DailyEventGiveExpLast = 0 --���ȫ��������辭�齱������ Ϊ0����ʱ��������
local DailyEventLevelMaxGiveItem = 0 --����ʱ���һ�����������߽�����itemid ��Ϊ��������δ��������
local DailyEventLevelMaxGiveItemLast = 196921 --����ʱ���ȫ�����������߽�����itemid ��Ϊ��������δ��������
local DailyEventStartLevel = 70 --���������������͵ȼ�
local ServerMaxLevel = 180 --�������趨�������ȼ�
local DailyEventWarp = 0 --���������Ƿ��� 1Ϊ��������������
local DailyEventWarpMap = 1000 --���������͵�ͼ
local DailyEventWarpPosX = 0 --����������x����
local DailyEventWarpPoxY = 0 --����������y����


local DENpcMetamo = 231111 --����npc����
local DENpcName = "�ճ�����" --����npc����
local DENpcMap = 1000 --����npc��ͼ
local DENpcPosX = 236 --����npc x����
local DENpcPosY = 80 --����npc y����
local DENpcDir = 4 --����npc����

local AnotherNpc = 0 --������Npc�Ƿ�ͬ������Npc 0Ϊͬ��npc������ 1Ϊ���õ�������������npc

local DENpcMetamo2 = 100500 --����������npc����
local DENpcName2 = "��������" --����������npc����
local DENpcMap2 = 777 --����������npc��ͼ
local DENpcPosX2 = 0 --����������npc x����
local DENpcPosY2 = 3 --����������npc y����
local DENpcDir2 = 4 --����������npc����

local DailyEventLocked = -1 --�Ƿ��������� -1Ϊȫ������� ����Ϊ������������--[1,ħ�� 2,��Ʒ 3,����]DailyEventList[2] = {1,1000} DailyEventList[5] = {2,9611,"ͭ��",5} DailyEventList[25] = {3,314,"�Ʒ�",1,1}
local DailyEventList = {} --����� DailyEventList[k] = {x,y����z} kΪ������ xΪ��������
DailyEventList[1] = {2,88888,"���",1} --��������0 �������� DailyEventList[k] = {1,y} yΪnpc������˵�� �����κε��ߣ�ֻ���뽻����npc�Ի�������ɡ�һ���������õ�������������npcʱʹ�á�
DailyEventList[2] = {2,18565,"�λ�ͷ��",1}
DailyEventList[3] = {2,15202,"������",1}
DailyEventList[4] = {2,18570,"���ν�ʱ",1}
DailyEventList[5] = {2,18310,"�ص�ˮ����Ƭ",10}
DailyEventList[6] = {2,18311,"ˮ��ˮ����Ƭ",10}
DailyEventList[7] = {2,18311,"���ˮ����Ƭ",10}
DailyEventList[8] = {2,18312,"���ˮ����Ƭ",10}
DailyEventList[9] = {1,2500}
DailyEventList[10] = {1,5000}
DailyEventList[11] = {2,195472,"��ʯ��",1}
DailyEventList[12] = {2,70902,"��������",20}
DailyEventList[13] = {2,70907,"�����𾫻�",40}
DailyEventList[14] = {2,70910,"������������",3}
DailyEventList[15] = {2,18983,"���������ǹ�Ǯ",5}
DailyEventList[16] = {2,18670,"ζ����",1}
DailyEventList[17] = {2,196204,"�Ŷ�����",1}
DailyEventList[18] = {2,21667,"����",1}
DailyEventList[19] = {2,18254,"̫�ŵĵ���",1}
DailyEventList[20] = {2,18403,"ŷ���ǿ˵Ľ�ָ",1}
DailyEventList[21] = {2,18231,"�����ͷ��",1}
DailyEventList[22] = {2,27998,"����",1}
DailyEventList[23] = {2,27053,"������",1}
DailyEventList[24] = {2,18973,"��֮����",1}
DailyEventList[25] = {2,18305,"���˿��",1}
DailyEventList[26] = {2,18487,"�ı���֮��",1}
DailyEventList[27] = {2,18278,"�ھ�֮��",1}
DailyEventList[28] = {2,18279,"�ھ�֮��",1}
DailyEventList[29] = {2,40080,"�Ϳ˴��ǩ����",1}
DailyEventList[30] = {2,192723,"����ı���¼����",1}
DailyEventList[31] = {2,192724,"����",1}
DailyEventList[32] = {2,18234,"ȫ������д�ȯ",1}
DailyEventList[33] = {2,18194,"��ͷ��",1}
DailyEventList[34] = {2,18451,"����֤֮",1}
DailyEventList[35] = {2,18449,"����֮��",1}
DailyEventList[36] = {2,18448,"����ʯ����Ʊ",1}
DailyEventList[37] = {3,834,"�ҷ�����",1,1}
DailyEventList[38] = {3,801,"�粼��",1,1}
DailyEventList[39] = {3,722,"ˮ����",1,1}
DailyEventList[40] = {3,321,"���",1,1}
DailyEventList[41] = {3,413,"����",1,1}
DailyEventList[42] = {3,333,"��֩��",1,1}
DailyEventList[43] = {3,314,"�Ʒ�",1,1}
DailyEventList[44] = {3,34,"������Ȯ",1,1}
DailyEventList[45] = {3,5602,"Ǳ��",1,1}
DailyEventList[46] = {3,13,"������",1,1}
DailyEventList[47] = {3,21,"�����",1,1}
DailyEventList[48] = {3,2000,"�����������",1,1}
DailyEventList[49] = {3,6035,"�����ĳ���",1,1}

--ʹ��Field��DailyEvent1��DailyEvent2��DailyEvent3�ֶ�
-------------------------------------------------------------

function DailyEventValue1(npc)
	Char.SetData(npc,%����_����%,DENpcMetamo)
	Char.SetData(npc,%����_ԭ��%,DENpcMetamo)
	Char.SetData(npc,%����_��ͼ%,DENpcMap)
	Char.SetData(npc,%����_X%,DENpcPosX)
	Char.SetData(npc,%����_Y%,DENpcPosY)
	Char.SetData(npc,%����_����%,DENpcDir)
	Char.SetData(npc,%����_ԭ��%,DENpcName)
	Char.SetTalkedEvent(nil, "DailyEventValue2",npc)
	Char.SetWindowTalkedEvent(nil,"DailyEventValue3",npc)
	NLG.UpChar(npc)
	return true
end

function DailyEventValue2(npc,player)
	if NLG.CheckInFront(npc,player,2) then
		for k,v in pairs(DailyEventDays) do
			if tonumber(os.date("%w")) == v then
				local DailyEvent1 = Field.Get(player,"DailyEvent1")
				if os.date("%x",tonumber(DailyEvent1)) ~= os.date("%x",os.time()) or DailyEvent1 == "" then
					Field.Set(player,"DailyEvent1",os.time())
					Field.Set(player,"DailyEvent2","0")
					Field.Set(player,"DailyEvent3","")
				end
				local DailyEventValue3 = "3\n�������"..DailyEventName.."��������\n��ѡ������Ҫ�ķ���\n\n1."..DailyEventName.."˵��\n2.��ȡ"..DailyEventName.."��鿴��ǰ����"
				if AnotherNpc == 0 then
					DailyEventValue3 = DailyEventValue3.."\n3.���"..DailyEventName
				end
				NLG.ShowWindowTalked(player,npc,2,2,0,DailyEventValue3)
				return
			end
		end
		--NLG.SystemMessage(player,"����"..DailyEventName.."�����š�")
	end
end

function DailyEventValue3(npc,player,Seqno,Select,Data)
	if NLG.CheckInFront(npc,player,2) then
		if Select ~= 2 then
			for k,v in pairs(DailyEventDays) do
				if tonumber(os.date("%w")) == v then
					local DailyEventValue16 = Char.GetData(player,%����_�ȼ�%)
					if DailyEventValue16 >= DailyEventStartLevel then
						if Seqno == 0 then
							if tonumber(Data) == 1 then
								NLG.ShowWindowTalked(player,npc,0,2,9999,DailyEventMsg)
							elseif tonumber(Data) == 2 then
								local DailyEvent2 = tonumber(Field.Get(player,"DailyEvent2"))
								if type(DailyEvent2) ~= "number" then
									DailyEvent2 = 0
								end
								if DailyEvent2 < DailyEventMax then
									local DailyEvent3 = tonumber(Field.Get(player,"DailyEvent3"))
									if type(DailyEvent3) ~= "number" then
										DailyEvent3 = 0
									end
									if DailyEvent3 > 0 then
										local DailyEventValue3 = "����ǰ���ڽ��е�"..(DailyEvent2+1).."��"..DailyEventName.."������Ŀ����"
										if DailyEventList[DailyEvent3][1] == 0 then
											DailyEventValue3 = DailyEventValue3..DailyEventList[DailyEvent3][2].."��"
										elseif DailyEventList[DailyEvent3][1] == 1 then
											DailyEventValue3 = DailyEventValue3.."����"..DailyEventList[DailyEvent3][2].."ħ�ҡ�"
										elseif DailyEventList[DailyEvent3][1] == 2 then
											for i = 2,#DailyEventList[DailyEvent3],3 do
												DailyEventValue3 = DailyEventValue3.."����"..DailyEventList[DailyEvent3][i+2].."��"..DailyEventList[DailyEvent3][i+1].." "
											end
											DailyEventValue3 = DailyEventValue3.."��"
										elseif DailyEventList[DailyEvent3][1] == 3 then
											DailyEventValue3 = DailyEventValue3.."���ɵȼ�:"..DailyEventList[DailyEvent3][4].."��"..DailyEventList[DailyEvent3][3].."��"
										end
										NLG.SystemMessage(player,DailyEventValue3)
									else
										if DailyEventLocked == -1 then
											local DailyEventValue4 = math.random(1,#DailyEventList)
											Field.Set(player,"DailyEvent3",DailyEventValue4)
										else
											Field.Set(player,"DailyEvent3",DailyEventLocked)
										end
										local DailyEvent3 = tonumber(Field.Get(player,"DailyEvent3"))
										local DailyEventValue3 = "����"..DailyEventName.."�ɹ�����ǰ�������"..DailyEvent2.."��"..DailyEventName.."�������ε�Ŀ����"
										if DailyEventList[DailyEvent3][1] == 0 then
											DailyEventValue3 = DailyEventValue3..DailyEventList[DailyEvent3][2].."��"
										elseif DailyEventList[DailyEvent3][1] == 1 then
											DailyEventValue3 = DailyEventValue3.."����"..DailyEventList[DailyEvent3][2].."ħ�ҡ�"
										elseif DailyEventList[DailyEvent3][1] == 2 then
											for i = 2,#DailyEventList[DailyEvent3],3 do
												DailyEventValue3 = DailyEventValue3.."����"..DailyEventList[DailyEvent3][i+2].."��"..DailyEventList[DailyEvent3][i+1].." "
											end
											DailyEventValue3 = DailyEventValue3.."��"
										elseif DailyEventList[DailyEvent3][1] == 3 then
											DailyEventValue3 = DailyEventValue3.."���ɵȼ�:"..DailyEventList[DailyEvent3][4].."��"..DailyEventList[DailyEvent3][3].."��"
										end
										NLG.SystemMessage(player,DailyEventValue3)
									end
								else
									NLG.SystemMessage(player,"���Ѿ�����˱������е�"..DailyEventName.."��")
								end
							elseif tonumber(Data) == 3 then
								if AnotherNpc == 0 then
									if Char.ItemSlot(player) < 20 then
										local DailyEvent2 = tonumber(Field.Get(player,"DailyEvent2"))
										if type(DailyEvent2) ~= "number" then
											DailyEvent2 = 0
										end
										if DailyEvent2 < DailyEventMax then
											local DailyEvent3 = tonumber(Field.Get(player,"DailyEvent3"))
											if type(DailyEvent3) ~= "number" then
												DailyEvent3 = 0
											end
											if DailyEvent3 > 0 then
												local DailyEventValue5 = 0
												if DailyEventList[DailyEvent3][1] == 0 then
													DailyEventValue5 = 1
												elseif DailyEventList[DailyEvent3][1] == 1 then
													local DailyEventValue6 = Char.GetData(player,%����_���%)
													if DailyEventValue6 >= DailyEventList[DailyEvent3][2] then
														Char.SetData(player,%����_���%,(DailyEventValue6-DailyEventList[DailyEvent3][2]))
														NLG.SystemMessage(player,"������"..DailyEventList[DailyEvent3][2].."ħ�ҡ�")
														DailyEventValue5 = 1
													else
														DailyEventValue5 = 0
														NLG.SystemMessage(player,"����ħ�Ҳ��㡣")
													end
												elseif DailyEventList[DailyEvent3][1] == 2 then
													local DailyEventValue7 = 1
													for i = 2,#DailyEventList[DailyEvent3],3 do
														if Char.ItemNum(player,DailyEventList[DailyEvent3][i]) < DailyEventList[DailyEvent3][i+2] then
															DailyEventValue7 = 0
														end
													end
													if DailyEventValue7 == 1 then
														for i = 2,#DailyEventList[DailyEvent3],3 do
															Char.DelItem(player,DailyEventList[DailyEvent3][i],DailyEventList[DailyEvent3][i+2])
														end
														DailyEventValue5 = 1
													else
														DailyEventValue5 = 0
														NLG.SystemMessage(player,"���ĵ��߲��㡣")
													end
												elseif DailyEventList[DailyEvent3][1] == 3 then
													local DailyEventValue8 = Char.HavePet(player,DailyEventList[DailyEvent3][2])
													if DailyEventValue8 >= 0 and DailyEventValue8 <= 4 then
														local DailyEventValue9 = Char.GetData(Char.GetPet(player,DailyEventValue8),%����_�ȼ�%)
														if DailyEventValue9 >= DailyEventList[DailyEvent3][4] and DailyEventValue9 <= DailyEventList[DailyEvent3][5] then
															Char.DelSlotPet(player,DailyEventValue8)
															NLG.SystemMessage(player,"������"..DailyEventList[DailyEvent3][3].."��")
															DailyEventValue5 = 1
														else
															DailyEventValue5 = 0
															NLG.SystemMessage(player,"���ĳ���ȼ�������")
														end
													else
														DailyEventValue5 = 0
														NLG.SystemMessage(player,"��û��"..DailyEventList[DailyEvent3][3].."��")
													end
												end
												if DailyEventValue5 == 1 then
													Field.Set(player,"DailyEvent2",(DailyEvent2+1))
													Field.Set(player,"DailyEvent3","")
													local DailyEventValue15 = Char.GetData(player,%����_�ȼ�%)
													if (DailyEvent2+1) >= DailyEventMax then
														if DailyEventValue15 >= ServerMaxLevel and DailyEventLevelMaxGiveItemLast > 0 then
															Char.GiveItem(player,DailyEventLevelMaxGiveItemLast,1)
														else
															if DailyEventGiveItemLast > 0 then
																Char.GiveItem(player,DailyEventGiveItemLast,1)
															end
															if DailyEventGiveExpLast > 0 then
																Char.SetData(player,%����_����%,(Char.GetData(player,%����_����%)+DailyEventGiveExpLast))
																NLG.SystemMessage(player,"�õ�"..DailyEventGiveExpLast.."���顣")
																NLG.UpChar(player)
															end
														end
													else
														if DailyEventValue15 >= ServerMaxLevel and DailyEventLevelMaxGiveItem > 0 then
															Char.GiveItem(player,DailyEventLevelMaxGiveItem,1)
														else
															if DailyEventGiveItem > 0 then
																Char.GiveItem(player,DailyEventGiveItem,1)
															end
															if DailyEventGiveExp > 0 then
																Char.SetData(player,%����_����%,(Char.GetData(player,%����_����%)+DailyEventGiveExp))
																NLG.SystemMessage(player,"�õ�"..DailyEventGiveExp.."���顣")
																NLG.UpChar(player)
															end
														end
													end
													if DailyEventWarp == 1 then
														Char.DischargeParty(player)
														Char.Warp(player,0,DailyEventWarpMap,DailyEventWarpPosX,DailyEventWarpPosY)
													end
												end
											else
												NLG.SystemMessage(player,"�������Ƚ�ȡһ��"..DailyEventName.."��")
											end
										else
											NLG.SystemMessage(player,"���Ѿ���������е�"..DailyEventName.."��")
										end
									else
										NLG.SystemMessage(player,"���Ķ���̫���ˡ�")
									end
								end
							end
						end
						return
					else
						NLG.SystemMessage(player,"���ĵȼ�̫���ˡ�")
					end
				end
			end
			--NLG.SystemMessage(player,"����"..DailyEventName.."�����š�")
		end
	end
end


if DailyEventValue11 == nil or DailyEventValue11 < 0 then
	DailyEventValue11 = NL.CreateNpc(nil,"DailyEventValue1")
end

function DailyEventValue12(npc)
	Char.SetData(npc,%����_����%,DENpcMetamo2)
	Char.SetData(npc,%����_ԭ��%,DENpcMetamo2)
	Char.SetData(npc,%����_��ͼ%,DENpcMap2)
	Char.SetData(npc,%����_X%,DENpcPosX2)
	Char.SetData(npc,%����_Y%,DENpcPosY2)
	Char.SetData(npc,%����_����%,DENpcDir2)
	Char.SetData(npc,%����_ԭ��%,DENpcName2)
	Char.SetTalkedEvent(nil, "DailyEventValue13",npc)
	Char.SetWindowTalkedEvent(nil,"DailyEventValue14",npc)
	NLG.UpChar(npc)
	return true
end

function DailyEventValue13(npc,player)
	if NLG.CheckInFront(npc,player,2) then
		if os.date("%x",tonumber(Field.Get(player,"DailyEvent1"))) ~= os.date("%x",os.time()) or Field.Get(player,"DailyEvent1") == "" then
			Field.Set(player,"DailyEvent1",os.time())
			Field.Set(player,"DailyEvent2","0")
			Field.Set(player,"DailyEvent3","")			
		end
		if AnotherNpc == 1 then
			local DailyEventValue3 = "3\n��������"..DailyEventName.."��������\n��ѡ������Ҫ�ķ���\n\n1."..DailyEventName.."˵��\n2.���"..DailyEventName
			NLG.ShowWindowTalked(player,npc,2,2,0,DailyEventValue3)
		end
	end
end

function DailyEventValue14(npc,player,Seqno,Select,Data)
	if NLG.CheckInFront(npc,player,2) then
		if Select ~= 2 then
			if Seqno == 0 then
				local DailyEventValue16 = Char.GetData(player,%����_�ȼ�%)
				if DailyEventValue16 >= DailyEventStartLevel then
					if tonumber(Data) == 1 then
						if AnotherNpc == 1 then
							NLG.ShowWindowTalked(player,npc,0,2,9999,DailyEventMsg)
						end
					elseif tonumber(Data) == 2 then
						if AnotherNpc == 1 then
							if Char.ItemSlot(player) < 20 then
								local DailyEvent2 = tonumber(Field.Get(player,"DailyEvent2"))
								if type(DailyEvent2) ~= "number" then
									DailyEvent2 = 0
								end
								if DailyEvent2 < DailyEventMax then
									local DailyEvent3 = tonumber(Field.Get(player,"DailyEvent3"))
									if type(DailyEvent3) ~= "number" then
										DailyEvent3 = 0
									end
									if DailyEvent3 > 0 then
										local DailyEventValue5 = 0
										if DailyEventList[DailyEvent3][1] == 0 then
											DailyEventValue5 = 1
										elseif DailyEventList[DailyEvent3][1] == 1 then
											--local DailyEventValue6 = Char.GetData(player,%����_���%)
											local DailyEventValue6 = Char.GetData(player,%����_���%)
											if DailyEventValue6 >= DailyEventList[DailyEvent3][2] then
												Char.SetData(player,%����_���%,(DailyEventValue6-DailyEventList[DailyEvent3][2]))
												NLG.SystemMessage(player,"������"..DailyEventList[DailyEvent3][2].."ħ�ҡ�")
												DailyEventValue5 = 1
											else
												DailyEventValue5 = 0
												NLG.SystemMessage(player,"����ħ�Ҳ��㡣")
											end
										elseif DailyEventList[DailyEvent3][1] == 2 then
											local DailyEventValue7 = 1
											for i = 2,#DailyEventList[DailyEvent3],3 do
												if Char.ItemNum(player,DailyEventList[DailyEvent3][i]) < DailyEventList[DailyEvent3][i+2] then
													DailyEventValue7 = 0
												end
											end
											if DailyEventValue7 == 1 then
												for i = 2,#DailyEventList[DailyEvent3],3 do
													Char.DelItem(Index,DailyEventList[DailyEvent3][i],DailyEventList[DailyEvent3][i+2])
												end
												DailyEventValue5 = 1
											else
												DailyEventValue5 = 0
												NLG.SystemMessage(player,"���ĵ��߲��㡣")
											end
										elseif DailyEventList[DailyEvent3][1] == 3 then
											local DailyEventValue8 = Char.HavePet(player,DailyEventList[DailyEvent3][2])
											if DailyEventValue8 >= 0 and DailyEventValue8 <= 4 then
												local DailyEventValue9 = Char.GetData(Char.GetPet(player,DailyEventValue8),%����_�ȼ�%)
												if DailyEventValue9 >= DailyEventList[DailyEvent3][4] and DailyEventValue9 <= DailyEventList[DailyEvent3][5] then
													Char.DelSlotPet(player,DailyEventValue8)
													NLG.SystemMessage(player,"������"..DailyEventList[DailyEvent3][3].."��")
													DailyEventValue5 = 1
												else
													DailyEventValue5 = 0
													NLG.SystemMessage(player,"���ĳ���ȼ�������")
												end
											else
												DailyEventValue5 = 0
												NLG.SystemMessage(player,"��û��"..DailyEventList[DailyEvent3][3].."��")
											end
										end
										if DailyEventValue5 == 1 then
											Field.Set(player,"DailyEvent2",(DailyEvent2+1))
											Field.Set(player,"DailyEvent3","")
											local DailyEventValue15 = Char.GetData(player,%����_�ȼ�%)
											if (DailyEvent2+1) >= DailyEventMax then
												if DailyEventValue15 >= ServerMaxLevel and DailyEventLevelMaxGiveItemLast > 0 then
													Char.GiveItem(player,DailyEventLevelMaxGiveItemLast,1)
												else
													if DailyEventGiveItemLast > 0 then
														Char.GiveItem(player,DailyEventGiveItemLast,1)
													end
													if DailyEventGiveExpLast > 0 then
														Char.SetData(player,%����_����%,(Char.GetData(player,%����_����%)+DailyEventGiveExpLast))
														NLG.SystemMessage(player,"�õ�"..DailyEventGiveExpLast.."���顣")
														NLG.UpChar(player)
													end
												end
											else
												if DailyEventValue15 >= ServerMaxLevel and DailyEventLevelMaxGiveItem > 0 then
													Char.GiveItem(player,DailyEventLevelMaxGiveItem,1)
												else
													if DailyEventGiveItem > 0 then
														Char.GiveItem(player,DailyEventGiveItem,1)
													end
													if DailyEventGiveExp > 0 then
														Char.SetData(player,%����_����%,(Char.GetData(player,%����_����%)+DailyEventGiveExp))
														NLG.SystemMessage(player,"�õ�"..DailyEventGiveExp.."���顣")
														NLG.UpChar(player)
													end
												end
											end
											if DailyEventWarp == 1 then
												Char.DischargeParty(player)
												Char.Warp(player,0,DailyEventWarpMap,DailyEventWarpPosX,DailyEventWarpPosY)
											end
										end
									else
										NLG.SystemMessage(player,"�������Ƚ�ȡһ��"..DailyEventName.."��")
									end
								else
									NLG.SystemMessage(player,"���Ѿ���������е�"..DailyEventName.."��")
								end
							else
								NLG.SystemMessage(player,"���Ķ���̫���ˡ�")
							end
						end
					end
				else
					NLG.SystemMessage(player,"���ĵȼ�̫���ˡ�")
				end
			end
		end
	end
end

if AnotherNpc == 1 then
	if DailyEventValue10 == nil or DailyEventValue10 < 0 then
		DailyEventValue10 = NL.CreateNpc(nil,"DailyEventValue12")
	end
end
