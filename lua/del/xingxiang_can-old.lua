
-- 形象
-- 本脚本 
--[[
说明: 
	形象 形象编号（如果 多个武器 或颜色 只需填写第一编号即可）
	武器 这个形象拥有的武器数量 （单一形象 填写1）
	颜色 拥有的颜色数量 （单一形象 填写1）
	本脚本会自动根据 武器和颜色 自动排列形象编号，避免繁琐的操作。
	注意：多武器 颜色 必须 形象编号连续 否则会出现bug
	注意：多武器 颜色 必须 形象编号连续 否则会出现bug
	注意：多武器 颜色 必须 形象编号连续 否则会出现bug
--]]





ImageTable = {}
ImageTable.Char = {   -- 人物形象
{形象 = 105610, 武器 = 6, 颜色 = 0 ,Item = {88888,1}},--需求道具,数量
{形象 = 105616, 武器 = 6, 颜色 = 0 ,Item = {88888,1}},
{形象 = 105622, 武器 = 6, 颜色 = 0 ,Item = {88888,1}},
{形象 = 105628, 武器 = 6, 颜色 = 0 ,Item = {88888,1}},
{形象 = 105634, 武器 = 6, 颜色 = 0 ,Item = {88888,1}},
{形象 = 105640, 武器 = 6, 颜色 = 0 ,Item = {88888,1}},
{形象 = 105646, 武器 = 6, 颜色 = 0 ,Item = {88888,1}},
{形象 = 105652, 武器 = 6, 颜色 = 0 ,Item = {88888,1}},
{形象 = 105658, 武器 = 6, 颜色 = 0 ,Item = {88888,1}},
{形象 = 105664, 武器 = 6, 颜色 = 0 ,Item = {88888,1}},
{形象 = 100425, 武器 = 6, 颜色 = 0 ,Item = {88888,1}},
{形象 = 100450, 武器 = 6, 颜色 = 0 ,Item = {88888,1}},
{形象 = 100475, 武器 = 6, 颜色 = 0 ,Item = {88888,1}},
{形象 = 100500, 武器 = 6, 颜色 = 0 ,Item = {88888,1}},
{形象 = 100972, 武器 = 6, 颜色 = 0 ,Item = {88888,1}},
{形象 = 100978, 武器 = 6, 颜色 = 0 ,Item = {88888,1}},
{形象 = 100984, 武器 = 6, 颜色 = 0 ,Item = {88888,1}},
{形象 = 100990, 武器 = 6, 颜色 = 0 ,Item = {88888,1}},
{形象 = 105700, 武器 = 6, 颜色 = 0 ,Item = {88888,1}},
{形象 = 105712, 武器 = 6, 颜色 = 0 ,Item = {88888,1}},
{形象 = 100000, 武器 = 6, 颜色 = 4 ,Item = {88888,10}},
{形象 = 100025, 武器 = 6, 颜色 = 4 ,Item = {88888,10}},
{形象 = 100050, 武器 = 6, 颜色 = 4 ,Item = {88888,10}},
{形象 = 100075, 武器 = 6, 颜色 = 4 ,Item = {88888,10}},
{形象 = 100100, 武器 = 6, 颜色 = 4 ,Item = {88888,10}},
{形象 = 100125, 武器 = 6, 颜色 = 4 ,Item = {88888,10}},
{形象 = 100150, 武器 = 6, 颜色 = 4 ,Item = {88888,10}},
{形象 = 100250, 武器 = 6, 颜色 = 4 ,Item = {88888,10}},
{形象 = 100275, 武器 = 6, 颜色 = 4 ,Item = {88888,10}},
{形象 = 100300, 武器 = 6, 颜色 = 4 ,Item = {88888,10}},
{形象 = 100325, 武器 = 6, 颜色 = 4 ,Item = {88888,10}},
{形象 = 100350, 武器 = 6, 颜色 = 4 ,Item = {88888,10}},
{形象 = 100375, 武器 = 6, 颜色 = 4 ,Item = {88888,10}},
{形象 = 100400, 武器 = 6, 颜色 = 4 ,Item = {88888,10}},
{形象 = 106000, 武器 = 6, 颜色 = 4 ,Item = {88888,10}},
{形象 = 106025, 武器 = 6, 颜色 = 4 ,Item = {88888,10}},
{形象 = 106050, 武器 = 6, 颜色 = 4 ,Item = {88888,10}},
{形象 = 106075, 武器 = 6, 颜色 = 4 ,Item = {88888,10}},
{形象 = 106100, 武器 = 6, 颜色 = 4 ,Item = {88888,10}},
{形象 = 106125, 武器 = 6, 颜色 = 4 ,Item = {88888,10}},
{形象 = 106150, 武器 = 6, 颜色 = 4 ,Item = {88888,10}},
{形象 = 106250, 武器 = 6, 颜色 = 4 ,Item = {88888,10}},
{形象 = 106275, 武器 = 6, 颜色 = 4 ,Item = {88888,10}},
{形象 = 106300, 武器 = 6, 颜色 = 4 ,Item = {88888,10}},
{形象 = 106325, 武器 = 6, 颜色 = 4 ,Item = {88888,10}},
{形象 = 106350, 武器 = 6, 颜色 = 4 ,Item = {88888,10}},
{形象 = 106375, 武器 = 6, 颜色 = 4 ,Item = {88888,10}},
{形象 = 106400, 武器 = 6, 颜色 = 4 ,Item = {88888,10}},
{形象 = 100525, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 100550, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 100575, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 100600, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 100625, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 100650, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 100675, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 100700, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 100725, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 100750, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 100800, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 100888, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 100915, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 100942, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 100966, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 100175, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 100181, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 100187, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 100193, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 100206, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 100212, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 105706, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 105737, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 105742, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 105748, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 100656, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 100882, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 100903, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 100909, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 100924, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 100930, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 100954, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 105676, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 105682, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 105688, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 105725, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 105731, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 105818, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 105824, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 105830, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 106756, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 106762, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 106768, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 106775, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 105670, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 105694, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 105718, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 105754, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 105760, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 105784, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 105790, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 105800, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 105806, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 119330, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 106500, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 106550, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 106600, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 106625, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 106650, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 106675, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 106725, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 100200, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},
{形象 = 119300, 武器 = 6, 颜色 = 0 ,Item = {88888,30}},

{形象 = 105993, 武器 = 1, 颜色 = 0 ,Item = {88888,9999}},
{形象 = 105994, 武器 = 1, 颜色 = 0 ,Item = {88888,9999}},
{形象 = 100897, 武器 = 1, 颜色 = 0 ,Item = {88888,9999}},
{形象 = 119500, 武器 = 1, 颜色 = 0 ,Item = {88888,9999}},

}

--[[local t22 = {
{"攻击|1","敏捷|1","生命|2","恢复|1","精神|1","防御|1"},
{"攻击|2","敏捷|2","生命|4","恢复|2","精神|2","防御|2"},
{"攻击|3","敏捷|3","生命|6","恢复|3","精神|3","防御|3"}}
local xxx = ""
for i = 1,#ImageTable.Char do 
	local a0 = ImageTable.Char[i].形象
	
	local a1 = ImageTable.Char[i].武器
	local a2 = ImageTable.Char[i].颜色
	local a3 = ImageTable.Char[i].Item[2]	
	local nnn = 1
	if a3 == 30 then 
		nnn = 2
	elseif a3 == 1 then 
		nnn = 3
	end		
	
	if a2 > 0 then 
		for q = 1,a2 do 
			for w = 0,a1-1 do 
				xxx = xxx .."\nImageTable.Attribute["..(a0 + w +((q-1)*6)).."] = {"..t22[nnn][w+1].."}"	
			end
		end
	else
		xxx = xxx .."\nImageTable.Attribute["..a0.."] = {"..t22[nnn][1].."}"
		for w = 2,a1 do 
			xxx = xxx .."\nImageTable.Attribute["..(a0 + w-1).."] = {"..t22[nnn][w].."}"	
		end
	end		
end	
写入文件(xxx,"ttt.txt")]]

ImageTable.Pet = {   -- 宠物形象
{形象 = 109451, 颜色 = 1 ,Item = {88888,1}},
{形象 = 117951, 颜色 = 1 ,Item = {88888,1}},
{形象 = 117952, 颜色 = 1 ,Item = {88888,1}},
{形象 = 117953, 颜色 = 1 ,Item = {88888,1}},
{形象 = 117954, 颜色 = 1 ,Item = {88888,1}},
{形象 = 101531, 颜色 = 1 ,Item = {88888,1}},
{形象 = 101533, 颜色 = 1 ,Item = {88888,1}},
{形象 = 101025, 颜色 = 1 ,Item = {88888,1}},
{形象 = 101205, 颜色 = 1 ,Item = {88888,1}},
{形象 = 119609, 颜色 = 1 ,Item = {88888,1}},
{形象 = 104695, 颜色 = 1 ,Item = {88888,1}},
{形象 = 104940, 颜色 = 1 ,Item = {88888,1}},
{形象 = 109426, 颜色 = 1 ,Item = {88888,1}},
{形象 = 100895, 颜色 = 1 ,Item = {88888,1}},
{形象 = 117024, 颜色 = 1 ,Item = {88888,1}},
{形象 = 104823, 颜色 = 1 ,Item = {88888,1}},
{形象 = 120059, 颜色 = 1 ,Item = {88888,1}},
{形象 = 104881, 颜色 = 1 ,Item = {88888,1}},
{形象 = 117127, 颜色 = 1 ,Item = {88888,1}},
{形象 = 101800, 颜色 = 1 ,Item = {88888,1}},
{形象 = 104887, 颜色 = 1 ,Item = {88888,1}},
{形象 = 104888, 颜色 = 1 ,Item = {88888,1}},
{形象 = 104896, 颜色 = 1 ,Item = {88888,1}},
{形象 = 105849, 颜色 = 1 ,Item = {88888,1}},
{形象 = 105862, 颜色 = 1 ,Item = {88888,1}},
{形象 = 104669, 颜色 = 1 ,Item = {88888,1}},
{形象 = 107703, 颜色 = 1 ,Item = {88888,1}},
{形象 = 107701, 颜色 = 1 ,Item = {88888,1}},
{形象 = 109429, 颜色 = 1 ,Item = {88888,1}},
}

ImageTable.Attribute = {}
ImageTable.Attribute[105993] = {"生命|60"}
ImageTable.Attribute[105994] = {"攻击|20"}
ImageTable.Attribute[100897] = {"敏捷|20"}
ImageTable.Attribute[119500] = {"精神|10"}



ImageTable.Attribute[100000] = {"攻击|1"}
ImageTable.Attribute[100001] = {"敏捷|1"}
ImageTable.Attribute[100002] = {"生命|2"}
ImageTable.Attribute[100003] = {"恢复|1"}
ImageTable.Attribute[100004] = {"精神|1"}
ImageTable.Attribute[100005] = {"防御|1"}
ImageTable.Attribute[100006] = {"攻击|1"}
ImageTable.Attribute[100007] = {"敏捷|1"}
ImageTable.Attribute[100008] = {"生命|2"}
ImageTable.Attribute[100009] = {"恢复|1"}
ImageTable.Attribute[100010] = {"精神|1"}
ImageTable.Attribute[100011] = {"防御|1"}
ImageTable.Attribute[100012] = {"攻击|1"}
ImageTable.Attribute[100013] = {"敏捷|1"}
ImageTable.Attribute[100014] = {"生命|2"}
ImageTable.Attribute[100015] = {"恢复|1"}
ImageTable.Attribute[100016] = {"精神|1"}
ImageTable.Attribute[100017] = {"防御|1"}
ImageTable.Attribute[100018] = {"攻击|1"}
ImageTable.Attribute[100019] = {"敏捷|1"}
ImageTable.Attribute[100020] = {"生命|2"}
ImageTable.Attribute[100021] = {"恢复|1"}
ImageTable.Attribute[100022] = {"精神|1"}
ImageTable.Attribute[100023] = {"防御|1"}

ImageTable.Attribute[100025] = {"攻击|1"}
ImageTable.Attribute[100026] = {"敏捷|1"}
ImageTable.Attribute[100027] = {"生命|2"}
ImageTable.Attribute[100028] = {"恢复|1"}
ImageTable.Attribute[100029] = {"精神|1"}
ImageTable.Attribute[100030] = {"防御|1"}
ImageTable.Attribute[100031] = {"攻击|1"}
ImageTable.Attribute[100032] = {"敏捷|1"}
ImageTable.Attribute[100033] = {"生命|2"}
ImageTable.Attribute[100034] = {"恢复|1"}
ImageTable.Attribute[100035] = {"精神|1"}
ImageTable.Attribute[100036] = {"防御|1"}
ImageTable.Attribute[100037] = {"攻击|1"}
ImageTable.Attribute[100038] = {"敏捷|1"}
ImageTable.Attribute[100039] = {"生命|2"}
ImageTable.Attribute[100040] = {"恢复|1"}
ImageTable.Attribute[100041] = {"精神|1"}
ImageTable.Attribute[100042] = {"防御|1"}
ImageTable.Attribute[100043] = {"攻击|1"}
ImageTable.Attribute[100044] = {"敏捷|1"}
ImageTable.Attribute[100045] = {"生命|2"}
ImageTable.Attribute[100046] = {"恢复|1"}
ImageTable.Attribute[100047] = {"精神|1"}
ImageTable.Attribute[100048] = {"防御|1"}

ImageTable.Attribute[100050] = {"攻击|1"}
ImageTable.Attribute[100051] = {"敏捷|1"}
ImageTable.Attribute[100052] = {"生命|2"}
ImageTable.Attribute[100053] = {"恢复|1"}
ImageTable.Attribute[100054] = {"精神|1"}
ImageTable.Attribute[100055] = {"防御|1"}
ImageTable.Attribute[100056] = {"攻击|1"}
ImageTable.Attribute[100057] = {"敏捷|1"}
ImageTable.Attribute[100058] = {"生命|2"}
ImageTable.Attribute[100059] = {"恢复|1"}
ImageTable.Attribute[100060] = {"精神|1"}
ImageTable.Attribute[100061] = {"防御|1"}
ImageTable.Attribute[100062] = {"攻击|1"}
ImageTable.Attribute[100063] = {"敏捷|1"}
ImageTable.Attribute[100064] = {"生命|2"}
ImageTable.Attribute[100065] = {"恢复|1"}
ImageTable.Attribute[100066] = {"精神|1"}
ImageTable.Attribute[100067] = {"防御|1"}
ImageTable.Attribute[100068] = {"攻击|1"}
ImageTable.Attribute[100069] = {"敏捷|1"}
ImageTable.Attribute[100070] = {"生命|2"}
ImageTable.Attribute[100071] = {"恢复|1"}
ImageTable.Attribute[100072] = {"精神|1"}
ImageTable.Attribute[100073] = {"防御|1"}

ImageTable.Attribute[100075] = {"攻击|1"}
ImageTable.Attribute[100076] = {"敏捷|1"}
ImageTable.Attribute[100077] = {"生命|2"}
ImageTable.Attribute[100078] = {"恢复|1"}
ImageTable.Attribute[100079] = {"精神|1"}
ImageTable.Attribute[100080] = {"防御|1"}
ImageTable.Attribute[100081] = {"攻击|1"}
ImageTable.Attribute[100082] = {"敏捷|1"}
ImageTable.Attribute[100083] = {"生命|2"}
ImageTable.Attribute[100084] = {"恢复|1"}
ImageTable.Attribute[100085] = {"精神|1"}
ImageTable.Attribute[100086] = {"防御|1"}
ImageTable.Attribute[100087] = {"攻击|1"}
ImageTable.Attribute[100088] = {"敏捷|1"}
ImageTable.Attribute[100089] = {"生命|2"}
ImageTable.Attribute[100090] = {"恢复|1"}
ImageTable.Attribute[100091] = {"精神|1"}
ImageTable.Attribute[100092] = {"防御|1"}
ImageTable.Attribute[100093] = {"攻击|1"}
ImageTable.Attribute[100094] = {"敏捷|1"}
ImageTable.Attribute[100095] = {"生命|2"}
ImageTable.Attribute[100096] = {"恢复|1"}
ImageTable.Attribute[100097] = {"精神|1"}
ImageTable.Attribute[100098] = {"防御|1"}

ImageTable.Attribute[100100] = {"攻击|1"}
ImageTable.Attribute[100101] = {"敏捷|1"}
ImageTable.Attribute[100102] = {"生命|2"}
ImageTable.Attribute[100103] = {"恢复|1"}
ImageTable.Attribute[100104] = {"精神|1"}
ImageTable.Attribute[100105] = {"防御|1"}
ImageTable.Attribute[100106] = {"攻击|1"}
ImageTable.Attribute[100107] = {"敏捷|1"}
ImageTable.Attribute[100108] = {"生命|2"}
ImageTable.Attribute[100109] = {"恢复|1"}
ImageTable.Attribute[100110] = {"精神|1"}
ImageTable.Attribute[100111] = {"防御|1"}
ImageTable.Attribute[100112] = {"攻击|1"}
ImageTable.Attribute[100113] = {"敏捷|1"}
ImageTable.Attribute[100114] = {"生命|2"}
ImageTable.Attribute[100115] = {"恢复|1"}
ImageTable.Attribute[100116] = {"精神|1"}
ImageTable.Attribute[100117] = {"防御|1"}
ImageTable.Attribute[100118] = {"攻击|1"}
ImageTable.Attribute[100119] = {"敏捷|1"}
ImageTable.Attribute[100120] = {"生命|2"}
ImageTable.Attribute[100121] = {"恢复|1"}
ImageTable.Attribute[100122] = {"精神|1"}
ImageTable.Attribute[100123] = {"防御|1"}

ImageTable.Attribute[100125] = {"攻击|1"}
ImageTable.Attribute[100126] = {"敏捷|1"}
ImageTable.Attribute[100127] = {"生命|2"}
ImageTable.Attribute[100128] = {"恢复|1"}
ImageTable.Attribute[100129] = {"精神|1"}
ImageTable.Attribute[100130] = {"防御|1"}
ImageTable.Attribute[100131] = {"攻击|1"}
ImageTable.Attribute[100132] = {"敏捷|1"}
ImageTable.Attribute[100133] = {"生命|2"}
ImageTable.Attribute[100134] = {"恢复|1"}
ImageTable.Attribute[100135] = {"精神|1"}
ImageTable.Attribute[100136] = {"防御|1"}
ImageTable.Attribute[100137] = {"攻击|1"}
ImageTable.Attribute[100138] = {"敏捷|1"}
ImageTable.Attribute[100139] = {"生命|2"}
ImageTable.Attribute[100140] = {"恢复|1"}
ImageTable.Attribute[100141] = {"精神|1"}
ImageTable.Attribute[100142] = {"防御|1"}
ImageTable.Attribute[100143] = {"攻击|1"}
ImageTable.Attribute[100144] = {"敏捷|1"}
ImageTable.Attribute[100145] = {"生命|2"}
ImageTable.Attribute[100146] = {"恢复|1"}
ImageTable.Attribute[100147] = {"精神|1"}
ImageTable.Attribute[100148] = {"防御|1"}
ImageTable.Attribute[100150] = {"攻击|1"}
ImageTable.Attribute[100151] = {"敏捷|1"}
ImageTable.Attribute[100152] = {"生命|2"}
ImageTable.Attribute[100153] = {"恢复|1"}
ImageTable.Attribute[100154] = {"精神|1"}
ImageTable.Attribute[100155] = {"防御|1"}
ImageTable.Attribute[100156] = {"攻击|1"}
ImageTable.Attribute[100157] = {"敏捷|1"}
ImageTable.Attribute[100158] = {"生命|2"}
ImageTable.Attribute[100159] = {"恢复|1"}
ImageTable.Attribute[100160] = {"精神|1"}
ImageTable.Attribute[100161] = {"防御|1"}
ImageTable.Attribute[100162] = {"攻击|1"}
ImageTable.Attribute[100163] = {"敏捷|1"}
ImageTable.Attribute[100164] = {"生命|2"}
ImageTable.Attribute[100165] = {"恢复|1"}
ImageTable.Attribute[100166] = {"精神|1"}
ImageTable.Attribute[100167] = {"防御|1"}
ImageTable.Attribute[100168] = {"攻击|1"}
ImageTable.Attribute[100169] = {"敏捷|1"}
ImageTable.Attribute[100170] = {"生命|2"}
ImageTable.Attribute[100171] = {"恢复|1"}
ImageTable.Attribute[100172] = {"精神|1"}
ImageTable.Attribute[100173] = {"防御|1"}
ImageTable.Attribute[100250] = {"攻击|1"}
ImageTable.Attribute[100251] = {"敏捷|1"}
ImageTable.Attribute[100252] = {"生命|2"}
ImageTable.Attribute[100253] = {"恢复|1"}
ImageTable.Attribute[100254] = {"精神|1"}
ImageTable.Attribute[100255] = {"防御|1"}
ImageTable.Attribute[100256] = {"攻击|1"}
ImageTable.Attribute[100257] = {"敏捷|1"}
ImageTable.Attribute[100258] = {"生命|2"}
ImageTable.Attribute[100259] = {"恢复|1"}
ImageTable.Attribute[100260] = {"精神|1"}
ImageTable.Attribute[100261] = {"防御|1"}
ImageTable.Attribute[100262] = {"攻击|1"}
ImageTable.Attribute[100263] = {"敏捷|1"}
ImageTable.Attribute[100264] = {"生命|2"}
ImageTable.Attribute[100265] = {"恢复|1"}
ImageTable.Attribute[100266] = {"精神|1"}
ImageTable.Attribute[100267] = {"防御|1"}
ImageTable.Attribute[100268] = {"攻击|1"}
ImageTable.Attribute[100269] = {"敏捷|1"}
ImageTable.Attribute[100270] = {"生命|2"}
ImageTable.Attribute[100271] = {"恢复|1"}
ImageTable.Attribute[100272] = {"精神|1"}
ImageTable.Attribute[100273] = {"防御|1"}
ImageTable.Attribute[100275] = {"攻击|1"}
ImageTable.Attribute[100276] = {"敏捷|1"}
ImageTable.Attribute[100277] = {"生命|2"}
ImageTable.Attribute[100278] = {"恢复|1"}
ImageTable.Attribute[100279] = {"精神|1"}
ImageTable.Attribute[100280] = {"防御|1"}
ImageTable.Attribute[100281] = {"攻击|1"}
ImageTable.Attribute[100282] = {"敏捷|1"}
ImageTable.Attribute[100283] = {"生命|2"}
ImageTable.Attribute[100284] = {"恢复|1"}
ImageTable.Attribute[100285] = {"精神|1"}
ImageTable.Attribute[100286] = {"防御|1"}
ImageTable.Attribute[100287] = {"攻击|1"}
ImageTable.Attribute[100288] = {"敏捷|1"}
ImageTable.Attribute[100289] = {"生命|2"}
ImageTable.Attribute[100290] = {"恢复|1"}
ImageTable.Attribute[100291] = {"精神|1"}
ImageTable.Attribute[100292] = {"防御|1"}
ImageTable.Attribute[100293] = {"攻击|1"}
ImageTable.Attribute[100294] = {"敏捷|1"}
ImageTable.Attribute[100295] = {"生命|2"}
ImageTable.Attribute[100296] = {"恢复|1"}
ImageTable.Attribute[100297] = {"精神|1"}
ImageTable.Attribute[100298] = {"防御|1"}
ImageTable.Attribute[100300] = {"攻击|1"}
ImageTable.Attribute[100301] = {"敏捷|1"}
ImageTable.Attribute[100302] = {"生命|2"}
ImageTable.Attribute[100303] = {"恢复|1"}
ImageTable.Attribute[100304] = {"精神|1"}
ImageTable.Attribute[100305] = {"防御|1"}
ImageTable.Attribute[100306] = {"攻击|1"}
ImageTable.Attribute[100307] = {"敏捷|1"}
ImageTable.Attribute[100308] = {"生命|2"}
ImageTable.Attribute[100309] = {"恢复|1"}
ImageTable.Attribute[100310] = {"精神|1"}
ImageTable.Attribute[100311] = {"防御|1"}
ImageTable.Attribute[100312] = {"攻击|1"}
ImageTable.Attribute[100313] = {"敏捷|1"}
ImageTable.Attribute[100314] = {"生命|2"}
ImageTable.Attribute[100315] = {"恢复|1"}
ImageTable.Attribute[100316] = {"精神|1"}
ImageTable.Attribute[100317] = {"防御|1"}
ImageTable.Attribute[100318] = {"攻击|1"}
ImageTable.Attribute[100319] = {"敏捷|1"}
ImageTable.Attribute[100320] = {"生命|2"}
ImageTable.Attribute[100321] = {"恢复|1"}
ImageTable.Attribute[100322] = {"精神|1"}
ImageTable.Attribute[100323] = {"防御|1"}
ImageTable.Attribute[100325] = {"攻击|1"}
ImageTable.Attribute[100326] = {"敏捷|1"}
ImageTable.Attribute[100327] = {"生命|2"}
ImageTable.Attribute[100328] = {"恢复|1"}
ImageTable.Attribute[100329] = {"精神|1"}
ImageTable.Attribute[100330] = {"防御|1"}
ImageTable.Attribute[100331] = {"攻击|1"}
ImageTable.Attribute[100332] = {"敏捷|1"}
ImageTable.Attribute[100333] = {"生命|2"}
ImageTable.Attribute[100334] = {"恢复|1"}
ImageTable.Attribute[100335] = {"精神|1"}
ImageTable.Attribute[100336] = {"防御|1"}
ImageTable.Attribute[100337] = {"攻击|1"}
ImageTable.Attribute[100338] = {"敏捷|1"}
ImageTable.Attribute[100339] = {"生命|2"}
ImageTable.Attribute[100340] = {"恢复|1"}
ImageTable.Attribute[100341] = {"精神|1"}
ImageTable.Attribute[100342] = {"防御|1"}
ImageTable.Attribute[100343] = {"攻击|1"}
ImageTable.Attribute[100344] = {"敏捷|1"}
ImageTable.Attribute[100345] = {"生命|2"}
ImageTable.Attribute[100346] = {"恢复|1"}
ImageTable.Attribute[100347] = {"精神|1"}
ImageTable.Attribute[100348] = {"防御|1"}
ImageTable.Attribute[100350] = {"攻击|1"}
ImageTable.Attribute[100351] = {"敏捷|1"}
ImageTable.Attribute[100352] = {"生命|2"}
ImageTable.Attribute[100353] = {"恢复|1"}
ImageTable.Attribute[100354] = {"精神|1"}
ImageTable.Attribute[100355] = {"防御|1"}
ImageTable.Attribute[100356] = {"攻击|1"}
ImageTable.Attribute[100357] = {"敏捷|1"}
ImageTable.Attribute[100358] = {"生命|2"}
ImageTable.Attribute[100359] = {"恢复|1"}
ImageTable.Attribute[100360] = {"精神|1"}
ImageTable.Attribute[100361] = {"防御|1"}
ImageTable.Attribute[100362] = {"攻击|1"}
ImageTable.Attribute[100363] = {"敏捷|1"}
ImageTable.Attribute[100364] = {"生命|2"}
ImageTable.Attribute[100365] = {"恢复|1"}
ImageTable.Attribute[100366] = {"精神|1"}
ImageTable.Attribute[100367] = {"防御|1"}
ImageTable.Attribute[100368] = {"攻击|1"}
ImageTable.Attribute[100369] = {"敏捷|1"}
ImageTable.Attribute[100370] = {"生命|2"}
ImageTable.Attribute[100371] = {"恢复|1"}
ImageTable.Attribute[100372] = {"精神|1"}
ImageTable.Attribute[100373] = {"防御|1"}
ImageTable.Attribute[100375] = {"攻击|1"}
ImageTable.Attribute[100376] = {"敏捷|1"}
ImageTable.Attribute[100377] = {"生命|2"}
ImageTable.Attribute[100378] = {"恢复|1"}
ImageTable.Attribute[100379] = {"精神|1"}
ImageTable.Attribute[100380] = {"防御|1"}
ImageTable.Attribute[100381] = {"攻击|1"}
ImageTable.Attribute[100382] = {"敏捷|1"}
ImageTable.Attribute[100383] = {"生命|2"}
ImageTable.Attribute[100384] = {"恢复|1"}
ImageTable.Attribute[100385] = {"精神|1"}
ImageTable.Attribute[100386] = {"防御|1"}
ImageTable.Attribute[100387] = {"攻击|1"}
ImageTable.Attribute[100388] = {"敏捷|1"}
ImageTable.Attribute[100389] = {"生命|2"}
ImageTable.Attribute[100390] = {"恢复|1"}
ImageTable.Attribute[100391] = {"精神|1"}
ImageTable.Attribute[100392] = {"防御|1"}
ImageTable.Attribute[100393] = {"攻击|1"}
ImageTable.Attribute[100394] = {"敏捷|1"}
ImageTable.Attribute[100395] = {"生命|2"}
ImageTable.Attribute[100396] = {"恢复|1"}
ImageTable.Attribute[100397] = {"精神|1"}
ImageTable.Attribute[100398] = {"防御|1"}
ImageTable.Attribute[100400] = {"攻击|1"}
ImageTable.Attribute[100401] = {"敏捷|1"}
ImageTable.Attribute[100402] = {"生命|2"}
ImageTable.Attribute[100403] = {"恢复|1"}
ImageTable.Attribute[100404] = {"精神|1"}
ImageTable.Attribute[100405] = {"防御|1"}
ImageTable.Attribute[100406] = {"攻击|1"}
ImageTable.Attribute[100407] = {"敏捷|1"}
ImageTable.Attribute[100408] = {"生命|2"}
ImageTable.Attribute[100409] = {"恢复|1"}
ImageTable.Attribute[100410] = {"精神|1"}
ImageTable.Attribute[100411] = {"防御|1"}
ImageTable.Attribute[100412] = {"攻击|1"}
ImageTable.Attribute[100413] = {"敏捷|1"}
ImageTable.Attribute[100414] = {"生命|2"}
ImageTable.Attribute[100415] = {"恢复|1"}
ImageTable.Attribute[100416] = {"精神|1"}
ImageTable.Attribute[100417] = {"防御|1"}
ImageTable.Attribute[100418] = {"攻击|1"}
ImageTable.Attribute[100419] = {"敏捷|1"}
ImageTable.Attribute[100420] = {"生命|2"}
ImageTable.Attribute[100421] = {"恢复|1"}
ImageTable.Attribute[100422] = {"精神|1"}
ImageTable.Attribute[100423] = {"防御|1"}
ImageTable.Attribute[106000] = {"攻击|1"}
ImageTable.Attribute[106001] = {"敏捷|1"}
ImageTable.Attribute[106002] = {"生命|2"}
ImageTable.Attribute[106003] = {"恢复|1"}
ImageTable.Attribute[106004] = {"精神|1"}
ImageTable.Attribute[106005] = {"防御|1"}
ImageTable.Attribute[106006] = {"攻击|1"}
ImageTable.Attribute[106007] = {"敏捷|1"}
ImageTable.Attribute[106008] = {"生命|2"}
ImageTable.Attribute[106009] = {"恢复|1"}
ImageTable.Attribute[106010] = {"精神|1"}
ImageTable.Attribute[106011] = {"防御|1"}
ImageTable.Attribute[106012] = {"攻击|1"}
ImageTable.Attribute[106013] = {"敏捷|1"}
ImageTable.Attribute[106014] = {"生命|2"}
ImageTable.Attribute[106015] = {"恢复|1"}
ImageTable.Attribute[106016] = {"精神|1"}
ImageTable.Attribute[106017] = {"防御|1"}
ImageTable.Attribute[106018] = {"攻击|1"}
ImageTable.Attribute[106019] = {"敏捷|1"}
ImageTable.Attribute[106020] = {"生命|2"}
ImageTable.Attribute[106021] = {"恢复|1"}
ImageTable.Attribute[106022] = {"精神|1"}
ImageTable.Attribute[106023] = {"防御|1"}
ImageTable.Attribute[106025] = {"攻击|1"}
ImageTable.Attribute[106026] = {"敏捷|1"}
ImageTable.Attribute[106027] = {"生命|2"}
ImageTable.Attribute[106028] = {"恢复|1"}
ImageTable.Attribute[106029] = {"精神|1"}
ImageTable.Attribute[106030] = {"防御|1"}
ImageTable.Attribute[106031] = {"攻击|1"}
ImageTable.Attribute[106032] = {"敏捷|1"}
ImageTable.Attribute[106033] = {"生命|2"}
ImageTable.Attribute[106034] = {"恢复|1"}
ImageTable.Attribute[106035] = {"精神|1"}
ImageTable.Attribute[106036] = {"防御|1"}
ImageTable.Attribute[106037] = {"攻击|1"}
ImageTable.Attribute[106038] = {"敏捷|1"}
ImageTable.Attribute[106039] = {"生命|2"}
ImageTable.Attribute[106040] = {"恢复|1"}
ImageTable.Attribute[106041] = {"精神|1"}
ImageTable.Attribute[106042] = {"防御|1"}
ImageTable.Attribute[106043] = {"攻击|1"}
ImageTable.Attribute[106044] = {"敏捷|1"}
ImageTable.Attribute[106045] = {"生命|2"}
ImageTable.Attribute[106046] = {"恢复|1"}
ImageTable.Attribute[106047] = {"精神|1"}
ImageTable.Attribute[106048] = {"防御|1"}
ImageTable.Attribute[106050] = {"攻击|1"}
ImageTable.Attribute[106051] = {"敏捷|1"}
ImageTable.Attribute[106052] = {"生命|2"}
ImageTable.Attribute[106053] = {"恢复|1"}
ImageTable.Attribute[106054] = {"精神|1"}
ImageTable.Attribute[106055] = {"防御|1"}
ImageTable.Attribute[106056] = {"攻击|1"}
ImageTable.Attribute[106057] = {"敏捷|1"}
ImageTable.Attribute[106058] = {"生命|2"}
ImageTable.Attribute[106059] = {"恢复|1"}
ImageTable.Attribute[106060] = {"精神|1"}
ImageTable.Attribute[106061] = {"防御|1"}
ImageTable.Attribute[106062] = {"攻击|1"}
ImageTable.Attribute[106063] = {"敏捷|1"}
ImageTable.Attribute[106064] = {"生命|2"}
ImageTable.Attribute[106065] = {"恢复|1"}
ImageTable.Attribute[106066] = {"精神|1"}
ImageTable.Attribute[106067] = {"防御|1"}
ImageTable.Attribute[106068] = {"攻击|1"}
ImageTable.Attribute[106069] = {"敏捷|1"}
ImageTable.Attribute[106070] = {"生命|2"}
ImageTable.Attribute[106071] = {"恢复|1"}
ImageTable.Attribute[106072] = {"精神|1"}
ImageTable.Attribute[106073] = {"防御|1"}
ImageTable.Attribute[106075] = {"攻击|1"}
ImageTable.Attribute[106076] = {"敏捷|1"}
ImageTable.Attribute[106077] = {"生命|2"}
ImageTable.Attribute[106078] = {"恢复|1"}
ImageTable.Attribute[106079] = {"精神|1"}
ImageTable.Attribute[106080] = {"防御|1"}
ImageTable.Attribute[106081] = {"攻击|1"}
ImageTable.Attribute[106082] = {"敏捷|1"}
ImageTable.Attribute[106083] = {"生命|2"}
ImageTable.Attribute[106084] = {"恢复|1"}
ImageTable.Attribute[106085] = {"精神|1"}
ImageTable.Attribute[106086] = {"防御|1"}
ImageTable.Attribute[106087] = {"攻击|1"}
ImageTable.Attribute[106088] = {"敏捷|1"}
ImageTable.Attribute[106089] = {"生命|2"}
ImageTable.Attribute[106090] = {"恢复|1"}
ImageTable.Attribute[106091] = {"精神|1"}
ImageTable.Attribute[106092] = {"防御|1"}
ImageTable.Attribute[106093] = {"攻击|1"}
ImageTable.Attribute[106094] = {"敏捷|1"}
ImageTable.Attribute[106095] = {"生命|2"}
ImageTable.Attribute[106096] = {"恢复|1"}
ImageTable.Attribute[106097] = {"精神|1"}
ImageTable.Attribute[106098] = {"防御|1"}
ImageTable.Attribute[106100] = {"攻击|1"}
ImageTable.Attribute[106101] = {"敏捷|1"}
ImageTable.Attribute[106102] = {"生命|2"}
ImageTable.Attribute[106103] = {"恢复|1"}
ImageTable.Attribute[106104] = {"精神|1"}
ImageTable.Attribute[106105] = {"防御|1"}
ImageTable.Attribute[106106] = {"攻击|1"}
ImageTable.Attribute[106107] = {"敏捷|1"}
ImageTable.Attribute[106108] = {"生命|2"}
ImageTable.Attribute[106109] = {"恢复|1"}
ImageTable.Attribute[106110] = {"精神|1"}
ImageTable.Attribute[106111] = {"防御|1"}
ImageTable.Attribute[106112] = {"攻击|1"}
ImageTable.Attribute[106113] = {"敏捷|1"}
ImageTable.Attribute[106114] = {"生命|2"}
ImageTable.Attribute[106115] = {"恢复|1"}
ImageTable.Attribute[106116] = {"精神|1"}
ImageTable.Attribute[106117] = {"防御|1"}
ImageTable.Attribute[106118] = {"攻击|1"}
ImageTable.Attribute[106119] = {"敏捷|1"}
ImageTable.Attribute[106120] = {"生命|2"}
ImageTable.Attribute[106121] = {"恢复|1"}
ImageTable.Attribute[106122] = {"精神|1"}
ImageTable.Attribute[106123] = {"防御|1"}
ImageTable.Attribute[106125] = {"攻击|1"}
ImageTable.Attribute[106126] = {"敏捷|1"}
ImageTable.Attribute[106127] = {"生命|2"}
ImageTable.Attribute[106128] = {"恢复|1"}
ImageTable.Attribute[106129] = {"精神|1"}
ImageTable.Attribute[106130] = {"防御|1"}
ImageTable.Attribute[106131] = {"攻击|1"}
ImageTable.Attribute[106132] = {"敏捷|1"}
ImageTable.Attribute[106133] = {"生命|2"}
ImageTable.Attribute[106134] = {"恢复|1"}
ImageTable.Attribute[106135] = {"精神|1"}
ImageTable.Attribute[106136] = {"防御|1"}
ImageTable.Attribute[106137] = {"攻击|1"}
ImageTable.Attribute[106138] = {"敏捷|1"}
ImageTable.Attribute[106139] = {"生命|2"}
ImageTable.Attribute[106140] = {"恢复|1"}
ImageTable.Attribute[106141] = {"精神|1"}
ImageTable.Attribute[106142] = {"防御|1"}
ImageTable.Attribute[106143] = {"攻击|1"}
ImageTable.Attribute[106144] = {"敏捷|1"}
ImageTable.Attribute[106145] = {"生命|2"}
ImageTable.Attribute[106146] = {"恢复|1"}
ImageTable.Attribute[106147] = {"精神|1"}
ImageTable.Attribute[106148] = {"防御|1"}
ImageTable.Attribute[106150] = {"攻击|1"}
ImageTable.Attribute[106151] = {"敏捷|1"}
ImageTable.Attribute[106152] = {"生命|2"}
ImageTable.Attribute[106153] = {"恢复|1"}
ImageTable.Attribute[106154] = {"精神|1"}
ImageTable.Attribute[106155] = {"防御|1"}
ImageTable.Attribute[106156] = {"攻击|1"}
ImageTable.Attribute[106157] = {"敏捷|1"}
ImageTable.Attribute[106158] = {"生命|2"}
ImageTable.Attribute[106159] = {"恢复|1"}
ImageTable.Attribute[106160] = {"精神|1"}
ImageTable.Attribute[106161] = {"防御|1"}
ImageTable.Attribute[106162] = {"攻击|1"}
ImageTable.Attribute[106163] = {"敏捷|1"}
ImageTable.Attribute[106164] = {"生命|2"}
ImageTable.Attribute[106165] = {"恢复|1"}
ImageTable.Attribute[106166] = {"精神|1"}
ImageTable.Attribute[106167] = {"防御|1"}
ImageTable.Attribute[106168] = {"攻击|1"}
ImageTable.Attribute[106169] = {"敏捷|1"}
ImageTable.Attribute[106170] = {"生命|2"}
ImageTable.Attribute[106171] = {"恢复|1"}
ImageTable.Attribute[106172] = {"精神|1"}
ImageTable.Attribute[106173] = {"防御|1"}
ImageTable.Attribute[106250] = {"攻击|1"}
ImageTable.Attribute[106251] = {"敏捷|1"}
ImageTable.Attribute[106252] = {"生命|2"}
ImageTable.Attribute[106253] = {"恢复|1"}
ImageTable.Attribute[106254] = {"精神|1"}
ImageTable.Attribute[106255] = {"防御|1"}
ImageTable.Attribute[106256] = {"攻击|1"}
ImageTable.Attribute[106257] = {"敏捷|1"}
ImageTable.Attribute[106258] = {"生命|2"}
ImageTable.Attribute[106259] = {"恢复|1"}
ImageTable.Attribute[106260] = {"精神|1"}
ImageTable.Attribute[106261] = {"防御|1"}
ImageTable.Attribute[106262] = {"攻击|1"}
ImageTable.Attribute[106263] = {"敏捷|1"}
ImageTable.Attribute[106264] = {"生命|2"}
ImageTable.Attribute[106265] = {"恢复|1"}
ImageTable.Attribute[106266] = {"精神|1"}
ImageTable.Attribute[106267] = {"防御|1"}
ImageTable.Attribute[106268] = {"攻击|1"}
ImageTable.Attribute[106269] = {"敏捷|1"}
ImageTable.Attribute[106270] = {"生命|2"}
ImageTable.Attribute[106271] = {"恢复|1"}
ImageTable.Attribute[106272] = {"精神|1"}
ImageTable.Attribute[106273] = {"防御|1"}
ImageTable.Attribute[106275] = {"攻击|1"}
ImageTable.Attribute[106276] = {"敏捷|1"}
ImageTable.Attribute[106277] = {"生命|2"}
ImageTable.Attribute[106278] = {"恢复|1"}
ImageTable.Attribute[106279] = {"精神|1"}
ImageTable.Attribute[106280] = {"防御|1"}
ImageTable.Attribute[106281] = {"攻击|1"}
ImageTable.Attribute[106282] = {"敏捷|1"}
ImageTable.Attribute[106283] = {"生命|2"}
ImageTable.Attribute[106284] = {"恢复|1"}
ImageTable.Attribute[106285] = {"精神|1"}
ImageTable.Attribute[106286] = {"防御|1"}
ImageTable.Attribute[106287] = {"攻击|1"}
ImageTable.Attribute[106288] = {"敏捷|1"}
ImageTable.Attribute[106289] = {"生命|2"}
ImageTable.Attribute[106290] = {"恢复|1"}
ImageTable.Attribute[106291] = {"精神|1"}
ImageTable.Attribute[106292] = {"防御|1"}
ImageTable.Attribute[106293] = {"攻击|1"}
ImageTable.Attribute[106294] = {"敏捷|1"}
ImageTable.Attribute[106295] = {"生命|2"}
ImageTable.Attribute[106296] = {"恢复|1"}
ImageTable.Attribute[106297] = {"精神|1"}
ImageTable.Attribute[106298] = {"防御|1"}
ImageTable.Attribute[106300] = {"攻击|1"}
ImageTable.Attribute[106301] = {"敏捷|1"}
ImageTable.Attribute[106302] = {"生命|2"}
ImageTable.Attribute[106303] = {"恢复|1"}
ImageTable.Attribute[106304] = {"精神|1"}
ImageTable.Attribute[106305] = {"防御|1"}
ImageTable.Attribute[106306] = {"攻击|1"}
ImageTable.Attribute[106307] = {"敏捷|1"}
ImageTable.Attribute[106308] = {"生命|2"}
ImageTable.Attribute[106309] = {"恢复|1"}
ImageTable.Attribute[106310] = {"精神|1"}
ImageTable.Attribute[106311] = {"防御|1"}
ImageTable.Attribute[106312] = {"攻击|1"}
ImageTable.Attribute[106313] = {"敏捷|1"}
ImageTable.Attribute[106314] = {"生命|2"}
ImageTable.Attribute[106315] = {"恢复|1"}
ImageTable.Attribute[106316] = {"精神|1"}
ImageTable.Attribute[106317] = {"防御|1"}
ImageTable.Attribute[106318] = {"攻击|1"}
ImageTable.Attribute[106319] = {"敏捷|1"}
ImageTable.Attribute[106320] = {"生命|2"}
ImageTable.Attribute[106321] = {"恢复|1"}
ImageTable.Attribute[106322] = {"精神|1"}
ImageTable.Attribute[106323] = {"防御|1"}
ImageTable.Attribute[106325] = {"攻击|1"}
ImageTable.Attribute[106326] = {"敏捷|1"}
ImageTable.Attribute[106327] = {"生命|2"}
ImageTable.Attribute[106328] = {"恢复|1"}
ImageTable.Attribute[106329] = {"精神|1"}
ImageTable.Attribute[106330] = {"防御|1"}
ImageTable.Attribute[106331] = {"攻击|1"}
ImageTable.Attribute[106332] = {"敏捷|1"}
ImageTable.Attribute[106333] = {"生命|2"}
ImageTable.Attribute[106334] = {"恢复|1"}
ImageTable.Attribute[106335] = {"精神|1"}
ImageTable.Attribute[106336] = {"防御|1"}
ImageTable.Attribute[106337] = {"攻击|1"}
ImageTable.Attribute[106338] = {"敏捷|1"}
ImageTable.Attribute[106339] = {"生命|2"}
ImageTable.Attribute[106340] = {"恢复|1"}
ImageTable.Attribute[106341] = {"精神|1"}
ImageTable.Attribute[106342] = {"防御|1"}
ImageTable.Attribute[106343] = {"攻击|1"}
ImageTable.Attribute[106344] = {"敏捷|1"}
ImageTable.Attribute[106345] = {"生命|2"}
ImageTable.Attribute[106346] = {"恢复|1"}
ImageTable.Attribute[106347] = {"精神|1"}
ImageTable.Attribute[106348] = {"防御|1"}
ImageTable.Attribute[106350] = {"攻击|1"}
ImageTable.Attribute[106351] = {"敏捷|1"}
ImageTable.Attribute[106352] = {"生命|2"}
ImageTable.Attribute[106353] = {"恢复|1"}
ImageTable.Attribute[106354] = {"精神|1"}
ImageTable.Attribute[106355] = {"防御|1"}
ImageTable.Attribute[106356] = {"攻击|1"}
ImageTable.Attribute[106357] = {"敏捷|1"}
ImageTable.Attribute[106358] = {"生命|2"}
ImageTable.Attribute[106359] = {"恢复|1"}
ImageTable.Attribute[106360] = {"精神|1"}
ImageTable.Attribute[106361] = {"防御|1"}
ImageTable.Attribute[106362] = {"攻击|1"}
ImageTable.Attribute[106363] = {"敏捷|1"}
ImageTable.Attribute[106364] = {"生命|2"}
ImageTable.Attribute[106365] = {"恢复|1"}
ImageTable.Attribute[106366] = {"精神|1"}
ImageTable.Attribute[106367] = {"防御|1"}
ImageTable.Attribute[106368] = {"攻击|1"}
ImageTable.Attribute[106369] = {"敏捷|1"}
ImageTable.Attribute[106370] = {"生命|2"}
ImageTable.Attribute[106371] = {"恢复|1"}
ImageTable.Attribute[106372] = {"精神|1"}
ImageTable.Attribute[106373] = {"防御|1"}
ImageTable.Attribute[106375] = {"攻击|1"}
ImageTable.Attribute[106376] = {"敏捷|1"}
ImageTable.Attribute[106377] = {"生命|2"}
ImageTable.Attribute[106378] = {"恢复|1"}
ImageTable.Attribute[106379] = {"精神|1"}
ImageTable.Attribute[106380] = {"防御|1"}
ImageTable.Attribute[106381] = {"攻击|1"}
ImageTable.Attribute[106382] = {"敏捷|1"}
ImageTable.Attribute[106383] = {"生命|2"}
ImageTable.Attribute[106384] = {"恢复|1"}
ImageTable.Attribute[106385] = {"精神|1"}
ImageTable.Attribute[106386] = {"防御|1"}
ImageTable.Attribute[106387] = {"攻击|1"}
ImageTable.Attribute[106388] = {"敏捷|1"}
ImageTable.Attribute[106389] = {"生命|2"}
ImageTable.Attribute[106390] = {"恢复|1"}
ImageTable.Attribute[106391] = {"精神|1"}
ImageTable.Attribute[106392] = {"防御|1"}
ImageTable.Attribute[106393] = {"攻击|1"}
ImageTable.Attribute[106394] = {"敏捷|1"}
ImageTable.Attribute[106395] = {"生命|2"}
ImageTable.Attribute[106396] = {"恢复|1"}
ImageTable.Attribute[106397] = {"精神|1"}
ImageTable.Attribute[106398] = {"防御|1"}
ImageTable.Attribute[106400] = {"攻击|1"}
ImageTable.Attribute[106401] = {"敏捷|1"}
ImageTable.Attribute[106402] = {"生命|2"}
ImageTable.Attribute[106403] = {"恢复|1"}
ImageTable.Attribute[106404] = {"精神|1"}
ImageTable.Attribute[106405] = {"防御|1"}
ImageTable.Attribute[106406] = {"攻击|1"}
ImageTable.Attribute[106407] = {"敏捷|1"}
ImageTable.Attribute[106408] = {"生命|2"}
ImageTable.Attribute[106409] = {"恢复|1"}
ImageTable.Attribute[106410] = {"精神|1"}
ImageTable.Attribute[106411] = {"防御|1"}
ImageTable.Attribute[106412] = {"攻击|1"}
ImageTable.Attribute[106413] = {"敏捷|1"}
ImageTable.Attribute[106414] = {"生命|2"}
ImageTable.Attribute[106415] = {"恢复|1"}
ImageTable.Attribute[106416] = {"精神|1"}
ImageTable.Attribute[106417] = {"防御|1"}
ImageTable.Attribute[106418] = {"攻击|1"}
ImageTable.Attribute[106419] = {"敏捷|1"}
ImageTable.Attribute[106420] = {"生命|2"}
ImageTable.Attribute[106421] = {"恢复|1"}
ImageTable.Attribute[106422] = {"精神|1"}
ImageTable.Attribute[106423] = {"防御|1"}
ImageTable.Attribute[100525] = {"攻击|2"}
ImageTable.Attribute[100526] = {"敏捷|2"}
ImageTable.Attribute[100527] = {"生命|4"}
ImageTable.Attribute[100528] = {"恢复|2"}
ImageTable.Attribute[100529] = {"精神|2"}
ImageTable.Attribute[100530] = {"防御|2"}
ImageTable.Attribute[100550] = {"攻击|2"}
ImageTable.Attribute[100551] = {"敏捷|2"}
ImageTable.Attribute[100552] = {"生命|4"}
ImageTable.Attribute[100553] = {"恢复|2"}
ImageTable.Attribute[100554] = {"精神|2"}
ImageTable.Attribute[100555] = {"防御|2"}
ImageTable.Attribute[100575] = {"攻击|2"}
ImageTable.Attribute[100576] = {"敏捷|2"}
ImageTable.Attribute[100577] = {"生命|4"}
ImageTable.Attribute[100578] = {"恢复|2"}
ImageTable.Attribute[100579] = {"精神|2"}
ImageTable.Attribute[100580] = {"防御|2"}
ImageTable.Attribute[100600] = {"攻击|2"}
ImageTable.Attribute[100601] = {"敏捷|2"}
ImageTable.Attribute[100602] = {"生命|4"}
ImageTable.Attribute[100603] = {"恢复|2"}
ImageTable.Attribute[100604] = {"精神|2"}
ImageTable.Attribute[100605] = {"防御|2"}
ImageTable.Attribute[100625] = {"攻击|2"}
ImageTable.Attribute[100626] = {"敏捷|2"}
ImageTable.Attribute[100627] = {"生命|4"}
ImageTable.Attribute[100628] = {"恢复|2"}
ImageTable.Attribute[100629] = {"精神|2"}
ImageTable.Attribute[100630] = {"防御|2"}
ImageTable.Attribute[100650] = {"攻击|2"}
ImageTable.Attribute[100651] = {"敏捷|2"}
ImageTable.Attribute[100652] = {"生命|4"}
ImageTable.Attribute[100653] = {"恢复|2"}
ImageTable.Attribute[100654] = {"精神|2"}
ImageTable.Attribute[100655] = {"防御|2"}
ImageTable.Attribute[100675] = {"攻击|2"}
ImageTable.Attribute[100676] = {"敏捷|2"}
ImageTable.Attribute[100677] = {"生命|4"}
ImageTable.Attribute[100678] = {"恢复|2"}
ImageTable.Attribute[100679] = {"精神|2"}
ImageTable.Attribute[100680] = {"防御|2"}
ImageTable.Attribute[100700] = {"攻击|2"}
ImageTable.Attribute[100701] = {"敏捷|2"}
ImageTable.Attribute[100702] = {"生命|4"}
ImageTable.Attribute[100703] = {"恢复|2"}
ImageTable.Attribute[100704] = {"精神|2"}
ImageTable.Attribute[100705] = {"防御|2"}
ImageTable.Attribute[100725] = {"攻击|2"}
ImageTable.Attribute[100726] = {"敏捷|2"}
ImageTable.Attribute[100727] = {"生命|4"}
ImageTable.Attribute[100728] = {"恢复|2"}
ImageTable.Attribute[100729] = {"精神|2"}
ImageTable.Attribute[100730] = {"防御|2"}
ImageTable.Attribute[100750] = {"攻击|2"}
ImageTable.Attribute[100751] = {"敏捷|2"}
ImageTable.Attribute[100752] = {"生命|4"}
ImageTable.Attribute[100753] = {"恢复|2"}
ImageTable.Attribute[100754] = {"精神|2"}
ImageTable.Attribute[100755] = {"防御|2"}
ImageTable.Attribute[100800] = {"攻击|2"}
ImageTable.Attribute[100801] = {"敏捷|2"}
ImageTable.Attribute[100802] = {"生命|4"}
ImageTable.Attribute[100803] = {"恢复|2"}
ImageTable.Attribute[100804] = {"精神|2"}
ImageTable.Attribute[100805] = {"防御|2"}
ImageTable.Attribute[100888] = {"攻击|2"}
ImageTable.Attribute[100889] = {"敏捷|2"}
ImageTable.Attribute[100890] = {"生命|4"}
ImageTable.Attribute[100891] = {"恢复|2"}
ImageTable.Attribute[100892] = {"精神|2"}
ImageTable.Attribute[100893] = {"防御|2"}
ImageTable.Attribute[100915] = {"攻击|2"}
ImageTable.Attribute[100916] = {"敏捷|2"}
ImageTable.Attribute[100917] = {"生命|4"}
ImageTable.Attribute[100918] = {"恢复|2"}
ImageTable.Attribute[100919] = {"精神|2"}
ImageTable.Attribute[100920] = {"防御|2"}
ImageTable.Attribute[100942] = {"攻击|2"}
ImageTable.Attribute[100943] = {"敏捷|2"}
ImageTable.Attribute[100944] = {"生命|4"}
ImageTable.Attribute[100945] = {"恢复|2"}
ImageTable.Attribute[100946] = {"精神|2"}
ImageTable.Attribute[100947] = {"防御|2"}
ImageTable.Attribute[100966] = {"攻击|2"}
ImageTable.Attribute[100967] = {"敏捷|2"}
ImageTable.Attribute[100968] = {"生命|4"}
ImageTable.Attribute[100969] = {"恢复|2"}
ImageTable.Attribute[100970] = {"精神|2"}
ImageTable.Attribute[100971] = {"防御|2"}
ImageTable.Attribute[100175] = {"攻击|2"}
ImageTable.Attribute[100176] = {"敏捷|2"}
ImageTable.Attribute[100177] = {"生命|4"}
ImageTable.Attribute[100178] = {"恢复|2"}
ImageTable.Attribute[100179] = {"精神|2"}
ImageTable.Attribute[100180] = {"防御|2"}
ImageTable.Attribute[100181] = {"攻击|2"}
ImageTable.Attribute[100182] = {"敏捷|2"}
ImageTable.Attribute[100183] = {"生命|4"}
ImageTable.Attribute[100184] = {"恢复|2"}
ImageTable.Attribute[100185] = {"精神|2"}
ImageTable.Attribute[100186] = {"防御|2"}
ImageTable.Attribute[100187] = {"攻击|2"}
ImageTable.Attribute[100188] = {"敏捷|2"}
ImageTable.Attribute[100189] = {"生命|4"}
ImageTable.Attribute[100190] = {"恢复|2"}
ImageTable.Attribute[100191] = {"精神|2"}
ImageTable.Attribute[100192] = {"防御|2"}
ImageTable.Attribute[100193] = {"攻击|2"}
ImageTable.Attribute[100194] = {"敏捷|2"}
ImageTable.Attribute[100195] = {"生命|4"}
ImageTable.Attribute[100196] = {"恢复|2"}
ImageTable.Attribute[100197] = {"精神|2"}
ImageTable.Attribute[100198] = {"防御|2"}
ImageTable.Attribute[100206] = {"攻击|2"}
ImageTable.Attribute[100207] = {"敏捷|2"}
ImageTable.Attribute[100208] = {"生命|4"}
ImageTable.Attribute[100209] = {"恢复|2"}
ImageTable.Attribute[100210] = {"精神|2"}
ImageTable.Attribute[100211] = {"防御|2"}
ImageTable.Attribute[100212] = {"攻击|2"}
ImageTable.Attribute[100213] = {"敏捷|2"}
ImageTable.Attribute[100214] = {"生命|4"}
ImageTable.Attribute[100215] = {"恢复|2"}
ImageTable.Attribute[100216] = {"精神|2"}
ImageTable.Attribute[100217] = {"防御|2"}
ImageTable.Attribute[105706] = {"攻击|2"}
ImageTable.Attribute[105707] = {"敏捷|2"}
ImageTable.Attribute[105708] = {"生命|4"}
ImageTable.Attribute[105709] = {"恢复|2"}
ImageTable.Attribute[105710] = {"精神|2"}
ImageTable.Attribute[105711] = {"防御|2"}
ImageTable.Attribute[105737] = {"攻击|2"}
ImageTable.Attribute[105738] = {"敏捷|2"}
ImageTable.Attribute[105739] = {"生命|4"}
ImageTable.Attribute[105740] = {"恢复|2"}
ImageTable.Attribute[105741] = {"精神|2"}
ImageTable.Attribute[105742] = {"防御|2"}
ImageTable.Attribute[105742] = {"攻击|2"}
ImageTable.Attribute[105743] = {"敏捷|2"}
ImageTable.Attribute[105744] = {"生命|4"}
ImageTable.Attribute[105745] = {"恢复|2"}
ImageTable.Attribute[105746] = {"精神|2"}
ImageTable.Attribute[105747] = {"防御|2"}
ImageTable.Attribute[105748] = {"攻击|2"}
ImageTable.Attribute[105749] = {"敏捷|2"}
ImageTable.Attribute[105750] = {"生命|4"}
ImageTable.Attribute[105751] = {"恢复|2"}
ImageTable.Attribute[105752] = {"精神|2"}
ImageTable.Attribute[105753] = {"防御|2"}
ImageTable.Attribute[105610] = {"攻击|3"}
ImageTable.Attribute[105611] = {"敏捷|3"}
ImageTable.Attribute[105612] = {"生命|6"}
ImageTable.Attribute[105613] = {"恢复|3"}
ImageTable.Attribute[105614] = {"精神|3"}
ImageTable.Attribute[105615] = {"防御|3"}
ImageTable.Attribute[105616] = {"攻击|3"}
ImageTable.Attribute[105617] = {"敏捷|3"}
ImageTable.Attribute[105618] = {"生命|6"}
ImageTable.Attribute[105619] = {"恢复|3"}
ImageTable.Attribute[105620] = {"精神|3"}
ImageTable.Attribute[105621] = {"防御|3"}
ImageTable.Attribute[105622] = {"攻击|3"}
ImageTable.Attribute[105623] = {"敏捷|3"}
ImageTable.Attribute[105624] = {"生命|6"}
ImageTable.Attribute[105625] = {"恢复|3"}
ImageTable.Attribute[105626] = {"精神|3"}
ImageTable.Attribute[105627] = {"防御|3"}
ImageTable.Attribute[105628] = {"攻击|3"}
ImageTable.Attribute[105629] = {"敏捷|3"}
ImageTable.Attribute[105630] = {"生命|6"}
ImageTable.Attribute[105631] = {"恢复|3"}
ImageTable.Attribute[105632] = {"精神|3"}
ImageTable.Attribute[105633] = {"防御|3"}
ImageTable.Attribute[105634] = {"攻击|3"}
ImageTable.Attribute[105635] = {"敏捷|3"}
ImageTable.Attribute[105636] = {"生命|6"}
ImageTable.Attribute[105637] = {"恢复|3"}
ImageTable.Attribute[105638] = {"精神|3"}
ImageTable.Attribute[105639] = {"防御|3"}
ImageTable.Attribute[105640] = {"攻击|3"}
ImageTable.Attribute[105641] = {"敏捷|3"}
ImageTable.Attribute[105642] = {"生命|6"}
ImageTable.Attribute[105643] = {"恢复|3"}
ImageTable.Attribute[105644] = {"精神|3"}
ImageTable.Attribute[105645] = {"防御|3"}
ImageTable.Attribute[105646] = {"攻击|3"}
ImageTable.Attribute[105647] = {"敏捷|3"}
ImageTable.Attribute[105648] = {"生命|6"}
ImageTable.Attribute[105649] = {"恢复|3"}
ImageTable.Attribute[105650] = {"精神|3"}
ImageTable.Attribute[105651] = {"防御|3"}
ImageTable.Attribute[105652] = {"攻击|3"}
ImageTable.Attribute[105653] = {"敏捷|3"}
ImageTable.Attribute[105654] = {"生命|6"}
ImageTable.Attribute[105655] = {"恢复|3"}
ImageTable.Attribute[105656] = {"精神|3"}
ImageTable.Attribute[105657] = {"防御|3"}
ImageTable.Attribute[105658] = {"攻击|3"}
ImageTable.Attribute[105659] = {"敏捷|3"}
ImageTable.Attribute[105660] = {"生命|6"}
ImageTable.Attribute[105661] = {"恢复|3"}
ImageTable.Attribute[105662] = {"精神|3"}
ImageTable.Attribute[105663] = {"防御|3"}
ImageTable.Attribute[105664] = {"攻击|3"}
ImageTable.Attribute[105665] = {"敏捷|3"}
ImageTable.Attribute[105666] = {"生命|6"}
ImageTable.Attribute[105667] = {"恢复|3"}
ImageTable.Attribute[105668] = {"精神|3"}
ImageTable.Attribute[105669] = {"防御|3"}
ImageTable.Attribute[100425] = {"攻击|3"}
ImageTable.Attribute[100426] = {"敏捷|3"}
ImageTable.Attribute[100427] = {"生命|6"}
ImageTable.Attribute[100428] = {"恢复|3"}
ImageTable.Attribute[100429] = {"精神|3"}
ImageTable.Attribute[100430] = {"防御|3"}
ImageTable.Attribute[100450] = {"攻击|3"}
ImageTable.Attribute[100451] = {"敏捷|3"}
ImageTable.Attribute[100452] = {"生命|6"}
ImageTable.Attribute[100453] = {"恢复|3"}
ImageTable.Attribute[100454] = {"精神|3"}
ImageTable.Attribute[100455] = {"防御|3"}
ImageTable.Attribute[100475] = {"攻击|3"}
ImageTable.Attribute[100476] = {"敏捷|3"}
ImageTable.Attribute[100477] = {"生命|6"}
ImageTable.Attribute[100478] = {"恢复|3"}
ImageTable.Attribute[100479] = {"精神|3"}
ImageTable.Attribute[100480] = {"防御|3"}
ImageTable.Attribute[100500] = {"攻击|3"}
ImageTable.Attribute[100501] = {"敏捷|3"}
ImageTable.Attribute[100502] = {"生命|6"}
ImageTable.Attribute[100503] = {"恢复|3"}
ImageTable.Attribute[100504] = {"精神|3"}
ImageTable.Attribute[100505] = {"防御|3"}
ImageTable.Attribute[100972] = {"攻击|3"}
ImageTable.Attribute[100973] = {"敏捷|3"}
ImageTable.Attribute[100974] = {"生命|6"}
ImageTable.Attribute[100975] = {"恢复|3"}
ImageTable.Attribute[100976] = {"精神|3"}
ImageTable.Attribute[100977] = {"防御|3"}
ImageTable.Attribute[100978] = {"攻击|3"}
ImageTable.Attribute[100979] = {"敏捷|3"}
ImageTable.Attribute[100980] = {"生命|6"}
ImageTable.Attribute[100981] = {"恢复|3"}
ImageTable.Attribute[100982] = {"精神|3"}
ImageTable.Attribute[100983] = {"防御|3"}
ImageTable.Attribute[100984] = {"攻击|3"}
ImageTable.Attribute[100985] = {"敏捷|3"}
ImageTable.Attribute[100986] = {"生命|6"}
ImageTable.Attribute[100987] = {"恢复|3"}
ImageTable.Attribute[100988] = {"精神|3"}
ImageTable.Attribute[100989] = {"防御|3"}
ImageTable.Attribute[100990] = {"攻击|3"}
ImageTable.Attribute[100991] = {"敏捷|3"}
ImageTable.Attribute[100992] = {"生命|6"}
ImageTable.Attribute[100993] = {"恢复|3"}
ImageTable.Attribute[100994] = {"精神|3"}
ImageTable.Attribute[100995] = {"防御|3"}
ImageTable.Attribute[105700] = {"攻击|3"}
ImageTable.Attribute[105701] = {"敏捷|3"}
ImageTable.Attribute[105702] = {"生命|6"}
ImageTable.Attribute[105703] = {"恢复|3"}
ImageTable.Attribute[105704] = {"精神|3"}
ImageTable.Attribute[105705] = {"防御|3"}
ImageTable.Attribute[105712] = {"攻击|3"}
ImageTable.Attribute[105713] = {"敏捷|3"}
ImageTable.Attribute[105714] = {"生命|6"}
ImageTable.Attribute[105715] = {"恢复|3"}
ImageTable.Attribute[105716] = {"精神|3"}
ImageTable.Attribute[105717] = {"防御|3"}

ImageTable.Attribute[100656] = {"攻击|2"}
ImageTable.Attribute[100657] = {"敏捷|2"}
ImageTable.Attribute[100658] = {"生命|4"}
ImageTable.Attribute[100659] = {"恢复|2"}
ImageTable.Attribute[100660] = {"精神|2"}
ImageTable.Attribute[100661] = {"防御|2"}

ImageTable.Attribute[100882] = {"攻击|2"}
ImageTable.Attribute[100883] = {"敏捷|2"}
ImageTable.Attribute[100884] = {"生命|4"}
ImageTable.Attribute[100885] = {"恢复|2"}
ImageTable.Attribute[100886] = {"精神|2"}
ImageTable.Attribute[100887] = {"防御|2"}

ImageTable.Attribute[100903] = {"攻击|2"}
ImageTable.Attribute[100904] = {"敏捷|2"}
ImageTable.Attribute[100905] = {"生命|4"}
ImageTable.Attribute[100906] = {"恢复|2"}
ImageTable.Attribute[100907] = {"精神|2"}
ImageTable.Attribute[100908] = {"防御|2"}

ImageTable.Attribute[100909] = {"攻击|2"}
ImageTable.Attribute[100910] = {"敏捷|2"}
ImageTable.Attribute[100911] = {"生命|4"}
ImageTable.Attribute[100912] = {"恢复|2"}
ImageTable.Attribute[100913] = {"精神|2"}
ImageTable.Attribute[100914] = {"防御|2"}

ImageTable.Attribute[100924] = {"攻击|2"}
ImageTable.Attribute[100925] = {"敏捷|2"}
ImageTable.Attribute[100926] = {"生命|4"}
ImageTable.Attribute[100927] = {"恢复|2"}
ImageTable.Attribute[100928] = {"精神|2"}
ImageTable.Attribute[100929] = {"防御|2"}
ImageTable.Attribute[100930] = {"攻击|2"}
ImageTable.Attribute[100931] = {"敏捷|2"}
ImageTable.Attribute[100932] = {"生命|4"}
ImageTable.Attribute[100933] = {"恢复|2"}
ImageTable.Attribute[100934] = {"精神|2"}
ImageTable.Attribute[100935] = {"防御|2"}
ImageTable.Attribute[100954] = {"攻击|2"}
ImageTable.Attribute[100955] = {"敏捷|2"}
ImageTable.Attribute[100956] = {"生命|4"}
ImageTable.Attribute[100957] = {"恢复|2"}
ImageTable.Attribute[100958] = {"精神|2"}
ImageTable.Attribute[100959] = {"防御|2"}
ImageTable.Attribute[105676] = {"攻击|2"}
ImageTable.Attribute[105677] = {"敏捷|2"}
ImageTable.Attribute[105678] = {"生命|4"}
ImageTable.Attribute[105679] = {"恢复|2"}
ImageTable.Attribute[105680] = {"精神|2"}
ImageTable.Attribute[105681] = {"防御|2"}
ImageTable.Attribute[105682] = {"攻击|2"}
ImageTable.Attribute[105683] = {"敏捷|2"}
ImageTable.Attribute[105684] = {"生命|4"}
ImageTable.Attribute[105685] = {"恢复|2"}
ImageTable.Attribute[105686] = {"精神|2"}
ImageTable.Attribute[105687] = {"防御|2"}
ImageTable.Attribute[105688] = {"攻击|2"}
ImageTable.Attribute[105689] = {"敏捷|2"}
ImageTable.Attribute[105690] = {"生命|4"}
ImageTable.Attribute[105691] = {"恢复|2"}
ImageTable.Attribute[105692] = {"精神|2"}
ImageTable.Attribute[105693] = {"防御|2"}
ImageTable.Attribute[105725] = {"攻击|2"}
ImageTable.Attribute[105726] = {"敏捷|2"}
ImageTable.Attribute[105727] = {"生命|4"}
ImageTable.Attribute[105728] = {"恢复|2"}
ImageTable.Attribute[105729] = {"精神|2"}
ImageTable.Attribute[105730] = {"防御|2"}
ImageTable.Attribute[105731] = {"攻击|2"}
ImageTable.Attribute[105732] = {"敏捷|2"}
ImageTable.Attribute[105733] = {"生命|4"}
ImageTable.Attribute[105734] = {"恢复|2"}
ImageTable.Attribute[105735] = {"精神|2"}
ImageTable.Attribute[105736] = {"防御|2"}
ImageTable.Attribute[105818] = {"攻击|2"}
ImageTable.Attribute[105819] = {"敏捷|2"}
ImageTable.Attribute[105820] = {"生命|4"}
ImageTable.Attribute[105821] = {"恢复|2"}
ImageTable.Attribute[105822] = {"精神|2"}
ImageTable.Attribute[105823] = {"防御|2"}
ImageTable.Attribute[105824] = {"攻击|2"}
ImageTable.Attribute[105825] = {"敏捷|2"}
ImageTable.Attribute[105826] = {"生命|4"}
ImageTable.Attribute[105827] = {"恢复|2"}
ImageTable.Attribute[105828] = {"精神|2"}
ImageTable.Attribute[105829] = {"防御|2"}
ImageTable.Attribute[105830] = {"攻击|2"}
ImageTable.Attribute[105831] = {"敏捷|2"}
ImageTable.Attribute[105832] = {"生命|4"}
ImageTable.Attribute[105833] = {"恢复|2"}
ImageTable.Attribute[105834] = {"精神|2"}
ImageTable.Attribute[105835] = {"防御|2"}
ImageTable.Attribute[106756] = {"攻击|2"}
ImageTable.Attribute[106757] = {"敏捷|2"}
ImageTable.Attribute[106758] = {"生命|4"}
ImageTable.Attribute[106759] = {"恢复|2"}
ImageTable.Attribute[106760] = {"精神|2"}
ImageTable.Attribute[106761] = {"防御|2"}
ImageTable.Attribute[106762] = {"攻击|2"}
ImageTable.Attribute[106763] = {"敏捷|2"}
ImageTable.Attribute[106764] = {"生命|4"}
ImageTable.Attribute[106765] = {"恢复|2"}
ImageTable.Attribute[106766] = {"精神|2"}
ImageTable.Attribute[106767] = {"防御|2"}
ImageTable.Attribute[106768] = {"攻击|2"}
ImageTable.Attribute[106769] = {"敏捷|2"}
ImageTable.Attribute[106770] = {"生命|4"}
ImageTable.Attribute[106771] = {"恢复|2"}
ImageTable.Attribute[106772] = {"精神|2"}
ImageTable.Attribute[106773] = {"防御|2"}
ImageTable.Attribute[106775] = {"攻击|2"}
ImageTable.Attribute[106776] = {"敏捷|2"}
ImageTable.Attribute[106777] = {"生命|4"}
ImageTable.Attribute[106778] = {"恢复|2"}
ImageTable.Attribute[106779] = {"精神|2"}
ImageTable.Attribute[106780] = {"防御|2"}
ImageTable.Attribute[105670] = {"攻击|2"}
ImageTable.Attribute[105671] = {"敏捷|2"}
ImageTable.Attribute[105672] = {"生命|4"}
ImageTable.Attribute[105673] = {"恢复|2"}
ImageTable.Attribute[105674] = {"精神|2"}
ImageTable.Attribute[105675] = {"防御|2"}
ImageTable.Attribute[105694] = {"攻击|2"}
ImageTable.Attribute[105695] = {"敏捷|2"}
ImageTable.Attribute[105696] = {"生命|4"}
ImageTable.Attribute[105697] = {"恢复|2"}
ImageTable.Attribute[105698] = {"精神|2"}
ImageTable.Attribute[105699] = {"防御|2"}
ImageTable.Attribute[105718] = {"攻击|2"}
ImageTable.Attribute[105719] = {"敏捷|2"}
ImageTable.Attribute[105720] = {"生命|4"}
ImageTable.Attribute[105721] = {"恢复|2"}
ImageTable.Attribute[105722] = {"精神|2"}
ImageTable.Attribute[105723] = {"防御|2"}
ImageTable.Attribute[105754] = {"攻击|2"}
ImageTable.Attribute[105755] = {"敏捷|2"}
ImageTable.Attribute[105756] = {"生命|4"}
ImageTable.Attribute[105757] = {"恢复|2"}
ImageTable.Attribute[105758] = {"精神|2"}
ImageTable.Attribute[105759] = {"防御|2"}
ImageTable.Attribute[105760] = {"攻击|2"}
ImageTable.Attribute[105761] = {"敏捷|2"}
ImageTable.Attribute[105762] = {"生命|4"}
ImageTable.Attribute[105763] = {"恢复|2"}
ImageTable.Attribute[105764] = {"精神|2"}
ImageTable.Attribute[105765] = {"防御|2"}
ImageTable.Attribute[105784] = {"攻击|2"}
ImageTable.Attribute[105785] = {"敏捷|2"}
ImageTable.Attribute[105786] = {"生命|4"}
ImageTable.Attribute[105787] = {"恢复|2"}
ImageTable.Attribute[105788] = {"精神|2"}
ImageTable.Attribute[105789] = {"防御|2"}
ImageTable.Attribute[105790] = {"攻击|2"}
ImageTable.Attribute[105791] = {"敏捷|2"}
ImageTable.Attribute[105792] = {"生命|4"}
ImageTable.Attribute[105793] = {"恢复|2"}
ImageTable.Attribute[105794] = {"精神|2"}
ImageTable.Attribute[105795] = {"防御|2"}
ImageTable.Attribute[105800] = {"攻击|2"}
ImageTable.Attribute[105801] = {"敏捷|2"}
ImageTable.Attribute[105802] = {"生命|4"}
ImageTable.Attribute[105803] = {"恢复|2"}
ImageTable.Attribute[105804] = {"精神|2"}
ImageTable.Attribute[105805] = {"防御|2"}
ImageTable.Attribute[105806] = {"攻击|2"}
ImageTable.Attribute[105807] = {"敏捷|2"}
ImageTable.Attribute[105808] = {"生命|4"}
ImageTable.Attribute[105809] = {"恢复|2"}
ImageTable.Attribute[105810] = {"精神|2"}
ImageTable.Attribute[105811] = {"防御|2"}
ImageTable.Attribute[119330] = {"攻击|2"}
ImageTable.Attribute[119331] = {"敏捷|2"}
ImageTable.Attribute[119332] = {"生命|4"}
ImageTable.Attribute[119333] = {"恢复|2"}
ImageTable.Attribute[119334] = {"精神|2"}
ImageTable.Attribute[119335] = {"防御|2"}
ImageTable.Attribute[106500] = {"攻击|2"}
ImageTable.Attribute[106501] = {"敏捷|2"}
ImageTable.Attribute[106502] = {"生命|4"}
ImageTable.Attribute[106503] = {"恢复|2"}
ImageTable.Attribute[106504] = {"精神|2"}
ImageTable.Attribute[106505] = {"防御|2"}
ImageTable.Attribute[106550] = {"攻击|2"}
ImageTable.Attribute[106551] = {"敏捷|2"}
ImageTable.Attribute[106552] = {"生命|4"}
ImageTable.Attribute[106553] = {"恢复|2"}
ImageTable.Attribute[106554] = {"精神|2"}
ImageTable.Attribute[106555] = {"防御|2"}
ImageTable.Attribute[106600] = {"攻击|2"}
ImageTable.Attribute[106601] = {"敏捷|2"}
ImageTable.Attribute[106602] = {"生命|4"}
ImageTable.Attribute[106603] = {"恢复|2"}
ImageTable.Attribute[106604] = {"精神|2"}
ImageTable.Attribute[106605] = {"防御|2"}
ImageTable.Attribute[106625] = {"攻击|2"}
ImageTable.Attribute[106626] = {"敏捷|2"}
ImageTable.Attribute[106627] = {"生命|4"}
ImageTable.Attribute[106628] = {"恢复|2"}
ImageTable.Attribute[106629] = {"精神|2"}
ImageTable.Attribute[106630] = {"防御|2"}
ImageTable.Attribute[106650] = {"攻击|2"}
ImageTable.Attribute[106651] = {"敏捷|2"}
ImageTable.Attribute[106652] = {"生命|4"}
ImageTable.Attribute[106653] = {"恢复|2"}
ImageTable.Attribute[106654] = {"精神|2"}
ImageTable.Attribute[106655] = {"防御|2"}
ImageTable.Attribute[106675] = {"攻击|2"}
ImageTable.Attribute[106676] = {"敏捷|2"}
ImageTable.Attribute[106677] = {"生命|4"}
ImageTable.Attribute[106678] = {"恢复|2"}
ImageTable.Attribute[106679] = {"精神|2"}
ImageTable.Attribute[106680] = {"防御|2"}
ImageTable.Attribute[106725] = {"攻击|2"}
ImageTable.Attribute[106726] = {"敏捷|2"}
ImageTable.Attribute[106727] = {"生命|4"}
ImageTable.Attribute[106728] = {"恢复|2"}
ImageTable.Attribute[106729] = {"精神|2"}
ImageTable.Attribute[106730] = {"防御|2"}

ImageTable.Attribute[100200] = {"攻击|2"}
ImageTable.Attribute[100201] = {"敏捷|2"}
ImageTable.Attribute[100202] = {"生命|4"}
ImageTable.Attribute[100203] = {"恢复|2"}
ImageTable.Attribute[100204] = {"精神|2"}
ImageTable.Attribute[100205] = {"防御|2"}

ImageTable.Attribute[119300] = {"攻击|2"}
ImageTable.Attribute[119301] = {"敏捷|2"}
ImageTable.Attribute[119302] = {"生命|4"}
ImageTable.Attribute[119303] = {"恢复|2"}
ImageTable.Attribute[119304] = {"精神|2"}
ImageTable.Attribute[119305] = {"防御|2"}






