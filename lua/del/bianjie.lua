

Delegate.RegDelTalkEvent("bianjie_TalkEvent");



function bianjie_TalkEvent(_PlayerIndex,msg,color,range,size)
	
	if msg == "[bianjie]"  then 
		Protocol.SendLuaCustomPacket(_PlayerIndex,"khd_bianjie", "ǩ��,[qiandao2]|ǿ��,[QiangHua]|����,[zuoqi2]|���,[#ChiBang]");
	end	
 end	

