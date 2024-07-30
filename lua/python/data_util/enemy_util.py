import os
from file_util import FileUtil
from data_util import getString

class Enemy:
    name = 0
    eId = 2
    bId = 3
    ENEMY_LEN = 48

class EnemyBase:
    name = 0
    bId = 1
    ENEMY_BASE_LEN = 46

def copyEnemy(path, enemyId, newEnemyId):
    enemyFile = FileUtil(path + "/../../data/enemy.txt", "gbk")
    enemyFile1 = FileUtil(path + "/enemy.txt", "gbk")
    for line in enemyFile.readLines():
        arr1 = line.split("\t")
        if len(arr1) < 5:
            continue
        if int(arr1[Enemy.eId]) != enemyId:
            continue

        newEnemyId = newEnemyId + 1
        copyEnemyBase(path, Enemy.bId, newEnemyId)
        arr1[Enemy.eId] = str(newEnemyId)

        getString(arr1, Enemy.ENEMY_LEN)
        #enemyFile1.writeLine(getString(arr1, Enemy.ENEMY_LEN))

def copyEnemyBase(path, enemyBaseId, newEnemyBaseId):
    enemyBaseFile = FileUtil(path + "/../../data/enemybase.txt", "gbk")
    enemyBaseFile1 = FileUtil(path + "/enemybase.txt", "gbk")
    for line in enemyBaseFile.readLines():
        arr1 = line.split("\t")
        if len(arr1) < 5:
            continue
        if int(arr1[Enemy.eId]) != enemyBaseId:
            continue

        newEnemyId = newEnemyId + 1
        arr1[Enemy.eId] = str(newEnemyBaseId)

        getString(arr1, EnemyBase.ENEMY_BASE_LEN)
        #enemyBaseFile1.writeLine(getString(arr1, EnemyBase.ENEMY_BASE_LEN))

def generateEnemy(path):
    template = "name	at:10;1;1|gu:1|es:1|wa:0;0;0;0;0;0;0;	id1	id2	1	1	1	1	0	-1	-1	0	1																															0	0			0"
    arr = template.split("\t")
    print('\t'.join(arr))
    print(len(arr))
    print(path + "/enemybase.txt")
    baseFile = FileUtil(path + "/enemybase.txt", "gbk")
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
        #enemyFile.writeLine('\t'.join(arr))


if __name__ == "__main__":
    generateEnemy("../../../task/chx", 1)