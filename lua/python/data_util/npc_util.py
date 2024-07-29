import os
from file_util import FileUtil


def generateNpc(path):
    name = 1
    id1 = 2
    od2 = 3
    template = "Event	name	0	1930010	0	1	1	0	59530	81	133	81	133	81	133	81	133	1	60000	4	103010	0	1	0	file"
    arr = template.split("\t")
    print('\t'.join(arr))
    print(len(arr))
    print(path + "/enemybase.txt")
    npcFile = FileUtil(path + "/npc.txt", "gbk")
    if not npcFile.isBlankLineEnd():
        npcFile.writeLine("")
    for line in npcFile.readLines():
        arr1 = line.split("\t")

        #enemyFile.writeLine('\t'.join(arr))

if __name__ == "__main__":
    generateNpc("../../../../task/chx")