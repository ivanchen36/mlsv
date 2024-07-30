import os

def getString(arr, arrLen):
    arr = [str(item) for item in arr]
    cur = len(arr)
    if len(arr) < arrLen:
        for i in range(cur, arrLen):
            arr.append("")
    tmp = '\t'.join(arr)
    tmp = tmp.replace("\n", "")
    print(tmp)
    return tmp

def initDataField():
    tpl = "0		0	-1	-1	1	2	3	4	5	6	0	0	0	0	1	1	1	1	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0"
    arr = tpl.split("\t")
    print(len(arr))
    return
    for i in range(len(arr)):
        tmp = arr[i].strip()
        if len(tmp) > 0 and tmp != "-1" and tmp != "0":
            print(f"{tmp} = {i}")

if __name__ == "__main__":
    initDataField()