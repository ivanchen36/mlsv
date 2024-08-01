function Split3(szFullString, szSeparator)  
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


tiaozhuanjuanID = 751751;--ÿ�ν����ؾ��������

tbl_mj = 
{
	[1] = {
		["name"] = "ɭ���ؾ�",--����
		["mapid"] = "huayao.bmp",--ͼƬ
		["itemdata_1"] = {1002970,27312,27442},--����ͼ��
		["itemdatainfo_1"] = {"$6�˺ͳ辭��","$6��������*2","$6����ϴ����*1"},--��������
		["itemdata_2"] = {1002970,27547,470440},
		["itemdatainfo_2"] = {"$6�˺ͳ辭��","$6[��װ]�����۾�ʯ","$6ħ�ܱ�ʯ*20"},
		["itemdata_3"] = {1002970,480384},
		["itemdatainfo_3"] = {"$6�˺ͳ辭��","$6ӣ�Ҳ������ﵰ"},
		["itemdata_4"] = {1002970,470339},
		["itemdatainfo_4"] = {"$6�˺ͳ辭��","$6����"},
		["itemdata_5"] = {1002970,1001929,27442},
		["itemdatainfo_5"] = {"$6�˺ͳ辭��","$6������ɫ��ë*20","$6����ϴ����*5"},
		["itemdata_6"] = {1002970,480668,480630},
		["itemdatainfo_6"] = {"$6�˺ͳ辭��","$6���������������","$6[�꿨]Ѩ��"},
		["dqcs"] = 1,
		["warp_1"] = {1131,111,31},--��������
		["warp_2"] = {1132,74,246},
		["warp_3"] = {1133,8,16},
		["warp_4"] = {1138,8,16},
		["warp_5"] = {1136,8,28},
		["warp_6"] = {1137,8,28},
	},
	
	[2] = {
		["name"] = "ɰʯ�ؾ�",
		["mapid"] = "shashi.bmp",
		["itemdata_1"] = {1002970,99044,1001929},
		["itemdatainfo_1"] = {"$6�˺ͳ辭��","$6[�輼]��Ϯ��","$6������ɫ��ë*10"},
		["itemdata_2"] = {1002970,480664,1001928},
		["itemdatainfo_2"] = {"$6�˺ͳ辭��","$6����������","$6�м���ɫ��ë*5"},
		["itemdata_3"] = {1002970,99699,26537},
		["itemdatainfo_3"] = {"$6�˺ͳ辭��","$6������������Ƭ","$6Q�����Ƭ"},
		["itemdata_4"] = {1002970,98502},
		["itemdatainfo_4"] = {"$6�˺ͳ辭��","$6��ʯ���ȹ�"},
		["itemdata_5"] = {1002970,1003173},
		["itemdatainfo_5"] = {"$6�˺ͳ辭��","$6ħ����"},
		["itemdata_6"] = {1002970,99044,480937,480629,480609},
		["itemdatainfo_6"] = {"$6�˺ͳ辭��","$6[�輼]ɭ֮������","$6��ʿ��ת��","$6[�꿨]������","$6[�꿨]�����"},
		["dqcs"] = 0,
		["warp_1"] = {1141,30,22},
		["warp_2"] = {1144,15,38},
		["warp_3"] = {1142,10,18},
		["warp_4"] = {1125,54,49},
		["warp_5"] = {1123,10,9},
		["warp_6"] = {1149,10,20},
	},
	[3] = {
		["name"] = "�����ؾ�",
		["mapid"] = "huoyan.bmp",
		["itemdata_1"] = {470025},
		["itemdatainfo_1"] = {"$6��ǰû�п���"},
		["itemdata_2"] = {470025},
		["itemdatainfo_2"] = {"$6��ǰû�п���"},
		["itemdata_3"] = {470025},
		["itemdatainfo_3"] = {"$6��ǰû�п���"},
		["itemdata_4"] = {470025},
		["itemdatainfo_4"] = {"$6��ǰû�п���"},
		["itemdata_5"] = {470025},
		["itemdatainfo_5"] = {"$6��ǰû�п���"},
		["itemdata_6"] = {470025},
		["itemdatainfo_6"] = {"$6��ǰû�п���"},
		["dqcs"] = 0,
		["warp_1"] = nil,
		["warp_2"] = nil,
		["warp_3"] = nil,
		["warp_4"] = nil,
		["warp_5"] = nil,
		["warp_6"] = nil,
	},
	[4] = {
		["name"] = "�����ؾ�",
		["mapid"] = "hanbing.bmp",
		["itemdata_1"] = {470025},
		["itemdatainfo_1"] = {"$6��ǰû�п���"},
		["itemdata_2"] = {470025},
		["itemdatainfo_2"] = {"$6��ǰû�п���"},
		["itemdata_3"] = {470025},
		["itemdatainfo_3"] = {"$6��ǰû�п���"},
		["itemdata_4"] = {470025},
		["itemdatainfo_4"] = {"$6��ǰû�п���"},
		["itemdata_5"] = {470025},
		["itemdatainfo_5"] = {"$6��ǰû�п���"},
		["itemdata_6"] = {470025},
		["itemdatainfo_6"] = {"$6��ǰû�п���"},
		["dqcs"] = 0,
		["warp_1"] = nil,
		["warp_2"] = nil,
		["warp_3"] = nil,
		["warp_4"] = nil,
		["warp_5"] = nil,
		["warp_6"] = nil,
	},
	[5] = {
		["name"] = "�ڰ��ؾ�",
		["mapid"] = "heian.bmp",
		["itemdata_1"] = {470025},
		["itemdatainfo_1"] = {"$6��ǰû�п���"},
		["itemdata_2"] = {470025},
		["itemdatainfo_2"] = {"$6��ǰû�п���"},
		["itemdata_3"] = {470025},
		["itemdatainfo_3"] = {"$6��ǰû�п���"},
		["itemdata_4"] = {470025},
		["itemdatainfo_4"] = {"$6��ǰû�п���"},
		["itemdata_5"] = {470025},
		["itemdatainfo_5"] = {"$6��ǰû�п���"},
		["itemdata_6"] = {470025},
		["itemdatainfo_6"] = {"$6��ǰû�п���"},
		["dqcs"] = 0,
		["warp_1"] = nil,
		["warp_2"] = nil,
		["warp_3"] = nil,
		["warp_4"] = nil,
		["warp_5"] = nil,
		["warp_6"] = nil,
	},
	[6] = {
		["name"] = "�����ؾ�",
		["mapid"] = "xingling.bmp",
		["itemdata_1"] = {470025},
		["itemdatainfo_1"] = {"$6��ǰû�п���"},
		["itemdata_2"] = {470025},
		["itemdatainfo_2"] = {"$6��ǰû�п���"},
		["itemdata_3"] = {470025},
		["itemdatainfo_3"] = {"$6��ǰû�п���"},
		["itemdata_4"] = {470025},
		["itemdatainfo_4"] = {"$6��ǰû�п���"},
		["itemdata_5"] = {470025},
		["itemdatainfo_5"] = {"$6��ǰû�п���"},
		["itemdata_6"] = {470025},
		["itemdatainfo_6"] = {"$6��ǰû�п���"},
		["dqcs"] = 0,
		["warp_1"] = nil,
		["warp_2"] = nil,
		["warp_3"] = nil,
		["warp_4"] = nil,
		["warp_5"] = nil,
		["warp_6"] = nil,
	}
}


function tbl_copy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == "table" then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[tbl_copy(orig_key)] = tbl_copy(orig_value)
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end


Delegate.RegDelTalkEvent("mijingTalkEvent");



function mijingTalkEvent(player,msg,color,range,size)
	

	if(msg == "123mjmj") then 
		local retbl1 = {
			["res"] = Char.ItemNum(player,tiaozhuanjuanID);
		}
		Protocol.PowerSend(player,"MIKING_RET1",retbl1)
		
		local tbl_mj2 = tbl_copy(tbl_mj)
	
		for i=1,#tbl_mj do
			
			local dqcs = Field.Get(player,"MKTZ_"..i);
			
			if tonumber(dqcs) == nil then
				if i == 1 then
					Field.Set(player,"MKTZ_"..i,"1");
				else
					Field.Set(player,"MKTZ_"..i,"0");
				end
				--tbl_mj2[i]["dqcs"] = tonumber(dqcs);
				--NLG.SystemMessage(player, dqcs)
			else
				--NLG.SystemMessage(player, dqcs)
				tbl_mj2[i]["dqcs"] = tonumber(dqcs);
			end
		end
		
		Protocol.PowerSend(player,"MIKING_RET2",tbl_mj2)
	end
	
end

function Event.Recv.mijing(player,packet)
      if string.find(packet,"MJWARP:") then
			
			--NLG.SystemMessage(player, packet)
            local sv = Split3(packet,":")
			if tbl_mj[tonumber(sv[2])]["warp_"..sv[3]] ~= nil then
				
				
				local dqcs = Field.Get(player,"MKTZ_"..sv[2]);
				if tonumber(dqcs) < tonumber(sv[3]) then
					NLG.SystemMessage(player, "����δ�ܿ�������������ս��")
					return
				end
					
				-- �����Ƿ��㹻
				if Char.ItemNum(player,tiaozhuanjuanID) > 0 then
					Char.DelItem(player,tiaozhuanjuanID,1)
				else
					NLG.SystemMessage(player, "������ս���߲��㡣")
					return
				end
				
				Char.DischargeParty(player)
				local warpinfo = tbl_mj[tonumber(sv[2])]["warp_"..sv[3]];
				Char.Warp(player,0,warpinfo[1],warpinfo[2],warpinfo[3]);
				NLG.SystemMessage(player, "�ѳɹ����븱����")
			else
				NLG.SystemMessage(player, "�˸�����δ���š�")
			end
      end
end

