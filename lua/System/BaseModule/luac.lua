tbl_daily = {};

scriptEvent = {}

--%����_����;�% 13
--%����_�;�% 65
function itemreb(npc, player, s)
	local this_item = Char.GetItemIndex(player,8);
	local nj = Item.GetData(this_item, 13);
	Item.SetData(this_item, 65,nj);
	Item.UpItem(player, 8);
end

function setdy(npc, player, s)
	local sv = string.gsub(s, "setdy", "");
	local playerkeyname = Playerkey(player)..sv;
	tbl_daily[playerkeyname] = tonumber(os.date("%d",os.time()));
	return 1;
end

function setskilllv(npc, player, s)
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

function getflg(npc, player, s)
	local get = NLG.GetString(s,"getflg",0);
	local ret = EventExpandCheckFlgCall(player,get);
	return ret;
end

function setflg(npc, player, s)
	local get = NLG.GetString(s, "setflg", 0);
	local ret = EventExpandSetFlgCall(player, get);
	return ret;
end

function delflg(npc, player, s)
	local get = NLG.GetString(s, "delflg", 0); -- Assuming this should be "delflg" if referring to a delete flag action
	local ret = EventExpandClsFlgCall(player, get);
	return ret;
end


function likeme(npc, player, s)
	local player = MyPlayer:new(player)
	local player1 = MyPlayer:new(npc)
	player:changeImage(player1:getImage());
end

function petme(npc, player, s)
	local pet = MyPet:new(player, 0)
	local player1 = MyPlayer:new(npc)
	pet:changeImage(player1:getImage());
end

function peth(npc, player, s)
	local pet = MyPet:new(player, 0)
	return pet:reinitDang(math.random(0,4), math.random(0,4), math.random(0,4), math.random(0,4), math.random(0,4))
end

function mandang(npc, player, s)
	local pet = MyPet:new(player, 0)
	return pet:reinitDang(0, 0, 0, 0, 0)
end

function shidangxidangjuan(npc, player, s)
	local pet = MyPet:new(player, 0)
	return pet:reinitDang(math.random(0,2), math.random(0,2), math.random(0,2), math.random(0,2), math.random(0,2))
end

function wudangxidangjuan(npc, player, s)
	local pet = MyPet:new(player, 0)
	return pet:reinitDang(math.random(0,1), math.random(0,1), math.random(0,1), math.random(0,1), math.random(0,1))
end

scriptEvent["itemreb"] = itemreb
scriptEvent["setdy"] = setdy
scriptEvent["setskilllv"] = setskilllv
scriptEvent["getflg"] = getflg;
scriptEvent["setflg"] = setflg
scriptEvent["delflg"] = delflg;
scriptEvent["likeme"] = likeme;
scriptEvent["petme"] = petme;
scriptEvent["setmj"] = setmj;
scriptEvent["peth"] = peth;
scriptEvent["mandang"] = mandang;
scriptEvent["shidangxidangjuan"] = shidangxidangjuan;
scriptEvent["wudangxidangjuan"] = wudangxidangjuan;

function ScriptCall(npc, player, s)
	if rawget(scriptEvent, s) ~= nil then
		return scriptEvent[s](npc, player, s)
	end
	if(string.find(s,"setdy"))then
        return setdy(npc, player, s)
    end
	if(string.find(s,"setskilllv"))then
		return setskilllv(npc, player, s)
	end
	if(string.find(s,"getflg"))then
		return getflg(npc, player, s)
	end
	if(string.find(s,"setflg"))then
		return setflg(npc, player, s)
	end
	if(string.find(s,"delflg"))then
		return delflg(npc, player, s)
	end

	return 0;
end
