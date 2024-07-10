import os
from file_util import FileUtil
import shutil

unknown = 0 #未鉴定
name = 1 #名称
script = 2 #使用效果
menu = 5 #道具功能
id = 11 #编号
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
itemFieldNum = 0

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
            arr[0] = "%sLv%d"% (techArr[i], + (j + 1))
            arr[3] = str(id)
            print ('\t'.join(arr))
            techFile.writeLine('\t'.join(arr))
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
        line = line.strip()
        arr1 = line.split("\t")
        arr[name] = arr1[0]
        arr[id1] = arr1[1]
        arr[od2] = arr1[1]
        print('\t'.join(arr))
        #enemyFile.writeLine('\t'.join(arr))

if __name__ == "__main__":
    generateTech("../../task/chx")