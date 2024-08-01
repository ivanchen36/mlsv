
---------------------------------------------------
Delegate.RegInit("wgfy_Init");

function initwgfyNpc_Init(index)
	print("vipnpc_index = " .. index);
	return 1;
end

function initwgfyNpc()
	if (wgfys == nil) then
		wgfys = NL.CreateNpc("lua/Module/wgfy.lua", "initwgfyNpc_Init");
		Char.SetData(wgfys,%对象_形象%,NPCwgfy[1]);
		Char.SetData(wgfys,%对象_原形%,NPCwgfy[1]);
		Char.SetData(wgfys,%对象_X%,NPCwgfy[3]);
		Char.SetData(wgfys,%对象_Y%,NPCwgfy[4]);
		Char.SetData(wgfys,%对象_地图%,NPCwgfy[2]);
		Char.SetData(wgfys,%对象_方向%,NPCwgfy[5]);
		Char.SetData(wgfys,%对象_原名%,"王宫封印师");
		NLG.UpChar(wgfys);
		Char.SetWindowTalkedEvent("lua/Module/wgfy.lua","wgfysA",wgfys);
		Char.SetTalkedEvent("lua/Module/wgfy.lua","wgfyMsg", wgfys);
	end
end

function wgfyMsg(_me,_tome)
	if (NLG.CanTalk(_me,_tome) == true) then
		str_ChangeWindow = "6|\\n\\n    王者封印师之争！\\n    谁先抓到置顶的极品宠物，谁就将获得奖励。\\n\\n    满档："..wgfy_gold[1].."卡    1档："..wgfy_gold[2].."卡    2档："..wgfy_gold[3].."卡\\n\\n               『登记对应魔物』\\n               『查看魔物目录』";
		NLG.ShowWindowTalked(_tome,_me,%窗口_选择框%,%按钮_关闭%,12,str_ChangeWindow);
		return;
	end
end

function wgfy_pet(id)
	local pet = Data.EnemyTempGetIndex(id);

	if(pet >= 0)then
		local xingxiang = Data.EnemyTempGetData(pet,29);
		return xingxiang;	
	else
		return 0;
	end
end


function wgfysA(_MeIndex,_PlayerIndex,_seqno,_select,_data)

	if(_select == 2)then
		return;
	end
	
	local _data = tonumber(_data)-1;

	
	---------------确认窗口--------------------
	if(_data == 0 and _seqno == 12)then
		str_ChangeWindow = "3|\\n\\n    您想登记哪只魔物呢？\\n\\n";

		for i=0,4 do
			local pet_indexA = Char.GetPet(_PlayerIndex,i);
			if(pet_indexA >= 0)then
				local a6 = dangci(pet_indexA)
				if(a6 <= 2 )then
					str_ChangeWindow = str_ChangeWindow.."        "..kongge(Char.GetData(pet_indexA,%对象_名字%),6).."  "..kong(a6,1).."档 (√)\\n";
				else
					str_ChangeWindow = str_ChangeWindow.."        "..kongge(Char.GetData(pet_indexA,%对象_名字%),6).."  "..kong(a6,1).."档 (×)\\n";
				end
			else
			
				str_ChangeWindow = str_ChangeWindow.."        无宠物\\n";

			end
		end
		
		NLG.ShowWindowTalked(_PlayerIndex,_MeIndex,%窗口_选择框%,%按钮_关闭%,13,str_ChangeWindow);
		return;
	end
	---------------确认窗口--------------------
	
	----------查询并弹出网页----------------
	
	if(_data == 1 and _seqno == 12)then
		web = "http://"..wgfy_http.."/wgfy.php";
		for i = 1,#wgfy_db do
		
			local x = wgfy_pet(wgfy_db[i]);
			if(x ~= 0)then
				local resset = SQL.Run("SELECT * FROM wgfy WHERE id = '"..wgfy_db[i].."'");
				if(type(resset)=="table")then
				
				else
					SQL.Run("INSERT INTO wgfy VALUES ('"..wgfy_db[i].."','','"..wgfy_pet(wgfy_db[i]).."','0','0','0')");
				end
			end

		end
		open_url(_PlayerIndex,web);
		return;
	end
	
	----------查询并弹出网页----------------
	

	----------交出对应宠物----------------
	if(_data >= 0 and _seqno == 13)then
		local pet_indexA = Char.GetPet(_PlayerIndex,_data);
		wgfy_off = 0;
		if(pet_indexA >= 0)then
			
			for i = 1,#wgfy_db do
		
				if(wgfy_pet(wgfy_db[i]) == Char.GetData(pet_indexA,%对象_原形%))then
					wgfy_off = 1;
					break;
				end
			end

			if(wgfy_off == 0)then
				NLG.SystemMessage(_PlayerIndex,"这个种类的魔物无法进行登记，请查看魔物目录找寻可登记的魔物！");
				return;
			end
			
			local a6 = dangci(pet_indexA)

			if(a6 <= 2)then

				local sql = "SELECT * FROM wgfy WHERE xingxiang = '"..Char.GetData(pet_indexA,%对象_原形%).."' and  dang"..a6.." = '1' ";
				local resset = SQL.Run(sql);
				
				if(type(resset)=="table")then
					NLG.SystemMessage(_PlayerIndex,""..a6.."档的『"..Char.GetData(pet_indexA,%对象_名字%).."』已经被登记了！");
				else
				
					if(Char.ItemSlot(_PlayerIndex)==20)then
						NLG.SystemMessage(_PlayerIndex,"您的背包满了，请清理后操作！");
						return;
					end
					
					if(Char.GetData(pet_indexA,%对象_等级%) ~= 1) then
						NLG.SystemMessage(_PlayerIndex,"不是1级宠物,无法提交。");
						return;
					end
					--NLG.SystemMessage(-1,""..a6.."档的『"..Char.GetData(pet_indexA,%对象_名字%).."』被玩家["..Char.GetData(_PlayerIndex,%对象_名字%).."]登记了，获得金卡奖励！");
					Char.GiveItem(_PlayerIndex,vipitemid,wgfy_gold[a6+1]);
					local sql = SQL.Run("UPDATE wgfy SET dang"..a6.." = '1' WHERE xingxiang = '"..Char.GetData(pet_indexA,%对象_原形%).."' ");
					NLG.SystemMessage(-1,""..a6.."档的『"..Char.GetData(pet_indexA,%对象_名字%).."』被玩家["..Char.GetData(_PlayerIndex,%对象_名字%).."]登记了，获得金卡奖励！");
				end
			else
				NLG.SystemMessage(_PlayerIndex,"这只魔物不满足登记标准，只有满档、一档、二档的魔物可以进行首次登记！");
			end
			return;
		else
			NLG.SystemMessage(_PlayerIndex,"该位置无魔物！");
			return;
		end
	end
	----------交出对应宠物----------------
	
	
end


function dangci(pet_indexA)
	local arr_rank1 = Pet.GetArtRank(pet_indexA,%宠档_体成%);
	local arr_rank11 = Pet.FullArtRank(pet_indexA,%宠档_体成%);
	local arr_rank2 = Pet.GetArtRank(pet_indexA,%宠档_力成%);
	local arr_rank21 = Pet.FullArtRank(pet_indexA,%宠档_力成%);
	local arr_rank3 = Pet.GetArtRank(pet_indexA,%宠档_强成%);
	local arr_rank31 = Pet.FullArtRank(pet_indexA,%宠档_强成%);
	local arr_rank4 = Pet.GetArtRank(pet_indexA,%宠档_敏成%);
	local arr_rank41 = Pet.FullArtRank(pet_indexA,%宠档_敏成%);
	local arr_rank5 = Pet.GetArtRank(pet_indexA,%宠档_魔成%);
	local arr_rank51 = Pet.FullArtRank(pet_indexA,%宠档_魔成%);
	local a1 = math.abs(arr_rank1 - arr_rank11);
	local a2 = math.abs(arr_rank2 - arr_rank21);
	local a3 = math.abs(arr_rank3 - arr_rank31);
	local a4 = math.abs(arr_rank4 - arr_rank41);
	local a5 = math.abs(arr_rank5 - arr_rank51);
	local a6 = a1 + a2+ a3+ a4+ a5;
	return a6;
end

---空格参数文字
function kongge(petnax,shu)

	local petnaxc = string.len(petnax)/2; 
	konggex = "";

	for i=petnaxc,shu do
		konggex = konggex.."　";
	end
	
	fanhui = petnax..""..konggex;
	return fanhui;
end
---空格参数数字
function kong(petnax,shu)

	local petnaxc = string.len(petnax); 
	konggex = "";

	for i=petnaxc,shu do
		konggex = konggex.." ";
	end
	
	fanhui = petnax..""..konggex;
	return fanhui;
end
function open_url(player,link)
	Protocol.SendLuaCustomPacket(player,"openurl", link);
end
function wgfy_Init()
	initwgfyNpc();
end