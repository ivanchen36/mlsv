battleSeqDB = {n=10001};
battleTimeDB = {n=10001};

for i=1,10001 do
	battleSeqDB[i] = "";
	battleTimeDB[i] = 0;
end


function fieldget(p,f)
	local ret = tonumber(Field.Get(p,f));
	if(ret==nil)then ret = 0; end
	return ret;
end

function fieldadd(p,f,n)
	local ret = tonumber(Field.Get(p,f));
	if(ret==nil)then ret=0; end
	ret = ret + n;
	Field.Set(p,f,ret);
	return;
end



function fielddel(p,f)
	fieldset(p,f,"");
end

function getIntPart(x)
if x <= 0 then
   return math.ceil(x);
end

if math.ceil(x) == x then
   x = math.ceil(x);
else
   x = math.ceil(x) - 1;
end
return x;
end

function trim (s)
   return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

function Split(szFullString, szSeparator)
local nFindStartIndex = 1
local nSplitIndex = 1
local nSplitArray = {}
while true do
   local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
   if not nFindLastIndex then
    nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
    break
   end
   nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
   nFindStartIndex = nFindLastIndex + string.len(szSeparator)
   nSplitIndex = nSplitIndex + 1
end
return nSplitArray
end


function check_msg(msg,check_msg)
	if(msg == nil) then
		return;
	end

   if(string.sub(msg,1,string.len(check_msg))==check_msg)then
		return true;
   end
   return false;
end

--%道具_堆叠数% 9
function giveitem(p,i,n)
	local item = Char.GiveItem(p,i);
	if(item>0)then
		Item.SetData(item, 9,n);
	end
	for i=8,27 do
		Item.UpItem(p,i);
	end
	return;
end

--%对象_等级% 8
--%对象_种族% 17
--%对象_名字% 2000
function isLevelOnePet(checkPet)
	if(checkPet==0)then
		return false;
	end
	if(Char.GetData(checkPet, 8)==1 and Char.GetData(checkPet, 17)~=9)then
		if((Char.GetData(checkPet, 2000)=="迷你蝙蝠") or (Char.GetData(checkPet, 2000)=="哥布林") or (Char.GetData(checkPet, 2000)=="盗贼") or (Char.GetData(checkPet, 2000)=="小石像怪"))then
			return false;
		end
		return true;
	end
	return false;
end

function Playerkey(player)
	if(player ~= nil) then
		local fanhui1 = Char.GetData(player, 2000)
		local fanhui2 = Char.GetData(player,48)
		
		if(fanhui1 == nil or fanhui2 == nil) then
			--print(player)
			--print(fanhui1)
			if(fanhui2 == nil) then
				fanhui2 = "bus"
			end
			
			--print("fanhui1"..fanhui1.."fanhui2"..fanhui2)
		end
		
		
		return fanhui1.."_"..fanhui2;
	else
		--print("无法计算")
		return 1;
	end
end

function useModule(file)
	gadofile("lua/Module/"..file..".lua");
end

function VERSION() 
	return NL.Ver();
end

function VaildChar(index)
	if(index == nil) then
		return false;
	end

	return index >= 0
end


function table.getn(_mytable)
   return #_mytable;
end

function math.mod(_num1,_num2)
	 --print("\n\n\n_num:".._num);
   return math.fmod(_num1,_num2);
end

--%对象_金币% 53
function Char.AddGold(_player,_gold)
	Char.SetData(_player, 53,Char.GetData(_player, 53)+_gold);
	NLG.UpChar(_player);
end

--%道具_ID% 0
function pequipitem(_player,_itemid)
	for k=0,7 do
		local _itemindex = Char.GetItemIndex(_player,k);
		if _itemindex ~= -1 and _itemindex ~= -2 and _itemindex ~= -3 then
			if (_itemid == Item.GetData(itemindex, 0))  then
				return true;
			end
		end
	end
 	return false;
end


--正整数转二进制字符串
function ZD2B(_num)
	local _str = "";
	local _left = _num;
	while true do
		if _left > 1 then
			_str = math.mod(_left,2).._str;
			_left = math.floor(_left / 2);
		else
			_str = _left.._str;
			break;
		end
	end
	return _str;
end

--十进制转换二进制
function IntToHex(_num)
	local _str = "";
	if _num == 0 then
		_str="0";
		return _str; 
	end
	--正数的情况
	if _num > 0 then
		_str = ZD2B(_num);
		return _str;
	end
	
	if _num < 0 then
		_str = ZD2B(0-_num);
		local _len = string.len(_str);
		local _nstr = "";
		--进行按位取反
		for i = 1,_len do
			if string.sub(_str,i,i) == "1" then
				_nstr = _nstr.."0";
			else
				_nstr = _nstr.."1";
			end
		end

		--补1
		if _len < 32 then
			for i=_len,31 do
				_nstr = "1".._nstr;
			end
		end

		--加1处理
		local _cf=1;--进位标志
		local _tmpn = 0;
		_str = "";
		for i=1,32 do
			_tmpn = tonumber(string.sub(_nstr,-i,-i))+_cf;
			if _tmpn == 2 then
				_str = "0".._str;
				_cf = 1;
			else
				_str = _tmpn.._str;
				_cf = 0;
			end
		end
		return _str;

	end	
end

--检测图鉴是否存在
function checkalbumid(_player,_aumid)
	if (_aumid <= 0) or (_aumid > 320) then
		return 0;
	end
	_aumid = _aumid-1;
	local _npos = _aumid / 32;
	local _lpos = math.mod(_aumid,32)+1;
	local _ndata = Char.GetData(_player,129+_npos);
	local _nstr = IntToHex(_ndata);
	if string.len(_nstr) < _lpos then
		return 0;
	else
		local _substr=string.sub(_nstr,-_lpos,-_lpos);
		if _substr == "1" then
			return 1;
		else
			return 0;
		end
	end
end

--检测玩家身上已登记图鉴数量
function checkalbumcount(_player)
	local _count = 0;
	for i=129,138 do
		local _ndata = Char.GetData(_player,i);
		
		local _nstr = IntToHex(_ndata);
		local _nl = string.len(_nstr);
		for i2=1,_nl do
			if string.sub(_nstr,i2,i2) == "1" then
				_count = _count + 1;
			end
		end
		
	end

	return _count;
end

--计算table的项目数量
function mygetn(_Mytbl)
	local count = 0
	for k,v in pairs(_Mytbl) do
		count = count + 1
	end
	return count;
end

--判断一个字符串是否是一个正整数
function CheckStrIsInt(_player,_data,_max)
	if _data == "" then
		return -1;
	end
	local _count = tonumber(_data);
	if (_count == nil)  then
		return -1;
	end	
	_count = math.floor(_count);
	
	if (_max ~= nil) and ((_count <= 0) or (_count > _max)) then
		return -1;
	end
	return _count;
end


function NPCInit(_MeIndex)
	return true;
end