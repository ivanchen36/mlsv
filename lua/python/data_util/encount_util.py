import os
from file_util import FileUtil
from enemy_util import copyEnemy
from data_util import getString

class Encount:
    eid = 0;
    mid = 3
    sx1 = 4
    sy1 = 5
    ex1 = 6
    ey1 = 7
    maxNum = 10
    priority = 11
    nextId = 12
    nextgrate = 13
    g1 = 14
    g2 = 15
    g3 = 16
    g4 = 17
    g5 = 18
    g6 = 19
    g7 = 20
    g8 = 21
    g9 = 22
    g10 = 23
    gr1 = 24
    gr2 = 25
    gr3 = 26
    gr4 = 27
    gr5 = 28
    gr6 = 29
    gr7 = 30
    gr8 = 31
    gr9 = 32
    gr10 = 33
    ENCOUNT_LEN = 34


class Group:
    name = 0
    gid = 2
    e1 = 5
    e2 = 6
    e3 = 7
    e4 = 8
    e5 = 9
    e6 = 10
    e7 = 11
    e8 = 12
    e9 = 13
    e10 = 14
    er1 = 15
    er2 = 16
    er3 = 17
    er4 = 18
    er5 = 19
    er6 = 20
    er7 = 21
    er8 = 22
    er9 = 23
    er0 = 24
    GROUP_LEN = 35

newEnemyId = 35000
newGroupId = 35000
enemyList = [Group.e1, Group.e2, Group.e3, Group.e4, Group.e5, Group.e6, Group.e7, Group.e8, Group.e9, Group.e10]
def copyGroup(path, groupId):
    global newEnemyId
    global newGroupId

    groupFile = FileUtil(path + "/../../data/group.txt", "gbk")
    groupFile1 = FileUtil(path + "/group.txt", "gbk")
    for line in groupFile.readLines():
        arr1 = line.split("\t")
        if len(arr1) < 5:
            continue
        if int(arr1[Group.gid]) != groupId:
            continue

        for eIndex in enemyList:
            newEnemyId = newEnemyId + 1

            if len(arr1[eIndex]) > 0 and arr1[eIndex] != "0":
                copyEnemy(path, int(arr1[eIndex]), newEnemyId)
                arr1[eIndex] = str(newEnemyId)
        newgroupId = newGroupId + 1
        arr1[Group.gid] = str(newGroupId)

        getString(arr1, Group.GROUP_LEN)
        #groupFile1.writeLine(getString(arr1, Group.GROUP_LEN))
    return newGroupId

newEncountId = 30000
groupList = [Encount.g1, Encount.g2, Encount.g3, Encount.g4, Encount.g5, Encount.g6, Encount.g7, Encount.g8, Encount.g9, Encount.g10]

def copyEncount(path, encountId):
    global newEncountId
    encountFile = FileUtil(path + "/../../data/encount.txt", "gbk")
    encountFile1 = FileUtil(path + "/encount.txt", "gbk")
    for line in encountFile.readLines():
        arr1 = line.split("\t")
        if len(arr1) < 5:
            continue
        if int(arr1[Encount.eid]) != encountId:
            continue
        for gIndex in groupList:
            if len(arr1[gIndex]) > 0 and arr1[gIndex] != "0":
                newGroupId = copyGroup(path, int(arr1[gIndex]))
                arr1[gIndex] = str(newGroupId)
        newEncountId = newEncountId + 1
        arr1[Encount.eid] = str(newEncountId)

        getString(arr1, Encount.ENCOUNT_LEN)
        #encountFile1.writeLine(getString(arr1, Encount.ENCOUNT_LEN))

if __name__ == "__main__":
    #generateEnemy("../../../task/chx")
    copyEncount("../../../task/chx", 1032)