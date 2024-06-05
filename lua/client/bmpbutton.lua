
--[[ 扩展控件（开源）
2018.12.15  by blue  QQ:859729391
2019.10.30  by blue  更新层次调节问题

一个可以直接使用32位真彩色的bmp按钮控件 
继承关系 bmpbutton->image->object

]];
-- 左移
function leftShift(num, shift)
    return math.floor(num * (2 ^ shift));
end
 
-- 右移
function rightShift(num, shift)
    return math.floor(num / (2 ^ shift));
end


function bufToInt32(buf,seek)
	seek = seek + 1
	local num1 = string.byte(buf,seek)
	local num2 = string.byte(buf,seek + 1)
	local num3 = string.byte(buf,seek + 2)
	local num4 = string.byte(buf,seek + 3)
    local num = 0;
    num = num + num1;
    num = num + leftShift(num2,8);
    num = num + leftShift(num3,16);
    num = num + leftShift(num4,24);
    return num;

end
-- 二进制转shot
function bufToInt16(num1, num2)
    local num = 0;
    num = num + num1;
    num = num + leftShift(num2, 8);
    return num;
end


tbl_bmps = tbl_bmps or {}
tbl_bmpsA = tbl_bmpsA or {}

local dllname = getspname();
local abname = string.gsub(dllname,'.dat','_ab') .. '\\';
local abname2 = string.gsub(dllname,'.dat','_ab') .. '//';

function get_size_z2(filename)
	
	
	local buf;
	local file;
	if tbl_bmps["jm_"..filename] ~= nil then
		--Msg("jm_"..file)
		if tbl_bmpsA["jm_"..filename] ~= nil then
			buf = tbl_bmpsA["jm_"..filename]
		else
			buf =  ZZBase64.decode(tbl_bmps["jm_"..filename].value);
			tbl_bmpsA["jm_"..filename] = buf
		end
	else
	
		file = io.open(abname2..filename,"rb")
		if file == nil then
			file = io.open("lua//image//"..filename,"rb")
			if file == nil then
				file = io.open("lua//image//jm_"..filename,"rb")
			end
		end
		if file == nil then
			return 0,0,nil;
		end
		
		buf = file:read("*all");
		buf = bmp.decode(buf)	
		file:close()	
	end
	local sizex = bufToInt32(buf,18);
	local sizey = bufToInt32(buf,22);
	
	return sizex,sizey,buf;
end





function new.bbutton(...) -- 别名
	return new.bmpbutton(...)
end

function new.bmpbutton(...)
		local args = {};
		local arg = {...};
		for i,v in ipairs(arg) do table.insert(args,v); end
			
		local ag_title 			= args[1] or "";		-- 控件名
		local ag_filename 		= args[2] or "";		-- 文件名	
		
		-- 从image继承
		local _bmpbutton = new.image(arg);
		_bmpbutton.title = ag_title;
		_bmpbutton.id = ag_filename;
		_bmpbutton.class = "bmpbutton";
		_bmpbutton._select1 = "";
		_bmpbutton._select2 = "";
		_bmpbutton._select3 = "";
		
		--_bmpbutton._select1 = {}
		--bmp.load(_bmpbutton.id)
		
		_bmpbutton.callbackfunc = function(object,event)	
			if type(object.event) == "function" then
				
				object.event(object,event)
			end
			
			local check = 0
			if object._select2 ~= object.id then
				check = 1
				object._select2 = object.id
				
			end
			local check2 = 0
			if check == 1 and check2 == 0 then
				check2 = 1
				check = 0
				local sx,sy,_buf = get_size_z2(object.id);
				object.sizex = tonumber(sx)
				object.sizey = tonumber(sy)
				
				bmp.load(object.id)
				
				for i = 1,#tbl_bmp2 do
					if tbl_bmp2[i].id == object.id then
						
						--Cli.MessageBox("".. - (10000 + tonumber(i)));
						object.imageID2 =  (9990000 + tonumber(i));
						--object.imageID = 100
						--object.backgroundcolor
						object.sizex = tonumber(sx)
						object.sizey = tonumber(sy)
						break
					end
				end
				check2 = 0
				
			end
			

		end
		
		return _bmpbutton;
		
end