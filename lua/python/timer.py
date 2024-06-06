# -*- coding: utf-8 -*-
import os

from config_observer import ConfigObserver
from log import Log
from mysql_client import MysqlClient
from base_task import BaseTask
from pk import PK
from scheduler_task import SchedulerTask

log = Log(os.getcwd() + "/log/", "timer")
ml_config = {"host": "127.0.0.1", "port": 3306, "db": "cgdev", "user": "root", "passwd": "123456", "charset": "gbk"}
mysql_client = MysqlClient(**ml_config)
baseTask = BaseTask(mysql_client)
pk = PK(mysql_client)

def startTimer():
    configFile = "config.json"
    filePath = os.getcwd() + "/config/"
    schedulerTask = SchedulerTask(globals(), filePath + configFile, log)
    configObserver = ConfigObserver(log)
    configObserver.registerEvent(configFile, schedulerTask.loadSchedulerTask)
    configObserver.startObserver(filePath)
    schedulerTask.startScheduler()

if __name__ == "__main__":
    startTimer()
