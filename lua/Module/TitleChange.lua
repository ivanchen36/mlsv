local bangdingkey = 1 --是否绑定被附加过称号的水晶 1为绑定 其他为不绑定 建议绑定
local renamekey = 1 --是否修改被附加称号水晶的名字 1为修改 其他为不修改
local TitalValue = {}
--TitalValue[t] = {name,x1,k1,y1,x2,k2,y2} 
--t为称号id name为称号名称 x系列为字段 k系列为修改方式 1为增减式 0为覆盖式 y系列为数值
--TitalValue[] = {}
TitalValue[87] = {"敬畏的寂静",%道具_攻击%,1,40,%道具_敏捷%,1,40,%道具_精神%,1,40,%道具_防御%,1,40,%道具_生命%,1,300}
TitalValue[114] = {"剑术师范",%道具_攻击%,1,80,%道具_敏捷%,1,20,%道具_生命%,1,200}
TitalValue[124] = {"战斧师范",%道具_攻击%,1,80,%道具_敏捷%,1,20,%道具_生命%,1,200}
TitalValue[134] = {"近卫骑士",%道具_攻击%,1,80,%道具_敏捷%,1,20,%道具_生命%,1,200}
TitalValue[144] = {"弓术师范",%道具_攻击%,1,80,%道具_敏捷%,1,20,%道具_生命%,1,200}
TitalValue[154] = {"士兵长",%道具_攻击%,1,80,%道具_敏捷%,1,20,%道具_生命%,1,200}
TitalValue[164] = {"主教",%道具_防御%,1,30,%道具_回复%,1,20,%道具_生命%,1,100,%道具_魔力%,1,150}
TitalValue[174] = {"魔导士",%道具_精神%,1,60,%道具_生命%,1,100,%道具_魔力%,1,150}
TitalValue[184] = {"降头师",%道具_精神%,1,60,%道具_生命%,1,100,%道具_魔力%,1,150}
TitalValue[194] = {"封印术师范",%道具_防御%,1,50,%道具_生命%,1,300}
TitalValue[224] = {"诈欺师",%道具_敏捷%,1,60,%道具_生命%,1,300}
TitalValue[234] = {"巫术大师",%道具_防御%,1,30,%道具_回复%,1,20,%道具_生命%,1,100,%道具_魔力%,1,150}
TitalValue[244] = {"格斗家师范",%道具_攻击%,1,120,%道具_敏捷%,1,20,%道具_生命%,1,100}
TitalValue[254] = {"影",%道具_敏捷%,1,60,%道具_生命%,1,300}
TitalValue[4048] = {"皇家爆弹师",%道具_攻击%,1,80,%道具_敏捷%,1,20,%道具_生命%,1,200}
TitalValue[5004] = {"圆桌骑士",%道具_攻击%,1,160,%道具_敏捷%,1,20,%道具_生命%,1,300}
TitalValue[5009] = {"Zeus",%道具_攻击%,1,160,%道具_敏捷%,1,20,%道具_生命%,1,300}
TitalValue[5014] = {"太极宗师",%道具_精神%,1,120,%道具_生命%,1,150,%道具_魔力%,1,200}
TitalValue[5019] = {"罗宾汉",%道具_攻击%,1,160,%道具_敏捷%,1,20,%道具_生命%,1,300}
TitalValue[5029] = {"罪",%道具_攻击%,1,160,%道具_敏捷%,1,20,%道具_生命%,1,300}
TitalValue[5024] = {"精灵",%道具_精神%,1,120,%道具_生命%,1,150,%道具_魔力%,1,200}
TitalValue[5034] = {"枫叶守望者",%道具_攻击%,1,160,%道具_敏捷%,1,20,%道具_生命%,1,200,%道具_魔力%,1,200}
TitalValue[5040] = {"神圣牧师",%道具_攻击%,1,40,%道具_精神%,1,40,%道具_生命%,1,150,%道具_魔力%,1,200}
TitalValue[1009] = {"艾尔巴第八等勳章",%道具_生命%,1,50,%道具_魔力%,1,50}
TitalValue[1010] = {"艾尔巴第七等勳章",%道具_生命%,1,100,%道具_魔力%,1,100}
TitalValue[1011] = {"艾尔巴第六等勳章",%道具_生命%,1,150,%道具_魔力%,1,150}
TitalValue[1012] = {"艾尔巴第五等勳章",%道具_生命%,1,200,%道具_魔力%,1,200}
TitalValue[1013] = {"艾尔巴第四等勳章",%道具_生命%,1,250,%道具_魔力%,1,250}
TitalValue[1014] = {"艾尔巴第三等勳章",%道具_生命%,1,300,%道具_魔力%,1,300}
TitalValue[1015] = {"艾尔巴第二等勳章",%道具_防御%,1,20,%道具_精神%,1,20,%道具_回复%,1,20,%道具_生命%,1,400,%道具_魔力%,1,500}
TitalValue[1016] = {"艾尔巴第一等勳章",%道具_防御%,1,30,%道具_精神%,1,30,%道具_回复%,1,30,%道具_生命%,1,500,%道具_魔力%,1,600}
TitalValue[1017] = {"兰国第八等勳章",%道具_生命%,1,100}
TitalValue[1018] = {"兰国第七等勳章",%道具_生命%,1,200}
TitalValue[1019] = {"兰国第六等勳章",%道具_生命%,1,300}
TitalValue[1020] = {"兰国第五等勳章",%道具_生命%,1,400}
TitalValue[1021] = {"兰国第四等勳章",%道具_生命%,1,500}
TitalValue[1022] = {"兰国第三等勳章",%道具_生命%,1,600}
TitalValue[1023] = {"兰国第二等勳章",%道具_防御%,1,20,%道具_回复%,1,10,%道具_生命%,1,800}
TitalValue[1024] = {"兰国第一等勳章",%道具_防御%,1,30,%道具_回复%,1,20,%道具_生命%,1,1000}
TitalValue[1043] = {"魔鬼克星",%道具_生命%,1,50,%道具_毒抗%,1,5,%道具_睡抗%,1,5,%道具_石抗%,1,5,%道具_醉抗%,1,5,%道具_乱抗%,1,5,%道具_忘抗%,1,5}
TitalValue[1044] = {"龙之拯救者",%道具_生命%,1,100,%道具_毒抗%,1,10,%道具_睡抗%,1,10,%道具_石抗%,1,10,%道具_醉抗%,1,10,%道具_乱抗%,1,10,%道具_忘抗%,1,10}
TitalValue[1045] = {"北国行者",%道具_生命%,1,200,%道具_毒抗%,1,15,%道具_睡抗%,1,15,%道具_石抗%,1,15,%道具_醉抗%,1,15,%道具_乱抗%,1,15,%道具_忘抗%,1,15}
TitalValue[1048] = {"解放者",%道具_生命%,1,300,%道具_毒抗%,1,20,%道具_睡抗%,1,20,%道具_石抗%,1,20,%道具_醉抗%,1,20,%道具_乱抗%,1,20,%道具_忘抗%,1,20}
TitalValue[61] = {"开启者",%道具_生命%,1,100,%道具_必杀%,1,5,%道具_反击%,1,2,%道具_命中%,1,2,%道具_闪躲%,1,2}
TitalValue[4080] = {"秋枫第五勳章",%道具_必杀%,1,1,%道具_反击%,1,1,%道具_命中%,1,1,%道具_闪躲%,1,1}
TitalValue[4081] = {"春樱第五勳章",%道具_必杀%,1,2,%道具_反击%,1,2,%道具_命中%,1,2,%道具_闪躲%,1,2}
TitalValue[4082] = {"秋枫第四勳章",%道具_必杀%,1,3,%道具_反击%,1,3,%道具_命中%,1,3,%道具_闪躲%,1,3}
TitalValue[4083] = {"春樱第四勳章",%道具_必杀%,1,4,%道具_反击%,1,4,%道具_命中%,1,4,%道具_闪躲%,1,4}
TitalValue[4084] = {"秋枫第三勳章",%道具_必杀%,1,5,%道具_反击%,1,5,%道具_命中%,1,5,%道具_闪躲%,1,5,%道具_生命%,1,50}
TitalValue[4085] = {"春樱第三勳章",%道具_必杀%,1,6,%道具_反击%,1,6,%道具_命中%,1,6,%道具_闪躲%,1,6,%道具_生命%,1,100}
TitalValue[4086] = {"秋枫第二勳章",%道具_必杀%,1,7,%道具_反击%,1,7,%道具_命中%,1,7,%道具_闪躲%,1,7,%道具_生命%,1,150}
TitalValue[4087] = {"春樱第二勳章",%道具_必杀%,1,8,%道具_反击%,1,8,%道具_命中%,1,8,%道具_闪躲%,1,8,%道具_生命%,1,200}
TitalValue[4088] = {"秋枫第一勳章",%道具_必杀%,1,9,%道具_反击%,1,9,%道具_命中%,1,9,%道具_闪躲%,1,9,%道具_生命%,1,250}
TitalValue[4089] = {"春樱第一勳章",%道具_必杀%,1,10,%道具_反击%,1,10,%道具_命中%,1,10,%道具_闪躲%,1,10,%道具_生命%,1,300}
TitalValue[5035] = {"明教教主",%道具_攻击%,1,240,%道具_必杀%,5,%道具_生命%,1,300}
TitalValue[5036] = {"命犯桃花",%道具_攻击%,1,50,%道具_命中%,1,20,%道具_生命%,1,300}
TitalValue[5041] = {"疾风传说",%道具_敏捷%,1,100,%道具_生命%,1,200}
TitalValue[5042] = {"疾风传说",%道具_敏捷%,1,100,%道具_生命%,1,200}
TitalValue[5043] = {"疾风传说",%道具_敏捷%,1,100,%道具_生命%,1,200}
TitalValue[5044] = {"疾风传说",%道具_敏捷%,1,100,%道具_生命%,1,200}

--[[附常见道具属性字段表：
	%道具_攻击%
	%道具_防御%
	%道具_敏捷%
	%道具_精神%
	%道具_回复%
	%道具_必杀%
	%道具_反击%
	%道具_命中%
	%道具_闪躲%
	%道具_生命%
	%道具_魔力%
	%道具_毒抗%
	%道具_睡抗%
	%道具_石抗%
	%道具_醉抗%
	%道具_乱抗%
	%道具_忘抗%
	%道具_魔抗%
]]

--*注意：属性设定为覆盖式时，会无条件覆盖原有属性。用于做特殊设置时使用。如对魔力道具数值无深刻理解，建议只使用增减式。
--*属性附带于水晶上，如不设置为绑定，会导致附加了属性的水晶交易给他人的情况。
--*水晶附加称号属性使用字段 %道具_自用参数% 请勿重复
--*如修改水晶名字，使用字段 %道具_鉴前名% 记录道具原名 请勿重复
-------------------------------------------------------------

NL.RegTitleChangedEvent(nil,"TitleChangedEvent");



function TitleChangeValue1(TitleChangeValue8)
	local TitleChangeValue2 = Item.GetData(TitleChangeValue8,3)
	if TitleChangeValue2 == 22 then
		local TitleChangeValue3 = tonumber(Item.GetData(TitleChangeValue8,%道具_宝石武%))
		if TitleChangeValue3 ~= nil and type(TitalValue[TitleChangeValue3]) == "table" then
			for i = 1,(#TitalValue[TitleChangeValue3]-1)/3 do
				local TitleChangeValue4 = TitalValue[TitleChangeValue3][2+(i-1)*3]
				local TitleChangeValue5 = TitalValue[TitleChangeValue3][3+(i-1)*3]
				local TitleChangeValue6 = TitalValue[TitleChangeValue3][4+(i-1)*3]
				local TitleChangeValue7 = Item.GetData(TitleChangeValue8,TitleChangeValue4)
				if TitleChangeValue5 == 0 then
					Item.SetData(TitleChangeValue8,TitleChangeValue4,0)
				elseif TitleChangeValue5 == 1 then
					Item.SetData(TitleChangeValue8,TitleChangeValue4,TitleChangeValue7-TitleChangeValue6)
				end
			end
			Item.SetData(TitleChangeValue8,%道具_宝石武%,0)
			if renamekey == 1 then
				Item.SetData(TitleChangeValue8,%道具_名字%,Item.GetData(TitleChangeValue8,%道具_鉴前名%))
			end
			return 1
		end
	end
	return 0
end
function TitleChangeValue9(TitleChangeValue12,TitleChangeValue8,TitleChangeValue10)
	for i = 1,(#TitalValue[TitleChangeValue10]-1)/3 do
		local TitleChangeValue4 = TitalValue[TitleChangeValue10][2+(i-1)*3]
		local TitleChangeValue5 = TitalValue[TitleChangeValue10][3+(i-1)*3]
		local TitleChangeValue6 = TitalValue[TitleChangeValue10][4+(i-1)*3]
		local TitleChangeValue7 = Item.GetData(TitleChangeValue8,TitleChangeValue4)
		Item.SetData(TitleChangeValue8,TitleChangeValue4,TitleChangeValue7*TitleChangeValue5+TitleChangeValue6)
	end
	--Item.SetData(TitleChangeValue8,%道具_自用参数%,TitleChangeValue10)
	Item.SetData(TitleChangeValue8,%道具_宝石武%,TitleChangeValue10)
	if renamekey == 1 then
		Item.SetData(TitleChangeValue8,%道具_鉴前名%,Item.GetData(TitleChangeValue8,%道具_名字%))
		Item.SetData(TitleChangeValue8,%道具_名字%,TitalValue[TitleChangeValue10][1])
	end
	if bangdingkey == 1 then
		Item.SetData(TitleChangeValue8,%道具_丢地消失%,1)
		Item.SetData(TitleChangeValue8,%道具_宠邮%,0)
	end
	NLG.SystemMessage(TitleChangeValue12,"得到了 "..TitalValue[TitleChangeValue10][1].." 的力量！")
end

function TitleChangedEvent(TitleChangeValue12,t1,TitleChangeValue11)
	for i = 7,27 do
		local TitleChangeValue8 = Char.GetItemIndex(TitleChangeValue12,i)
		if TitleChangeValue8 > 0 then
			if TitleChangeValue1(TitleChangeValue8) ~= 0 then
				Item.UpItem(TitleChangeValue12,i)
			end
		end
	end
	if type(TitalValue[TitleChangeValue11]) == "table" then
		local TitleChangeValue8 = Char.GetItemIndex(TitleChangeValue12,7)
		if TitleChangeValue8 > 0 then
			TitleChangeValue9(TitleChangeValue12,TitleChangeValue8,TitleChangeValue11)
			Item.UpItem(TitleChangeValue12,7)
		else
			NLG.SystemMessage(TitleChangeValue12,"附加称号属性失败。您未装备水晶。")
		end
	end
	return
end
