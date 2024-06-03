import json
import datetime
from apscheduler.schedulers.blocking import BlockingScheduler
from apscheduler.triggers.cron import CronTrigger


class SchedulerTask(object):
    def __init__(self, funcEnv, configFile, log):
        self.configFile = configFile
        self.scheduler = BlockingScheduler()
        self.log = log
        self.funcEnv = funcEnv

    def readConfig(self):
        with open(self.configFile, 'r') as file:
            config = json.load(file)
        return config['scheduler']['tasks']

    def startScheduler(self):
        self.log.debug("Scheduler started...")
        self.loadSchedulerTask()
        self.scheduler.start()

    def loadSchedulerTask(self):
        def createScheduledTask(function, name):
            def scheduledTask():
                self.log.debug(f"Task '{name}' executed on {datetime.datetime.now()}")
                function()

            return scheduledTask
        rs = {}
        try:
            tasks = self.readConfig()
            for task in tasks:
                self.log.debug(f"Task '{task['name']}' loaded with cron expression '{task['cron_expression']}'")
                funcName = task['name']
                if '.' in funcName:
                    className, methodName = funcName.split('.')
                    targetClass = self.funcEnv.get(className)
                    func = getattr(targetClass, methodName)
                else:
                    func = self.funcEnv.get(funcName)
                if not func:
                    self.log.debug("function not fund.")
                    return
                scheduledTask = createScheduledTask(func, task['name'])
                rs[scheduledTask] = CronTrigger.from_crontab(task['cron_expression'])
        except Exception as e:
            self.log.debug("occurred exception.")
            return
        self.addSchedulerTask(rs)
        self.log.debug("Tasks reloaded from config file.")

    def addSchedulerTask(self, tasks):
        self.scheduler.remove_all_jobs()
        for task, cron in tasks.items():
            self.scheduler.add_job(task, cron)
