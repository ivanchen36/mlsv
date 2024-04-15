
SG_ChanSong = {}
SG_ChanSong.Npc = {metamo = 106233, map = 1000 ,posx = 247 ,posy = 86 ,faceto = 6 ,name= "��ݴ���" , showname = 1, namecolor=5}
SG_ChanSong.Item = {1282}
----------------
-- �� �����޸� ��
----------------
SG_ChanSong.data = {



{"����",		100,	500,	{11003,9,38}},
{"����",		100,	500,	{11015,8,10}},
{"���ɴ�½",	500,	2000,	{191,462,109}},
{"����",		500,	2500,	{33000,290,433}},
{"����",		500,	2500,	{15005,10,8}},
{"ħ����ѧ",	1500,	7500,	{402,118,106}},
{"ѩɽ",		1500,	7500,	{402,80,191}},
{"����",		2500,	10000,	{33500,36,48}},
{"�׶�",		1000,	5000,	{15595,22,2}},
{"ˮ��",		1000,	5000,	{15542,17,18}},
{"ɳ̲",		10000,	50000,	{30002,400,100}},

{"��������",	1000,	5000,	{15507,29,14}},
{"����",		5000,	25000,	{16511,26,28}},
{"˫��",		10000,	50000,	{24068,20,20}},
{"����",		2000,	10000,	{34005,20,20}},
{"����",		20000,	100000,	{8802,5,5}},
{"����˵�",	30000,	150000,	{27138,458,506}},


--{"���֮��",	2000,	10000,	{59750,57,160}},
--{"��Ѩ",		2000,	10000,	{59670,176,138}},
--{"ѩ��50��",	1500,	7500,	{59850,75,55}},
--{"ѩ��79��",	1500,	7500,	{59879,158,122}},

--{"ѩ��90��",	1500,	7500,	{59890,45,50}},
--{"��ҫ֮��",	2500,	10000,	{31954,390,163}},

}





SG_ChanSong.table = {}

for i = 1,#SG_ChanSong.data do 
	SG_ChanSong.table[i] = {SG_ChanSong.data[i][1],SG_ChanSong.data[i][2],SG_ChanSong.data[i][3]}
end	


function SG_ChanSongNpc_Talked( _MePtr, _PlayerIndex)
	if (NLG.CanTalk(_MePtr, _PlayerIndex)==false) then
		return
	end	
		Protocol.PowerSend(_PlayerIndex,"#ChuanSong", SG_ChanSong.table);

end

function Event.Recv.chuansong(_PlayerIndex,packet)
	if string.sub(packet,1,#"@chuansong|") == "@chuansong|" then
		local a1 = Stringsplitplus(packet,"|");
		local PartyNum = Char.PartyNum(_PlayerIndex)
		if PartyNum > 1 then 
			for i = 1,PartyNum do 
				local CharIndex = Char.GetPartyMember(_PlayerIndex,i-1)
				if SG_chuansongBUGitem(CharIndex) == 1 then
					SG.MSG(_PlayerIndex,"[ϵͳ]"..Char.GetData(CharIndex,2000).." ����Я��Υ��Ʒ���޷�����")
					return
				end
			end
		else
			if SG_chuansongBUGitem(_PlayerIndex) == 1 then
				SG.MSG(_PlayerIndex,"[ϵͳ] ����Я��Υ��Ʒ���޷�����")
				return
			end
		end				
		if tonumber(a1[2]) > 0 and tonumber(a1[3]) > 0 then 
			local Gold = Char.GetData(_PlayerIndex,%����_���%)
			local xuan = tonumber(a1[2])
			local fang = tonumber(a1[3])
			local delGold = SG_ChanSong.data[xuan][fang+1]
			if Gold >= delGold then 
				if fang == 1 then 
					Char.DischargeParty(_PlayerIndex)
				end	
				NLG.AddGold(_PlayerIndex,-delGold)				
				Char.Warp(_PlayerIndex,0,SG_ChanSong.data[xuan][4][1],SG_ChanSong.data[xuan][4][2],SG_ChanSong.data[xuan][4][3])
			else
			SG.MSG(_PlayerIndex,"[ϵͳ] ���ϵ�Ǯ��������")		
			end	
		else
			SG.MSG(_PlayerIndex,"[ϵͳ] ���ϵ�Ǯ��������")	 
		end	
	end
end		



function SG_chuansongBUGitem(_PlayerIndex)
	for i = 1,#SG_ChanSong.Item do 
		if Char.ItemNum(_PlayerIndex,SG_ChanSong.Item[i]) > 0 then 
			return 1
		end
	end
	return 0		
end

function SG_ChanSongNpc_Init( _npc )
	Char.SetData(_npc, 1, SG_ChanSong.Npc.metamo)
	Char.SetData(_npc, 2, SG_ChanSong.Npc.metamo)
	Char.SetData(_npc, 3, 0)
	Char.SetData(_npc, 4, SG_ChanSong.Npc.map)
	Char.SetData(_npc, 5, SG_ChanSong.Npc.posx)
	Char.SetData(_npc, 6, SG_ChanSong.Npc.posy)
	Char.SetData(_npc, 7, SG_ChanSong.Npc.faceto)
	Char.SetData(_npc, 2000, SG_ChanSong.Npc.name)


	if (Char.SetTalkedEvent(nil, "SG_ChanSongNpc_Talked", _npc) < 0) then
		print("SG_ChanSongNpc_Talked")
		return false
	end

	return true
end

if LuaNpcIndex["SG_ChanSongNpc_Index"] == nil then
	LuaNpcIndex["SG_ChanSongNpc_Index"] =  NL.CreateNpc(nil,"SG_ChanSongNpc_Init");
	NLG.UpChar(LuaNpcIndex["SG_ChanSongNpc_Index"]);
else
	NL.DelNpc(LuaNpcIndex["SG_ChanSongNpc_Index"])
	LuaNpcIndex["SG_ChanSongNpc_Index"] =  NL.CreateNpc(nil,"SG_ChanSongNpc_Init");
	NLG.UpChar(LuaNpcIndex["SG_ChanSongNpc_Index"]);	
end



