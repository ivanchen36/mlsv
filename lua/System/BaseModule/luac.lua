tbl_daily = {};

function ScriptCall(npc, player, s)


	if(string.find(s,"itemreb"))then
		local this_item = Char.GetItemIndex(player,8);
		local nj = Item.GetData(this_item, %����_����;�%);
		Item.SetData(this_item, %����_�;�%,nj);
		Item.UpItem(player, 8);
	end
	
	
	if(string.find(s,"daily"))then
		local sv = string.gsub(s, "daily", "");	
		local playerkeyname = Playerkey(player)..sv;
		if(tbl_daily[playerkeyname] == nil)then
			tbl_daily[playerkeyname] = os.time();
			return 1;
		end
						
		if (os.date("%d",tbl_daily[playerkeyname]) ~= os.date("%d",os.time())) then 
			tbl_daily[playerkeyname] = os.time();
			return 1;
		end
		
		return 0;
	end
		

	if(string.find(s,"setdy"))then
		local sv = string.gsub(s, "setdy", "");	
		local playerkeyname = Playerkey(player)..sv;
		tbl_daily[playerkeyname] = tonumber(os.date("%d",os.time()));
		return 1;
	end

	
	if(string.find(s,"setskilllv"))then	
		local sv = string.gsub(s, "setskilllv", "");
		if(sv~=nil and sv~=0)then
			local svA =Split(sv,",");			
			local skillid = tonumber(svA[1]);
			local setexp = tonumber(svA[2]);
			local level = tonumber(svA[3]);
			local skillpos = Char.HaveSkill(player,skillid);
			if(skillpos == -1)then
				Char.AddSkill(player,skillid,setexp);
				local skillpos2 = Char.HaveSkill(player,skillid);
				if(skillpos2 == -1)then
					return 0;
				end
				Char.SetSkillLevel(player,skillpos2, level)
				NLG.UpChar(player);
				return 1;
			end
			return 0;
		end
	end

	if(string.find(s,"getflg"))then
		local get = NLG.GetString(s,"getflg",0);
		local ret = EventExpandCheckFlgCall(player,get);
		return ret;
	end
	

	if(string.find(s,"setflg"))then
		local get = NLG.GetString(s,"setflg",0);
		local ret = EventExpandSetFlgCall(player,get);
		return ret;
	end
	

	if(string.find(s,"delflg"))then
		local get = NLG.GetString(s,"setflg",0);
		local ret = EventExpandClsFlgCall(player,get);
		return ret;
	end
	
	if(string.find(s,"likeme"))then
		
		Char.SetData(player,%����_����%,Char.GetData(npc, %����_����%));
		Char.SetData(player,%����_ԭ��%,Char.GetData(npc, %����_ԭ��%));
		Char.SetData(player,%����_ԭʼͼ��%,Char.GetData(npc, %����_ԭʼͼ��%));
		NLG.UpChar(player);

		
	end
	
	
	if(string.find(s,"petme"))then
		local petindex = Char.GetPet(player,0);
		if petindex >= 0 then
 			Char.SetData(petindex,%����_����%,Char.GetData(npc, %����_����%));
			Char.SetData(petindex,%����_ԭ��%,Char.GetData(npc, %����_ԭ��%));
			Char.SetData(petindex,%����_ԭʼͼ��%,Char.GetData(npc, %����_ԭʼͼ��%));
			Pet.UpPet(player, petindex);
			NLG.UpChar(player);
		end
		
	end
	
	
	if(string.find(s,"setmj"))then	
		local sv = string.gsub(s, "setmj", "");
		if(sv ~= nil)then
			local svA = Split(sv,",");	
			local num1 = tonumber(Field.Get(player,"MKTZ_"..svA[1]));
			if num1 ~= nil and num1 < tonumber(svA[2]) then
				Field.Set(player,"MKTZ_"..svA[1],tostring(svA[2]));
				return 1;
			end
		end 
		return 0;
	end 

	if(string.find(s,"showmj"))then	
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
		return 1;
	end 	

	if(string.find(s,"peth"))then--���peth �ǵ���
		local _PetIndex = Char.GetPet(player,0);
		if _PetIndex >=0 then
			if Char.GetData(_PetIndex,%����_�ȼ�%) > 1 then--ֻ��ϴ����1������
				NLG.SystemMessage(player,"[����ϴ��]���ﲢ��һ�����޷�ϴ��");
				return 0;
			else
				Pet.SetArtRank(_PetIndex,%�赵_���%,Pet.FullArtRank(_PetIndex,%�赵_���%)-math.random(0,4));
				Pet.SetArtRank(_PetIndex,%�赵_����%,Pet.FullArtRank(_PetIndex,%�赵_����%)-math.random(0,4));
				Pet.SetArtRank(_PetIndex,%�赵_ǿ��%,Pet.FullArtRank(_PetIndex,%�赵_ǿ��%)-math.random(0,4));
				Pet.SetArtRank(_PetIndex,%�赵_����%,Pet.FullArtRank(_PetIndex,%�赵_����%)-math.random(0,4));
				Pet.SetArtRank(_PetIndex,%�赵_ħ��%,Pet.FullArtRank(_PetIndex,%�赵_ħ��%)-math.random(0,4));
				Pet.UpPet(player,_PetIndex);
				Pet.ReBirth(player,_PetIndex);
				local DC1 = Pet.GetArtRank(_PetIndex,%�赵_���%);
				local MD1 = Pet.FullArtRank(_PetIndex,%�赵_���%);
				local DC2 = Pet.GetArtRank(_PetIndex,%�赵_����%);
				local MD2 = Pet.FullArtRank(_PetIndex,%�赵_����%);
				local DC3 = Pet.GetArtRank(_PetIndex,%�赵_ǿ��%);
				local MD3 = Pet.FullArtRank(_PetIndex,%�赵_ǿ��%);
				local DC4 = Pet.GetArtRank(_PetIndex,%�赵_����%);
				local MD4 = Pet.FullArtRank(_PetIndex,%�赵_����%);
				local DC5 = Pet.GetArtRank(_PetIndex,%�赵_ħ��%);
				local MD5 = Pet.FullArtRank(_PetIndex,%�赵_ħ��%);
				local SDC1 = math.abs(DC1 - MD1);
				local SDC2 = math.abs(DC2 - MD2);
				local SDC3 = math.abs(DC3 - MD3);
				local SDC4 = math.abs(DC4 - MD4);
				local SDC5 = math.abs(DC5 - MD5);
				local DC8 = SDC1 + SDC2 + SDC3 + SDC4 + SDC5
				local DC6 = DC1 + DC2 + DC3 + DC4 + DC5
				local DC7 = MD1 + MD2 + MD3 + MD4 + MD5
				local msg = "";
				--local Msg = GAMsgFormat("                ���ݲ������ܡ�")
					NLG.SystemMessage(player,"[ϴ���ɹ�]����:"..SDC1..","..SDC2..","..SDC3..","..SDC4..","..SDC5..",�ܼ�:-"..DC8.."��");
				return 1;
			end
		else
			NLG.SystemMessage(player,"[����ϴ��]ϴ��ʧ�ܣ���������һ��û�г���");
			return 0;
		end
	end
	if(string.find(s,"mandang"))then
		local _PetIndex = Char.GetPet(player,0);
		if _PetIndex >=0 then
			if Char.GetData(_PetIndex,%����_�ȼ�%) > 1 then--ֻ��ϴ����1������
				NLG.SystemMessage(player,"[����ϴ��]���ﲢ��һ�����޷�ϴ��");
				return 0;
			else
				local MD11 = Pet.FullArtRank(_PetIndex,%�赵_���%);
				local MD12 = Pet.FullArtRank(_PetIndex,%�赵_����%);
				local MD13 = Pet.FullArtRank(_PetIndex,%�赵_ǿ��%);
				local MD14 = Pet.FullArtRank(_PetIndex,%�赵_����%);
				local MD15 = Pet.FullArtRank(_PetIndex,%�赵_ħ��%);
				Pet.SetArtRank(_PetIndex,%�赵_���%,MD11);
				Pet.SetArtRank(_PetIndex,%�赵_����%,MD12);
				Pet.SetArtRank(_PetIndex,%�赵_ǿ��%,MD13);
				Pet.SetArtRank(_PetIndex,%�赵_����%,MD14);
				Pet.SetArtRank(_PetIndex,%�赵_ħ��%,MD15);
				Pet.UpPet(player,_PetIndex);
				Pet.ReBirth(player,_PetIndex);
				local DC1 = Pet.GetArtRank(_PetIndex,%�赵_���%);
				local MD1 = Pet.FullArtRank(_PetIndex,%�赵_���%);
				local DC2 = Pet.GetArtRank(_PetIndex,%�赵_����%);
				local MD2 = Pet.FullArtRank(_PetIndex,%�赵_����%);
				local DC3 = Pet.GetArtRank(_PetIndex,%�赵_ǿ��%);
				local MD3 = Pet.FullArtRank(_PetIndex,%�赵_ǿ��%);
				local DC4 = Pet.GetArtRank(_PetIndex,%�赵_����%);
				local MD4 = Pet.FullArtRank(_PetIndex,%�赵_����%);
				local DC5 = Pet.GetArtRank(_PetIndex,%�赵_ħ��%);
				local MD5 = Pet.FullArtRank(_PetIndex,%�赵_ħ��%);
				local SDC1 = math.abs(DC1 - MD1);
				local SDC2 = math.abs(DC2 - MD2);
				local SDC3 = math.abs(DC3 - MD3);
				local SDC4 = math.abs(DC4 - MD4);
				local SDC5 = math.abs(DC5 - MD5);
				local DC8 = SDC1 + SDC2 + SDC3 + SDC4 + SDC5
				local DC6 = DC1 + DC2 + DC3 + DC4 + DC5
				local DC7 = MD1 + MD2 + MD3 + MD4 + MD5
				local msg = "";
				NLG.SystemMessage(player,"[ϴ���ɹ�]����:"..SDC1..","..SDC2..","..SDC3..","..SDC4..","..SDC5..",�ܼ�:-"..DC8.."��");
				return 1;
			end
		else
			NLG.SystemMessage(player,"[����ϴ��]ϴ��ʧ�ܣ���������һ��û�г���");
			return 0;
		end
	end
	if(string.find(s,"shidangxidangjuan"))then--���peth �ǵ���
		local _PetIndex = Char.GetPet(player,0);
		if _PetIndex >=0 then
			if Char.GetData(_PetIndex,%����_�ȼ�%) > 1 then--ֻ��ϴ����1������
				NLG.SystemMessage(player,"[����ϴ��]���ﲢ��һ�����޷�ϴ��");
				return 0;
			else
				Pet.SetArtRank(_PetIndex,%�赵_���%,Pet.FullArtRank(_PetIndex,%�赵_���%)-math.random(0,2));
				Pet.SetArtRank(_PetIndex,%�赵_����%,Pet.FullArtRank(_PetIndex,%�赵_����%)-math.random(0,2));
				Pet.SetArtRank(_PetIndex,%�赵_ǿ��%,Pet.FullArtRank(_PetIndex,%�赵_ǿ��%)-math.random(0,2));
				Pet.SetArtRank(_PetIndex,%�赵_����%,Pet.FullArtRank(_PetIndex,%�赵_����%)-math.random(0,2));
				Pet.SetArtRank(_PetIndex,%�赵_ħ��%,Pet.FullArtRank(_PetIndex,%�赵_ħ��%)-math.random(0,2));
				Pet.UpPet(player,_PetIndex);
				Pet.ReBirth(player,_PetIndex);
				local DC1 = Pet.GetArtRank(_PetIndex,%�赵_���%);
				local MD1 = Pet.FullArtRank(_PetIndex,%�赵_���%);
				local DC2 = Pet.GetArtRank(_PetIndex,%�赵_����%);
				local MD2 = Pet.FullArtRank(_PetIndex,%�赵_����%);
				local DC3 = Pet.GetArtRank(_PetIndex,%�赵_ǿ��%);
				local MD3 = Pet.FullArtRank(_PetIndex,%�赵_ǿ��%);
				local DC4 = Pet.GetArtRank(_PetIndex,%�赵_����%);
				local MD4 = Pet.FullArtRank(_PetIndex,%�赵_����%);
				local DC5 = Pet.GetArtRank(_PetIndex,%�赵_ħ��%);
				local MD5 = Pet.FullArtRank(_PetIndex,%�赵_ħ��%);
				local SDC1 = math.abs(DC1 - MD1);
				local SDC2 = math.abs(DC2 - MD2);
				local SDC3 = math.abs(DC3 - MD3);
				local SDC4 = math.abs(DC4 - MD4);
				local SDC5 = math.abs(DC5 - MD5);
				local DC8 = SDC1 + SDC2 + SDC3 + SDC4 + SDC5
				local DC6 = DC1 + DC2 + DC3 + DC4 + DC5
				local DC7 = MD1 + MD2 + MD3 + MD4 + MD5
				local msg = "";
				NLG.SystemMessage(player,"[ϴ���ɹ�]����:"..SDC1..","..SDC2..","..SDC3..","..SDC4..","..SDC5..",�ܼ�:-"..DC8.."��");
				return 1;
			end
		else
			NLG.SystemMessage(player,"[����ϴ��]ϴ��ʧ�ܣ���������һ��û�г���");
			return 0;
		end
	end
	if(string.find(s,"wudangxidangjuan"))then--���peth �ǵ���
		local _PetIndex = Char.GetPet(player,0);
		if _PetIndex >=0 then
			if Char.GetData(_PetIndex,%����_�ȼ�%) > 1 then--ֻ��ϴ����1������
				NLG.SystemMessage(player,"[����ϴ��]���ﲢ��һ�����޷�ϴ��");
				return 0;
			else
				Pet.SetArtRank(_PetIndex,%�赵_���%,Pet.FullArtRank(_PetIndex,%�赵_���%)-math.random(0,1));
				Pet.SetArtRank(_PetIndex,%�赵_����%,Pet.FullArtRank(_PetIndex,%�赵_����%)-math.random(0,1));
				Pet.SetArtRank(_PetIndex,%�赵_ǿ��%,Pet.FullArtRank(_PetIndex,%�赵_ǿ��%)-math.random(0,1));
				Pet.SetArtRank(_PetIndex,%�赵_����%,Pet.FullArtRank(_PetIndex,%�赵_����%)-math.random(0,1));
				Pet.SetArtRank(_PetIndex,%�赵_ħ��%,Pet.FullArtRank(_PetIndex,%�赵_ħ��%)-math.random(0,1));
				Pet.UpPet(player,_PetIndex);
				Pet.ReBirth(player,_PetIndex);
				local DC1 = Pet.GetArtRank(_PetIndex,%�赵_���%);
				local MD1 = Pet.FullArtRank(_PetIndex,%�赵_���%);
				local DC2 = Pet.GetArtRank(_PetIndex,%�赵_����%);
				local MD2 = Pet.FullArtRank(_PetIndex,%�赵_����%);
				local DC3 = Pet.GetArtRank(_PetIndex,%�赵_ǿ��%);
				local MD3 = Pet.FullArtRank(_PetIndex,%�赵_ǿ��%);
				local DC4 = Pet.GetArtRank(_PetIndex,%�赵_����%);
				local MD4 = Pet.FullArtRank(_PetIndex,%�赵_����%);
				local DC5 = Pet.GetArtRank(_PetIndex,%�赵_ħ��%);
				local MD5 = Pet.FullArtRank(_PetIndex,%�赵_ħ��%);
				local SDC1 = math.abs(DC1 - MD1);
				local SDC2 = math.abs(DC2 - MD2);
				local SDC3 = math.abs(DC3 - MD3);
				local SDC4 = math.abs(DC4 - MD4);
				local SDC5 = math.abs(DC5 - MD5);
				local DC8 = SDC1 + SDC2 + SDC3 + SDC4 + SDC5
				local DC6 = DC1 + DC2 + DC3 + DC4 + DC5
				local DC7 = MD1 + MD2 + MD3 + MD4 + MD5
				local msg = "";
				NLG.SystemMessage(player,"[ϴ���ɹ�]����:"..SDC1..","..SDC2..","..SDC3..","..SDC4..","..SDC5..",�ܼ�:-"..DC8.."��");
				return 1;
			end
		else
			NLG.SystemMessage(player,"[����ϴ��]ϴ��ʧ�ܣ���������һ��û�г���");
			return 0;
		end
	end

end




