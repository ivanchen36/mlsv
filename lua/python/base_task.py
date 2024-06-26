#!/usr/bin/env python
import datetime
import time


# -*- coding: utf-8 -*-

class BaseTask:
    def __init__(self, mysqlClient):
        self.mysqlClient = mysqlClient

    def sysMsg(self, msg):
        sql = "insert into tbl_task(RegNum,Type,Status,Info, ExeTime, CreateTime) values " \
              "(0,99,1,'%s',UNIX_TIMESTAMP(), UNIX_TIMESTAMP());" % msg

        self.mysqlClient.execute(sql)

    def noticeBoss(self):  # 7
        self.sysMsg('各位勇士，听我号令！世界boss即将汹涌来袭，这是一场前所未有的挑战，也是证明我们实力的最佳时刻。请大家迅速做好战斗准备，磨亮你们的武器，调整你们的状态，以最佳的精神面貌迎接这场硬仗。记住，我们不是孤军奋战，而是并肩作战的兄弟姐妹。让我们携手并进，共同击败这个强大的敌人，创造属于我们的辉煌！')

    def startBoss(self):  # 7
        sql = "insert into tbl_task(RegNum,Type,Status,Info, ExeTime, CreateTime) values " \
              "(0,7,1,'',UNIX_TIMESTAMP(), UNIX_TIMESTAMP());"
        self.mysqlClient.execute(sql)

    def stopBoss(self):  # 8
        sql = "insert into tbl_task(RegNum,Type,Status,Info, ExeTime, CreateTime) values " \
              "(0,8,1,'', UNIX_TIMESTAMP(), UNIX_TIMESTAMP());"
        self.mysqlClient.execute(sql)

    def noticeGift(self):
        sql = "insert into tbl_task(RegNum,Type,Status,Info, ExeTime, CreateTime) values " \
              "(0,99,1,'天降好礼，喜迎幸运时刻！各位亲爱的玩家，天降礼包活动即将拉开帷幕，海量福利即将倾盆而下！请保持高度关注，做好抢领准备，机会难得，不容错过！让我们共同期待这份幸运大礼包，一起迎接喜悦与惊喜的降临吧！',UNIX_TIMESTAMP(), UNIX_TIMESTAMP());"
        self.mysqlClient.execute(sql)

    def startGift(self):  # 6
        info = "||"
        sql = "insert into tbl_task(RegNum,Type,Status,Info, ExeTime, CreateTime) values " \
              "(0,6,1,'%s',UNIX_TIMESTAMP(), UNIX_TIMESTAMP());" % info
        self.mysqlClient.execute(sql)

    def weekdayExp(self):  # 3 4 5
        info = "200|3600"
        sql1 = "insert into tbl_task(RegNum,Type,Status,Info, ExeTime, CreateTime) values " \
               "(0,3,1,'%s',UNIX_TIMESTAMP(), UNIX_TIMESTAMP());" % (info)
        self.mysqlClient.execute(sql1)
        sql2 = "insert into tbl_task(RegNum,Type,Status,Info, ExeTime, CreateTime) values " \
               "(0,4,1,'%s',UNIX_TIMESTAMP(), UNIX_TIMESTAMP());" % (info)
        self.mysqlClient.execute(sql2)
        sql3 = "insert into tbl_task(RegNum,Type,Status,Info, ExeTime, CreateTime) values " \
               "(0,5,1,'%s',UNIX_TIMESTAMP(), UNIX_TIMESTAMP());" % (info)
        self.mysqlClient.execute(sql3)

    def holidayExp(self):  # 3 4 5
        info = "200|10800"
        sql1 = "insert into tbl_task(RegNum,Type,Status,Info, ExeTime, CreateTime) values " \
               "(0,3,1,'%s',UNIX_TIMESTAMP(), UNIX_TIMESTAMP());" % (info)
        self.mysqlClient.execute(sql1)
        sql2 = "insert into tbl_task(RegNum,Type,Status,Info, ExeTime, CreateTime) values " \
               "(0,4,1,'%s',UNIX_TIMESTAMP(), UNIX_TIMESTAMP());" % (info)
        self.mysqlClient.execute(sql2)
        sql3 = "insert into tbl_task(RegNum,Type,Status,Info, ExeTime, CreateTime) values " \
               "(0,5,1,'%s',UNIX_TIMESTAMP(), UNIX_TIMESTAMP());" % (info)
        self.mysqlClient.execute(sql3)

    def noticeExp(self):
        self.sysMsg('准备好了吗？激动人心的时刻来临，即将开启经验翻倍的狂飙之旅，每一秒都蓄势待发，')

    def initData(self):
        ts = time.time() - 86400 * 7
        isMonday = (datetime.date.today().weekday() == 0)
        avoidArr = [600, 1800, 3600, 5400, 7200, 7800, 8400, 9200, 10800]
        avoid = ""
        gift = ""
        for i in range(len(avoidArr)):
            avoid = avoid + " when VipLevel = %ld then %ld" % (i + 1, avoidArr[i])
        sql = "update tbl_vip_info set EnemyAvoidSec = case %s end, %s AddExp = if(VipLevel > 0, 1, 0) where VipLevel > 1 and UpdateTime > from_unixtime(%ld) "
        if isMonday:
            gift = " GodGift = if(VipLevel > 0, 1, 0),"
        sql = sql % (avoid, gift, ts)
        print(sql)
        self.mysqlClient.execute(sql)
