#!/usr/bin/env python
# encoding: utf-8
"""
@project:artist-database-init
@author:cloudy
@site:
@file:databases_init.py
@date:2018/1/17 15:23
"""

import MySQLdb
import os
import yaml


def create_databases(base_config):
    """
    创建数据库
    :param base_config: 数据库基础链接信息
    :return:
    """
    conn = MySQLdb.connect(host=base_config['address'],
                           user=base_config['user'],
                           passwd=base_config['password'],
                           port=base_config['port'])

    # 文件前缀
    file_prefix = base_config['file_prefix']
    if not file_prefix:
        file_prefix = ""
    # 数据库前缀
    prefix = base_config['prefix']
    # 数据库列表
    db_list = base_config['db_list']
    cur = conn.cursor()
    # 创建所有的数据库
    for database_name in db_list:
        if database_name:
            database_name = database_name.strip('\n')
            sql = "drop database if exists `{}`;".format(prefix + database_name)
            cur.execute(sql)
            sql = "CREATE DATABASE `{}` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;".format(prefix + database_name)
            cur.execute(sql)

    cur.close()
    conn.commit()
    conn.close()


def nav_create_tables(create_table, conn):
    """
    创建表
    :param create_table:
    :param conn:
    :return:
    """
    if os.path.exists(create_table):
        cur = conn.cursor()
        create_tables_file = open(create_table)
        create_tables_lines = create_tables_file.readlines()
        create_tables_sql = ""
        cur.execute("SET FOREIGN_KEY_CHECKS=0;")
        is_sql = False
        split = False
        # 分割线的下一行如果开始DROP TABLE 则为sql语句，出现空行则结束sql语句
        for line in create_tables_lines:
            line = line.strip("\n")
            if line.find("-- ") == 0:
                split = True
            if line.find("DROP TABLE") == 0:
                continue
            if line.find("CREATE TABLE") == 0:
                is_sql = True
            if is_sql and split:
                create_tables_sql += line
            if line.find(") ENGINE=") == 0 and split:
                print create_tables_sql
                cur.execute(create_tables_sql)
                conn.commit()
                create_tables_sql = ''
                split = False
                is_sql = False
        cur.close()
        conn.commit()


def pd_create_tables(create_table, conn):
    """
    创建表
    :param create_table:
    :param conn:
    :return:
    """
    if os.path.exists(create_table):
        cur = conn.cursor()
        create_tables_file = open(create_table)
        create_tables_lines = create_tables_file.readlines()
        create_tables_sql = ""
        is_sql = False
        is_alter = False
        # 分割线的下一行如果开始DROP TABLE 则为sql语句，出现空行则结束sql语句
        for line in create_tables_lines:
            line = line.strip("\n")

            if line.find("drop table") == 0:
                continue
            if line.find("alter table") == 0:
                is_alter = True
                create_tables_sql += line
            if line.find("alter table") == -1 and is_alter:
                create_tables_sql += line
            if not line and is_alter:
                print create_tables_sql
                cur.execute(create_tables_sql)
                create_tables_sql = ''
                is_alter = False
            if line.find("create table") == 0:
                is_sql = True
            if is_sql:
                create_tables_sql += line
            if is_sql and not line:
                print create_tables_sql
                try:
                    cur.execute(create_tables_sql)
                except Exception:
                    print Exception.message
                create_tables_sql = ''
                is_sql = False
        cur.close()
        conn.commit()


def insert_data(db_config_yml, db_data_path, conn):
    """
    插入数据到数据库
    :param db_config_yml:
    :param db_data_path:
    :param conn:
    :return:
    """
    sequence = db_config_yml.get('sequence', [])
    cur = conn.cursor()
    if sequence:
        for file_item in sequence:
            f_item = open(os.path.join(db_data_path, file_item + ".sql"))
            for line in f_item.readlines():
                line = line.strip('\n')
                if line:
                    try:
                        print "result: ", cur.execute(line), " execute sql: ", line
                    except Exception:
                        print "error: ", Exception.message
    cur.close()
    conn.commit()


def create_tables_insert_data(base_config):
    """
    创建表插入数据
    :param base_config: 数据库基础链接信息
    :return:
    """
    # 文件前缀
    file_prefix = base_config['file_prefix']
    if not file_prefix:
        file_prefix = ""
    # 数据库列表
    db_list = base_config['db_list']
    # 数据库前缀
    prefix = base_config['prefix']
    # 数据库名称即为文件夹名称
    for db_name in db_list:
        db_data_path = os.path.join(os.getcwd(), db_name)

        db_config_path = os.path.join(db_data_path, "{0}".format("config.yml"))
        if not os.path.exists(db_config_path):
            continue
        db_config_file = open(db_config_path)
        db_config_yml = yaml.load(db_config_file)
        db_config_file.close()
        database = db_config_yml['database']
        if not database.get("cover", False):
            database_name = database.get("name", "")
            if database_name:
                conn = MySQLdb.connect(host=base_config['address'],
                                       user=base_config['user'],
                                       passwd=base_config['password'],
                                       port=base_config['port'],
                                       db=prefix + database_name,
                                       charset="utf8")

        else:
            conn = MySQLdb.connect(host=database['address'],
                                   user=database['user'],
                                   passwd=database['password'],
                                   port=database['port'],
                                   db=prefix + database_name,
                                   charset="utf8")

        # 创建数据库中的表
        create_table_file = database.get("create_tables_file",  "create_tables.sql")
        if file_prefix:
            create_table_file = "pd_{}".format(create_table_file)
        create_table = os.path.join(db_data_path, create_table_file)
        print "create table file: {}".format(create_table)
        if not file_prefix:
            nav_create_tables(create_table, conn)
        else:
            pd_create_tables(create_table, conn)
        insert_data(db_config_yml, db_data_path, conn)


def databases_init():
    """
    创建数据库
    :return:
    """

    config_file = os.path.join(os.getcwd(), "config.yml")
    f_c = open(config_file)
    config = yaml.load(f_c)
    f_c.close()
    base_config = config['database']
    create_databases(base_config)
    create_tables_insert_data(base_config)

if __name__ == "__main__":
    databases_init()
