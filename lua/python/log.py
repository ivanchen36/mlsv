# -*- coding: utf-8 -*-
import inspect
import logging
import os
from logging.handlers import TimedRotatingFileHandler


class Log(object):
    def __init__(self, workPath, fileName):
        self.infoLogger = logging.getLogger(fileName)
        self.level = logging.DEBUG
        self.initLogger(self.infoLogger, workPath + "/" + fileName + ".log")

    def initLogger(self, logger, logFile):
        handler = TimedRotatingFileHandler(logFile, when='midnight', interval=1, backupCount=3, delay=True)
        handler.setLevel(self.level)
        formatter = logging.Formatter('%(asctime)s-[%(cusFuncName)s:%(cusLineno)d]%(levelname)s %(message)s',
                                      datefmt="%Y-%m-%d %H:%M:%S")
        handler.setFormatter(formatter)
        logger.addHandler(handler)
        logger.setLevel(self.level)

    @staticmethod
    def getExt(stack, ext):
        if ext is None:
            funcName = os.path.basename(stack[1][1]).split(".")[0] + "." + stack[1][3]
            lineNo = stack[1][2]
            return {'cusFuncName': funcName, 'cusLineno': lineNo}
        return ext

    def info(self, msg, ext=None):
        self.infoLogger.info(msg, extra=Log.getExt(inspect.stack(), ext))

    def debug(self, msg, ext=None):
        self.infoLogger.debug(msg, extra=Log.getExt(inspect.stack(), ext))

    def warning(self, msg, ext=None):
        self.infoLogger.warning(msg, extra=Log.getExt(inspect.stack(), ext))

    def error(self, msg, ext=None):
        self.infoLogger.debug(msg, extra=Log.getExt(inspect.stack(), ext))
