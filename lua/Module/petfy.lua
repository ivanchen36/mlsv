rand_fy = 15;		--最高修正/抗性
rand_level = 1;		--有效等级












Delegate.RegDelTalkEvent("petfy_TalkEvent");

function petfy_TalkEvent(_PlayerIndex,msg,color,range,size)

	if msg == "[petfy]" then 		
		zouhou(_PlayerIndex)
	end
end		

function zouhou(player)
	for i=0,4 do
		local pet = Char.GetPet(player,i);
		if(pet>=0)then			
			local xz =	Char.GetData(pet,%对象_必杀%) + Char.GetData(pet,%对象_反击%) + Char.GetData(pet,%对象_命中%) + Char.GetData(pet,%对象_闪躲%);

			if(xz == 0)then
				Char.SetData(pet,%对象_必杀%,petfy_xz(pet))
				Char.SetData(pet,%对象_闪躲%,petfy_xz(pet))
				Char.SetData(pet,%对象_命中%,petfy_xz(pet))
				Char.SetData(pet,%对象_反击%,petfy_xz(pet))

				Char.SetData(pet,%对象_抗睡%,petfy_xz(pet))
				Char.SetData(pet,%对象_抗石%,petfy_xz(pet))
				Char.SetData(pet,%对象_抗乱%,petfy_xz(pet))
				Char.SetData(pet,%对象_抗毒%,petfy_xz(pet))			
				Char.SetData(pet,%对象_抗醉%,petfy_xz(pet))
				Char.SetData(pet,%对象_抗忘%,petfy_xz(pet))	

				Pet.UpPet(player,pet)	
			end
		
		
		end
		
	end

end


function petfy_xz(id)
	local rand = NLG.Rand(0, rand_fy);
	return rand;
end

