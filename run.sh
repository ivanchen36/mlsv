#! /bin/sh
#mysql -uroot -e "use rogue;delete from tbl_lock;"

while ( : )
do
  DATE=`date`
  var=`date +%Y%m%d%H%M`
  if [ -r .shutdown ]; then
	  rm -f .shutdown
  fi

  ./gmsv gmserver1 > "$var".gmsvlog 2>&1

  DATE2=`date`
  if [ -r .shutdown ]; then
	  echo "**** Shutdown $DATE ~ $DATE2" >> rebootlog
	  exit
  fi

  echo "!!!! Reboot $DATE ~ $DATE2" >> rebootlog
  sleep 2
done

