import os
from file_util import FileUtil
import shutil


def generateEnemy(path):
    name = 0
    id1 = 2
    od2 = 3
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
        arr[name] = arr1[0]
        arr[id1] = arr1[1]
        arr[od2] = arr1[1]
        print('\t'.join(arr))
        #enemyFile.writeLine('\t'.join(arr))


if __name__ == "__main__":
    generateEnemy("../../../task/chx")