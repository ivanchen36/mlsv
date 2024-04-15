tbl_daily = {};

function ScriptCall(npc, player, s)


	if(string.find(s,"itemreb"))then
		local this_item = Char.GetItemIndex(player,8);
		local nj = Item.GetData(this_item, %道具_最大耐久%);
		Item.SetData(this_item, %道具_耐久%,nj);
		Item.UpItem(player, 8);
	end
	
	
	if(string.find(s,"daily"))then
		local sv = string.gsub(s, "daily", "");	
		local playerkeyname = Playerkey(player)..sv;
		if(tbl_daily[playerkeyname] == nil)then
			tbl_daily[playerkeyname] = os.time();
			return 1;
		end
						
		if (os.date("%d",tbl_daily[playerkeyname]) ~= os.date("%d",os.time())) then 
			tbl_daily[playerkeyname] = os.time();
			return 1;
		end
		
		return 0;
	end
		

	if(string.find(s,"setdy"))then
		local sv = string.gsub(s, "setdy", "");	
		local playerkeyname = Playerkey(player)..sv;
		tbl_daily[playerkeyname] = tonumber(os.date("%d",os.time()));
		return 1;
	end

	
	if(string.find(s,"setskilllv"))then	
		local sv = string.gsub(s, "setskilllv", "");
		if(sv~=nil and sv~=0)then
			local svA =Split(sv,",");			
			local skillid = tonumber(svA[1]);
			local setexp = tonumber(svA[2]);
			local level = tonumber(svA[3]);
			local skillpos = Char.HaveSkill(player,skillid);
			if(skillpos == -1)then
				Char.AddSkill(player,skillid,setexp);
				local skillpos2 = Char.HaveSkill(player,skillid);
				if(skillpos2 == -1)then
					return 0;
				end
				Char.SetSkillLevel(player,skillpos2, level)
				NLG.UpChar(player);
				return 1;
			end
			return 0;
		end
	end

	if(string.find(s,"getflg"))then
		local get = NLG.GetString(s,"getflg",0);
		local ret = EventExpandCheckFlgCall(player,get);
		return ret;
	end
	

	if(string.find(s,"setflg"))then
		local get = NLG.GetString(s,"setflg",0);
		local ret = EventExpandSetFlgCall(player,get);
		return ret;
	end
	

	if(string.find(s,"delflg"))then
		local get = NLG.GetString(s,"setflg",0);
		local ret = EventExpandClsFlgCall(player,get);
		return ret;
	end
	
	if(string.find(s,"likeme"))then
		
		Char.SetData(player,%对象_形象%,Char.GetData(npc, %对象_形象%));
		Char.SetData(player,%对象_原形%,Char.GetData(npc, %对象_原形%));
		Char.SetData(player,%对象_原始图档%,Char.GetData(npc, %对象_原始图档%));
		NLG.UpChar(player);

		
	end
	
	
	if(string.find(s,"petme"))then
		local petindex = Char.GetPet(player,0);
		if petindex >= 0 then
 			Char.SetData(petindex,%对象_形象%,Char.GetData(npc, %对象_形象%));
			Char.SetData(petindex,%对象_原形%,Char.GetData(npc, %对象_原形%));
			Char.SetData(petindex,%对象_原始图档%,Char.GetData(npc, %对象_原始图档%));
			Pet.UpPet(player, petindex);
			NLG.UpChar(player);
		end
		
	end
	
	
	if(string.find(s,"setmj"))then	
		local sv = string.gsub(s, "setmj", "");
		if(sv ~= nil)then
			local svA = Split(sv,",");	
			local num1 = tonumber(Field.Get(player,"MKTZ_"..svA[1]));
			if num1 ~= nil and num1 < tonumber(svA[2]) then
				Field.Set(player,"MKTZ_"..svA[1],tostring(svA[2]));
				return 1;
			end
		end 
		return 0;
	end 

	if(string.find(s,"showmj"))then	
		local retbl1 = {
			["res"] = Char.ItemNum(player,tiaozhuanjuanID);
		}
		Protocol.PowerSend(player,"MIKING_RET1",retbl1)
		
		local tbl_mj2 = tbl_copy(tbl_mj)
	
		for i=1,#tbl_mj do
			
			local dqcs = Field.Get(player,"MKTZ_"..i);
			
			if tonumber(dqcs) == nil then
				if i == 1 then
					Field.Set(player,"MKTZ_"..i,"1");
				else
					Field.Set(player,"MKTZ_"..i,"0");
				end
				--tbl_mj2[i]["dqcs"] = tonumber(dqcs);
				--NLG.SystemMessage(player, dqcs)
			else
				--NLG.SystemMessage(player, dqcs)
				tbl_mj2[i]["dqcs"] = tonumber(dqcs);
			end
		end
		
		Protocol.PowerSend(player,"MIKING_RET2",tbl_mj2)
		return 1;
	end 	

	if(string.find(s,"peth"))then--这个peth 是调用
		local _PetIndex = Char.GetPet(player,0);
		if _PetIndex >=0 then
			if Char.GetData(_PetIndex,%对象_等级%) > 1 then--只能洗等于1级宠物
				NLG.SystemMessage(player,"[万能洗档]宠物并非一级，无法洗档");
				return 0;
			else
				Pet.SetArtRank(_PetIndex,%宠档_体成%,Pet.FullArtRank(_PetIndex,%宠档_体成%)-math.random(0,4));
				Pet.SetArtRank(_PetIndex,%宠档_力成%,Pet.FullArtRank(_PetIndex,%宠档_力成%)-math.random(0,4));
				Pet.SetArtRank(_PetIndex,%宠档_强成%,Pet.FullArtRank(_PetIndex,%宠档_强成%)-math.random(0,4));
				Pet.SetArtRank(_PetIndex,%宠档_敏成%,Pet.FullArtRank(_PetIndex,%宠档_敏成%)-math.random(0,4));
				Pet.SetArtRank(_PetIndex,%宠档_魔成%,Pet.FullArtRank(_PetIndex,%宠档_魔成%)-math.random(0,4));
				Pet.UpPet(player,_PetIndex);
				Pet.ReBirth(player,_PetIndex);
				local DC1 = Pet.GetArtRank(_PetIndex,%宠档_体成%);
				local MD1 = Pet.FullArtRank(_PetIndex,%宠档_体成%);
				local DC2 = Pet.GetArtRank(_PetIndex,%宠档_力成%);
				local MD2 = Pet.FullArtRank(_PetIndex,%宠档_力成%);
				local DC3 = Pet.GetArtRank(_PetIndex,%宠档_强成%);
				local MD3 = Pet.FullArtRank(_PetIndex,%宠档_强成%);
				local DC4 = Pet.GetArtRank(_PetIndex,%宠档_敏成%);
				local MD4 = Pet.FullArtRank(_PetIndex,%宠档_敏成%);
				local DC5 = Pet.GetArtRank(_PetIndex,%宠档_魔成%);
				local MD5 = Pet.FullArtRank(_PetIndex,%宠档_魔成%);
				local SDC1 = math.abs(DC1 - MD1);
				local SDC2 = math.abs(DC2 - MD2);
				local SDC3 = math.abs(DC3 - MD3);
				local SDC4 = math.abs(DC4 - MD4);
				local SDC5 = math.abs(DC5 - MD5);
				local DC8 = SDC1 + SDC2 + SDC3 + SDC4 + SDC5
				local DC6 = DC1 + DC2 + DC3 + DC4 + DC5
				local DC7 = MD1 + MD2 + MD3 + MD4 + MD5
				local msg = "";
				--local Msg = GAMsgFormat("                ★快捷操作介绍★")
					NLG.SystemMessage(player,"[洗档成功]掉档:"..SDC1..","..SDC2..","..SDC3..","..SDC4..","..SDC5..",总计:-"..DC8.."档");
				return 1;
			end
		else
			NLG.SystemMessage(player,"[万能洗档]洗档失败，宠物栏第一栏没有宠物");
			return 0;
		end
	end
	if(string.find(s,"mandang"))then
		local _PetIndex = Char.GetPet(player,0);
		if _PetIndex >=0 then
			if Char.GetData(_PetIndex,%对象_等级%) > 1 then--只能洗等于1级宠物
				NLG.SystemMessage(player,"[万能洗档]宠物并非一级，无法洗档");
				return 0;
			else
				local MD11 = Pet.FullArtRank(_PetIndex,%宠档_体成%);
				local MD12 = Pet.FullArtRank(_PetIndex,%宠档_力成%);
				local MD13 = Pet.FullArtRank(_PetIndex,%宠档_强成%);
				local MD14 = Pet.FullArtRank(_PetIndex,%宠档_敏成%);
				local MD15 = Pet.FullArtRank(_PetIndex,%宠档_魔成%);
				Pet.SetArtRank(_PetIndex,%宠档_体成%,MD11);
				Pet.SetArtRank(_PetIndex,%宠档_力成%,MD12);
				Pet.SetArtRank(_PetIndex,%宠档_强成%,MD13);
				Pet.SetArtRank(_PetIndex,%宠档_敏成%,MD14);
				Pet.SetArtRank(_PetIndex,%宠档_魔成%,MD15);
				Pet.UpPet(player,_PetIndex);
				Pet.ReBirth(player,_PetIndex);
				local DC1 = Pet.GetArtRank(_PetIndex,%宠档_体成%);
				local MD1 = Pet.FullArtRank(_PetIndex,%宠档_体成%);
				local DC2 = Pet.GetArtRank(_PetIndex,%宠档_力成%);
				local MD2 = Pet.FullArtRank(_PetIndex,%宠档_力成%);
				local DC3 = Pet.GetArtRank(_PetIndex,%宠档_强成%);
				local MD3 = Pet.FullArtRank(_PetIndex,%宠档_强成%);
				local DC4 = Pet.GetArtRank(_PetIndex,%宠档_敏成%);
				local MD4 = Pet.FullArtRank(_PetIndex,%宠档_敏成%);
				local DC5 = Pet.GetArtRank(_PetIndex,%宠档_魔成%);
				local MD5 = Pet.FullArtRank(_PetIndex,%宠档_魔成%);
				local SDC1 = math.abs(DC1 - MD1);
				local SDC2 = math.abs(DC2 - MD2);
				local SDC3 = math.abs(DC3 - MD3);
				local SDC4 = math.abs(DC4 - MD4);
				local SDC5 = math.abs(DC5 - MD5);
				local DC8 = SDC1 + SDC2 + SDC3 + SDC4 + SDC5
				local DC6 = DC1 + DC2 + DC3 + DC4 + DC5
				local DC7 = MD1 + MD2 + MD3 + MD4 + MD5
				local msg = "";
				NLG.SystemMessage(player,"[洗档成功]掉档:"..SDC1..","..SDC2..","..SDC3..","..SDC4..","..SDC5..",总计:-"..DC8.."档");
				return 1;
			end
		else
			NLG.SystemMessage(player,"[万能洗档]洗档失败，宠物栏第一栏没有宠物");
			return 0;
		end
	end
	if(string.find(s,"shidangxidangjuan"))then--这个peth 是调用
		local _PetIndex = Char.GetPet(player,0);
		if _PetIndex >=0 then
			if Char.GetData(_PetIndex,%对象_等级%) > 1 then--只能洗等于1级宠物
				NLG.SystemMessage(player,"[万能洗档]宠物并非一级，无法洗档");
				return 0;
			else
				Pet.SetArtRank(_PetIndex,%宠档_体成%,Pet.FullArtRank(_PetIndex,%宠档_体成%)-math.random(0,2));
				Pet.SetArtRank(_PetIndex,%宠档_力成%,Pet.FullArtRank(_PetIndex,%宠档_力成%)-math.random(0,2));
				Pet.SetArtRank(_PetIndex,%宠档_强成%,Pet.FullArtRank(_PetIndex,%宠档_强成%)-math.random(0,2));
				Pet.SetArtRank(_PetIndex,%宠档_敏成%,Pet.FullArtRank(_PetIndex,%宠档_敏成%)-math.random(0,2));
				Pet.SetArtRank(_PetIndex,%宠档_魔成%,Pet.FullArtRank(_PetIndex,%宠档_魔成%)-math.random(0,2));
				Pet.UpPet(player,_PetIndex);
				Pet.ReBirth(player,_PetIndex);
				local DC1 = Pet.GetArtRank(_PetIndex,%宠档_体成%);
				local MD1 = Pet.FullArtRank(_PetIndex,%宠档_体成%);
				local DC2 = Pet.GetArtRank(_PetIndex,%宠档_力成%);
				local MD2 = Pet.FullArtRank(_PetIndex,%宠档_力成%);
				local DC3 = Pet.GetArtRank(_PetIndex,%宠档_强成%);
				local MD3 = Pet.FullArtRank(_PetIndex,%宠档_强成%);
				local DC4 = Pet.GetArtRank(_PetIndex,%宠档_敏成%);
				local MD4 = Pet.FullArtRank(_PetIndex,%宠档_敏成%);
				local DC5 = Pet.GetArtRank(_PetIndex,%宠档_魔成%);
				local MD5 = Pet.FullArtRank(_PetIndex,%宠档_魔成%);
				local SDC1 = math.abs(DC1 - MD1);
				local SDC2 = math.abs(DC2 - MD2);
				local SDC3 = math.abs(DC3 - MD3);
				local SDC4 = math.abs(DC4 - MD4);
				local SDC5 = math.abs(DC5 - MD5);
				local DC8 = SDC1 + SDC2 + SDC3 + SDC4 + SDC5
				local DC6 = DC1 + DC2 + DC3 + DC4 + DC5
				local DC7 = MD1 + MD2 + MD3 + MD4 + MD5
				local msg = "";
				NLG.SystemMessage(player,"[洗档成功]掉档:"..SDC1..","..SDC2..","..SDC3..","..SDC4..","..SDC5..",总计:-"..DC8.."档");
				return 1;
			end
		else
			NLG.SystemMessage(player,"[万能洗档]洗档失败，宠物栏第一栏没有宠物");
			return 0;
		end
	end
	if(string.find(s,"wudangxidangjuan"))then--这个peth 是调用
		local _PetIndex = Char.GetPet(player,0);
		if _PetIndex >=0 then
			if Char.GetData(_PetIndex,%对象_等级%) > 1 then--只能洗等于1级宠物
				NLG.SystemMessage(player,"[万能洗档]宠物并非一级，无法洗档");
				return 0;
			else
				Pet.SetArtRank(_PetIndex,%宠档_体成%,Pet.FullArtRank(_PetIndex,%宠档_体成%)-math.random(0,1));
				Pet.SetArtRank(_PetIndex,%宠档_力成%,Pet.FullArtRank(_PetIndex,%宠档_力成%)-math.random(0,1));
				Pet.SetArtRank(_PetIndex,%宠档_强成%,Pet.FullArtRank(_PetIndex,%宠档_强成%)-math.random(0,1));
				Pet.SetArtRank(_PetIndex,%宠档_敏成%,Pet.FullArtRank(_PetIndex,%宠档_敏成%)-math.random(0,1));
				Pet.SetArtRank(_PetIndex,%宠档_魔成%,Pet.FullArtRank(_PetIndex,%宠档_魔成%)-math.random(0,1));
				Pet.UpPet(player,_PetIndex);
				Pet.ReBirth(player,_PetIndex);
				local DC1 = Pet.GetArtRank(_PetIndex,%宠档_体成%);
				local MD1 = Pet.FullArtRank(_PetIndex,%宠档_体成%);
				local DC2 = Pet.GetArtRank(_PetIndex,%宠档_力成%);
				local MD2 = Pet.FullArtRank(_PetIndex,%宠档_力成%);
				local DC3 = Pet.GetArtRank(_PetIndex,%宠档_强成%);
				local MD3 = Pet.FullArtRank(_PetIndex,%宠档_强成%);
				local DC4 = Pet.GetArtRank(_PetIndex,%宠档_敏成%);
				local MD4 = Pet.FullArtRank(_PetIndex,%宠档_敏成%);
				local DC5 = Pet.GetArtRank(_PetIndex,%宠档_魔成%);
				local MD5 = Pet.FullArtRank(_PetIndex,%宠档_魔成%);
				local SDC1 = math.abs(DC1 - MD1);
				local SDC2 = math.abs(DC2 - MD2);
				local SDC3 = math.abs(DC3 - MD3);
				local SDC4 = math.abs(DC4 - MD4);
				local SDC5 = math.abs(DC5 - MD5);
				local DC8 = SDC1 + SDC2 + SDC3 + SDC4 + SDC5
				local DC6 = DC1 + DC2 + DC3 + DC4 + DC5
				local DC7 = MD1 + MD2 + MD3 + MD4 + MD5
				local msg = "";
				NLG.SystemMessage(player,"[洗档成功]掉档:"..SDC1..","..SDC2..","..SDC3..","..SDC4..","..SDC5..",总计:-"..DC8.."档");
				return 1;
			end
		else
			NLG.SystemMessage(player,"[万能洗档]洗档失败，宠物栏第一栏没有宠物");
			return 0;
		end
	end

end




