Delegate.RegInit("item_Init");

function CheckItem(player,itemindex)
	for i=8,27 do
		if(Char.GetItemIndex(player,i) == itemindex) then
			return i;
		end
	end
	return -1;
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
	NL.RegItemString("lua/Module/item.lua","AddFame","LUA_useAddFame"); --注册声望之花
	NL.RegItemString("lua/Module/item.lua","PetMetamo","LUA_usePetMetamo"); --注册宠物形象卡
end
