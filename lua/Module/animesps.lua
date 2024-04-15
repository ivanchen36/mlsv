Delegate.RegDelLoginEvent("spset_LoginEvent");


function spset_LoginEvent(player)
	
	--秘钥列表（请作图家授权） 用逗号隔开,
	--登录器需更新到20190804以上版本--本次更新20220614/用于GA通用客户端第二套系列免费 发布站点 bbs.ml30.com
	local spsset = "u21XrUOgC1nmdQoMm1HK7ymhBg==,u2tfrUOgCx3Qa2EB41TB,vWlVrUOgCwfbehMbiCXK7yShCA==,umxXrUOgCwbhehMbiCXK7yehBg==,vWVQrUOgCwbxehMbiCXK7ySnDw==,u2VTrUOgCwbxehMbiCHK7yeiDQ==,uGxWrUOgCwfhVBcbmCGniCnGAmcEmz4=,vWRRrUOgCwfhVBcbmCGniCnCAmcFljg=,u2pQrUOgCwfhVBcbmCGniCnOAmcFljw=,";
	Protocol.SendLuaCustomPacket(player,"spsset", spsset);

end