<?php
header("content-type:text/html; charset=gbk");
	$ip = "127.0.0.1";
	$username = "root";
	$password = "123456";
	$db = "youxi";
	
	$connect=@mysql_connect($ip,$username,$password);
	@mysql_select_db($db);
	$yuan = "a.ml30.com";//ͼƬ��Դ�ӿڲ�Ҫ�޸�
	$table = "";
	$sql = mysql_query("SELECT * FROM `wgfy`");

	while($group = mysql_fetch_array($sql)) {
		$pet = $group[2];
		$a = $group[3];
		$b = $group[4];
		$c = $group[5];
		if($a == 1){$ad = "<font color='#FF0000'>��</font>";}else{$ad = "<font color='#4169E1'>��</font>";}
		if($b == 1){$bd = "<font color='#FF0000'>��</font>";}else{$bd = "<font color='#4169E1'>��</font>";}
		if($c == 1){$cd = "<font color='#FF0000'>��</font>";}else{$cd = "<font color='#4169E1'>��</font>";}
		$table = $table."<tr><th width = '20%'><img src='http://".$yuan."/pet/".$pet.".gif'  alt='".$pet."' /></th><th><font size='8' >".$ad."</font></th><th><font size='8' >".$bd."</font></th><th><font size='8' >".$cd."</font></th></tr>";
	}

?>

<html>
	<head>

		<title>�����߷�ӡ��</title>?
		<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
	</head>
	<body>
		<table border="1" width="100%" >
			<tr >
				<th colspan="4"><br/>
					<p><font size="8" color="#FF0000">�����߷�ӡ��</font><font size="4" color="#FF0000">�� &nbsp;&nbsp;&nbsp;ħ��һ����</font></p>
					<p>ע���� ��ʾ��ħ�����Ӧ�����ѱ������ύ&nbsp;&nbsp;&nbsp;&nbsp;</p>
					<p>ע���� ��ʾ��ħ�����Ӧ���λ�δ�������ύ</p><br/>
				</th>

			</tr>
			<tr>
				<th><br/>ħ��<br/><br/></th>
				<th><br/>����<br/><br/></th>
				<th><br/>һ��<br/><br/></th>
				<th><br/>����<br/><br/></th>
			</tr>
			<?php echo $table ?>
		</table>

	</body>
</html>
		