Delegate.RegDelTalkEvent("ng_TalkEvent");
Delegate.RegDelLoginEvent("button_LoginEvent");
Delegate.RegDelLoginEvent("skillset_LoginEvent");
Delegate.RegDelLoginEvent("chibangset_LoginEvent");
Delegate.RegDelLoginEvent("toushi_nilset_LoginEvent");

function skillset_LoginEvent(player)
--tech_原图档&新图档, --为了区分官方 tech尾数后两位 为51开始才生效 比如乾坤 351~399 才支持更改新图档
local skillset = "481_111055&111252,6381_110085&111154,6681_111019&111199,6681_110168&111019,"

	Protocol.SendLuaCustomPacket(player,"diyskill", skillset);

end

function chibangset_LoginEvent(player)
--加载翅膀图档
local chibangset = "119750,119751,"

	Protocol.SendLuaCustomPacket(player,"diychibang", chibangset);

end

function toushi_nilset_LoginEvent(player)
--设置无数据默认偏移-65_-1为默认, -200_119751为单独设置 如果打算新增称号图档 直接后面 偏移_编号
local chibangset = "-65_-1,-200_119751,"

	Protocol.SendLuaCustomPacket(player,"diytoushinil", chibangset);

end


function button_LoginEvent(player)

	Protocol.SendLuaCustomPacket(player,"diy6", "显示隐藏地上的宠物&|组队T人&[TEAM]|宠物算档&[1]|宠物自售&[2]|发送观战代码&[3]|离线挂机&[5]|test&[t3]|test&[t4]|test&[t5]|test&[t6]|在线商城&[shop]|联系客服&[6]|加入QQ群&[7]");

end

function open_url(player,link)
	Protocol.SendLuaCustomPacket(player,"openurl", link);
end

local GuanZhanPlayer = "";
function ng_TalkEvent(player,msg,color,range,size)
	
	if(msg == "/1")then
		local getXiangVar1 = Char.GetData(player,%对象_香步数%);
		local getXiangVar2 = Char.GetData(player,%对象_香上限%);
		if(getXiangVar1 > 0)then
			Char.SetData(player,%对象_香步数%,0);
			Char.SetData(player,%对象_香上限%,0);
			NLG.SystemMessage(player,"步步遇敌已经关闭！");
		else
			Char.SetData(player,%对象_香步数%,999);
			Char.SetData(player,%对象_香上限%,999);
			NLG.SystemMessage(player,"步步遇敌已经开启！");
		end
	end
	
	if(msg == "/2")then
		local getXiangVar1 = Char.GetData(player,%对象_不遇敌开关%);
		if(getXiangVar1 == 1)then
			Char.SetData(player,%对象_不遇敌开关%,0);
			NLG.SystemMessage(player,"不遇敌已经关闭！");
		else
			Char.SetData(player,%对象_不遇敌开关%,1);
			NLG.SystemMessage(player,"不遇敌已经开启！");
		end
	end
	
	if(msg == "/3")then
		--开启高速切图
		Protocol.SendLuaCustomPacket(player,"diyng", "GSQT");
	end

	if(msg == "/4")then
		--开启高速制作
		Protocol.SendLuaCustomPacket(player,"diyng", "GSZZ");
	end
	
	if(msg == "/5")then
		--开启高速采集
		Protocol.SendLuaCustomPacket(player,"diyng", "GSCJ");
	end
	
	if(msg == "/6")then
		--开启高速战斗
		Protocol.SendLuaCustomPacket(player,"diyng", "GSZD");
	end
	
	if(msg == "/hc" or msg == "/HC" )then
		if Char.GetPartyMember(player,0) == player then
			Char.Warp(player,0,1000,240,80);
		else
			NLG.SystemMessage(player,"对不起，只有队长可以使用！");	
		end
	end

	if msg == "/dk" then   ---快捷打卡
		local daka = Char.GetData(player, %对象_打卡%);
		local money = Char.GetData(player,%对象_金币%);
		if daka == 0 and money >= 200 then
			Char.SetData(player,%对象_金币%,money-200);
			Char.FeverStart(player);
			NLG.UpChar(player);
			NLG.SystemMessage(player, "扣除魔币200G。");	
			NLG.SystemMessage(player, "恭喜您打卡成功。");	
			return ;
		end
		if daka == 1 and money >= 200 then
			Char.SetData(player,%对象_金币%,money-200);
			Char.FeverStop(player);
			NLG.UpChar(player);
			NLG.SystemMessage(player, "扣除魔币200G。");
			NLG.SystemMessage(player, "恭喜您关闭打卡成功。");	
			return ;
		end
		if money < 200 then
			NLG.SystemMessage(player, "您的魔币不够，无法使用。");	
			return ;
		end
	end
	
	if msg == "/jd" then  ----鉴定
		local Count = 0
		for ItemSlot = 8,27 do
			local ItemIndex = Char.GetItemIndex(player, ItemSlot)
			local money = Char.GetData(player,%对象_金币%);
			local djdj = Item.GetData(ItemIndex,%道具_等级%);
			local kcmb = djdj*200;
			if Item.GetData(ItemIndex, %道具_已鉴定%)==0 and money >= (djdj*200) then
				Count = Count + 1
				Char.SetData(player,%对象_金币%,money-kcmb);
				Item.SetData(ItemIndex, %道具_已鉴定%, 1)
				NLG.SystemMessage(player,"[系统] 您鉴定的道具等级为"..djdj.."级。扣除魔币"..kcmb.."G");
				NLG.SystemMessage(player,"[系统] 你身上的 " .. Item.GetData(ItemIndex, %道具_鉴前名%) .. "已鉴定为 " .. Item.GetData(ItemIndex, %道具_名字%))
				Item.UpItem(player, ItemSlot);
				NLG.UpChar(player);
				return ;
			end
		end
		if Count==0 then
			NLG.SystemMessage(player,"[系统] 你身上没有需要鉴定的物品【或你的钱不足以鉴定此道具】");
			return;
		end
		return 0
	end
	
	if (msg == "/zl")then ---治疗受伤
		local CdKey = Char.GetData(player,2002);
		local shoushang = Char.GetData(player,%对象_受伤%);
		local money = Char.GetData(player,%对象_金币%);
		for i = 0,4 do 
			local _petindex = Char.GetPet(player,i)
			if _petindex > 0 then 
				Char.SetData(_petindex,%对象_受伤%,0);
				Pet.UpPet(player, _petindex)
			end	
		end	
		if(Char.GetData(player,%对象_受伤%)<1) then
			NLG.SystemMessage(player,"您未受伤。");
			return;
		end
		if(money>=200) and (Char.GetData(player,%对象_受伤%)>0 and Char.GetData(player,%对象_受伤%)<26) then
			Char.SetData(player,%对象_受伤%,shoushang-shoushang);
			Char.SetData(player,%对象_金币%,money-200);
			NLG.UpdateParty(player);
			NLG.UpChar(player);
			NLG.SystemMessage(player,"恭喜你治疗完毕。");
			NLG.SendGraphEvent(player, 45, 0);
			NLG.SystemMessage(player,"扣除200魔币。");
			return;	
		end
		if(money>=400) and (Char.GetData(player,%对象_受伤%)>24 and Char.GetData(player,%对象_受伤%)<51) then
			Char.SetData(player,%对象_受伤%,shoushang-shoushang);
			Char.SetData(player,%对象_金币%,money-400);
			NLG.UpdateParty(player);
			NLG.UpChar(player);
			NLG.SystemMessage(player,"恭喜你治疗完毕。");
			NLG.SendGraphEvent(player, 45, 0);
			NLG.SystemMessage(player,"扣除400魔币。");
			return;	
		end
		if(money>=800) and (Char.GetData(player,%对象_受伤%)>49 and Char.GetData(player,%对象_受伤%)<76) then
			Char.SetData(player,%对象_受伤%,shoushang-shoushang);
			Char.SetData(player,%对象_金币%,money-800);
			NLG.UpdateParty(player);
			NLG.UpChar(player);
			NLG.SystemMessage(player,"恭喜你治疗完毕。");
			NLG.SendGraphEvent(player, 45, 0);
			NLG.SystemMessage(player,"扣除800魔币。");
			return;	
		end
		if(money>=1500) and (Char.GetData(player,%对象_受伤%)>74 and Char.GetData(player,%对象_受伤%)<101) then
			Char.SetData(player,%对象_受伤%,shoushang-shoushang);
			Char.SetData(player,%对象_金币%,money-1500);
			NLG.UpdateParty(player);
			NLG.UpChar(player);
			NLG.SystemMessage(player,"恭喜你治疗完毕。");
			NLG.SendGraphEvent(player, 45, 0);
			NLG.SystemMessage(player,"扣除1500魔币。");
			return;	
		else
			NLG.SystemMessage(player,"对不起！您的魔币不足，治疗价格为【白伤200】【黄伤400】【紫伤800】【红伤1500】！");	
			return;
		end
		return 0
	end
	
	if(msg == "[pay]")then
		NLG.SystemMessage(player,"当前没有开通自助充值,请联系客服！");	
	end
	
	if(msg=="[3]") then 
		local money = Char.GetData(player,%对象_金币%);
		if(money>=100)then
			Char.SetData(player,%对象_金币%,money-100);
			NLG.UpChar(player);

			GuanZhanPlayer = player;
			NLG.SystemMessage(-1,"「"..Char.GetData(player,%对象_名字%).."」开启远程观战模式了。可输入/gz "..GuanZhanPlayer.."观看战斗。");
			NLG.SystemMessage(player,"扣除100魔币。");
			return;	
		else
			NLG.SystemMessage(player,"对不起！您的魔币不足100！");	
		end
	end

	if( check_msg(msg,"/gz ") ) then
		GuanZhanPlayer = tonumber(string.sub(msg,5))
		NLG.WatchBattle(player,GuanZhanPlayer);
	end	
	

	
	if(msg == "[5]")then
		NLG.SetOfflinePlayer(player, 9999999);
	end

	if(msg == "[lxgj]")then
		NLG.SetOfflinePlayer(player, 9999999);
	end

	if msg=="[6]" then
		open_url(player,"http://bbs.ml30.com");
	end
	if msg=="[7]" then
		open_url(player,"http://bbs.ml30.com");
	end
	
	
end
