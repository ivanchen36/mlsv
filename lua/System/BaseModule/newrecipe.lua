


-- 配方扩充 2022/10/20

function RecipeExpandCheckFlgCall(player, flg)
   local cdk = Char.GetData(player,%对象_账号%);
	local Reg = Char.GetData(player,%对象_RegistNumber%);
	sql = "SELECT * FROM `newrecipe` WHERE `cdk` = '"..cdk .."' and `reg` ='"..Reg.."' and `flg` ='"..flg.."'";
	resset = SQL.Run(sql);
	if(type(resset) == "table")then
		return tonumber(resset["0_4"]);
	else
		return 0;
	end
end

function RecipeExpandSetFlgCall(player, flg)
   local cdk = Char.GetData(player,%对象_账号%);
	local Reg = Char.GetData(player,%对象_RegistNumber%);
	
	sql = "SELECT * FROM `newrecipe` WHERE `cdk` = '"..cdk .."' and `reg` ='"..Reg.."' and `flg` ='"..flg.."'";
	resset = SQL.Run(sql);

	if(type(resset) == "table")then
		if(tonumber(resset["0_4"]) == 0)then
			local sql = SQL.Run("UPDATE newrecipe SET off = '1' WHERE cdk= '"..cdk .."' and reg ='"..Reg.."' and flg ='"..flg.."'");
		end
		return 1;
	else
		local sql = SQL.Run("INSERT INTO newrecipe VALUES ('','"..cdk.."','"..Reg.."','"..flg.."','1')");
		return 1;
	end
end

function RecipeExpandClsFlgCall(player, flg)
    local cdk = Char.GetData(player,%对象_账号%);
	local Reg = Char.GetData(player,%对象_RegistNumber%);
	
	sql = "SELECT * FROM `newrecipe` WHERE `cdk` = '"..cdk .."' and `reg` ='"..Reg.."' and `flg` ='"..flg.."'";
	resset = SQL.Run(sql);

	if(type(resset) == "table")then
		if(tonumber(resset["0_4"]) == 1)then
			local sql = SQL.Run("UPDATE newrecipe SET off = '0' WHERE cdk= '"..cdk .."' and reg ='"..Reg.."' and flg ='"..flg.."'");
		end
		return 1;
	else
		local sql = SQL.Run("INSERT INTO newrecipe VALUES ('','"..cdk.."','"..Reg.."','"..flg.."','0')");
		return 1;
	end
end