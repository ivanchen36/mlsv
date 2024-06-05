
new = new or {};
convent = convent or {};


function new.rollbox(...)
		local args = {};
		local arg = {...};
		for i,v in ipairs(arg) do	table.insert(args,v);	end
		
		local ag_title 			= args[1] or "";		-- 控件名
		local ag_id    			= args[2] or 0;		-- 控件ID
		local ag_mainview 		= args[3] or 0;		-- 控件的父窗口
		local ag_virmainview 	= args[4] or 0;		-- 控件的虚拟父窗口
		--Msg("ag"..ag_title);
		
		local _rollbox = {
			title 			= ag_title;
			class			="rollbox";
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
			now				= 0;
			max				= 0;
			ra2				= {};
						
		};
			
		local MiagAddress = calloc(1,56);
		if MiagAddress == -1 then
			return -1;
		end
		_rollbox._tagptr = MiagAddress;
		
		
		-- 判断对象生命周期是否结束
		_rollbox.islive = function()
			if _rollbox.mainview._address ~= 0 or _rollbox._tagptr ~=0 then
				return true;
			end
			return false;
		end 



		_rollbox.free = function()
			return;
		end

		
		return setmetatable(_rollbox, 
		{
		__index = rollboxget2,
		__newindex = rollboxset2,
		});
	
end
function rollboxget(Mtable,key)
	local e,err = pcall(rollboxget2,Mtable,key)
	--if err ~= nil then
	--Msg(err)
	--end
	
end
function rollboxget2(Mtable,key)
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
			if key == "selected" then
				local tMiagAddress = getMember(t_address + t_countid + 28);
				return tonumber(getMember(tMiagAddress + 4));
			end	
			if key == "imageID" then
				local tMiagAddress = getMember(t_address + t_countid + 28);
				return tonumber(getMember(tMiagAddress + 32));
			end	
			if key == "backgroundcolor" then
				local tMiagAddress = getMember(t_address + t_countid + 28);
				return tonumber(getMember(tMiagAddress + 52));
			end	
			return Mtable['ra2'][key]
							
end
function rollboxset(Mtable,key,value)
	local e,err = pcall(rollboxset2,Mtable,key,value)
	--if err ~= nil then
	--Msg(err)
	--end
end
function rollboxset2(Mtable,key,value)
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
					Mtable.type = 4;
					Mtable.objectptr = Mtable._tagptr;
					Mtable.backgroundcolor = -1;
					Mtable.func = get_allcallback();
					local tMiagAddress = getMember(t_address + t_countid + 28);
					setMember(tMiagAddress + 12,20);
					setMember(tMiagAddress + 16,50);
					setMember(tMiagAddress + 20,50);
					setMember(tMiagAddress + 24,33);
					setMember(tMiagAddress + 28,33);
						
				end
				setMember(t_address + t_countid + 24,value);
			end	
			if key == "objectptr" then
				setMember(t_address + t_countid + 28,value);
			end	
			if key == "func" then
				setMember(t_address + t_countid + 32,value);
			end	
			if key == "selected" then
				local tMiagAddress = getMember(t_address + t_countid + 28);
				setMember(tMiagAddress + 4,value);
					
			end	
			if key == "imageID" then
				local tMiagAddress = getMember(t_address + t_countid + 28);
				setMember(tMiagAddress + 32,value);
			end	
			if key == "backgroundcolor" then
				local tMiagAddress = getMember(t_address + t_countid + 28);
				setMember(tMiagAddress + 52,value);
			end	
			Mtable['ra2'][key] = value		
		
end

