import os
from file_util import FileUtil

NAME = 0
TECH_ID = 3
MSG_ID = 4
SKILL_ID = 5
LEVEL = 6
LEN = 15

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

def getString(arr):
    arr = [str(item) for item in arr]
    cur = len(arr)
    if len(arr) < LEN:
        for i in range(cur, LEN):
            arr.append("")
    return '\t'.join(arr)

def modifyTechLevel(path):
    tmpFile = FileUtil("./tmp.txt", "gbk")
    techFile = FileUtil(path + "/tech.txt", "gbk")
    if not tmpFile.isBlankLineEnd():
        techFile.writeLine("")
    for line in tmpFile.readLines():
        line = line.replace("\r", "").replace("\n", "")
        arr = line.split("\t")
        arr[LEVEL] = "30"
        str = getString(arr)
        print(len((str).split("\t")))
        techFile.writeLine(getString(arr))

def genDisableTech(path):
    template = "name	TECH_Breed	AR:0,	30401	16004	70	30	1	1141			0	1		"
    arr = template.split("\t")
    tmpFile = FileUtil("./tmp.txt", "gbk")
    techFile = FileUtil(path + "/tech.txt", "gbk")
    if not tmpFile.isBlankLineEnd():
        techFile.writeLine("")
    for line in tmpFile.readLines():
        line = line.replace("\r", "").replace("\n", "")
        arr1 = line.split("\t")
        arr[TECH_ID] = int(arr1[TECH_ID]) + 1000000
        arr[MSG_ID] = arr1[MSG_ID]
        arr[NAME] = arr1[NAME]
        tmp = getString(arr)
        print(tmp)
        techFile.writeLine(tmp)

def genDisableTech(path):
    tmpFile = FileUtil("./tmp.txt", "gbk")
    techFile = FileUtil(path + "/petweapon.txt", "gbk")
    if not tmpFile.isBlankLineEnd():
        techFile.writeLine("")
    for line in tmpFile.readLines():
        line = line.replace("\r", "").replace("\n", "")
        arr1 = line.split("\t")
        tmp = f'{int(arr1[2]) + 1000000} 4'
        print(tmp)
        techFile.writeLine(tmp)
    for i in range(30001, 30100):
        tmp = f'{1000000 + i} 4'
        print(tmp)
        techFile.writeLine(tmp)

skillList = [
    {200, 201,202},
    {208,210,211,213},
    {207,209,212,214},
    {203,204,205,206}
]
def genDisableTech(path):
    tmpFile = FileUtil("./tmp.txt", "gbk")
    skillLvFile = FileUtil(path + "/../../data/skilllv.txt", "gbk")
    id = 0
    for line in skillLvFile.readLines():
        line = line.replace("\r", "").replace("\n", "")
        arr1 = line.split("\t")
        if len(arr1) < 3:
            continue
        id = int(arr1[0])
    if not tmpFile.isBlankLineEnd():
        skillLvFile.writeLine("")
    jobList = [3000, 4000, 5000, 6000]
    for index in range(4):
        jobId = jobList[index]
        jobSkillList = skillList[index]
        for line in tmpFile.readLines():
            line = line.replace("\r", "").replace("\n", "")
            arr1 = line.split("\t")
            if len(arr1) < 3:
                continue
            id = id + 1
            jobIndex = int(arr1[2]) - 200
            arr1[0] = str(id)
            if int(arr1[1]) in jobSkillList:
                if jobIndex == 1:
                    arr1[3] = "4"
                elif jobIndex == 2:
                    arr1[3] = "6"
                elif jobIndex == 3:
                    arr1[3] = "8"
                elif jobIndex >= 4:
                    arr1[3] = "10"
            arr1[2] = str(jobIndex + jobId)
            print('\t'.join(arr1))
            skillLvFile.writeLine('\t'.join(arr1))


def copyJobSkill(path):
    tmpFile = FileUtil("./tmp.txt", "gbk")
    skillLvFile = FileUtil(path + "/skilllv.txt", "gbk")
    id = 115498
    if not tmpFile.isBlankLineEnd():
        skillLvFile.writeLine("")
    jobSet = {155, 19}
    for index in range(4):
        for line in tmpFile.readLines():
            line = line.replace("\r", "").replace("\n", "")
            arr1 = line.split("\t")
            if len(arr1) < 3:
                continue
            id = id + 1
            jobId = int(int(arr1[2]) / 10)
            if jobId not in jobSet:
                continue
            print('\t'.join(arr1))
            skillLvFile.writeLine('\t'.join(arr1))

if __name__ == "__main__":
    #modifyTechNo("../../../task/chx")
    copyJobSkill("../../../task/chx")