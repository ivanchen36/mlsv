rand_fy = 15;		--�������/����
rand_level = 1;		--��Ч�ȼ�












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
			local xz =	Char.GetData(pet,%����_��ɱ%) + Char.GetData(pet,%����_����%) + Char.GetData(pet,%����_����%) + Char.GetData(pet,%����_����%);

			if(xz == 0)then
				Char.SetData(pet,%����_��ɱ%,petfy_xz(pet))
				Char.SetData(pet,%����_����%,petfy_xz(pet))
				Char.SetData(pet,%����_����%,petfy_xz(pet))
				Char.SetData(pet,%����_����%,petfy_xz(pet))

				Char.SetData(pet,%����_��˯%,petfy_xz(pet))
				Char.SetData(pet,%����_��ʯ%,petfy_xz(pet))
				Char.SetData(pet,%����_����%,petfy_xz(pet))
				Char.SetData(pet,%����_����%,petfy_xz(pet))			
				Char.SetData(pet,%����_����%,petfy_xz(pet))
				Char.SetData(pet,%����_����%,petfy_xz(pet))	

				Pet.UpPet(player,pet)	
			end
		
		
		end
		
	end

end


function petfy_xz(id)
	local rand = NLG.Rand(0, rand_fy);
	return rand;
end

