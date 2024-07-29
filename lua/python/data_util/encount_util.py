import os
from file_util import FileUtil

eid = 0
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



def initEncountField():
    tpl = ""
    arr = tpl.split("\t")
    for i in range(len(arr)):
        tmp = arr[i].strip()
        if len(tmp) > 0 and tmp != "-1" and tmp != "0":
            print(f"{tmp} = {i}")


if __name__ == "__main__":
    #generateEnemy("../../../task/chx")
    initEncountField()