#!/bin/bash
##备份数据库里的所有的表，每个表一个.sql 
#首先需要从information_schema表中获得每个表的名称,保存为文件，如all_tables
#
#SELECT TABLE_NAME FROM information_schema.`TABLES`
#WHERE TABLE_SCHEMA ='mysqltest' AND TABLE_TYPE ='BASE TABLE'
#
#执行脚本


IPAddress=8.8.8.8
DB_pwd=mysqltest   #数据库密码；
DB_name=mysqltest   #数据库名称；

BACKUP_tmp=/usr/local/mysqltestbackup/backupsql     #备份文件临时存放目录；
BACKUP_path=/usr/local/mysqltestbackup    #备份文件压缩打包存放目录；


for i in `cat all_tables`
  do
    mysqldump -h$IPAddress  -umysqltest -p$DB_pwd $DB_name $i > $BACKUP_tmp/$i-$(date +%Y%m%d%H%M%S).sql
  sleep 1
done
  sleep 10
#将备份数据打包；
    tar -cvzf $BACKUP_path/$DB_name-$(date +%Y%m%d%H%M%S).tar.gz $BACKUP_tmp/*
exit 0


