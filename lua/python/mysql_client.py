#!/usr/bin/env python

# -*- coding=utf-8 -*-

import time
import copy
import itertools
import logging
import MySQLdb
from DBUtils.PooledDB import PooledDB

class Row(dict):
    def __getattr__(self, name):
        try:
            return self[name]
        except KeyError:
            raise AttributeError(name)

class MysqlClient(object):
    def __init__(self, host, port, db, user, passwd):
        self.host = host
        self.last_use_time = 0
        self.max_idle_time = 1800
        self.config = {}
        self.config["host"] = host
        self.config["port"] = port
        self.config["db"] = db
        self.config["user"] = user
        self.config["passwd"] = passwd
        self.config["charset"] = 'utf8'
        self.db = None

        try:
            self.reconnect()
        except Exception:
            logging.error("Cannot connect to MySQL on %s", self.host)

class MysqlClient(object):
    def __init__(self, host, port, db, user, passwd):
        self.config = {
            "host": host,
            "port": port,
            "db": db,
            "user": user,
            "passwd": passwd,
            "charset": 'utf8'
        }
        self.pool = PooledDB(MySQLdb, mincached=1, maxcached=20, **self.config)

    def __del__(self):
        self.close()

    def close(self):
        """Closes this database connection."""
        if getattr(self, "db", None) is not None:
            self.db.close()
            self.db = None

    def reconnect(self):
        # With connection pooling, reconnect simply retrieves a connection from the pool
        self.db = self.pool.connection()

    def begin(self):
        self.db.autocommit(False)

    def commit(self):
        self.db.commit()
        self.db.autocommit(True)

    def rollback(self):
        self.db.rollback()
        self.db.autocommit(True)

    def iter(self, query, *parameters):
        """Returns an iterator for the given query and parameters."""
        self.ensure_connected()
        cursor = MySQLdb.cursors.SSCursor(self.db)
        try:
            self.executeSql(cursor, query, parameters)
            column_names = [d[0] for d in cursor.description]
            for row in cursor:
                yield Row(zip(column_names, row))
        finally:
            cursor.close()

    def query(self, query, *parameters):
        """Returns a row list for the given query and parameters."""
        cursor = self.cursor()
        try:
            self.executeSql(cursor, query, parameters)
            column_names = [d[0] for d in cursor.description]
            return [Row(itertools.izip(column_names, row)) for row in cursor]
        finally:
            cursor.close()

    def get(self, query, *parameters):
        """Returns the first row returned for the given query."""
        rows = self.query(query, *parameters)
        if not rows:
            return None
        elif len(rows) > 1:
            raise Exception("Multiple rows returned for Database.get() query")
        else:
            return rows[0]

    # rowcount is a more reasonable default return value than lastrowid,
    # but for historical compatibility executeSql() must return lastrowid.
    def execute(self, query, *parameters):
        """Executes the given query, returning the lastrowid from the query."""
        return self.execute_lastrowid(query, *parameters)

    def execute_lastrowid(self, query, *parameters):
        """Executes the given query, returning the lastrowid from the query."""
        cursor = self.cursor()

        try:
            self.executeSql(cursor, query, parameters)
            return cursor.lastrowid
        finally:
            cursor.close()

    def execute_rowcount(self, query, *parameters):
        """Executes the given query, returning the rowcount from the query."""
        cursor = self.cursor()
        try:
            self.executeSql(cursor, query, parameters)
            return cursor.rowcount
        finally:
            cursor.close()
            return -1

    def executemany(self, query, parameters):
        """Executes the given query against all the given param sequences.

        We return the lastrowid from the query.
        """
        return self.executemany_lastrowid(query, parameters)

    def executemany_lastrowid(self, query, parameters):
        """Executes the given query against all the given param sequences.

        We return the lastrowid from the query.
        """
        cursor = self.cursor()
        try:
            cursor.executemany(query, parameters)
            return cursor.lastrowid
        finally:
            cursor.close()

    def executemany_rowcount(self, query, parameters):
        """Executes the given query against all the given param sequences.

        We return the rowcount from the query.
        """
        cursor = self.cursor()
        try:
            cursor.executemany(query, parameters)
            return cursor.rowcount
        finally:
            cursor.close()

    def ensure_connected(self):
        # Mysql by default closes client connections that are idle for
        # 8 hours, but the client library does not report this fact until
        # you try to perform a query and it fails.  Protect against this
        # case by preemptively closing and reopening the connection
        # if it has been idle for too long (7 hours by default).
        if (self.db is None or
            (time.time() - self.last_use_time > self.max_idle_time)):
            self.reconnect()

    def cursor(self):
        if self.db is None:
            self.reconnect()
        return self.db.cursor()

    def executeSql(self, cursor, query, parameters):
        try:
            return cursor.execute(query, parameters)
        except MySQLdb.OperationalError:
            logging.error("Error connecting to MySQL on %s", self.host)
            self.close()
            raise
        finally:
            cursor.close()
