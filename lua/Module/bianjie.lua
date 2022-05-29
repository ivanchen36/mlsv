

Delegate.RegDelTalkEvent("bianjie_TalkEvent");



function bianjie_TalkEvent(_PlayerIndex,msg,color,range,size)
	
	if msg == "[bianjie]"  then 
		Protocol.SendLuaCustomPacket(_PlayerIndex,"khd_bianjie", "Ç©µ½,[qiandao2]|Ç¿»¯,[QiangHua]|×øÆï,[zuoqi2]|³á°ò,[#ChiBang]");
	end	
 end	

