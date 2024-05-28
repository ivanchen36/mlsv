import json
import time
import datetime
from apscheduler.schedulers.blocking import BlockingScheduler
from apscheduler.triggers.interval import IntervalTrigger
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
from mysql_client import MysqlClient
from base_task import BaseTask

ml_config = {"host":"10.0.127.13", "port":3306, "db":"p2p", "user":"pay_r", "passwd":"b92f^bb832EF9"}
mysql_client = MysqlClient(**ml_config)
baseTask = BaseTask(mysql_client)
class ConfigFileHandler(FileSystemEventHandler):
    def __init__(self, scheduler, config_file):
        self.scheduler = scheduler
        self.config_file = config_file

    def on_modified(self, event):
        if event.src_path == self.config_file:
            self.reload_tasks()

    def reload_tasks(self):
        tasks = read_config(self.config_file)
        self.scheduler.remove_all_jobs()  # 清除现有任务
        for task in tasks:
            func = globals().get(task['name'])
            def scheduled_task(name=task['name']):
                print(f"Task '{name}' executed on {datetime.datetime.now()}")
                func()

            self.scheduler.add_job(scheduled_task, 'cron', task['cron_expression'])
        print("Tasks reloaded from config file.")

def startBoss():
    baseTask.startBoss()

def stopBoss():
    baseTask.stopBoss()

def startGift():
    baseTask.gift()

def read_config(file_path):
    with open(file_path, 'r') as file:
        config = json.load(file)
    return config['scheduler']['tasks']

if __name__ == "__main__":
    config_file = "config.json"
    tasks = read_config(config_file)

    # 创建调度器
    scheduler = BlockingScheduler()

    # 添加初始任务
    for task in tasks:
        def scheduled_task(name=task['name']):
            job(name)
        scheduler.add_job(scheduled_task, 'cron', task['cron_expression'])

    # 创建事件处理器和观察器
    handler = ConfigFileHandler(scheduler, config_file)
    observer = Observer()
    observer.schedule(handler, path='.', recursive=False)

    # 每5分钟检查一次配置文件
    scheduler.add_job(observer.run, 'interval', minutes=5, args=(), id='check_config')

    # 启动调度器
    print("Scheduler started...")
    scheduler.start()