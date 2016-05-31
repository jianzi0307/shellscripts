#!/usr/bin/env bash
#==========================================
# This script is a tool to clear redis keys
#
# jianzi0307 2010/10/13
#
# Usage: ./redis_clear_keys.sh userid
#        ./redis_clear_keys.sh all
#==========================================

if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, use sudo sh $0"
    exit 1
fi

if [ $# != 1 ]; then
    echo "Usage: $0 userid"
    echo "       $0 all"
    exit 2
fi

REDIS_PORT=20000
REDIS_AUTH=sbhacker110

if [ $1 == "all" ]; then
    echo "================> ALL <================="
    expect -c "
            spawn sh /home/redis/start_cli.sh $REDIS_PORT
            expect -re \"redis 127.0.0.1:$REDIS_PORT>\" {send \"auth sbhacker110\r\"}
        expect -re \"OK\" { send \"flushall\r\" }
        expect -re \"OK\" { send \"exit\r\" }
        send_user \"\n\"
            expect eof
    "
    exit 3
fi

USERID=$1
echo "================> UID: $USERID <================="
MD5UID=`echo -n $USERID | md5sum | cut -d ' ' -f 1`
echo "MD5 :$MD5UID"
FCHAR=`expr substr "$MD5UID" 1 1`
echo "HEX :0x$FCHAR "
let hex=0x$FCHAR
DEC_NUM=`echo $hex`
echo "DEC :$DEC_NUM"
LEN=`expr length "$DEC_NUM"`
SVR_ID=`expr substr "$DEC_NUM" $LEN 1`
echo "SERVER ID :"$SVR_ID

echo "================> KEYS <================="
redis-cli -p $REDIS_PORT -a $REDIS_AUTH -n $SVR_ID keys "renren:$USERID*"

echo "================> CLEAR <================"
redis-cli -p $REDIS_PORT -a $REDIS_AUTH -n $SVR_ID keys "renren:$USERID*" | xargs redis-cli -p $REDIS_PORT -a $REDIS_AUTH -n $SVR_ID del

#expect -c "
    #spawn sh /home/redis/start_cli.sh $REDIS_PORT
    #expect -re \"redis 127.0.0.1:$REDIS_PORT>\" {send \"auth $REDIS_AUTH\r\"}
    #expect -re \"OK\" { send \"select $SVR_ID\r\" }
    #expect -re \"OK\" { send \"keys renren:$USERID*\r\" }
    #expect {
    #    -re \"empty list or set\" {
    #        send \"quit\r\"
    #    }
    #    \"renren\" {
    #        send \"quit\r\"
    #    }
    #}
    #send_user \"\n\"
    #expect eof
#"