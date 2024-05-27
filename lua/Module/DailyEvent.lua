local DailyEventName = "日常任务" --npc对此称呼
local DailyEventMsg = "    您可以在此领取日常任务。每日一轮,奖励丰厚" --修行说明
local DailyEventMax = 1 --每日可完成最大次数
local DailyEventDays = {0,1,2,3,4,5,6} --修行任务开放日期 0-6表示周日-周6
local DailyEventGiveItem = 0 --完成一次任务给予道具奖励的itemid，如有多个道具或魔币请制作成礼包形式 为0或负数时不给予道具
local DailyEventGiveItemLast = 196921 --完成全部任务给予道具奖励的itemid，如有多个道具或魔币请制作成礼包形式 为0或负数时不给予道具
local DailyEventGiveExp = 0 --完成一次任务给予经验奖励数量 为0或负数时不给经验
local DailyEventGiveExpLast = 0 --完成全部任务给予经验奖励数量 为0或负数时不给经验
local DailyEventLevelMaxGiveItem = 0 --满级时完成一次任务给予道具奖励的itemid 如为负数则按照未满级给予
local DailyEventLevelMaxGiveItemLast = 196921 --满级时完成全部任务给予道具奖励的itemid 如为负数则按照未满级给予
local DailyEventStartLevel = 70 --开启修行任务的最低等级
local ServerMaxLevel = 180 --服务器设定的满级等级
local DailyEventWarp = 0 --完成任务后是否传送 1为传送其他不传送
local DailyEventWarpMap = 1000 --完成任务后传送地图
local DailyEventWarpPosX = 0 --完成任务后传送x坐标
local DailyEventWarpPoxY = 0 --完成任务后传送y坐标


local DENpcMetamo = 231111 --修行npc形象
local DENpcName = "日常任务" --修行npc名字
local DENpcMap = 1000 --修行npc地图
local DENpcPosX = 236 --修行npc x坐标
local DENpcPosY = 80 --修行npc y坐标
local DENpcDir = 4 --修行npc方向

local AnotherNpc = 0 --交任务Npc是否不同于修行Npc 0为同个npc交任务 1为启用单独交任务修行npc

local DENpcMetamo2 = 100500 --交任务修行npc形象
local DENpcName2 = "修行任务" --交任务修行npc名字
local DENpcMap2 = 777 --交任务修行npc地图
local DENpcPosX2 = 0 --交任务修行npc x坐标
local DENpcPosY2 = 3 --交任务修行npc y坐标
local DENpcDir2 = 4 --交任务修行npc方向

local DailyEventLocked = -1 --是否锁定任务 -1为全任务随机 否则为锁定此任务编号--[1,魔币 2,物品 3,宠物]DailyEventList[2] = {1,1000} DailyEventList[5] = {2,9611,"铜条",5} DailyEventList[25] = {3,314,"黄蜂",1,1}
local DailyEventList = {} --任务表单 DailyEventList[k] = {x,y……z} k为任务编号 x为任务类型
DailyEventList[1] = {2,88888,"金币",1} --任务类型0 跑腿任务 DailyEventList[k] = {1,y} y为npc的任务说明 无需任何道具，只需与交修行npc对话即可完成。一般用于启用单独交任务修行npc时使用。
DailyEventList[2] = {2,18565,"梦幻头巾",1}
DailyEventList[3] = {2,15202,"蛋包饭",1}
DailyEventList[4] = {2,18570,"宇治金时",1}
DailyEventList[5] = {2,18310,"地的水晶碎片",10}
DailyEventList[6] = {2,18311,"水的水晶碎片",10}
DailyEventList[7] = {2,18311,"火的水晶碎片",10}
DailyEventList[8] = {2,18312,"风的水晶碎片",10}
DailyEventList[9] = {1,2500}
DailyEventList[10] = {1,5000}
DailyEventList[11] = {2,195472,"宝石？",1}
DailyEventList[12] = {2,70902,"树精精华",20}
DailyEventList[13] = {2,70907,"大蝙蝠精华",40}
DailyEventList[14] = {2,70910,"初级进化材料",3}
DailyEventList[15] = {2,18983,"阿尔卡迪亚古钱",5}
DailyEventList[16] = {2,18670,"味噌汤",1}
DailyEventList[17] = {2,196204,"炫动饮料",1}
DailyEventList[18] = {2,21667,"骨衣",1}
DailyEventList[19] = {2,18254,"太古的道具",1}
DailyEventList[20] = {2,18403,"欧兹那克的戒指",1}
DailyEventList[21] = {2,18231,"赖光的头盔",1}
DailyEventList[22] = {2,27998,"神眼",1}
DailyEventList[23] = {2,27053,"井底蛙",1}
DailyEventList[24] = {2,18973,"土之乐谱",1}
DailyEventList[25] = {2,18305,"遗物「丝巾」",1}
DailyEventList[26] = {2,18487,"夏贝特之笛",1}
DailyEventList[27] = {2,18278,"冠军之戒",1}
DailyEventList[28] = {2,18279,"冠军之环",1}
DailyEventList[29] = {2,40080,"巴克达的签名照",1}
DailyEventList[30] = {2,192723,"王♂的悲鸣录音带",1}
DailyEventList[31] = {2,192724,"画像",1}
DailyEventList[32] = {2,18234,"全套面包招待券",1}
DailyEventList[33] = {2,18194,"红头盔",1}
DailyEventList[34] = {2,18451,"誓言之证",1}
DailyEventList[35] = {2,18449,"钢骑之矿",1}
DailyEventList[36] = {2,18448,"传送石回数票",1}
DailyEventList[37] = {3,834,"烈风鸟人",1,1}
DailyEventList[38] = {3,801,"哥布林",1,1}
DailyEventList[39] = {3,722,"水龙蜥",1,1}
DailyEventList[40] = {3,321,"螳螂",1,1}
DailyEventList[41] = {3,413,"妖草",1,1}
DailyEventList[42] = {3,333,"火蜘蛛",1,1}
DailyEventList[43] = {3,314,"黄蜂",1,1}
DailyEventList[44] = {3,34,"地狱妖犬",1,1}
DailyEventList[45] = {3,5602,"潜盾",1,1}
DailyEventList[46] = {3,13,"北极熊",1,1}
DailyEventList[47] = {3,21,"大地鼠",1,1}
DailyEventList[48] = {3,2000,"快枯死的树精",1,1}
DailyEventList[49] = {3,6035,"虚弱的雏鸟",1,1}

--使用Field库DailyEvent1、DailyEvent2、DailyEvent3字段
-------------------------------------------------------------

function DailyEventValue1(npc)
	Char.SetData(npc,%对象_形象%,DENpcMetamo)
	Char.SetData(npc,%对象_原形%,DENpcMetamo)
	Char.SetData(npc,%对象_地图%,DENpcMap)
	Char.SetData(npc,%对象_X%,DENpcPosX)
	Char.SetData(npc,%对象_Y%,DENpcPosY)
	Char.SetData(npc,%对象_方向%,DENpcDir)
	Char.SetData(npc,%对象_原名%,DENpcName)
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
				local DailyEventValue3 = "3\n★★★★★★"..DailyEventName.."★★★★★★★\n请选择您需要的服务：\n\n1."..DailyEventName.."说明\n2.领取"..DailyEventName.."或查看当前进度"
				if AnotherNpc == 0 then
					DailyEventValue3 = DailyEventValue3.."\n3.完成"..DailyEventName
				end
				NLG.ShowWindowTalked(player,npc,2,2,0,DailyEventValue3)
				return
			end
		end
		--NLG.SystemMessage(player,"今天"..DailyEventName.."不开放。")
	end
end

function DailyEventValue3(npc,player,Seqno,Select,Data)
	if NLG.CheckInFront(npc,player,2) then
		if Select ~= 2 then
			for k,v in pairs(DailyEventDays) do
				if tonumber(os.date("%w")) == v then
					local DailyEventValue16 = Char.GetData(player,%对象_等级%)
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
										local DailyEventValue3 = "您当前正在进行第"..(DailyEvent2+1).."次"..DailyEventName.."，您的目标是"
										if DailyEventList[DailyEvent3][1] == 0 then
											DailyEventValue3 = DailyEventValue3..DailyEventList[DailyEvent3][2].."。"
										elseif DailyEventList[DailyEvent3][1] == 1 then
											DailyEventValue3 = DailyEventValue3.."缴纳"..DailyEventList[DailyEvent3][2].."魔币。"
										elseif DailyEventList[DailyEvent3][1] == 2 then
											for i = 2,#DailyEventList[DailyEvent3],3 do
												DailyEventValue3 = DailyEventValue3.."缴纳"..DailyEventList[DailyEvent3][i+2].."个"..DailyEventList[DailyEvent3][i+1].." "
											end
											DailyEventValue3 = DailyEventValue3.."。"
										elseif DailyEventList[DailyEvent3][1] == 3 then
											DailyEventValue3 = DailyEventValue3.."缴纳等级:"..DailyEventList[DailyEvent3][4].."的"..DailyEventList[DailyEvent3][3].."。"
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
										local DailyEventValue3 = "接受"..DailyEventName.."成功！当前您已完成"..DailyEvent2.."次"..DailyEventName.."，您本次的目标是"
										if DailyEventList[DailyEvent3][1] == 0 then
											DailyEventValue3 = DailyEventValue3..DailyEventList[DailyEvent3][2].."。"
										elseif DailyEventList[DailyEvent3][1] == 1 then
											DailyEventValue3 = DailyEventValue3.."缴纳"..DailyEventList[DailyEvent3][2].."魔币。"
										elseif DailyEventList[DailyEvent3][1] == 2 then
											for i = 2,#DailyEventList[DailyEvent3],3 do
												DailyEventValue3 = DailyEventValue3.."缴纳"..DailyEventList[DailyEvent3][i+2].."个"..DailyEventList[DailyEvent3][i+1].." "
											end
											DailyEventValue3 = DailyEventValue3.."。"
										elseif DailyEventList[DailyEvent3][1] == 3 then
											DailyEventValue3 = DailyEventValue3.."缴纳等级:"..DailyEventList[DailyEvent3][4].."的"..DailyEventList[DailyEvent3][3].."。"
										end
										NLG.SystemMessage(player,DailyEventValue3)
									end
								else
									NLG.SystemMessage(player,"您已经完成了本日所有的"..DailyEventName.."。")
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
													local DailyEventValue6 = Char.GetData(player,%对象_金币%)
													if DailyEventValue6 >= DailyEventList[DailyEvent3][2] then
														Char.SetData(player,%对象_金币%,(DailyEventValue6-DailyEventList[DailyEvent3][2]))
														NLG.SystemMessage(player,"交出了"..DailyEventList[DailyEvent3][2].."魔币。")
														DailyEventValue5 = 1
													else
														DailyEventValue5 = 0
														NLG.SystemMessage(player,"您的魔币不足。")
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
														NLG.SystemMessage(player,"您的道具不足。")
													end
												elseif DailyEventList[DailyEvent3][1] == 3 then
													local DailyEventValue8 = Char.HavePet(player,DailyEventList[DailyEvent3][2])
													if DailyEventValue8 >= 0 and DailyEventValue8 <= 4 then
														local DailyEventValue9 = Char.GetData(Char.GetPet(player,DailyEventValue8),%对象_等级%)
														if DailyEventValue9 >= DailyEventList[DailyEvent3][4] and DailyEventValue9 <= DailyEventList[DailyEvent3][5] then
															Char.DelSlotPet(player,DailyEventValue8)
															NLG.SystemMessage(player,"交出了"..DailyEventList[DailyEvent3][3].."。")
															DailyEventValue5 = 1
														else
															DailyEventValue5 = 0
															NLG.SystemMessage(player,"您的宠物等级不符。")
														end
													else
														DailyEventValue5 = 0
														NLG.SystemMessage(player,"您没有"..DailyEventList[DailyEvent3][3].."。")
													end
												end
												if DailyEventValue5 == 1 then
													Field.Set(player,"DailyEvent2",(DailyEvent2+1))
													Field.Set(player,"DailyEvent3","")
													local DailyEventValue15 = Char.GetData(player,%对象_等级%)
													if (DailyEvent2+1) >= DailyEventMax then
														if DailyEventValue15 >= ServerMaxLevel and DailyEventLevelMaxGiveItemLast > 0 then
															Char.GiveItem(player,DailyEventLevelMaxGiveItemLast,1)
														else
															if DailyEventGiveItemLast > 0 then
																Char.GiveItem(player,DailyEventGiveItemLast,1)
															end
															if DailyEventGiveExpLast > 0 then
																Char.SetData(player,%对象_经验%,(Char.GetData(player,%对象_经验%)+DailyEventGiveExpLast))
																NLG.SystemMessage(player,"得到"..DailyEventGiveExpLast.."经验。")
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
																Char.SetData(player,%对象_经验%,(Char.GetData(player,%对象_经验%)+DailyEventGiveExp))
																NLG.SystemMessage(player,"得到"..DailyEventGiveExp.."经验。")
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
												NLG.SystemMessage(player,"您必须先接取一个"..DailyEventName.."。")
											end
										else
											NLG.SystemMessage(player,"您已经完成了所有的"..DailyEventName.."。")
										end
									else
										NLG.SystemMessage(player,"您的东西太多了。")
									end
								end
							end
						end
						return
					else
						NLG.SystemMessage(player,"您的等级太低了。")
					end
				end
			end
			--NLG.SystemMessage(player,"今天"..DailyEventName.."不开放。")
		end
	end
end


if DailyEventValue11 == nil or DailyEventValue11 < 0 then
	DailyEventValue11 = NL.CreateNpc(nil,"DailyEventValue1")
end

function DailyEventValue12(npc)
	Char.SetData(npc,%对象_形象%,DENpcMetamo2)
	Char.SetData(npc,%对象_原形%,DENpcMetamo2)
	Char.SetData(npc,%对象_地图%,DENpcMap2)
	Char.SetData(npc,%对象_X%,DENpcPosX2)
	Char.SetData(npc,%对象_Y%,DENpcPosY2)
	Char.SetData(npc,%对象_方向%,DENpcDir2)
	Char.SetData(npc,%对象_原名%,DENpcName2)
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
			local DailyEventValue3 = "3\n★★★★★★★"..DailyEventName.."★★★★★★★\n请选择您需要的服务：\n\n1."..DailyEventName.."说明\n2.完成"..DailyEventName
			NLG.ShowWindowTalked(player,npc,2,2,0,DailyEventValue3)
		end
	end
end

function DailyEventValue14(npc,player,Seqno,Select,Data)
	if NLG.CheckInFront(npc,player,2) then
		if Select ~= 2 then
			if Seqno == 0 then
				local DailyEventValue16 = Char.GetData(player,%对象_等级%)
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
											--local DailyEventValue6 = Char.GetData(player,%对象_金币%)
											local DailyEventValue6 = Char.GetData(player,%对象_金币%)
											if DailyEventValue6 >= DailyEventList[DailyEvent3][2] then
												Char.SetData(player,%对象_金币%,(DailyEventValue6-DailyEventList[DailyEvent3][2]))
												NLG.SystemMessage(player,"交出了"..DailyEventList[DailyEvent3][2].."魔币。")
												DailyEventValue5 = 1
											else
												DailyEventValue5 = 0
												NLG.SystemMessage(player,"您的魔币不足。")
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
												NLG.SystemMessage(player,"您的道具不足。")
											end
										elseif DailyEventList[DailyEvent3][1] == 3 then
											local DailyEventValue8 = Char.HavePet(player,DailyEventList[DailyEvent3][2])
											if DailyEventValue8 >= 0 and DailyEventValue8 <= 4 then
												local DailyEventValue9 = Char.GetData(Char.GetPet(player,DailyEventValue8),%对象_等级%)
												if DailyEventValue9 >= DailyEventList[DailyEvent3][4] and DailyEventValue9 <= DailyEventList[DailyEvent3][5] then
													Char.DelSlotPet(player,DailyEventValue8)
													NLG.SystemMessage(player,"交出了"..DailyEventList[DailyEvent3][3].."。")
													DailyEventValue5 = 1
												else
													DailyEventValue5 = 0
													NLG.SystemMessage(player,"您的宠物等级不符。")
												end
											else
												DailyEventValue5 = 0
												NLG.SystemMessage(player,"您没有"..DailyEventList[DailyEvent3][3].."。")
											end
										end
										if DailyEventValue5 == 1 then
											Field.Set(player,"DailyEvent2",(DailyEvent2+1))
											Field.Set(player,"DailyEvent3","")
											local DailyEventValue15 = Char.GetData(player,%对象_等级%)
											if (DailyEvent2+1) >= DailyEventMax then
												if DailyEventValue15 >= ServerMaxLevel and DailyEventLevelMaxGiveItemLast > 0 then
													Char.GiveItem(player,DailyEventLevelMaxGiveItemLast,1)
												else
													if DailyEventGiveItemLast > 0 then
														Char.GiveItem(player,DailyEventGiveItemLast,1)
													end
													if DailyEventGiveExpLast > 0 then
														Char.SetData(player,%对象_经验%,(Char.GetData(player,%对象_经验%)+DailyEventGiveExpLast))
														NLG.SystemMessage(player,"得到"..DailyEventGiveExpLast.."经验。")
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
														Char.SetData(player,%对象_经验%,(Char.GetData(player,%对象_经验%)+DailyEventGiveExp))
														NLG.SystemMessage(player,"得到"..DailyEventGiveExp.."经验。")
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
										NLG.SystemMessage(player,"您必须先接取一个"..DailyEventName.."。")
									end
								else
									NLG.SystemMessage(player,"您已经完成了所有的"..DailyEventName.."。")
								end
							else
								NLG.SystemMessage(player,"您的东西太多了。")
							end
						end
					end
				else
					NLG.SystemMessage(player,"您的等级太低了。")
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
