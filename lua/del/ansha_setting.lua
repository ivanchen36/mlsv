-- ������ �ٷֱ�
ansha_tbl= {4,8,12,16,20,24,28,32,36,40};

-- ���㰵ɱ����
-- pet �ͷŰ�ɱ�ĳ���
-- deobject ����ɱ�Ķ���
-- ��ɱ�ȼ� 1~10
-- ����ֵ������ Ʃ�緵��40% ����40%�ļ��ʳ���ɱ ����100��ʾ100%����ɱ
function select_ansha(pet,deobject,techlv)
	
	-- ��������Լ���˫�������ԡ��ȼ�����ֹ�ϵ�����ж������ɱ�ļ���
	-- ��ʾ���ֱ�ӹ̶���ɱ����Ϊansha_tbl
	
	local player = Pet.GetOwner(pet)
	if Battle.IsBossBattle(Char.GetBattleIndex(player)) == 1 then -- bossս��Ĭ�ϲ���
		return 0;
	end
	
	return ansha_tbl[techlv];
end