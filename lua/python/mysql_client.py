#!/usr/bin/env python

# -*- coding: utf-8 -*-

import itertools
import logging
import time

import MySQLdb
from dbutils.pooled_db import PooledDB

class Row(dict):
    def __getattr__(self, name):
        try:
            return self[name]
        except KeyError:
            raise AttributeError(name)

class MysqlClient(object):
    def __init__(self, host, port, db, user, passwd, charset="utf8"):
        self.config = {
            "host": host,
            "port": port,
            "db": db,
            "user": user,
            "passwd": passwd,
            "charset": charset,
            "autocommit": True
        }
        self.db = None
        self.pool = PooledDB(MySQLdb, mincached=1, maxcached=20, **self.config)

    def __del__(self):
        self.close()

    def close(self):
        """Closes this database connection."""
        if self.db is not None:
            self.db.close()
            self.db = None

    def reconnect(self):
        # With connection pooling, reconnect simply retrieves a connection from the pool
        self.db = self.pool.connection()

    def begin(self):
        self.cursor().execute("SET autocommit = 0")
        self.db.begin()

    def commit(self):
        cursor = self.cursor()
        self.db.commit()
        cursor.execute("SET autocommit = 1")

    def rollback(self):
        cursor = self.cursor()
        self.db.rollback()
        cursor.execute("SET autocommit = 1")

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
        return self.execute_rowcount(query, *parameters)

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

    def executemany(self, query, parameters):
        """Executes the given query against all the given param sequences.

        We return the lastrowid from the query.
        """
        return self.executemany_rowcount(query, parameters)

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
            if self.config["charset"] == 'gbk':
                query = query.encode('gbk')
            return cursor.execute(query, parameters)
        except MySQLdb.OperationalError:
            logging.error("Error connecting to MySQL on %s", self.host)
            self.close()
            raise
        finally:
            cursor.close()
