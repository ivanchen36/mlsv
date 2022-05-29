
SG_ChanSong = {}
SG_ChanSong.Npc = {metamo = 104731, map = 1000 ,posx = 247 ,posy = 82 ,faceto = 6 ,name= "练级传送" , showname = 1, namecolor=5}
SG_ChanSong.Item = {1282}
----------------
-- √ 允许修改 √
----------------
SG_ChanSong.data = {



{"1-10",		100,	500,	{1538,15,15}},
{"10-30",		100,	500,	{33000,290,434}},
{"30-40",	500,	2000,	{30192,10,10}},
{"40-50",		500,	2500,	{100,540,40}},
{"50-60",		500,	2500,	{15595,20,3}},
{"60-70",	1500,	7500,	{15542,15,8}},
{"70-80",		1500,	7500,	{15564,21,7}},
{"80-100",		2500,	10000,	{402,74,183}},
{"100-110",		1000,	5000,	{34017,11,5}},
{"110-120",		1000,	5000,	{34017,11,5}},
{"120-130",		10000,	50000,	{59670,175,131}},

--{"长老树精",	1000,	5000,	{15507,29,14}},
--{"神兽",		5000,	25000,	{16511,26,28}},
--{"双王",		10000,	50000,	{24068,20,20}},
--{"海神",		2000,	10000,	{34005,20,20}},
--{"龙王",		20000,	100000,	{8802,5,5}},
--{"切里克岛",	30000,	150000,	{27138,458,506}},


--{"天空之城",	2000,	10000,	{59750,57,160}},
--{"风穴",		2000,	10000,	{59670,176,138}},
--{"雪塔50层",	1500,	7500,	{59850,75,55}},
--{"雪塔79层",	1500,	7500,	{59879,158,122}},

--{"雪塔90层",	1500,	7500,	{59890,45,50}},
--{"日耀之域",	2500,	10000,	{31954,390,163}},

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
					SG.MSG(_PlayerIndex,"[系统]"..Char.GetData(CharIndex,2000).." 身上携有违禁品，无法传送")
					return
				end
			end
		else
			if SG_chuansongBUGitem(_PlayerIndex) == 1 then
				SG.MSG(_PlayerIndex,"[系统] 身上携有违禁品，无法传送")
				return
			end
		end				
		if tonumber(a1[2]) > 0 and tonumber(a1[3]) > 0 then 
			local Gold = Char.GetData(_PlayerIndex,%对象_金币%)
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
			SG.MSG(_PlayerIndex,"[系统] 身上的钱不够唉。")		
			end	
		else
			SG.MSG(_PlayerIndex,"[系统] 身上的钱不够唉。")	 
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



