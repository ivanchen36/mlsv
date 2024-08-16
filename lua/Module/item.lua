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
		NLG.SystemMessage(_meIndex,"����ʹ�ò�������");
		return;
	end
	local Fame = Char.GetData(_meIndex,%����_����%);
	Char.SetData(_meIndex,%����_����%,Fame + Item.GetData(_itemindex,%����_��������%));
	NLG.SystemMessage(_meIndex,"��������ֵ�����"..Item.GetData(_itemindex,%����_��������%).."��");
	Item.Kill(_meIndex,_itemindex,_itemslot);
end

function PetMetamo(_meIndex,_toIndex,_itemslot)
	local _itemindex = Char.GetItemIndex(_meIndex,_itemslot);
	if(CheckItem(_meIndex,_itemindex) == -1) then
		NLG.SystemMessage(_meIndex,"����ʹ�ò�������");
		return;
	end
	local PetIndex = Char.GetPet(_meIndex,0);
	if(PetIndex < 0) then
		NLG.SystemMessage(_meIndex,"��ȷ�����ĳ�������һ��λ�г���...");
		return;
	end

	--�ȼ�¼ԭ����
	if(Char.GetData(PetIndex,%����_�˺���%) == 0) then
		Char.SetData(PetIndex,%����_�˺���%,Char.GetData(PetIndex,%����_ԭ��%));
	end

	local image = Item.GetData(_itemindex,%����_��������%);
	if(image == 0) then	--�������͵���0������ﻹԭ��
		image = Char.GetData(PetIndex,%����_�˺���%);
		Char.SetData(PetIndex,%����_�˺���%,0);
	end

	Char.SetData(PetIndex,%����_ԭ��%,image);
	Pet.UpPet(_meIndex,PetIndex);
	Char.DelItem(_meIndex,Item.GetData(_itemindex,%����_��%),1);

	NLG.SystemMessage(_meIndex,"���������޸����,��򿪳�����������!...");
	return;
end

function item_Init()
	NL.RegItemString("lua/Module/item.lua","AddFame","LUA_useAddFame"); --ע������֮��
	NL.RegItemString("lua/Module/item.lua","PetMetamo","LUA_usePetMetamo"); --ע���������
end
