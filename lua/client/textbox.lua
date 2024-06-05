
new = new or {};
convent = convent or {};
Convent = Convent or {};

function Convent.textbox(object,count)
	return convent.textbox(object,count);
end

function convent.textbox(object,count)
	if object.type == 3 then 
		local _textbox = {
			title 			= "";
			class			="textbox";
			mainview		= object.mainview;
			isautodel       = true;					-- 当对象生命周期被销毁时，是否自动销毁
			_address 		= 0;					-- 当值=0时，对象生命周期结束，可以使用 object.islive() 判断对象的生命周期
			_countid 		= object._countid;					-- 控件所在的位置，由view.addcontrol()函数的先后顺序决定
			_tagptr 		= 0;					-- 当值=0时，对象生命周期结束，可以使用 object.islive() 判断对象的生命周期
			_func 			= 0;
			_select1        = "";					-- 3个保留字段，用于自定义数据存储
			_select2        = "";
			_select3        = "";		
			ra2				= {};	
		};
					
		_textbox.islive = 
		function()			
				return true;
		end 	
			
		return setmetatable(_textbox, 
		{
		__index = textboxget,
		__newindex = textboxset,
		});
	end

end


function new.textbox(...)
		local args = {};
		local arg = {...};
		for i,v in ipairs(arg) do	table.insert(args,v);	end
		
		local ag_title 			= args[1] or "";		-- 控件名
		local ag_id    			= args[2] or 0;		-- 控件ID
		local ag_mainview 		= args[3] or 0;		-- 控件的父窗口
		local ag_virmainview 	= args[4] or 0;		-- 控件的虚拟父窗口
		--Msg("ag"..ag_title);
		
		local _textbox = {
			title 			= ag_title;
			class			="textbox";
			id 				= ag_id;
			mainviewid		= ag_mainview;
			mainview		= {};
			virmainview		= ag_virmainview;
			event			= {}; 
			autocallback2	= {};
			callbackfunc	= {};
			isautodel       = true;					-- 当对象生命周期被销毁时，是否自动销毁
			_address 		= 0;					-- 当值=0时，对象生命周期结束，可以使用 object.islive() 判断对象的生命周期
			_countid 		= 0;					-- 控件所在的位置，由view.addcontrol()函数的先后顺序决定
			_tagptr 		= 0;					-- 当值=0时，对象生命周期结束，可以使用 object.islive() 判断对象的生命周期
			_func 			= 0;
			_select1        = nil;					-- 3个保留字段，用于自定义数据存储
			_select2        = nil;
			_select3        = nil;		
			ra2				= {};	
		};
		--sysmsg(tostring("1"),4,3);  	
		local MiagAddress = calloc(1,8);
		--sysmsg(tostring(MiagAddress),4,3);  
		if MiagAddress == -1 then
			return -1;
		end
		_textbox._tagptr = MiagAddress;
		local textAddress = calloc(1,255);
		setMember(MiagAddress + 4,textAddress);
		-- 判断对象生命周期是否结束
		_textbox.islive = function()
			if _textbox.mainview._address ~= 0 or _textbox._tagptr ~=0 then
				return true;
			end
			return false;
		end 

		_textbox.callbackfunc = function(object,oevent)
			if type(_textbox.event) == "function" then 
				_textbox.event(object,oevent)
			end
		end
		

		_textbox.free = function()
			return;
		end

			
		return setmetatable(_textbox, 
		{
		__index = textboxget,
		__newindex = textboxset,
		});
	
end

function textboxget(Mtable,key)
			if Mtable.islive() == false then
					return -1;
			end
			local t_countid = (Mtable._countid - 1) * 36;
			local t_address = Mtable.mainview._address;
			if key == "type" then
				return tonumber(getMember(t_address + t_countid));
			end
			if key == "vunk1" then
				return tonumber(getMember(t_address + t_countid + 4));
			end	
			if key == "xpos" then
				return tonumber(getMember(t_address + t_countid + 8));
			end
			if key == "ypos" then
				return tonumber(getMember(t_address + t_countid + 12));
			end
			if key == "sizex" then
				return tonumber(getMember(t_address + t_countid + 16));
			end	
			if key == "sizey" then
				return tonumber(getMember(t_address + t_countid + 20));
			end			
			if key == "enable" then
				return tonumber(getMember(t_address + t_countid + 24));
			end	
			if key == "objectptr" then
				return tonumber(getMember(t_address + t_countid + 28));
			end	
			if key == "func" then
				return tonumber(getMember(t_address + t_countid + 32));
			end		
			if key == "color" then
				local tMiagAddress = getMember(t_address + t_countid + 28);
				return getMemberChar(tMiagAddress ,value);
			end				

			if key == "fontsize" then
				local tMiagAddress = getMember(t_address + t_countid + 28);
				return getMemberChar(tMiagAddress + 1,value);
			end	

			if key == "text" then
				local tMiagAddress = getMember(t_address + t_countid + 28);
				return getMemberString(getMember(tMiagAddress + 4),value);
			end	
			return Mtable['ra2'][key]
end

function textboxset(Mtable,key,value)
			if Mtable.islive() == false then
					return -1;
			end	
			local t_countid = (Mtable._countid - 1) * 36;
			local t_address = Mtable.mainview._address;
			if key == "type" then
				setMember(t_address + t_countid,value);
			end
			if key == "vunk1" then
				setMember(t_address + t_countid + 4,value);
			end			
			if key == "xpos" then
				setMember(t_address + t_countid + 8,value);
			end
			if key == "ypos" then
				setMember(t_address + t_countid + 12,value);
			end
			if key == "sizex" then
				setMember(t_address + t_countid + 16,value);
			end	
			if key == "sizey" then
				setMember(t_address + t_countid + 20,value);
			end			
			if key == "enable" then
				if value == 1 then
					Mtable.type = 3;
					Mtable.objectptr = Mtable._tagptr;
					Mtable.func = get_allcallback();
					
				end
				setMember(t_address + t_countid + 24,value);
			end	
			if key == "objectptr" then
				setMember(t_address + t_countid + 28,value);
			end	
			if key == "func" then
				setMember(t_address + t_countid + 32,value);
			end	
			if key == "color" then
				local tMiagAddress = getMember(t_address + t_countid + 28);
				setMemberChar(tMiagAddress ,value);
			end	
			if key == "fontsize" then
				local tMiagAddress = getMember(t_address + t_countid + 28);
				setMemberChar(tMiagAddress + 1,value);
			end	

			if key == "text" then
				local tMiagAddress = getMember(t_address + t_countid + 28);
				setMemberString2(getMember(tMiagAddress + 4),value);
			end
			Mtable['ra2'][key] = value	
		
end