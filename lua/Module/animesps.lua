Delegate.RegDelLoginEvent("spset_LoginEvent");


function spset_LoginEvent(player)
	
	--��Կ�б�����ͼ����Ȩ�� �ö��Ÿ���,
	--��¼������µ�20190804���ϰ汾--���θ���20220614/����GAͨ�ÿͻ��˵ڶ���ϵ����� ����վ�� bbs.ml30.com
	local spsset = "u21XrUOgC1nmdQoMm1HK7ymhBg==,u2tfrUOgCx3Qa2EB41TB,vWlVrUOgCwfbehMbiCXK7yShCA==,umxXrUOgCwbhehMbiCXK7yehBg==,vWVQrUOgCwbxehMbiCXK7ySnDw==,u2VTrUOgCwbxehMbiCHK7yeiDQ==,uGxWrUOgCwfhVBcbmCGniCnGAmcEmz4=,vWRRrUOgCwfhVBcbmCGniCnCAmcFljg=,u2pQrUOgCwfhVBcbmCGniCnOAmcFljw=,";
	Protocol.SendLuaCustomPacket(player,"spsset", spsset);

end