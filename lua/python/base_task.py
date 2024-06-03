#!/usr/bin/env python

# -*- coding: utf-8 -*-

class BaseTask:
    def __init__(self, mysqlClient):
        self.mysqlClient = mysqlClient

    def test1(self):
        print("test1")

    def test2(self):
        print("test2")

    def noticeBoss(self):  # 7
        sql = "insert into tbl_task(RegNum,Type,Status,Info, ExeTime, CreateTime) values " \
              "(0,99,1,'各位勇士，听我号令！世界boss即将汹涌来袭，这是一场前所未有的挑战，也是证明我们实力的最佳时刻。请大家迅速做好战斗准备，磨亮你们的武器，调整你们的状态，以最佳的精神面貌迎接这场硬仗。记住，我们不是孤军奋战，而是并肩作战的兄弟姐妹。让我们携手并进，共同击败这个强大的敌人，创造属于我们的辉煌！',UNIX_TIMESTAMP(), UNIX_TIMESTAMP());"

        self.mysqlClient.execute(sql)

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
              "(0,%ld,1,'%s',UNIX_TIMESTAMP(), UNIX_TIMESTAMP());" % (6, info)
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

    def noticeExp(self):  # 7
        sql = "insert into tbl_task(RegNum,Type,Status,Info, ExeTime, CreateTime) values " \
              "(0,99,1,'准备好了吗？激动人心的时刻来临，即将开启经验翻倍的狂飙之旅，每一秒都蓄势待发，',UNIX_TIMESTAMP(), UNIX_TIMESTAMP());"
        self.mysqlClient.execute(sql)
