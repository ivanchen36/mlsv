#! /bin/sh
touch .shutdown
pid=`ps -ef|grep run.sh|grep -v grep|awk '{print $2}'`
pid1=`ps -ef|grep gmsv|grep -v grep|awk '{print $2}'`
sleep 1
            echo "【提示】：稍等，请不要进行其他操作!"

 kill -9 $pid
 kill $pid1

sleep 15
            echo "【提示】：正在杀死进程!"
sleep 15
            echo "【提示】：成功杀死进程!"
