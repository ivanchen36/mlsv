#! /bin/sh
touch .shutdown
pid=`ps -ef|grep run.sh|grep -v grep|awk '{print $2}'`
pid1=`ps -ef|grep gmsv|grep -v grep|awk '{print $2}'`
sleep 1
            echo "����ʾ�����Եȣ��벻Ҫ������������!"

 kill -9 $pid
 kill $pid1

sleep 15
            echo "����ʾ��������ɱ������!"
sleep 15
            echo "����ʾ�����ɹ�ɱ������!"
