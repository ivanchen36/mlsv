# -*- coding=utf-8 -*-
import os


class FileUtil(object):
    def __init__(self, fileName, encoding="utf-8"):
        self.fp = open(fileName, "a+", encoding=encoding, errors='surrogateescape')
        self.encoding = encoding

    def __del__(self):
        self.fp.close()

    def readLines(self):
        self.fp.seek(0)
        return self.fp.readlines()

    def writeLine(self, line):
        self.fp.write("%s\n" % line)

    def insertLine(self, lineNum, line):
        self.fp.seek(0)
        lines = self.fp.readlines()

        if lineNum > len(lines):
            return False

        lines.insert(lineNum - 1, "%s\n" % line)
        self.fp.truncate(0)
        self.fp.writelines(lines)
        return True

    def deleteLine(self, lineNum, lineCount=1):
        self.fp.seek(0)
        lines = self.fp.readlines()

        if lineNum > len(lines):
            return False
        lines = lines[:lineNum - 1] + lines[lineNum + lineCount - 1:]

        self.fp.truncate(0)
        self.fp.writelines(lines)
        return True

    def updateLine(self, lineNum, line):
        self.fp.seek(0)
        lines = self.fp.readlines()

        if lineNum > len(lines):
            return False

        lines[lineNum - 1] = "%s\n" % line
        self.fp.truncate(0)
        self.fp.writelines(lines)
        return True

    def findLine(self, line):
        self.fp.seek(0)
        lines = self.fp.readlines()

        for i in range(len(lines)):
            if line == lines[i].strip():
                return i + 1

        return 0

    def isBlankFile(self):
        for line in self.readLines():
            if line.strip() != "":
                return False

        return True

    def isBlankLineEnd(self):
        self.fp.seek(0, os.SEEK_END)
        size = self.fp.tell()
        if 0 == size:
            return True
        self.fp.seek(size - 1)
        last_char = self.fp.read(1)
        return last_char == '\n'

    def test(self):
        self.fp.seek(0)
        lines = self.fp.readlines()

        self.fp.truncate(0)
        self.fp.writelines(lines)
