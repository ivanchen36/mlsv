import os
from file_util import FileUtil
import shutil

unknown = 0 #未鉴定
name = 1 #名称
script = 2 #使用效果
menu = 5 #道具功能
iid = 11 #编号
img = 12 #图档
price = 13 #卖价
type = 14 #种类
battle = 18 #可战斗使用
obj = 19 #战斗使用对象
collect1 = 20 #最小采集
collect2 = 21 #最大采集
num = 22 #堆叠数量
level = 23 #道具等级
remain = 25 #耐久
remain1 = 26
atkNum = 27#攻击次数
atkNum1 = 28
atk = 31 #攻击
atk1 = 32
deff = 33 #防御
deff1 = 34
agi = 35 #敏捷
agi1 = 36
spirit = 37 #精神
spirit1 = 38
recover = 39 #回复
recover1 = 40
crit = 41 #必杀
crit1 = 42
counter = 43 #反击
counter1 = 44
hit = 45 #命中
hit1 = 46
avoid = 47 #躲闪
avoid1 = 48
hp = 49 #生命
hp1 = 50
mp = 51 #魔力
mp1 = 52
luck = 53 #幸运
luck1 = 54
charm = 57 #魅力
charm1 = 58
attr1 = 59 #属性1
attr2 = 60 #属性2
attr1Val = 61 #属性1值
attr2Val = 62
endurance = 63 #耐力
endurance1 = 64 #耐力
dex = 65 #智力
dex1 = 66
intel = 67 #智力
intel1 = 68
poison = 69 #中毒
poison1 = 70
sleep = 71 #昏睡
sleep1 = 72
stone = 73 #石化
stone1 = 74
drunk = 75 #醉酒
drunk1 = 76
confusion = 77 #混乱
confusion1 = 78
amnesia = 79 #遗忘
amnesia = 80
special = 81 #特殊功能
param1 = 82
param2 = 83
jewel1 = 84 #宝石1
jewel2 = 85
jewel3 = 86
rss = 91 #抗魔
rss1 = 92
msg1 = 94 #说明
msg2 = 95 #右键
identify = 96 #被鉴定率
adm = 99 #魔攻
adm1 = 100
itemFieldNum = 102

def generateItem(path):
    baseFile = FileUtil("./tmp.txt", "gbk")
    itemFile = FileUtil(path + "/itemset.txt", "gbk")
    if not itemFile.isBlankLineEnd():
        itemFile.writeLine("")
    lineNum = 1
    baseId = 40200
    for line in baseFile.readLines():
        level = int((lineNum - 1) / 8) + 1
        index = lineNum % 8
        if index == 0:
            index = 8
        tmpId = (level - 1) * 10 + baseId + index
        line = line.replace("\n", "")
        arr1 = line.split("\t")
        arr1[iid] = tmpId
        arr1[remain] = 233
        arr1[remain1] = 399
        if index == 1 or index == 2:
            arr1[atk] = 30 * level
            arr1[atk1] = 50 * level
        else:
            arr1[atk] = 0
            arr1[atk1] = 0
        if index == 4:
            arr1[deff] = 9 * level
            arr1[deff1] = 15 * level
        else:
            arr1[deff] = 0
            arr1[deff1] = 0
        if index == 5:
            arr1[agi] = 17 * level
            arr1[agi1] = 29 * level
        else:
            arr1[agi] = 0
            arr1[agi1] = 0
        if index == 3:
            arr1[spirit] = 12 * level
            arr1[spirit1] = 20 * level
        else:
            arr1[spirit] = 0
            arr1[spirit1] = 0
        if index == 6:
            arr1[hp] = 60 * level
            arr1[hp1] = 100 * level
        else:
            arr1[hp] = 0
            arr1[hp1] = 0
        if index == 7:
            arr1[mp] = 60 * level
            arr1[mp1] = 100 * level
        else:
            arr1[mp] = 0
            arr1[mp1] = 0
        arr1 = [str(item) for item in arr1]
        print('\t'.join(arr1))
        lineNum = lineNum + 1
        itemFile.writeLine('\t'.join(arr1))

def generateItem1(path):
    baseFile = FileUtil("./tmp.txt", "gbk")
    itemFile = FileUtil(path + "/itemset.txt", "gbk")
    if not itemFile.isBlankLineEnd():
        itemFile.writeLine("")
    lineNum = 1
    baseId = 40299
    for line in baseFile.readLines():
        line = line.replace("\n", "")
        arr1 = line.split("\t")
        arr1[iid] = baseId
        baseId = baseId - 1
        arr1 = [str(item) for item in arr1]
        print('\t'.join(arr1))
        lineNum = lineNum + 1
        itemFile.writeLine('\t'.join(arr1))

def pringArrStr():
    tmpList = ["青铜","白银","黄金","钻石","星耀","王者","荣耀"]
    index = -1
    for line in tmpList:
        index = index + 1
        print(f'["{line}"] = {{')
        for i in range(8):
            if i == 2:
                print(f'[{40201 + index * 10 + i}] = {{{40299 - index * 2}, 20}},')
            elif i <= 2:
                print(f'[{40201 + index * 10 + i}] = {{{40299 - index * 2}, 10}},')
            else:
                print(f'[{40201 + index * 10 + i}] = {{{40299 - index * 2 - 1}, 10}},')
        print('},')

if __name__ == "__main__":
    #generateItem1("../../../task/chx")
    pringArrStr()
