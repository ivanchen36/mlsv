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


tiaozhuanjuanID = 751751;--每次进入秘境所需道具

tbl_mj = 
{
	[1] = {
		["name"] = "森林秘境",--名字
		["mapid"] = "huayao.bmp",--图片
		["itemdata_1"] = {1002970,27312,27442},--奖励图档
		["itemdatainfo_1"] = {"$6人和宠经验","$6怪物料理*2","$6宠物洗档卷*1"},--奖励名字
		["itemdata_2"] = {1002970,27547,470440},
		["itemdatainfo_2"] = {"$6人和宠经验","$6[宠装]花妖蜜晶石","$6魔能宝石*20"},
		["itemdata_3"] = {1002970,480384},
		["itemdatainfo_3"] = {"$6人和宠经验","$6樱桃布丁宠物蛋"},
		["itemdata_4"] = {1002970,470339},
		["itemdatainfo_4"] = {"$6人和宠经验","$6箭鞘"},
		["itemdata_5"] = {1002970,1001929,27442},
		["itemdatainfo_5"] = {"$6人和宠经验","$6初级彩色羽毛*20","$6宠物洗档卷*5"},
		["itemdata_6"] = {1002970,480668,480630},
		["itemdatainfo_6"] = {"$6人和宠经验","$6宠物重来种子礼包","$6[魂卡]穴熊"},
		["dqcs"] = 1,
		["warp_1"] = {1131,111,31},--传送坐标
		["warp_2"] = {1132,74,246},
		["warp_3"] = {1133,8,16},
		["warp_4"] = {1138,8,16},
		["warp_5"] = {1136,8,28},
		["warp_6"] = {1137,8,28},
	},
	
	[2] = {
		["name"] = "砂石秘境",
		["mapid"] = "shashi.bmp",
		["itemdata_1"] = {1002970,99044,1001929},
		["itemdatainfo_1"] = {"$6人和宠经验","$6[宠技]炎袭玉","$6初级彩色羽毛*10"},
		["itemdata_2"] = {1002970,480664,1001928},
		["itemdatainfo_2"] = {"$6人和宠经验","$6宠物变身卡礼包","$6中级彩色羽毛*5"},
		["itemdata_3"] = {1002970,99699,26537},
		["itemdatainfo_3"] = {"$6人和宠经验","$6冰蓝冰晶的碎片","$6Q零件碎片"},
		["itemdata_4"] = {1002970,98502},
		["itemdatainfo_4"] = {"$6人和宠经验","$6宝石鼠都腿骨"},
		["itemdata_5"] = {1002970,1003173},
		["itemdatainfo_5"] = {"$6人和宠经验","$6魔币箱"},
		["itemdata_6"] = {1002970,99044,480937,480629,480609},
		["itemdatainfo_6"] = {"$6人和宠经验","$6[宠技]森之气功弹","$6骑士六转卷","$6[魂卡]火焰鼠","$6[魂卡]大地鼠"},
		["dqcs"] = 0,
		["warp_1"] = {1141,30,22},
		["warp_2"] = {1144,15,38},
		["warp_3"] = {1142,10,18},
		["warp_4"] = {1125,54,49},
		["warp_5"] = {1123,10,9},
		["warp_6"] = {1149,10,20},
	},
	[3] = {
		["name"] = "火焰秘境",
		["mapid"] = "huoyan.bmp",
		["itemdata_1"] = {470025},
		["itemdatainfo_1"] = {"$6当前没有开放"},
		["itemdata_2"] = {470025},
		["itemdatainfo_2"] = {"$6当前没有开放"},
		["itemdata_3"] = {470025},
		["itemdatainfo_3"] = {"$6当前没有开放"},
		["itemdata_4"] = {470025},
		["itemdatainfo_4"] = {"$6当前没有开放"},
		["itemdata_5"] = {470025},
		["itemdatainfo_5"] = {"$6当前没有开放"},
		["itemdata_6"] = {470025},
		["itemdatainfo_6"] = {"$6当前没有开放"},
		["dqcs"] = 0,
		["warp_1"] = nil,
		["warp_2"] = nil,
		["warp_3"] = nil,
		["warp_4"] = nil,
		["warp_5"] = nil,
		["warp_6"] = nil,
	},
	[4] = {
		["name"] = "寒冰秘境",
		["mapid"] = "hanbing.bmp",
		["itemdata_1"] = {470025},
		["itemdatainfo_1"] = {"$6当前没有开放"},
		["itemdata_2"] = {470025},
		["itemdatainfo_2"] = {"$6当前没有开放"},
		["itemdata_3"] = {470025},
		["itemdatainfo_3"] = {"$6当前没有开放"},
		["itemdata_4"] = {470025},
		["itemdatainfo_4"] = {"$6当前没有开放"},
		["itemdata_5"] = {470025},
		["itemdatainfo_5"] = {"$6当前没有开放"},
		["itemdata_6"] = {470025},
		["itemdatainfo_6"] = {"$6当前没有开放"},
		["dqcs"] = 0,
		["warp_1"] = nil,
		["warp_2"] = nil,
		["warp_3"] = nil,
		["warp_4"] = nil,
		["warp_5"] = nil,
		["warp_6"] = nil,
	},
	[5] = {
		["name"] = "黑暗秘境",
		["mapid"] = "heian.bmp",
		["itemdata_1"] = {470025},
		["itemdatainfo_1"] = {"$6当前没有开放"},
		["itemdata_2"] = {470025},
		["itemdatainfo_2"] = {"$6当前没有开放"},
		["itemdata_3"] = {470025},
		["itemdatainfo_3"] = {"$6当前没有开放"},
		["itemdata_4"] = {470025},
		["itemdatainfo_4"] = {"$6当前没有开放"},
		["itemdata_5"] = {470025},
		["itemdatainfo_5"] = {"$6当前没有开放"},
		["itemdata_6"] = {470025},
		["itemdatainfo_6"] = {"$6当前没有开放"},
		["dqcs"] = 0,
		["warp_1"] = nil,
		["warp_2"] = nil,
		["warp_3"] = nil,
		["warp_4"] = nil,
		["warp_5"] = nil,
		["warp_6"] = nil,
	},
	[6] = {
		["name"] = "星灵秘境",
		["mapid"] = "xingling.bmp",
		["itemdata_1"] = {470025},
		["itemdatainfo_1"] = {"$6当前没有开放"},
		["itemdata_2"] = {470025},
		["itemdatainfo_2"] = {"$6当前没有开放"},
		["itemdata_3"] = {470025},
		["itemdatainfo_3"] = {"$6当前没有开放"},
		["itemdata_4"] = {470025},
		["itemdatainfo_4"] = {"$6当前没有开放"},
		["itemdata_5"] = {470025},
		["itemdatainfo_5"] = {"$6当前没有开放"},
		["itemdata_6"] = {470025},
		["itemdatainfo_6"] = {"$6当前没有开放"},
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
					NLG.SystemMessage(player, "您还未能开启本副本的挑战。")
					return
				end
					
				-- 道具是否足够
				if Char.ItemNum(player,tiaozhuanjuanID) > 0 then
					Char.DelItem(player,tiaozhuanjuanID,1)
				else
					NLG.SystemMessage(player, "您的挑战道具不足。")
					return
				end
				
				Char.DischargeParty(player)
				local warpinfo = tbl_mj[tonumber(sv[2])]["warp_"..sv[3]];
				Char.Warp(player,0,warpinfo[1],warpinfo[2],warpinfo[3]);
				NLG.SystemMessage(player, "已成功进入副本。")
			else
				NLG.SystemMessage(player, "此副本尚未开放。")
			end
      end
end

