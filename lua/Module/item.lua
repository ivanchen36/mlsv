Delegate.RegInit("item_Init");
Delegate.RegDelLoginEvent("item_LoginEvent");
Delegate.RegDelLogoutEvent("item_LogoutEvent");
Delegate.RegDelLoginGateEvent("item_LoginGateEvent");

JpackTable = {10000,10001,10002,10003,10004,10005,10006,10007,10008,10009,12800,12801,12802,12803,12804,12805,12806,12807,12808,12809,12006,12102,12400,11219,12401,12402,12403,12404,11200,11201,11203,12100,12101,12407,12408,12409,12000,12002,12003,11601,11600,12001,12005,11205,11311,11306,11309,12410,12411,12412,12406,12406,11202,11226,12416,12417,12418,12419,12405,15201,15202,15203,15204,15205,15205,15205,15208,15209,15209,15211,15212,15213,15214,15215,15216,15217,15218,15219,15606,15607,15608,15609,15610,15611,15612,15613,15614,15615,9600,9601,9602,9603,9604,9605,9606,9607,9608,9609,9611,9612,9613,9614,9615,9616,9617,9618,9619,9620};

function GetItemNum(_player,_ItemId)
	local Count = 0;
	for i = 0,27 do
		local ItemIndex = Char.GetItemIndex(_player,i);
		if(ItemIndex >= 0) then
			if(Item.GetData(ItemIndex,%道具_ID%) == _ItemId) then
				Count = Count + Item.GetData(ItemIndex,%道具_堆叠数%);
			end
		end
	end
	return Count;
end

function item_LoginEvent(player)
	Char.SetWalkPostEvent("lua/Module/item.lua","PostWalkEvent",player);
end
function item_LoginGateEvent(player)
	if(tbl_bx[Playerkey(player)] ~= nil) then
		tbl_bx[Playerkey(player)] = nil;
		Char.SetData(player,%对象_香步数%,0);
		Char.SetData(player,%对象_香上限%,0);
		NLG.SystemMessage(player,"检测到您已登回城内记录点,诱魔香状态我们已为您暂停...如要继续,请重新使用..");
	end
end
function item_LogoutEvent(player)
	if(tbl_bx[Playerkey(player)] ~= nil) then
		tbl_bx[Playerkey(player)] = nil;
	end
end	
function CheckItem(player,itemindex)
	for i=8,27 do
		if(Char.GetItemIndex(player,i) == itemindex) then
			return i;
		end
	end
	return -1;
end

function PostWalkEvent(player)



	JMXFootLoop(player);
	
	
	
	
	if(tbl_bx[Playerkey(player)] ~= nil) then
		local ItemSlot = CheckItem(player,tbl_bx[Playerkey(player)]);
		if(ItemSlot == -1) then
			Item.SetData(tbl_bx[Playerkey(player)],%道具_耐久%,Item.GetData(tbl_bx[Playerkey(player)],%道具_耐久%) -1);
			tbl_bx[Playerkey(player)] = nil;
			Char.SetData(player,%对象_香步数%,0);
			Char.SetData(player,%对象_香上限%,0);
			NLG.SystemMessage(player,"诱魔香已经烧完了...");
		else
			local Rem = Item.GetData(tbl_bx[Playerkey(player)],%道具_耐久%);
			if(Rem - 1 <= 0) then
				Item.Kill(player,tbl_bx[Playerkey(player)],ItemSlot);
				tbl_bx[Playerkey(player)] = nil;
				Char.SetData(player,%对象_香步数%,0);
				Char.SetData(player,%对象_香上限%,0);
				NLG.SystemMessage(player,"诱魔香已经烧完了...");
			else
				Item.SetData(tbl_bx[Playerkey(player)],%道具_耐久%,Rem -1);
				Item.UpItem(player,ItemSlot);
			end
		end
	end
end

function InTohelos(_meIndex,_toIndex,_itemslot)
	local _itemindex = Char.GetItemIndex(_meIndex,_itemslot);
	if(CheckItem(_meIndex,_itemindex) == -1) then
		NLG.SystemMessage(_meIndex,"道具使用参数错误");
		return;
	end
	if(Item.GetData(_itemindex,%道具_耐久%) <= 0) then
		Item.Kill(_meIndex,_itemindex,_itemslot);
		NLG.SystemMessage(_meIndex,"诱魔香已经烧完了...");
		return;
	end
	if(tbl_bx[Playerkey(_meIndex)] == nil) then
		tbl_bx[Playerkey(_meIndex)] = _itemindex;
		Char.SetData(_meIndex,%对象_香步数%,Item.GetData(_itemindex,%道具_耐久%));
		Char.SetData(_meIndex,%对象_香上限%,99);
		NLG.SystemMessage(_meIndex,"诱魔香已经生效了..您在随后的"..Item.GetData(_itemindex,%道具_耐久%).."步内将会步步遇敌!");
	else
		tbl_bx[Playerkey(_meIndex)] = nil;
		Char.SetData(_meIndex,%对象_香步数%,0);
		Char.SetData(_meIndex,%对象_香上限%,0);
		NLG.SystemMessage(_meIndex,"诱魔香已经暂停了..");
	end
end

function AddFame(_meIndex,_toIndex,_itemslot)
	local _itemindex = Char.GetItemIndex(_meIndex,_itemslot);
	if(CheckItem(_meIndex,_itemindex) == -1) then
		NLG.SystemMessage(_meIndex,"道具使用参数错误");
		return;
	end
	local Fame = Char.GetData(_meIndex,%对象_声望%);
	Char.SetData(_meIndex,%对象_声望%,Fame + Item.GetData(_itemindex,%道具_特殊类型%));
	NLG.SystemMessage(_meIndex,"您的声望值提高了"..Item.GetData(_itemindex,%道具_特殊类型%).."点");
	Item.Kill(_meIndex,_itemindex,_itemslot);
end

function Pack(_meIndex,_toIndex,_itemslot)
	local _itemindex = Char.GetItemIndex(_meIndex,_itemslot);
	if(CheckItem(_meIndex,_itemindex) == -1) then
		NLG.SystemMessage(_meIndex,"道具使用参数错误");
		return;
	end
	if(Char.ItemSlot(_meIndex) >= 20) then
		NLG.SystemMessage(_meIndex,"请至少留出一个空的道具栏栏位...");
		return;
	end
	for i = 8,27 do
		local JpItem = Char.GetItemIndex(_meIndex,i);
		if(JpItem >= 0) then
			local ItemId = Item.GetData(JpItem,%道具_ID%);
			if(IsInTable(ItemId,JpackTable) ~= -1) then
				local MaxRemain = Item.GetData(JpItem,%道具_最大堆叠数%);
				local ItemName = Item.GetData(JpItem,2001);
				local YunRemain = MaxRemain * 10;
				if(GetItemNum(_meIndex,ItemId) >= YunRemain) then
					Char.DelItem(_meIndex,Item.GetData(_itemindex,%道具_ID%),1);
					local _RetItem = Char.GiveItem(_meIndex,500218,1);
					if(_RetItem < 0) then
						NLG.SystemMessage(_meIndex,"万能打包器发生错误,请将此错误提示截图发与客服,以便我们修复此Bug!");
						return;
					end
					Char.DelItem(_meIndex,ItemId,YunRemain);
					Item.SetData(_RetItem,2001,"『"..ItemName.."』×"..YunRemain.."");
					Item.SetData(_RetItem,2003,""..ItemId..","..YunRemain.."");
					Item.SetData(_RetItem,%道具_最大堆叠数%,1);
					Item.SetData(_RetItem,%道具_堆叠数%,1);
					Item.UpItem(_meIndex,-1);
					NLG.SystemMessage(_meIndex,"成功打包了"..YunRemain.." 件 "..ItemName.."");
					return;
				end
			end

		end
	end
	NLG.SystemMessage(_meIndex,"好像没有什么可以被打包的道具...需要身上有10组以上相同道具才可以被打包噢!");
	return;
end

function UnPack(_meIndex,_toIndex,_itemslot)
	local _itemindex = Char.GetItemIndex(_meIndex,_itemslot);
	if(CheckItem(_meIndex,_itemindex) == -1) then
		NLG.SystemMessage(_meIndex,"道具使用参数错误");
		return;
	end
	if(Char.ItemSlot(_meIndex) >= 10) then
		NLG.SystemMessage(_meIndex,"请至少留出十个空的道具栏栏位...");
		return;
	end
	local _itemindex = Char.GetItemIndex(_meIndex,_itemslot);
	local ItemPar = Item.GetData(_itemindex,2003);
	local data = Split(ItemPar,",");
	local ItemId = data[1];
	local ItemNum = data[2];
	Item.Kill(_meIndex, _itemindex,_itemslot);
	Char.GiveItem(_meIndex,ItemId,ItemNum);
	NLG.SystemMessage(_meIndex,"被打包的道具已经全部取出了...");
	return;
end

function PetReBirth(_meIndex,_toIndex,_itemslot)
	local _itemindex = Char.GetItemIndex(_meIndex,_itemslot);
	if(CheckItem(_meIndex,_itemindex) == -1) then
		NLG.SystemMessage(_meIndex,"道具使用参数错误");
		return;
	end
	local PetIndex = Char.GetPet(_meIndex,0);
	if(PetIndex < 0) then
		NLG.SystemMessage(_meIndex,"请确认您的宠物栏第一栏位有宠物...");
		return;
	end

	if(Char.GetData(PetIndex,%对象_脸%) ~= 1) then
		NLG.SystemMessage(_meIndex,"无法为野生宠物提供洗档服务...");
		return;
	end
	local PetExp = Char.GetData(PetIndex,%对象_经验%);
	
	Char.DelItem(_meIndex,Item.GetData(_itemindex,%道具_序%),1);
	Pet.ReBirth(_meIndex, PetIndex);
	Char.SetData(PetIndex,%对象_经验%,PetExp);
	Pet.UpPet(_meIndex, PetIndex);
	NLG.SystemMessage(_meIndex,"宠物洗点完成,快打开宠物栏看看吧!...");
	return;
end

function PetMetamo(_meIndex,_toIndex,_itemslot)
	local _itemindex = Char.GetItemIndex(_meIndex,_itemslot);
	if(CheckItem(_meIndex,_itemindex) == -1) then
		NLG.SystemMessage(_meIndex,"道具使用参数错误");
		return;
	end
	local PetIndex = Char.GetPet(_meIndex,0);
	if(PetIndex < 0) then
		NLG.SystemMessage(_meIndex,"请确认您的宠物栏第一栏位有宠物...");
		return;
	end

	--先记录原形象
	if(Char.GetData(PetIndex,%对象_伤害数%) == 0) then
		Char.SetData(PetIndex,%对象_伤害数%,Char.GetData(PetIndex,%对象_原形%));
	end

	local image = Item.GetData(_itemindex,%道具_特殊类型%);
	if(image == 0) then	--特殊类型等于0代表宠物还原卡
		image = Char.GetData(PetIndex,%对象_伤害数%);
		Char.SetData(PetIndex,%对象_伤害数%,0);
	end

	Char.SetData(PetIndex,%对象_原形%,image);
	Pet.UpPet(_meIndex,PetIndex);
	Char.DelItem(_meIndex,Item.GetData(_itemindex,%道具_序%),1);

	NLG.SystemMessage(_meIndex,"宠物形象修改完成,快打开宠物栏看看吧!...");
	return;
end

function item_Init()
	NL.RegItemString("lua/Module/item.lua","InTohelos","LUA_useInTohelos"); --注册诱魔香
	NL.RegItemString("lua/Module/item.lua","AddFame","LUA_useAddFame"); --注册声望之花
	NL.RegItemString("lua/Module/item.lua","Pack","LUA_usePack"); --注册万能打包器
	NL.RegItemString("lua/Module/item.lua","UnPack","LUA_useUnPack"); --注册万能解包器
	NL.RegItemString("lua/Module/item.lua","PetReBirth","LUA_usePetReBirth"); --注册宠物洗点药水
	NL.RegItemString("lua/Module/item.lua","PetMetamo","LUA_usePetMetamo"); --注册宠物形象卡
end
