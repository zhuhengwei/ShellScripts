#!/bin/bash
##�������ݿ�������еı�ÿ����һ��.sql 
#������Ҫ��information_schema���л��ÿ���������,����Ϊ�ļ�����all_tables
#
#SELECT TABLE_NAME FROM information_schema.`TABLES`
#WHERE TABLE_SCHEMA ='mysqltest' AND TABLE_TYPE ='BASE TABLE'
#
#ִ�нű�


IPAddress=8.8.8.8
DB_pwd=mysqltest   #���ݿ����룻
DB_name=mysqltest   #���ݿ����ƣ�

BACKUP_tmp=/usr/local/mysqltestbackup/backupsql     #�����ļ���ʱ���Ŀ¼��
BACKUP_path=/usr/local/mysqltestbackup    #�����ļ�ѹ��������Ŀ¼��


for i in `cat all_tables`
  do
    mysqldump -h$IPAddress  -umysqltest -p$DB_pwd $DB_name $i > $BACKUP_tmp/$i-$(date +%Y%m%d%H%M%S).sql
  sleep 1
done
  sleep 10
#���������ݴ����
    tar -cvzf $BACKUP_path/$DB_name-$(date +%Y%m%d%H%M%S).tar.gz $BACKUP_tmp/*
exit 0


