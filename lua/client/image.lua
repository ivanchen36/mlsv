
new = new or {};
convent = convent or {};
Convent = Convent or {};

function Convent.image(object,count)
	return convent.image(object,count);
end

function convent.image(object,count)
	--Msg(object.type)
	--sysmsg(tostring(object.mainview.vid),4,3);
	if object.type == 1 then 
		local _image = {
			title 			= "";
			class			="image";
			mainview		= object.mainview;
			isautodel       = true;					-- 当对象生命周期被销毁时，是否自动销毁
			_address 		= 0;					-- 当值=0时，对象生命周期结束，可以使用 object.islive() 判断对象的生命周期
			_countid 		= object._countid;					-- 控件所在的位置，由view.addcontrol()函数的先后顺序决定
			_tagptr 		= 0;					-- 当值=0时，对象生命周期结束，可以使用 object.islive() 判断对象的生命周期
			_func 			= 0;
			_select1        = "";					-- 3个保留字段，用于自定义数据存储
			_select2        = "";
			_select3        = "";	
			item_xpos		= 0;
			item_ypos		= 0;		
			issetimage 		= 0;
			ra2				= {};
		};
		
	
					
		_image.islive = 
		function()			
				return true;
		end 	
		
		
			
		return setmetatable(_image, 
		{
		__index = imageget,
		__newindex = imageset,
		});
	end
end

function new.image(...)
		local args = {};
		local arg = {...};
		for i,v in ipairs(arg) do	table.insert(args,v);	end
		
		local ag_title 			= args[1] or "";		-- 控件名
		local ag_id    			= args[2] or 0;		-- 控件ID
		local ag_mainview 		= args[3] or 0;		-- 控件的父窗口
		local ag_virmainview 	= args[4] or 0;		-- 控件的虚拟父窗口
		--Msg("ag"..ag_title);
		
		local _image = {
			title 			= ag_title;
			class			="image";
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
			_select1        = "";					-- 3个保留字段，用于自定义数据存储
			_select2        = "";
			_select3        = "";
			item_xpos		= 0;
			item_ypos		= 0;	
			ra2				= {};		
		};
			
		local MiagAddress = calloc(1,24);
		if MiagAddress == -1 then
			return -1;
		end
		_image._tagptr = MiagAddress;
		
		
		_image.callbackfunc = function(object,oevent)
			if type(_image.event) == "function" then 
				_image.event(object,oevent)
			end
		end
		
		
		-- 判断对象生命周期是否结束
		_image.islive = function()
			if _image.mainview._address ~= 0 or _image._tagptr ~=0 then
				return true;
			end
			return false;
		end 



		_image.free = function()
			return;
		end

			
		return setmetatable(_image, 
		{
		__index = imageget,
		__newindex = imageset,
		});
	
end

function imageget(Mtable,key)
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
			if key == "imageID" then
				local tMiagAddress = getMember(t_address + t_countid + 28);
				return tonumber(getMember(tMiagAddress));
			end	
			if key == "_unk1" then
				local tMiagAddress = getMember(t_address + t_countid + 28);
				return tonumber(getMember(tMiagAddress + 4));
			end	
			if key == "_unk2" then
				local tMiagAddress = getMember(t_address + t_countid + 28);
				return tonumber(getMember(tMiagAddress + 8));
			end	
			if key == "_unk3" then
				local tMiagAddress = getMember(t_address + t_countid + 28);
				return tonumber(getMember(tMiagAddress + 12));
			end
			if key == "_unk4" then
				local tMiagAddress = getMember(t_address + t_countid + 28);
				return tonumber(getMember(tMiagAddress + 16));
			end
			if key == "backgroundcolor" then
				local tMiagAddress = getMember(t_address + t_countid + 28);
				return tonumber(getMember(tMiagAddress + 20));
			end	
			return Mtable['ra2'][key]				
end

function imageset(Mtable,key,value)
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
				if Mtable['ra2']['realXY'] ~= nil and  Mtable['ra2']['realXY'] == true then
					
					value = value + Mtable.item_xpos + math.floor(Mtable.sizex / 2);
					--Msg(Mtable.title .. tostring(value))
					setMember(t_address + t_countid + 8,math.floor(value));
					
				else
					value = value + Mtable.item_xpos;
					setMember(t_address + t_countid + 8,value);
				end
			end
			if key == "ypos" then
				if Mtable['ra2']['realXY'] ~= nil and  Mtable['ra2']['realXY'] == true then
					value = value + Mtable.item_ypos + math.floor(Mtable.sizey / 2);
					--Msg(Mtable.title ..tostring(value))
					setMember(t_address + t_countid + 12,math.floor(value));
					
				else
					value = value + Mtable.item_ypos;
					setMember(t_address + t_countid + 12,value);
				end
			end
			
			
			if key == "xpos2" then
				value = value + Mtable.item_xpos + (Mtable.sizex / 2);
				setMember(t_address + t_countid + 8,value);
			end
			if key == "ypos2" then
				value = value + Mtable.item_ypos + (Mtable.sizey / 2);
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
					Mtable.type = 1;
					Mtable.objectptr = Mtable._tagptr;
					Mtable.backgroundcolor = -1;
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
			if key == "imageID" then
				local tMiagAddress = getMember(t_address + t_countid + 28);
				setMember(tMiagAddress,value);
				
				--if Mtable.issetimage == 0 then
				
					local nom = realGetNo(value);
					local px,py = realGetPos(nom);
					local sx,sy = realGetSize(nom);
					--local sx,sy = realGetSize(nom);
					--if sx ~= nil and sx > 0 then
					--	setMember(t_address + t_countid + 16,sx);
					--end
					--if sy ~= nil and sy > 0 then
					--	setMember(t_address + t_countid + 20,sy);
					--end			
					Mtable.sizex = sx;
					Mtable.sizey = sy;
					Mtable.item_xpos = px;
					Mtable.item_ypos = py;
					Mtable.issetimage = 1;
				--end
			
			end	
			
			if key == "imageID2" then	
				local tMiagAddress = getMember(t_address + t_countid + 28);
				setMember(tMiagAddress,value);
				
			end
			
			if key == "_unk1" then
				local tMiagAddress = getMember(t_address + t_countid + 28);
				setMember(tMiagAddress + 4,value);
			end	
			if key == "_unk2" then
				local tMiagAddress = getMember(t_address + t_countid + 28);
				setMember(tMiagAddress + 8,value);
			end	
			if key == "_unk3" then
				local tMiagAddress = getMember(t_address + t_countid + 28);
				setMember(tMiagAddress + 12,value);
			end
			if key == "_unk4" then
				local tMiagAddress = getMember(t_address + t_countid + 28);
				setMember(tMiagAddress + 16,value);
			end
			if key == "backgroundcolor" then
				local tMiagAddress = getMember(t_address + t_countid + 28);
				setMember(tMiagAddress + 20,value);
			end				
			Mtable['ra2'][key] = value	
		
end




