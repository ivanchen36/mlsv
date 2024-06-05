
new = new or {};
convent = convent or {};
Convent = Convent or {};

function Convent.anime(object,count)
	return convent.anime(object,count);
end

function convent.anime(object,count)
	if object.type == 2 then 
		local _anime = {
			title 			= "";
			class			="anime";
			mainview		= object.mainview;
			isautodel       = true;					-- �������������ڱ�����ʱ���Ƿ��Զ�����
			_address 		= 0;					-- ��ֵ=0ʱ�������������ڽ���������ʹ�� object.islive() �ж϶������������
			_countid 		= object._countid;					-- �ؼ����ڵ�λ�ã���view.addcontrol()�������Ⱥ�˳�����
			_tagptr 		= 0;					-- ��ֵ=0ʱ�������������ڽ���������ʹ�� object.islive() �ж϶������������
			_func 			= 0;
			_select1        = "";					-- 3�������ֶΣ������Զ������ݴ洢
			_select2        = "";
			_select3        = "";		
			ra2				= {};	
		};
					
		_anime.islive = 
		function()			
				return true;
		end 	
			
		return setmetatable(_anime, 
		{
		__index = animeget,
		__newindex = animeset,
		});
	end

end

function new.anime(...)
		local args = {};
		local arg = {...};
		for i,v in ipairs(arg) do	table.insert(args,v);	end
		
		local ag_title 			= args[1] or "";		-- �ؼ���
		local ag_id    			= args[2] or 0;		-- �ؼ�ID
		local ag_mainview 		= args[3] or 0;		-- �ؼ��ĸ�����
		local ag_virmainview 	= args[4] or 0;		-- �ؼ������⸸����
		--Msg("ag"..ag_title);
		
		local _anime = {
			title 			= ag_title;
			class			="anime";
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
			_tagptr 		= 0;					-- ��ֵ=0ʱ�������������ڽ���������ʹ�� object.islive() �ж϶������������
			_func 			= 0;
			_select1        = nil;					-- 3�������ֶΣ������Զ������ݴ洢
			_select2        = nil;
			_select3        = nil;		
			ra2				= {};	
		};
			
		local MiagAddress = calloc(1,8);
		--sysmsg(tostring(MiagAddress),4,3);
		if MiagAddress == -1 then
			return -1;
		end
		_anime._tagptr = MiagAddress;

		local actionAddress = getaction(2,0);
		--sysmsg(tostring(actionAddress),4,3);
		setMember(MiagAddress,actionAddress);
		setMember(MiagAddress + 4,0);
		
		
		
		-- �ж϶������������Ƿ����
		_anime.islive = function()
			if _anime.mainview._address ~= 0 or _anime._tagptr ~=0 then
				return true;
			end
			return false;
		end 

		_anime.callbackfunc = function(object,oevent)
			if type(_anime.event) == "function" then 
				_anime.event(object,oevent)
			end
		end

		_anime.free = function()
			return;
		end

			
		return setmetatable(_anime, 
		{
		__index = animeget,
		__newindex = animeset,
		});
	
end

function animeget(Mtable,key)
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
			if key == "animeID" then
				local tMiagAddress = getMember(t_address + t_countid + 28);
				return getMember(getMember(tMiagAddress) + 680,value);
			end	
			if key == "action" then
				local tMiagAddress = getMember(t_address + t_countid + 28);
				return getMember(getMember(tMiagAddress) + 688,value);
			end	
			if key == "dir" then
				local tMiagAddress = getMember(t_address + t_countid + 28);
				return getMember(getMember(tMiagAddress) + 696,value);
			end		
			return Mtable['ra2'][key]			
end

function animeset(Mtable,key,value)
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
					Mtable.type = 2;
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
			if key == "animeID" then
				local tMiagAddress = getMember(t_address + t_countid + 28);
				setMember(getMember(tMiagAddress) + 680,value);
			end	
			if key == "action" then
				local tMiagAddress = getMember(t_address + t_countid + 28);
				setMember(getMember(tMiagAddress) + 688,value);
			end	
			if key == "dir" then
				local tMiagAddress = getMember(t_address + t_countid + 28);
				setMember(getMember(tMiagAddress) + 696,value);
			end	
			Mtable['ra2'][key] = value
		
end