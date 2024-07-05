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

def parseTemplate():
    keuMap = {
        "111": "id",
        "1": "unknown",
        "222" : "img",
        "2": "name",
        "3": "type",
        "4": "price",
        "5": "obj",
        "6": "level",
        "7": "battle",
        "8": "identify",
        "9": "num",
        "10": "msg1",
        "11": "msg2",
        "12": "atk",
        "13": "atk1",
        "14": "def",
        "15": "def1",
        "16": "agi",
        "17": "agi1",
        "18": "spirit",
        "19": "spirit1",
        "20": "recover",
        "21": "recover1",
        "22": "hp",
        "23": "hp1",
        "24": "mp",
        "25": "mp1",
        "26": "luck",
        "27": "luck1",
        "28": "endurance",
        "29": "endurance1",
        "30": "remain",
        "31": "remain1",
        "32": "crit",
        "33": "crit1",
        "34": "counter",
        "35": "counter1",
        "36": "hit",
        "37": "hit1",
        "38": "avoid",
        "39": "avoid1",
        "40": "atkNum",
        "41": "atkNum1",
        "42": "charm",
        "43": "charm1",
        "44": "rss",
        "45": "rss1",
        "46": "adm",
        "47": "adm1",
        "48": "dex",
        "49": "dex1",
        "50": "poison",
        "51": "poison1",
        "52": "sleep",
        "53": "sleep1",
        "54": "stone",
        "55": "stone1",
        "56": "drunk",
        "57": "drunk1",
        "58": "confusion",
        "59": "confusion1",
        "60": "amnesia",
        "61": "amnesia",
        "89": "attr1",
        "90": "attr2",
        "62": "attr1Val",
        "63": "attr2Val",
        "64": "intel",
        "65": "intel1",
        "68": "special",
        "69": "param1",
        "70": "param2",
        "71": "jewel1",
        "72": "jewel2",
        "73": "jewel3",
        "74": "collect1",
        "75": "collect2",
        "txt": "script",
        "ITEM_useMystery": "menu"
    }
    tempFile = FileUtil("./template.txt", "gbk")
    for line in tempFile.readLines():
        if len(line.strip()) == 0:
            continue
        print(line)
        arr = line.split("\t")
        print(arr)
        print('\t'.join(arr))
    for i in range(len(arr)):
        if arr[i] in  keuMap:
            print(f"{keuMap[arr[i]]} = {i}")
            print(f"{keuMap[arr[i]]} = {arr[i]}")

if __name__ == "__main__":
    parseTemplate()