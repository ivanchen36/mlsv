function new.rollbutton(...)
	local args = {};
	local arg = {...};
	for i,v in ipairs(arg) do table.insert(args,v); end
		
	local ag_title 			= args[1] or "";		-- 控件名	
	
	-- 新创建一个object 作为子控件的偏移标准
	local _rollbutton 		= new.objectwithout(arg);
	_rollbutton.title 		= ag_title;
	_rollbutton.class 		= "rollbutton";
	_rollbutton.now 		= 0;
	_rollbutton.max 		= 0;
	_rollbutton.clicktime = os.clock();
	_rollbutton.Init = function(view,object)
		local tbl_object = {};
		--Msg("123123")
		-- 创建按钮
		table.insert(tbl_object,new.image(ag_title.."_defimage"));
		table.insert(tbl_object,new.rollbox(ag_title.."_defroll"));
		table.insert(tbl_object,new.image(ag_title.."_defimageup"));
		table.insert(tbl_object,new.image(ag_title.."_defimagedown"));
		--Msg("123123")		
		return tbl_object;
	end
	_rollbutton.update = function()
			local object = _rollbutton;
			local view = object.mainview;
			local rollbutton = object;
			local defimage = view.find(rollbutton.title.."_defimage");
			defimage.enable = 1;			
			defimage.xpos = rollbutton.xpos;
			defimage.ypos = rollbutton.ypos;
			defimage.virmainview = rollbutton;
			defimage.imageID = 243096
			
			local defroll = view.find(rollbutton.title.."_defroll");
			defroll.enable = 1;			
			defroll.xpos = rollbutton.xpos;
			defroll.ypos = rollbutton.ypos;
			defroll.sizex = rollbutton.sizex;
			defroll.sizey = rollbutton.sizey;
			defroll.virmainview = rollbutton;
			
			defroll.callbackfunc = function(object,event)
				local view = object.mainview;
				local rollbutton = object.virmainview;
				-- 鼠标进入事件
				local a1 = object._countid - 1;
				local a2 = event;
				local v2 = sub_46CF30(a1,a2);
				if v2 == 1 then
					--Cli.SysMessage("第"..object.imageID.."被选择",4,3);
					local t_countid = (object._countid - 1) * 36;
					local t_address = object.mainview._address;
					rollbutton.now = sub_46D060(t_address + t_countid, rollbutton.max);
					if type(rollbutton.event) == "function" then
						rollbutton.event(rollbutton)
					end
					--Cli.SysMessage("第"..rollbutton.now.."被选择",4,3);
				end
				return v2;
			end	
			
			local defimageup = view.find(rollbutton.title.."_defimageup");
			defimageup.enable = 1;
			defimageup.xpos = rollbutton.xpos;
			defimageup.ypos = rollbutton.ypos - 10;
			defimageup.imageID = 243090;
			defimageup.virmainview = rollbutton;
			defimageup.callbackfunc = function(object,event)
				local view = object.mainview;
				local rollbutton = object.virmainview;
				if event == Cevent.mouseover then
					object.imageID = 243092;
				elseif event == 9 then	
					object.imageID = 243091;
				else
					object.imageID = 243090;
				end		
				
				if event == 11 or event == 9 then
					local _go = false
					if event == 11 then
						rollbutton.clicktime = os.clock() + 0.5
						_go = true
					else
						if os.clock() - rollbutton.clicktime > 0.1 then
							_go = true
							rollbutton.clicktime = os.clock()
						end
					end
					if _go == true then
						local view = object.mainview;
						local rollbox = view.find(rollbutton.title.."_defroll");
						local t_countid = (rollbox._countid - 1) * 36;
						local t_address = rollbox.mainview._address;
						if rollbutton.now <= 0 then
							Audio.Bell(55,320);
							return;
						else
							Audio.Bell(51,320);
						end
						rollbutton.now = rollbutton.now - 1;
						sub_46D0F0(t_address + t_countid,rollbutton.max, rollbutton.now);
						
						if type(rollbutton.event) == "function" then
							rollbutton.event(rollbutton)
						end
					end
				end
			end
			
			local defimagedown = view.find(rollbutton.title.."_defimagedown");
			defimagedown.enable = 1;
			defimagedown.xpos = rollbutton.xpos;
			defimagedown.ypos = rollbutton.ypos + rollbutton.sizey;
			defimagedown.imageID = 243093;
			defimagedown.virmainview = rollbutton;
			defimagedown.callbackfunc = function(object,event)
				local view = object.mainview;
				local rollbutton = object.virmainview;
				if event == Cevent.mouseover then
					object.imageID = 243095;
				elseif event == 9 then	
					object.imageID = 243094;
				else
					object.imageID = 243093;
				end		
				if event == 11 or event == 9 then
					local _go = false
					if event == 11 then
						rollbutton.clicktime = os.clock() + 0.5
						_go = true
					else
						if os.clock() - rollbutton.clicktime > 0.1 then
							_go = true
							rollbutton.clicktime = os.clock()
						end
					end
					if _go == true then
						local view = object.mainview;
						local rollbox = view.find(rollbutton.title.."_defroll");
						local t_countid = (rollbox._countid - 1) * 36;
						local t_address = rollbox.mainview._address;
						if rollbutton.now >= rollbutton.max then
							Audio.Bell(55,320);
							return;
						else
							Audio.Bell(51,320);
						end
						rollbutton.now = rollbutton.now + 1;
						sub_46D0F0(t_address + t_countid,rollbutton.max, rollbutton.now);
						
						if type(rollbutton.event) == "function" then
							rollbutton.event(rollbutton)
						end
					end
				end
			end
	
	end
	_rollbutton.set = function(_now)
		local object = _rollbutton;
		local view = object.mainview;
		local rollbutton = object;
		local rollbox = view.find(rollbutton.title.."_defroll");
		local t_countid = (rollbox._countid - 1) * 36;
		local t_address = rollbox.mainview._address;
		rollbutton.now = _now - 1;
		sub_46D0F0(t_address + t_countid,rollbutton.max, rollbutton.now);
	end
	-- 所有控件回调函数
	_rollbutton.callbackfunc = function(object,event)	
		
	end
	return _rollbutton.box();
end