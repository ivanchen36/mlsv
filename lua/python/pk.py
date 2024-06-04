import random
from datetime import datetime
import time


class PK:
    def __init__(self, mysqlClient):
        self.mysqlClient = mysqlClient
    @staticmethod
    def isLastWeek(date):
        ts2 = time.time() + 86400 * 7
        return date.month != datetime.fromtimestamp(ts2).month

    def sysMsg(self, msg):
        sql = "insert into tbl_task(RegNum,Type,Status,Info, ExeTime, CreateTime) values " \
              "(0,99,1,'%s',UNIX_TIMESTAMP(), UNIX_TIMESTAMP());" % msg

        self.mysqlClient.execute(sql)

    def noticeSinglePk(self):  # 7
        self.sysMsg('[PK系统] 个人PK积分赛即将热血来袭！勇士们，你们准备好迎接这场巅峰对决，与各路英豪一较高下了吗？这将是一场激情四溢、斗志昂扬的竞技盛宴，每一次击杀、每一次超越都将铭刻在荣耀的史册上。快来加入吧，用你的实力和智慧，在积分赛中脱颖而出，赢取属于你的至高荣誉！是时候展现你真正的技术了，勇士，就在此时此刻！')
        ts = time.time()
        date = datetime.fromtimestamp(ts)
        pkType = 1
        desc = str(date.year) + "年" + str(date.month) + "月第" + str(int(date.day - 1 / 7) + 1) + "周个人积分赛"
        sql = "insert into tbl_pk_info (PkDate, PkType, Round, count, EventDescription, ParticipantCount, Status, CreateTime) values ('%s', %ld, 0, 0, '%s', 0, 1, %ld);" \
              % (date.strftime("%Y年%m月%d日"), pkType, desc, ts)
        self.mysqlClient.execute(sql)

    def noticeTeamPk(self):  # 7
        self.sysMsg('[PK系统] 团队PK淘汰赛即将拉开战幕！各位战士，是时候集结你们的队友，携手并进，共同迎接这场热血沸腾的竞技挑战了。在这个舞台上，每一支队伍都将拼尽全力，每一次团队协作都将闪耀光芒。只有最强的团队才能脱颖而出，只有最默契的配合才能问鼎巅峰。快来加入这场团队PK淘汰赛，用你们的团结和勇气，书写属于你们的传奇篇章！激情燃烧，斗志昂扬，团队荣耀，等你来战！')
        ts = time.time()
        date = datetime.fromtimestamp(ts)
        PkType = 2
        if self.isLastWeek(date):
            PkType = 3
            if date.month == 12:
                PkType = 5
            elif date.month % 3 == 0:
                PkType = 4
        desc = str(date.year) + "年"
        if 2 == PkType:
            desc = desc + str(date.month) + "月第" + str(int(date.day - 1 / 7) + 1) + "周周赛"
        elif PkType == 3:
            desc = desc + str(date.month) + "月月赛"
        elif PkType == 4:
            desc = desc + "第" + str(int(date.day - 1 / 3) + 1) + "季度季赛"
        elif PkType == 5:
            desc = desc + "年年赛"
        sql = "insert into tbl_pk_info (PkDate, PkType, Round, count, EventDescription, ParticipantCount, Status, CreateTime) values ('%s', %ld, 0, 0, '%s', 0, 1, %ld);" \
              % (date.strftime("%Y年%m月%d日"), PkType, desc, ts)
        self.mysqlClient.execute(sql)

    def startPk(self, pkType):  # 2 10
        sql = "insert into tbl_task(RegNum,Type,Status,Info, ExeTime, CreateTime) values " \
              "(0,%ld,1,'',UNIX_TIMESTAMP(), UNIX_TIMESTAMP());" % pkType
        self.mysqlClient.execute(sql)

    def randomTeam(self, teamList):
        randomizedList = [(team, random.random()) for team in teamList]
        randomizedList.sort(key=lambda x: x[1])
        randomTeamList = [obj for obj, _ in randomizedList]
        return randomTeamList

    def getRound(self, teamNum):
        power = 2
        while power < teamNum:
            power *= 2
        return power

    def startSinglePk(self):
        sql = "select Id, PkDate, PkType, Round, count, EventDescription, ParticipantCount, Status from tbl_pk_info where Status = 1 and PkType = 1;"
        pkInfo = self.mysqlClient.get(sql)
        if not pkInfo:
            return
        pass

        sql = "select Id, RegNum, Name from tbl_pk_team where PkId = %ld and Status = 0;" % pkInfo["Id"]
        teams = self.mysqlClient.query(sql)
        teams = self.randomTeam(teams)
        teamCount = len(teams)
        pkRecord = int((teamCount - 1) / 2) + 1
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
                  "(%ld, %ld, %ld, %ld, %s, %s, UNIX_TIMESTAMP())" % (
                  pkInfo["Id"], 0, teamA, teamB, teamAName, teamBName)
            self.mysqlClient.execute(sql)

        sql = "update tbl_pk_info set Status = 2, Count = %ld, Round = %ld where Id = %ld" % (
        pkRecord, pkRecord, pkInfo["Id"])
        self.mysqlClient.execute(sql)

    def stopSinglePk(self):
        sql = "select Id, PkDate, PkType, Round, count, EventDescription, ParticipantCount, Status from tbl_pk_info where Status = 1 and PkType = 1;"
        pkInfo = self.mysqlClient.get(sql)
        if not pkInfo:
            return
        pass
        sql = "update tbl_pk_info set Status = 4 where Id = %ld" % pkInfo["Id"]
        self.mysqlClient.execute(sql)

    def startTeamPk(self):
        sql = "select Id, PkDate, PkType, Round, count, EventDescription, ParticipantCount, Status from tbl_pk_info where Status = 1 and PkType <> 1;"
        pkInfo = self.mysqlClient.get(sql)
        if not pkInfo:
            return
        pass
        sql = "select Id, RegNum, Name from tbl_pk_team where PkId = %ld and Status = 0;" % pkInfo["Id"]
        teams = self.mysqlClient.query(sql)
        teams = self.randomTeam(teams)
        teamCount = len(teams)
        if pkInfo["Round"] > pkInfo["ParticipantCount"]:
            self.modifyNoBattleTeam(pkInfo["ParticipantCount"], pkInfo["Id"])
        if pkInfo["Round"] == 0:
            pkRound = self.getRound(len(teams))
            self.sysMsg("[PK系统] %s%ld强晋级赛开始匹配..." % (pkInfo["EventDescription"], pkRound / 2))
            sql = "update tbl_pk_info set ParticipantCount = %ld where Id = %ld" % (teamCount, pkInfo["Id"])
            self.mysqlClient.execute(sql)
        else:
            pkRound = pkInfo["Round"]
        pkRecord = pkRound / 2
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
                  "(%ld, %ld, %ld, %ld, %s, %s, UNIX_TIMESTAMP())" % (pkInfo["Id"], pkRound, teamA, teamB, teamAName, teamBName)
            self.mysqlClient.execute(sql)

        sql = "update tbl_pk_info set Status = 2, Count = %ld, Round = %ld where Id = %ld" % (pkRecord, pkRecord, pkInfo["Id"])
        self.mysqlClient.execute(sql)
        self.startPk(2)

    def modifyNoBattleTeam(self, count, pkId):
        sql = "select TeamARegNum, TeamBRegNum, WinnerRegNum from tbl_pk_record" \
              " where StartTime = 0 and Status = 2 and Round >= %ld and pkId = %ld;" % (count, pkId)
        teams = self.mysqlClient.query(sql)
        if not teams:
            return
        for team in teams:
            if team["WinnerRegNum"] == team["TeamBRegNum"]:
                sql = "update tbl_pk_team set CurrentRanking = 0 where RegNum = %ld and PkId = %ld;"\
                      % (team["TeamARegNum"], pkId)
            else:
                sql = "update tbl_pk_team set CurrentRanking = 0 where RegNum = %ld and PkId = %ld;" \
                      % (team["TeamBRegNum"], pkId)
            self.mysqlClient.execute(sql)

    def noticePk(self):
        self.sysMsg("[PK系统] 尊敬的参赛者们，请抓紧时间入场，比赛即将开始，期待你们的精彩表现！")
