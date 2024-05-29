class BaseTask:
    def __init__(self, mysqlClient):
        self.mysqlClient = mysqlClient
    def startBoss(self): # 7
        sql = "insert into tbl_task(RegNum,Type,Status,Info, ExeTime, CreateTime) values " \
               "(0,7,1,'',Now(), Now());"
        self.mysqlClient.execute(sql)

    def stopBoss(self): #8
        sql = "insert into tbl_task(RegNum,Type,Status,Info, ExeTime, CreateTime) values " \
              "(0,8,1,'', Now(), Now());"
        self.mysqlClient.execute(sql)

    def gift(self): #6
        info = "||"
        sql = "insert into tbl_task(RegNum,Type,Status,Info, ExeTime, CreateTime) values " \
              "(0,%ld,1,'%s',Now(), Now());" % (6, info)
        self.mysqlClient.execute(sql)