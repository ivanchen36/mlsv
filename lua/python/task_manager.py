import os
from file_util import FileUtil
import shutil


def getTaskPath(taskDir: str, taskName: str) -> bool:
    try:
        if not os.path.exists(taskDir):
            raise FileNotFoundError(f"路径 {taskDir} 不存在。")
        if not os.path.isdir(taskDir):
            raise NotADirectoryError(f"{taskDir} 不是一个文件夹。")

        for folderName in os.listdir(taskDir):
            taskPath = os.path.join(taskDir, folderName)
            if os.path.isdir(taskPath) and folderName == taskName:
                return taskDir
        return ""
    except FileNotFoundError:
        raise FileNotFoundError(f"路径 {taskDir} 未找到。")
    except NotADirectoryError:
        raise NotADirectoryError(f"{taskDir} 不是一个有效的文件夹路径。")


def handleInstallDir(dataDir, taskDir, task):
    for fileName in os.listdir(taskDir):
        taskFile = os.path.join(taskDir, fileName)
        dataFile = os.path.join(dataDir, fileName)
        if os.path.isdir(taskFile):
            continue
        if ".txt" in fileName:
            handleUninstallFile(dataFile, task)
            handleInstallFile(dataFile, taskFile, task)
            continue
        shutil.copy2(taskFile, dataFile)

def handleInstallFile(dataFilePath, taskFilePath, task):
    if not os.path.exists(taskFilePath):
        return
    taskFile = FileUtil(taskFilePath, "gbk")
    dataFile = FileUtil(dataFilePath, "gbk")
    if not dataFile.isBlankLineEnd():
        dataFile.writeLine("")
    dataFile.writeLine(f"#TASK_START{task}")
    for line in taskFile.readLines():
        if len(line.strip()) == 0:
            continue
        dataFile.writeLine(line.replace("\n", ""))
    dataFile.writeLine(f"#TASK_END{task}")

def handleInstall(dataDir, taskDir, task):
    for fileName in os.listdir(taskDir):
        taskFile = os.path.join(taskDir, fileName)
        dataFile = os.path.join(dataDir, fileName)
        if os.path.isdir(taskFile):
            handleInstallDir(dataFile, taskFile, task)
        else:
            if not os.path.exists(dataFile):
                continue
            handleUninstallFile(dataFile, task)
            handleInstallFile(dataFile, taskFile, task)


def handleUninstallDir(dataDir, taskDir, task):
    for fileName in os.listdir(taskDir):
        taskFile = os.path.join(taskDir, fileName)
        dataFile = os.path.join(dataDir, fileName)
        if os.path.isdir(taskFile):
            continue
        if ".txt" in fileName:
            handleUninstallFile(dataFile, task)
            continue
        if os.path.exists(dataFile):
            os.remove(dataFile)


def handleUninstallFile(dataFilePath,  task):
    if not os.path.exists(dataFilePath):
        return
    dataFile = FileUtil(dataFilePath, "gbk")
    print(dataFilePath)
    startLine = dataFile.findLine(f"#TASK_START{task}")
    if startLine <= 0:
        return
    endLine = dataFile.findLine(f"#TASK_END{task}")
    dataFile.deleteLine(startLine, endLine - startLine + 1)
    if dataFile.isBlankFile():
        del dataFile
        os.remove(dataFilePath)


def handleUninstall(dataDir, taskDir, task):
    for fileName in os.listdir(taskDir):
        taskFile = os.path.join(taskDir, fileName)
        dataFile = os.path.join(dataDir, fileName)
        if os.path.isdir(taskFile):
            handleUninstallDir(dataFile, taskFile, task)
        else:
            handleUninstallFile(dataFile, task)


def installTask(gameDir, task):
    dataDir = os.path.join(gameDir, "data")
    taskDir = os.path.join(gameDir, "task")
    fileName = os.path.join(dataDir, "task.txt")
    taskList = FileUtil(fileName, "gbk")
    lineNum = taskList.findLine(task)
    if lineNum > 0:
        print(f"任务{task}已经安装")
        return
    taskPath = getTaskPath(taskDir, task)
    if taskPath == "":
        print(f"任务{task}未找到")
        return
    handleInstall(dataDir, os.path.join(taskPath,task), task)
    taskList.writeLine(task)
    print(f"任务{task}安装成功")


def uninstallTask(gameDir, task):
    dataDir = os.path.join(gameDir, "data")
    taskDir = os.path.join(gameDir, "task")
    fileName = os.path.join(dataDir, "task.txt")
    taskList = FileUtil(fileName, "gbk")
    lineNum = taskList.findLine(task)
    if lineNum == 0:
        print(f"任务{task}已经卸载")
        return
    taskPath = getTaskPath(taskDir, task)
    if taskPath == "":
        print(f"任务{task}未找到")
        return
    handleUninstall(dataDir, os.path.join(taskPath,task), task)
    taskList.deleteLine(lineNum)
    print(f"任务{task}卸载成功")


if __name__ == "__main__":
    installTask("../../", "羁绊系列任务1-5章")
    uninstallTask("../../", "羁绊系列任务1-5章")