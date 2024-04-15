local WelcomeMessage = {};--欢迎词
table.insert(WelcomeMessage,"bbs.ml30.com");

Delegate.RegDelLoginEvent("Welcome_LoginEvent");

function Welcome_LoginEvent(player)
	if (WelcomeMessage ~= nil) then --欢迎词
		for _,text in ipairs(WelcomeMessage) do
		      NLG.TalkToCli(player,-1,text,%颜色_黄色%,%字体_小%);
		end
		NLG.TalkToCli(player,-1,"欢迎使用GA免费版windows二建端。GM命令密码[gm gold 1]",%颜色_绿色%,%字体_小%);
		NLG.TalkToCli(player,-1,"当前版本为测试版,商业版请参考bbs.ml30.com",%颜色_黄色%,%字体_小%);
		NLG.SystemMessage(player,"新增界面自动寻路 F3 F4 开启   自动战斗F1 F2 F5");
		NLG.TalkToCli(player,-1,"新增秘境系统block showmj 新增频道看聊天栏调整颜色旁边",%颜色_绿色%,%字体_中%);
	end
	
end