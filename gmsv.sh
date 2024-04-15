#! /bin/sh
rm -f core.*
rm -f gmsvlog
rm -f gmsvlog.*
rm -f .shutdown
rm -f rebootlog

#. ./stop.sh
nohup ./run.sh runserver1 > /dev/null 2>&1 &

