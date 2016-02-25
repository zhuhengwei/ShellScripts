#!/bin/bash
#批量备份 mysql 多表，每个表一个.sql
#对于每天生成的表，需要把以前的表备份，
#即定义起始的表和结束的表，针对有规律的表的备份

IPAddress=8.8.8.8
DB_pwd=mysqltest   #数据库密码；
DB_name=mysqltest   #数据库名称；
table_name="zhw_"  #数据表名称前缀；

Start=20150112 # 每天生成的表 的开始的第一个
End=20150610   #每天生成的表 最后需要备份的一个


BACKUP_tmp=/usr/local/mysqltestbackup/backupsql     #备份文件临时存放目录；
BACKUP_path=/usr/local/mysqltestbackup    #备份文件压缩打包存放目录；


DATERange=`seq -f%.f $Start $End | date -f - "+%Y%m%d" 2>/dev/null` #日期范围

for i in $DATERange
  do
    mysqldump -h$IPAddress  -umysqltest -p$DB_pwd $DB_name $table_name$i > $BACKUP_tmp/$table_name$i-$(date +%Y%m%d%H%M%S).sql
  sleep 1
done
  sleep 10
#将备份数据打包；
    tar -cvzf $BACKUP_path/$DB_name-$table_name-$(date +%Y%m%d%H%M%S).tar.gz $BACKUP_tmp/*
exit 0
