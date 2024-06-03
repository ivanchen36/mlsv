import os

from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler


class ConfigObserver(FileSystemEventHandler):
    def __init__(self, log):
        self.observer = Observer()
        self.log = log
        self.eventHandler = {}

    def registerEvent(self, fileName, func):
        self.eventHandler[fileName] = func

    def startObserver(self, filePath):
        try:
            self.observer.schedule(self, path=filePath, recursive=False)
            self.observer.start()
            self.log.debug("Observer started.")
        except Exception as e:
            self.log.error(f"Error starting observer: {e}")

    def on_modified(self, event):
        self.log.debug("on_modified ")
        fileName = os.path.basename(event.src_path)
        if fileName in self.eventHandler:
            self.eventHandler[fileName]()
