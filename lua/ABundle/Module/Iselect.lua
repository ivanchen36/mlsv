

cc.view = 
{
    title = 'Iselect';
	xpos = 200; ypos = 200; 
	sizex = 504; sizey = 327; pxpos = 504; pypos = 50;
    on_init  = function (view)
		
    end;
	
	on_load = function(view)
	
	end;
};

cc.bmpbutton = 
{
	args = { 'bg2.bmp' };
	title = 'bg';
	xpos = 0; ypos = 0;

	on_load = function(object)
	
		Cli.SysMessage( '�����ɹ�' ,4,3)

	end;
	
	
};

cc.closebutton =
{
	title = 'Iclose';
	xpos = 461; ypos = 9;
	event = function ( object )
		Audio.Bell(54,320)
		
		return 1;
	end
};

cc.textbox =
{
	title = 'Itextbox';
	xpos = 50;
	ypos = 150;
	color = 6;
	fontsize = 1;
	text = ''
	
}

cc.counter =
{
	title ='Icounter';
	args = {};
	xpos = 50; ypos = 35;
	imageArry = 
	{
		200481,201062,200831,200519,200606,201285
	};
	NameArry = 
	{
		'ɳ��','���Ӵ���','����÷��','��Ů��','��Ů','С����'
	};
	on_result = function(selected,anime)
		Cli.SysMessage('�Ѿ������'.. selected .. '[' .. anime .. '] ��Ư��,�����ҿ�����',4,3);
	end;
}

cc.image = 
{
	title = 'Iimage1';
	realXY = true;
	xpos = 370; ypos = 160;
	--realXY = true;
	imageID = 243048;
	

	on_lclick = function(object)
		Cli.SysMessage( '���������' ,4,3)
		--object.imageID = 243049;
	end;
	
	on_rclick = function(object)
		Cli.SysMessage( '�Ҽ�������' ,4,3)
	end;
	
	on_dlclick = function(object)
		Cli.SysMessage( '�����˫��' ,4,3)
	end;
	
	on_drclick = function(object)
		Cli.SysMessage( '�Ҽ���˫��' ,4,3)
	end;
	
	on_mousein = function(object)
		Cli.SysMessage( '�������' ,4,3)
		object.imageID = 243050
	end;
	
	on_mouseout = function(object)
		Cli.SysMessage( '�����˳�' ,4,3)
		object.imageID = 243048
	end;
	
	on_event = function(object,event)
		--object.imageID = 243048;
	end;
};



<?

function Event.RegTalkEvent.Iselect(player,msg,color,font)
	if msg == '/7' then
		Client.RunABundle(player,'a.control.con1.lua')
		Client.RunABundle(player,'Iselect.lua')
		
		Client.Show(player,'Iselect')
		
	end
	
end
?>