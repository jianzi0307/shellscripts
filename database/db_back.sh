#!/bin/sh
# jian0307@icloud.com

#
MYSQL_CNF=/etc/my.cnf
BACK_CMD=/usr/bin/mysqldump
BACK_DIR=/data/backup/database
BACK_FILE=${BACK_DIR}/pkuvr_db_backup.`date +%Y%m%d_%H%M%S`.sql.gz

#
GZ_CMD=/bin/gzip

#
DB_HOST=127.0.0.1
DB_DATABASE=dbname
DB_USER=user
DB_PASS=password

#
cd ${BACK_DIR}
unalias rm 2> /dev/null
rm -rf `find . -name '*.sql.gz' -mtime 10` 2> /dev/null

#
${BACK_CMD} --defaults-extra-file=${MYSQL_CNF} ${DB_DATABASE} | ${GZ_CMD} > ${BACK_FILE} 
