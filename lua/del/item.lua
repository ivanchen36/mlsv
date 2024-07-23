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
			if(Item.GetData(ItemIndex,%����_ID%) == _ItemId) then
				Count = Count + Item.GetData(ItemIndex,%����_�ѵ���%);
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
		Char.SetData(player,%����_�㲽��%,0);
		Char.SetData(player,%����_������%,0);
		NLG.SystemMessage(player,"��⵽���ѵǻس��ڼ�¼��,��ħ��״̬������Ϊ����ͣ...��Ҫ����,������ʹ��..");
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
			Item.SetData(tbl_bx[Playerkey(player)],%����_�;�%,Item.GetData(tbl_bx[Playerkey(player)],%����_�;�%) -1);
			tbl_bx[Playerkey(player)] = nil;
			Char.SetData(player,%����_�㲽��%,0);
			Char.SetData(player,%����_������%,0);
			NLG.SystemMessage(player,"��ħ���Ѿ�������...");
		else
			local Rem = Item.GetData(tbl_bx[Playerkey(player)],%����_�;�%);
			if(Rem - 1 <= 0) then
				Item.Kill(player,tbl_bx[Playerkey(player)],ItemSlot);
				tbl_bx[Playerkey(player)] = nil;
				Char.SetData(player,%����_�㲽��%,0);
				Char.SetData(player,%����_������%,0);
				NLG.SystemMessage(player,"��ħ���Ѿ�������...");
			else
				Item.SetData(tbl_bx[Playerkey(player)],%����_�;�%,Rem -1);
				Item.UpItem(player,ItemSlot);
			end
		end
	end
end

function InTohelos(_meIndex,_toIndex,_itemslot)
	local _itemindex = Char.GetItemIndex(_meIndex,_itemslot);
	if(CheckItem(_meIndex,_itemindex) == -1) then
		NLG.SystemMessage(_meIndex,"����ʹ�ò�������");
		return;
	end
	if(Item.GetData(_itemindex,%����_�;�%) <= 0) then
		Item.Kill(_meIndex,_itemindex,_itemslot);
		NLG.SystemMessage(_meIndex,"��ħ���Ѿ�������...");
		return;
	end
	if(tbl_bx[Playerkey(_meIndex)] == nil) then
		tbl_bx[Playerkey(_meIndex)] = _itemindex;
		Char.SetData(_meIndex,%����_�㲽��%,Item.GetData(_itemindex,%����_�;�%));
		Char.SetData(_meIndex,%����_������%,99);
		NLG.SystemMessage(_meIndex,"��ħ���Ѿ���Ч��..��������"..Item.GetData(_itemindex,%����_�;�%).."���ڽ��Ჽ������!");
	else
		tbl_bx[Playerkey(_meIndex)] = nil;
		Char.SetData(_meIndex,%����_�㲽��%,0);
		Char.SetData(_meIndex,%����_������%,0);
		NLG.SystemMessage(_meIndex,"��ħ���Ѿ���ͣ��..");
	end
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

function Pack(_meIndex,_toIndex,_itemslot)
	local _itemindex = Char.GetItemIndex(_meIndex,_itemslot);
	if(CheckItem(_meIndex,_itemindex) == -1) then
		NLG.SystemMessage(_meIndex,"����ʹ�ò�������");
		return;
	end
	if(Char.ItemSlot(_meIndex) >= 20) then
		NLG.SystemMessage(_meIndex,"����������һ���յĵ�������λ...");
		return;
	end
	for i = 8,27 do
		local JpItem = Char.GetItemIndex(_meIndex,i);
		if(JpItem >= 0) then
			local ItemId = Item.GetData(JpItem,%����_ID%);
			if(IsInTable(ItemId,JpackTable) ~= -1) then
				local MaxRemain = Item.GetData(JpItem,%����_���ѵ���%);
				local ItemName = Item.GetData(JpItem,2001);
				local YunRemain = MaxRemain * 10;
				if(GetItemNum(_meIndex,ItemId) >= YunRemain) then
					Char.DelItem(_meIndex,Item.GetData(_itemindex,%����_ID%),1);
					local _RetItem = Char.GiveItem(_meIndex,500218,1);
					if(_RetItem < 0) then
						NLG.SystemMessage(_meIndex,"���ܴ������������,�뽫�˴�����ʾ��ͼ����ͷ�,�Ա������޸���Bug!");
						return;
					end
					Char.DelItem(_meIndex,ItemId,YunRemain);
					Item.SetData(_RetItem,2001,"��"..ItemName.."����"..YunRemain.."");
					Item.SetData(_RetItem,2003,""..ItemId..","..YunRemain.."");
					Item.SetData(_RetItem,%����_���ѵ���%,1);
					Item.SetData(_RetItem,%����_�ѵ���%,1);
					Item.UpItem(_meIndex,-1);
					NLG.SystemMessage(_meIndex,"�ɹ������"..YunRemain.." �� "..ItemName.."");
					return;
				end
			end

		end
	end
	NLG.SystemMessage(_meIndex,"����û��ʲô���Ա�����ĵ���...��Ҫ������10��������ͬ���߲ſ��Ա������!");
	return;
end

function UnPack(_meIndex,_toIndex,_itemslot)
	local _itemindex = Char.GetItemIndex(_meIndex,_itemslot);
	if(CheckItem(_meIndex,_itemindex) == -1) then
		NLG.SystemMessage(_meIndex,"����ʹ�ò�������");
		return;
	end
	if(Char.ItemSlot(_meIndex) >= 10) then
		NLG.SystemMessage(_meIndex,"����������ʮ���յĵ�������λ...");
		return;
	end
	local _itemindex = Char.GetItemIndex(_meIndex,_itemslot);
	local ItemPar = Item.GetData(_itemindex,2003);
	local data = Split(ItemPar,",");
	local ItemId = data[1];
	local ItemNum = data[2];
	Item.Kill(_meIndex, _itemindex,_itemslot);
	Char.GiveItem(_meIndex,ItemId,ItemNum);
	NLG.SystemMessage(_meIndex,"������ĵ����Ѿ�ȫ��ȡ����...");
	return;
end

function PetReBirth(_meIndex,_toIndex,_itemslot)
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

	if(Char.GetData(PetIndex,%����_��%) ~= 1) then
		NLG.SystemMessage(_meIndex,"�޷�ΪҰ�������ṩϴ������...");
		return;
	end
	local PetExp = Char.GetData(PetIndex,%����_����%);
	
	Char.DelItem(_meIndex,Item.GetData(_itemindex,%����_��%),1);
	Pet.ReBirth(_meIndex, PetIndex);
	Char.SetData(PetIndex,%����_����%,PetExp);
	Pet.UpPet(_meIndex, PetIndex);
	NLG.SystemMessage(_meIndex,"����ϴ�����,��򿪳�����������!...");
	return;
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
	NL.RegItemString("lua/Module/item.lua","InTohelos","LUA_useInTohelos"); --ע����ħ��
	NL.RegItemString("lua/Module/item.lua","AddFame","LUA_useAddFame"); --ע������֮��
	NL.RegItemString("lua/Module/item.lua","Pack","LUA_usePack"); --ע�����ܴ����
	NL.RegItemString("lua/Module/item.lua","UnPack","LUA_useUnPack"); --ע�����ܽ����
	NL.RegItemString("lua/Module/item.lua","PetReBirth","LUA_usePetReBirth"); --ע�����ϴ��ҩˮ
	NL.RegItemString("lua/Module/item.lua","PetMetamo","LUA_usePetMetamo"); --ע���������
end
