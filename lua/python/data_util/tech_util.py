import os
from file_util import FileUtil
import shutil

NAME = 0
TECH_ID = 3
SKILL_ID = 5

def readTech(path, func):
    techFile = FileUtil(path + "/../../data/tech.txt", "gbk")
    for line in techFile.readLines():
        arr1 = line.split("\t")
        if len(arr1) < 5:
            continue
        func(arr1)
def getTechMaxNo(path, skillId):
    maxId = 0
    def getMaxId(arr):
        nonlocal maxId
        tid = int(arr[TECH_ID])
        if skillId != int(arr[SKILL_ID]):
            return
        if tid > maxId:
            maxId = tid
    readTech(path, getMaxId)

    return maxId

techArr = ["百毒不侵","悬梁刺股","镜盾反射","众人皆醉","乱中有序","永生难忘","生命脉动","魔力共鸣","防御壁垒","迅捷疾风","致命打击","心灵之眼","生命不息","致命绽放","混沌波动","永恒之壁"]
def generateTech(path):
    template = "name	TECH_Breed	AR:0,	id1	130070	70	10	1	1141			0	1		"
    arr = template.split("\t")
    techFile = FileUtil(path + "/tech.txt", "gbk")
    if not techFile.isBlankLineEnd():
        techFile.writeLine("")
    for i in range(len(techArr)):
        for j in range(3):
            id = 30401 + i + j * 30
            arr[NAME] = "%sLv%d"% (techArr[i], + (j + 1))
            arr[TECH_ID] = str(id)
            print ('\t'.join(arr))
            techFile.writeLine('\t'.join(arr))

def modifyTechNo(path):
    techId = {}
    techFile = FileUtil(path + "/tech.txt", "gbk")
    tmpFile = FileUtil(path + "/tech_tmp.txt", "gbk")
    if not tmpFile.isBlankLineEnd():
        tmpFile.writeLine("")
    for line in techFile.readLines():
        line = line.replace("\r", "").replace("\n", "")
        arr = line.split("\t")
        skillId = int(arr[SKILL_ID])
        if skillId in techId:
            tid = techId[skillId] + 1
            print("%d %d" % (skillId, tid))
            techId[skillId] = tid
        else:
            tid = getTechMaxNo(path, skillId) + 1
            print("%d %d" % (skillId, tid))
            techId[skillId] = tid

        arr[TECH_ID] = str(tid)
        print('\t'.join(arr))
        tmpFile.writeLine('\t'.join(arr))
    del techFile
    del tmpFile
    os.remove(path + "/tech.txt")
    os.rename(path + "/tech_tmp.txt", path + "/tech.txt")

if __name__ == "__main__":
    modifyTechNo("../../../task/chx")