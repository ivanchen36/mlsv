
function findview(_vid)
		return tbl_object_view2[_vid];
end

function new.view(_vid,_oldcount)
	local s = {
		IsInit		= false;
		vid			= _vid;
		_index		= 0;
		oldcount	= _oldcount;
		newcount	= 0;
		_address	= 0; 
		oldxpos 	= 0;
		ontop 		= 0;
		ra2				= {};
	};
	s.addcontrol = 
	function(object) 
		s.newcount = s.newcount + 1;
		object._countid = s.oldcount + s.newcount;	
		object.mainviewid = s.vid;	
		object.mainview = s;
		table.insert(tbl_object_box[s.vid],object);
	end	
	
	
	s.add =
	function(object)
		-- call 构造函数
		s.addcontrol(object)
		if type(object.Init) == "function" then
			local tbl_object = object.Init(s,object);
			for i=1,#tbl_object do
				s.newcount = s.newcount + 1;
				tbl_object[i]._countid = s.oldcount + s.newcount;
				tbl_object[i].mainviewid = s.vid;	
				tbl_object[i].mainview = s;
				table.insert(tbl_object_box[s.vid],tbl_object[i]);
			end
		end
	end

	s.settop = 
	function() 
		s.ontop = s.newcount;
	end

	s.find = 
	function(_title)	
		for i, tobject in pairs(tbl_object_box[s.vid]) do 		
			if tobject.mainviewid == s.vid and tobject.title == _title then			
				return tobject;			
			end
		end
		return nil;
	end	

	s.findbyCount = 
	function(count)
		for i, tobject in pairs(tbl_object_box[s.vid]) do 
			if tobject._countid == count then
				return tobject;			
			end
		end
		return nil;
	end	


	s.update =
	function()
		if s.newcount > 0 then
			s.num = s.oldcount + s.newcount;
		end
	end
	
	tbl_object_view2[_vid] = s;
	return setmetatable(s, {
		--重载table读写的元表方法
		__index = Mget,
		__newindex = Mset,
	})	
	
end


function view_init(id)

	
	local countid = getMember(id);
	this_view_id = countid;
	--Msg(countid);
	local countnum2 = getMember(getMember(tonumber("56B310",16) + countid * 4) + 28);
	--old
	--local countnum2 = getMember(getMember(5677920 + countid * 4) + 28);
	if(this_show_num ~= 0 and countid == org_vid) then
		countid = this_show_num;	
		this_view_id = this_show_num;
	end
	
	local s2 = new.view(countid,countnum2);	
	tbl_object_box[countid] = {};
	viewObject_init(s2);
	
end




function view_pro(index)

	local t = getMember(index + 4);
	if(this_show_num ~= 0 and t == org_vid) then
		setMember(index + 4,this_show_num)	
	end
	local _vid = getMember(index + 4);
	--Msg(_vid)
	local tveiw =tbl_object_view2[_vid];
	--Msg(tveiw.oldcount)
	tveiw._index = index;
	--Msg(tveiw._index)
	tveiw._address = tveiw.objptr;
	viewObject_pro(tveiw);
	tveiw.update();

end

function Mget(Mtable,key)
	--[[
		这里是读内存代码
	]]
	if key == "_index" then
		return tonumber(Mtable._index);
	end
	if key == "viewID" then
		--Msg("mm"..Mtable._index);
		return tonumber(getMember(Mtable._index + 4));
	end
	if key == "xpos" then
		--Msg("mm"..Mtable._index+8);
		return tonumber(getMember(Mtable._index + 12));
	end	
	if key == "ypos" then
		return tonumber(getMember(Mtable._index + 16));
	end		
	
	if key == "sizex" then
		return tonumber(getMember(Mtable._index + 20));
	end		
	
	if key == "sizey" then
		return tonumber(getMember(Mtable._index + 24));
	end	
	
	if key == "num" or key == "controlnum" then
		return tonumber(getMember(Mtable._index + 40));
	end
	
	if key == "objptr"  then
		return tonumber(getMember(Mtable._index + 44));
	end				
	--Msg("key:"..key);
	if key == "controls" then	
		local controls = {};
		local num = tonumber(getMember(Mtable._index + 40));
		--Msg("num:"..num);
		local conptrs = tonumber(getMember(Mtable._index + 44));
		
		for i=1,num  do
			local conptr = 0;
			conptr = conptrs + ((i - 1) * 36);
			--Msg(getMember(conptr + 8));
			local _con = {};
		
			_con["_index"] = conptr;
			_con["mainview"] = Mtable;
			
			_con["_countid"] = i;
			_con["ra2"]		= {};
			
			setmetatable(_con, {
				__index = CMget,
				__newindex = CMset,

			});	

			table.insert (controls,_con); 	
		
		end
		
		return controls;
	end
	
	if key == "pxpos"  then
		return tonumber(getMember(Mtable._index + 72));
	end				

	if key == "pypos"  then
		return tonumber(getMember(Mtable._index + 76));
	end		
	return Mtable['ra2'][key]
	--return -1; 
end


function Mset(Mtable,key,value)
	--[[
		这里是写内存代码
	]]
	--Msg("key:"..key);
	if key == "viewID" then
		setMember(Mtable._index + 4,value);
	end
	if key == "xpos" then
		setMember(Mtable._index + 12,value);
	end	
	if key == "ypos" then
		setMember(Mtable._index + 16,value);
	end	
	if key == "sizex" then
		setMember(Mtable._index + 20,value);
	end		
	
	if key == "sizey" then
		setMember(Mtable._index + 24,value);
	end	
	
	
	if key == "num" or key == "controlnum" then
		setMember(Mtable._index + 40,value);
	end	
	
	if key == "objptr"  then
		setMember(Mtable._index + 44,value);
	end	
	
	if key == "pxpos"  then
		setMember(Mtable._index + 72,value);
		
	end				

	if key == "pypos"  then
		setMember(Mtable._index + 76,value);
		
	end		
	Mtable['ra2'][key] = value
end

function CMget(Mtable,key)
	--[[
		这里是读内存代码
	]]
	local conptr = Mtable._index;
	if key == "type" then
		return getMember(conptr);
	end
	if key == "vunk1" then
		return getMember(conptr + 4);
	end
	if key == "xpos" then
		return getMember(conptr + 8);
	end
	if key == "ypos" then
		return getMember(conptr + 12);
	end
	if key == "sizex" then
		return getMember(conptr + 16);
	end
	if key == "sizey" then
		return getMember(conptr + 20);
	end
	if key == "enable" then
		return getMember(conptr + 24);
	end
	
	if key == "objectptr" then
		return getMember(conptr + 28);
	end
	if key == "func" then
		return getMember(conptr + 32);
	end
	return Mtable['ra2'][key]
end




function CMset(Mtable,key,value)
	--[[
		这里是写内存代码
	]]
	
	local conptr = Mtable._index;
	if key == "type" then
		setMember(conptr,value);
	end
	if key == "hide" then
		if value == true then
			setMember(conptr,9);
		end
	end
	if key == "vunk1" then
		setMember(conptr + 4,value);
	end
	if key == "xpos" then
		setMember(conptr + 8,value);
	end
	if key == "ypos" then
		setMember(conptr + 12,value);
	end
	if key == "sizex" then
		setMember(conptr + 16,value);
	end
	if key == "sizey" then
		setMember(conptr + 20,value);
	end	
	if key == "enable" then
		setMember(conptr + 24,value);
	end
	if key == "objectptr" then
		setMember(conptr + 28,value);
	end
	if key == "func" then
		setMember(conptr + 32,value);
	end	
	Mtable['ra2'][key] = value
	
end