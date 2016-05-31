#!/usr/bin/env bash

# */30 * * * * sh /root/DB_BackUp_Tool.sh

BACKUP_TIME=`date +%Y-%m-%d_%H:%M`
DB_BACKUP_DIR=/root/DB_YYJ_PROJECT_BACKUP
mysqldump -uroot -p1.41421 yyj_project > $DB_BACKUP_DIR/yyj_project_$BACKUP_TIME.sql