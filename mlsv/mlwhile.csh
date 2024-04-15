
# ホスト名を記憶
set host = `hostname -s`
rm log/gdbout

while 1
	#gdb mlsv -x gdbbatch < /dev/null >>& log/gdbout
	./mlsv < /dev/null >>& log/gdbout

# サーバーダウンの時刻を保存。
	echo Mail Server Down >> cg_downtime.txt
	date >> cg_downtime.txt
	echo -------- >> cg_downtime.txt

# メールにも同じように書く。
	echo ${host} > mail.txt 
	echo Mail Server Down >> mail.txt
	date >> mail.txt

# メールを出す。
if ( "$host" == "ml01" || "$host" == "sotetsu" ) then
	mail mymooncg@gmail.com  -s "mail server down" < mail.txt
	mail mymooncg@gmail.com  -s "mail server down" < mail.txt
endif


end
