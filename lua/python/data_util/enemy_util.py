import os
from file_util import FileUtil
from data_util import getString

class Enemy:
    name = 0
    eId = 2
    bId = 3
    ai = 8
    ENEMY_LEN = 48

class EnemyBase:
    name = 0
    bId = 1
    ENEMY_BASE_LEN = 46

class EnemyAi:
    aId = 0
    ENEMY_AI_LEN = 41

def copyEnemy(path, enemyId, newEnemyId):
    enemyFile = FileUtil(path + "/../../data/enemy.txt", "gbk")
    enemyFile1 = FileUtil(path + "/enemy.txt", "gbk")
    for line in enemyFile.readLines():
        arr1 = line.split("\t")
        if len(arr1) < 5:
            continue
        if int(arr1[Enemy.eId]) == enemyId:
            if arr1[Enemy.ai] != "0" or arr1[Enemy.ai]!= "":
                copyEnemyAi(path, int(arr1[Enemy.ai]), newEnemyId)
            copyEnemyAi(path, int(arr1[Enemy.ai]), newEnemyId)
            copyEnemyBase(path, int(arr1[Enemy.bId]), newEnemyId)
            arr1[Enemy.eId] = str(newEnemyId)
            arr1[Enemy.bId] = str(newEnemyId)

            #getString(arr1, Enemy.ENEMY_LEN)
            enemyFile1.writeLine(getString(arr1, Enemy.ENEMY_LEN))
            return

def copyEnemyBase(path, enemyBaseId, newEnemyBaseId):
    print("copyEnemyBase", path, enemyBaseId, newEnemyBaseId)
    enemyBaseFile = FileUtil(path + "/../../data/enemybase.txt", "gbk")
    enemyBaseFile1 = FileUtil(path + "/enemybase.txt", "gbk")
    for line in enemyBaseFile.readLines():
        arr1 = line.split("\t")
        if len(arr1) < 5:
            continue

        if int(arr1[EnemyBase.bId]) == enemyBaseId:
            arr1[EnemyBase.bId] = str(newEnemyBaseId)

            #getString(arr1, EnemyBase.ENEMY_BASE_LEN)
            enemyBaseFile1.writeLine(getString(arr1, EnemyBase.ENEMY_BASE_LEN))
            return

def copyEnemyAi(path, enemyAiId, newEnemyAiId):
    print("copyEnemyAi", path, enemyAiId, newEnemyAiId)
    enemyAiFile = FileUtil(path + "/../../data/enemyai.txt", "gbk")
    enemyAiFile1 = FileUtil(path + "/enemyai.txt", "gbk")
    for line in enemyAiFile.readLines():
        arr1 = line.split("\t")
        if len(arr1) < 5:
            continue

        if int(arr1[EnemyAi.aId]) == enemyAiId:
            arr1[EnemyAi.aId] = str(newEnemyAiId)

            #getString(arr1, EnemyBase.ENEMY_BASE_LEN)
            enemyAiFile1.writeLine(getString(arr1, EnemyAi.ENEMY_AI_LEN))
            return

def generateEnemy(path):
    template = "name	at:10;1;1|gu:1|es:1|wa:0;0;0;0;0;0;0;	id1	id2	1	1	1	1	0	-1	-1	0	1																															0	0			0"
    arr = template.split("\t")
    print('\t'.join(arr))
    print(len(arr))
    print(path + "/enemybase.txt")
    baseFile = FileUtil("./tmp.txt", "gbk")
    enemyFile = FileUtil(path + "/enemy.txt", "gbk")
    if not enemyFile.isBlankLineEnd():
        enemyFile.writeLine("")
    for line in baseFile.readLines():
        line = line.replace("\n", "")
        arr1 = line.split("\t")
        arr[Enemy.name] = arr1[EnemyBase.name]
        arr[Enemy.eId] = arr1[EnemyBase.bId]
        arr[Enemy.bId] = arr1[EnemyBase.bId]
        print('\t'.join(arr))
        enemyFile.writeLine('\t'.join(arr))


if __name__ == "__main__":
    generateEnemy("../../../task/chx")