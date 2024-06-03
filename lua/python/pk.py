from datetime import datetime
import time


class PK:
    def __init__(self, mysqlClient):
        self.mysqlClient = mysqlClient
    @staticmethod
    def isLastWeek(date):
        ts2 = time.time() + 86400 * 7
        return date.month != datetime.fromtimestamp(ts2).month

    def noticeSinglePk(self):  # 7
        sql = "insert into tbl_task(RegNum,Type,Status,Info, ExeTime, CreateTime) values " \
              "(0,99,1,'个人PK积分赛即将热血来袭！勇士们，你们准备好迎接这场巅峰对决，与各路英豪一较高下了吗？这将是一场激情四溢、斗志昂扬的竞技盛宴，每一次击杀、每一次超越都将铭刻在荣耀的史册上。快来加入吧，用你的实力和智慧，在积分赛中脱颖而出，赢取属于你的至高荣誉！是时候展现你真正的技术了，勇士，就在此时此刻！',UNIX_TIMESTAMP(), UNIX_TIMESTAMP());"
        self.mysqlClient.execute(sql)
        ts = time.time()
        date = datetime.fromtimestamp(ts)
        type = 1
        desc = str(date.year) + "年" + str(date.month) + "月第" + str(int(date.day - 1 / 7) + 1) + "周个人积分赛"
        sql = "insert into tbl_pk_info (PkDate, PkType, Round, count, EventDescription, ParticipantCount, Status, CreateTime) values ('%s', %ld, 0, 0, '%s', 0, 1, %ld);" \
              % (date.strftime("%Y年%m月%d日"), type, desc, ts)
        self.mysqlClient.execute(sql)

    def noticeTeamPk(self):  # 7
        sql = "insert into tbl_task(RegNum,Type,Status,Info, ExeTime, CreateTime) values " \
              "(0,99,1,'团队PK淘汰赛即将拉开战幕！各位战士，是时候集结你们的队友，携手并进，共同迎接这场热血沸腾的竞技挑战了。在这个舞台上，每一支队伍都将拼尽全力，每一次团队协作都将闪耀光芒。只有最强的团队才能脱颖而出，只有最默契的配合才能问鼎巅峰。快来加入这场团队PK淘汰赛，用你们的团结和勇气，书写属于你们的传奇篇章！激情燃烧，斗志昂扬，团队荣耀，等你来战！',UNIX_TIMESTAMP(), UNIX_TIMESTAMP());"
        self.mysqlClient.execute(sql)
        ts = time.time()
        date = datetime.fromtimestamp(ts)
        type = 2
        if self.isLastWeek(date):
            type = 3
            if date.month == 12:
                type = 5
            elif date.month % 3 == 0:
                type = 4
        desc = str(date.year) + "年"
        if 2 == type:
            desc = desc + str(date.month) + "月第" + str(int(date.day - 1 / 7) + 1) + "周周赛"
        elif type == 3:
            desc = desc + str(date.month) + "月月赛"
        elif type == 4:
            desc = desc + "第" + str(int(date.day - 1 / 3) + 1) + "季度季赛"
        elif type == 5:
            desc = desc + "年年赛"
        sql = "insert into tbl_pk_info (PkDate, PkType, Round, count, EventDescription, ParticipantCount, Status, CreateTime) values ('%s', %ld, 0, 0, '%s', 0, 1, %ld);" \
              % (date.strftime("%Y年%m月%d日"), type, desc, ts)
        self.mysqlClient.execute(sql)

    def startPk1(self):  # 2
        sql = "insert into tbl_task(RegNum,Type,Status,Info, ExeTime, CreateTime) values " \
              "(0,2,1,'',UNIX_TIMESTAMP(), UNIX_TIMESTAMP());"
        self.mysqlClient.execute(sql)

    def startPk2(self):  # 10
        sql = "insert into tbl_task(RegNum,Type,Status,Info, ExeTime, CreateTime) values " \
              "(0,10,1,'',UNIX_TIMESTAMP(), UNIX_TIMESTAMP());"
        self.mysqlClient.execute(sql)

    def startSinglePk(self):
        sql = "select Id, PkDate, PkType, Round, count, EventDescription, ParticipantCount, Status from tbl_pk_info where Status = 1 and PkType = 1;"
        pkInfo = self.mysqlClient.get(sql)
        if pkInfo is None:
            return

        pass

    def getRound(self, teamNum):
        power = 2
        while power < teamNum:
            power *= 2
        return power

    def startTeamPk(self):
        sql = "select Id, PkDate, PkType, Round, count, EventDescription, ParticipantCount, Status from tbl_pk_info where Status = 1;"
        pkInfo = self.mysqlClient.get(sql)
        if pkInfo:
            return
        pass
        sql = "select Id, RegNum, Name from tbl_pk_team where PkId = %ld and Status = 0;"
        teams = self.mysqlClient.query(sql)
        if pkInfo["Round"] == 0:
            round = self.getRound(len(teams))
        else:
            round = pkInfo["Round"]
        teamCount = len(teams)
        pkRecord = round / 2
        for i in range(pkRecord):
            teamA = teams[i]["RegNum"]
            teamAName = teams[i]["Name"]
            if i + pkRecord < teamCount:
                teamB = teams[i + pkRecord]["RegNum"]
                teamBName = teams[i + pkRecord]["Name"]
            else:
                teamB = 0
                teamBName = ""
            sql = "insert into tbl_pk_record (PkId, Round, TeamARegNum, TeamBRegNum, TeamAName, TeamBName, CreateTime) values " \
                  "(%ld, %ld, %ld, %ld, %s, %s, UNIX_TIMESTAMP())" % (pkInfo["Id"], round, teamA, teamB, teamAName, teamBName)
            self.mysqlClient.execute(sql)
        sql = "update tbl_pk_info"
        pass
