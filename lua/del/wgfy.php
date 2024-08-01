<?php
header("content-type:text/html; charset=gbk");
	$ip = "127.0.0.1";
	$username = "root";
	$password = "123456";
	$db = "youxi";
	
	$connect=@mysql_connect($ip,$username,$password);
	@mysql_select_db($db);
	$yuan = "a.ml30.com";//图片资源接口不要修改
	$table = "";
	$sql = mysql_query("SELECT * FROM `wgfy`");

	while($group = mysql_fetch_array($sql)) {
		$pet = $group[2];
		$a = $group[3];
		$b = $group[4];
		$c = $group[5];
		if($a == 1){$ad = "<font color='#FF0000'>√</font>";}else{$ad = "<font color='#4169E1'>×</font>";}
		if($b == 1){$bd = "<font color='#FF0000'>√</font>";}else{$bd = "<font color='#4169E1'>×</font>";}
		if($c == 1){$cd = "<font color='#FF0000'>√</font>";}else{$cd = "<font color='#4169E1'>×</font>";}
		$table = $table."<tr><th width = '20%'><img src='http://".$yuan."/pet/".$pet.".gif'  alt='".$pet."' /></th><th><font size='8' >".$ad."</font></th><th><font size='8' >".$bd."</font></th><th><font size='8' >".$cd."</font></th></tr>";
	}

?>

<html>
	<head>

		<title>《王者封印》</title>?
		<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
	</head>
	<body>
		<table border="1" width="100%" >
			<tr >
				<th colspan="4"><br/>
					<p><font size="8" color="#FF0000">《王者封印》</font><font size="4" color="#FF0000">— &nbsp;&nbsp;&nbsp;魔物一览表</font></p>
					<p>注：√ 表示该魔物的相应档次已被他人提交&nbsp;&nbsp;&nbsp;&nbsp;</p>
					<p>注：× 表示该魔物的相应档次还未被他人提交</p><br/>
				</th>

			</tr>
			<tr>
				<th><br/>魔物<br/><br/></th>
				<th><br/>满档<br/><br/></th>
				<th><br/>一档<br/><br/></th>
				<th><br/>二档<br/><br/></th>
			</tr>
			<?php echo $table ?>
		</table>

	</body>
</html>
		