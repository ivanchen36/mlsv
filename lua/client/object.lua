
new = new or {};

function new.object(...)
		local args = {};
		local arg = {...};
		for i,v in ipairs(arg) do table.insert(args,v);	end
		
		local ag_title 			= args[1] or "";		-- �ؼ���
		local ag_id    			= args[2] or 0;		-- �ؼ�ID
		local ag_mainview 		= args[3] or 0;		-- �ؼ��ĸ�����
		local ag_virmainview 	= args[4] or 0;		-- �ؼ������⸸����
		--Msg("ag"..ag_title);
		local _object = {
			title 			= ag_title;
			id 				= ag_id;
			mainviewid		= ag_mainview;
			mainview		= {};
			virmainview		= ag_virmainview;
			event			= {}; 
			autocallback2	= {}; 
			callbackfunc	= {};
			isautodel       = true;					-- �������������ڱ�����ʱ���Ƿ��Զ�����
			_address 		= 0;					-- ��ֵ=0ʱ�������������ڽ���������ʹ�� object.islive() �ж϶������������
			_countid 		= 0;					-- �ؼ����ڵ�λ�ã���view.addcontrol()�������Ⱥ�˳�����
			_func 			= 0;
			_select1        = nil;					-- 3�������ֶΣ������Զ������ݴ洢
			_select2        = nil;
			_select3        = nil;		
			ra2				= {};	
		};
			
		
		-- �ж϶������������Ƿ����
		_object.islive = function()
			if _object.mainview._address ~= 0 or _object._tagptr ~=0 then
				return true;
			end
			return false;
		end 

		_object.callbackfunc = function(object,oevent)
			if type(_object.event) == "function" then 
				_object.event(object,oevent)
			end
		end

		_object.free = function()
			return;
		end

		_object.copyfrom = function(tcon)
			_object.type = tcon.type;
			_object.xpos = tcon.xpos;
			_object.ypos = tcon.ypos;
			_object.sizex = tcon.sizex;
			_object.sizey = tcon.sizey;
			_object.enable = tcon.enable;
			_object.objectptr = tcon.objectptr;
			_object.func = tcon.func;
			return _object;
		end	
		return setmetatable(_object, 
		{
		__index = objectget,
		__newindex = objectset,
		});
	
end

function new.objectwithout(...)
		local args = {};
		local arg = {...};
		for i,v in ipairs(arg) do table.insert(args,v);	end
		
		local ag_title 			= args[1] or "";		-- �ؼ���
		local ag_id    			= args[2] or 0;		-- �ؼ�ID
		local ag_mainview 		= args[3] or 0;		-- �ؼ��ĸ�����
		local ag_virmainview 	= args[4] or 0;		-- �ؼ������⸸����
		--Msg("ag"..ag_title);
		local _object = {
			title 			= ag_title;
			id 				= ag_id;
			mainviewid		= ag_mainview;
			mainview		= {};
			virmainview		= ag_virmainview;
			event			= {}; 
			autocallback2	= {}; 
			callbackfunc	= {};
			isautodel       = true;					-- �������������ڱ�����ʱ���Ƿ��Զ�����
			_address 		= 0;					-- ��ֵ=0ʱ�������������ڽ���������ʹ�� object.islive() �ж϶������������
			_countid 		= 0;					-- �ؼ����ڵ�λ�ã���view.addcontrol()�������Ⱥ�˳�����
			_func 			= 0;
			_select1        = nil;					-- 3�������ֶΣ������Զ������ݴ洢
			_select2        = nil;
			_select3        = nil;		
			ra2				= {};	
		};
		
		local MiagAddress = calloc(1,24);
		if MiagAddress == -1 then
			return -1;
		end
		_object._tagptr = MiagAddress;
		
		
		
		_object.Init = function(s,object)
			return;
		
		end
		
		_object.free = function()
			return;
		end
		
		-- �ж϶������������Ƿ����
		_object.islive = function()
			if _object.mainview._address ~= 0 or _object._tagptr ~=0 then
				return true;
			end
			return false;
		end 
		
		_object.box = function()
			return setmetatable(_object, 
			{
				__index = objectget,
				__newindex = objectset2,
			});
		end	
		
		
		
		return _object;
	
end






function objectget(Mtable,key)
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
			return Mtable['ra2'][key]
end

function objectset(Mtable,key,value)
			if Mtable.islive() == false then
					return -1;
			end	
			local t_countid = (Mtable._countid - 1) * 36;
			local t_address = Mtable.mainview._address;
			if key == "type" then
				setMember(t_address + t_countid,value);
			end
			if key == "hide" then
				if value == true then
					setMember(t_address + t_countid,9);
				end
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

				setMember(t_address + t_countid + 24,value);
			end	
			if key == "objectptr" then
				setMember(t_address + t_countid + 28,value);
			end	
			if key == "func" then
				setMember(t_address + t_countid + 32,value);
			end			
		
end


function objectset2(Mtable,key,value)
			if Mtable.islive() == false then
					return -1;
			end	
			local t_countid = (Mtable._countid - 1) * 36;
			local t_address = Mtable.mainview._address;
			if key == "type" then
				setMember(t_address + t_countid,value);
			end
			if key == "hide" then
				if value == true then
					setMember(t_address + t_countid,9);
				end
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
					Mtable.type = 1;
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
			Mtable['ra2'][key] = value
end




