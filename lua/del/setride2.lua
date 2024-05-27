cset = Char.SetData
cget = Char.GetData
tbl_PetRideImage = tbl_PetRideImage or {};
NL.RegPetRideImageEvent(nil, "MyPetRideImage");

--CONST_PRideImageID 	= 8117 - 9 - 3; --骑宠图档
CONST_PRideSpeed	= 8117 - 9;     --骑宠速度


function MyPetRideImage(Player, PetRideImage)
	
	
	if tbl_PetRideImage[Playerkey(Player)] ~= nil then
		--NLG.SystemMessage(Player,"123123");
		cset(Player,CONST_PRideSpeed,tbl_PetRideImage[Playerkey(Player)][2])
		return tbl_PetRideImage[Playerkey(Player)][1]
	end
	

	return PetRideImage
	
end


-- alloc GE 4 GA
function NLG.SetRideEffect(Player,ImageID,Speed)
	
	Speed = Speed or 100;
	if ImageID == -1 then
		--NLG.SystemMessage(Player,ImageID);
		tbl_PetRideImage[Playerkey(Player)] = nil;
	else
		--NLG.SystemMessage(Player,"s"..ImageID);
		--保存原速度
		local oSpeed = cget(Player,CONST_PRideSpeed)
		tbl_PetRideImage[Playerkey(Player)] = {ImageID,Speed,oSpeed};
	end
	
	
	if cget(Player,%对象_序%) == %对象类型_人% then	
		cset(Player,CONST_PRideSpeed,Speed)	
		NLG.UpChar(Player); 
	end
end


--[[
xx1 = 0;
Delegate.RegDelTalkEvent("prtest_TalkEvent");
function prtest_TalkEvent(player,msg,color,range,size)
	
	if(string.find (msg,"/123"))then
		if xx1 == 0 then
			local sv = string.gsub(msg, "/123 ", "");
			NLG.SystemMessage(player,sv);
			NLG.SetRideEffect(player,tonumber(sv),600)
			xx1=1
		else
			NLG.SetRideEffect(player,-1,100)
			xx1=0
		end
	end
end

--]]


