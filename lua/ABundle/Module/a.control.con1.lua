-- 自定义控件 头像选择器
function cc.control.counter(...)
	local arg = {...};
	--Cli.SysMessage(arg[1],6,1)
	local ag_title = arg[1]; -- 取出头像选择器控件名字
	local M = arg[2];        -- 取出头像选择器对象
	
	

	
	for i=1,#(M.imageArry) do
		--Cli.SysMessage( (M.xpos + 65 * i),6,1)
		cc.image = 
		{
			title = 'await.'..ag_title..'counter999'..'_'..i;
			selected = i;
			imageID = M.imageArry[i];
			xpos = M.xpos + (65 * (i - 1));
			ypos = M.ypos;
			realXY = true;
			
		
			<?
				tbl_CounterAnime =
				{
					106252,106090,106061,106600,106275,1190776
				}
				function unsafe.getCounterOne(player,selected)
					--NLG.SystemMessage(player,tostring(tbl_CounterAnime[selected]))
					Char.SetData(player,%对象_形象%,tbl_CounterAnime[selected]);
					Char.SetData(player,%对象_原形%,tbl_CounterAnime[selected]);
					Char.SetData(player,%对象_原始图档%,tbl_CounterAnime[selected]);
					NLG.UpChar(player);
					return selected,tbl_CounterAnime[selected]
				end
			?>
			on_lclick = function(object)
				local selected,anime = await.unsafe.getCounterOne(object.selected)
				if M.on_result ~= nil then
					M.on_result(M.NameArry[selected],anime)
				end
			end;
			on_mousein = function(object)
				local view = object.mainview
				view.find('Itextbox').text = '[' .. M.NameArry[object.selected] .. ']'
				
			end
		}
	end
	
	
end