#!/bin/sh
SCRIPT_DIR=/usr/local/bin/
SENTINEL=redis-sentinel
DAEMON=redis-server
CLIENT=redis-cli

function start_master()
{
    cd /usr/local/redisDB/master
    ./$DAEMON ./redis.conf
}

function start_slave()
{
    cd /usr/local/redisDB/slave
    ./$DAEMON ./redis.conf
}

function start_sentinel()
{
    cd /usr/local/redisDB/sentinel
    ./$SENTINEL ./sentinel26371/sentinel26371.conf
    ./$SENTINEL ./sentinel26372/sentinel26372.conf
    ./$SENTINEL ./sentinel26373/sentinel26373.conf
}

function start()
{
    start_master
    start_slave
    start_sentinel
}

function stop()
{
    killall redis-server
    killall redis-sentinel
}

function check()
{
    netstat -antp
}
case "$1" in
	start)
        echo "start redis cluster..."
		start
		check
		;;
	stop)
		echo "stop redis cluster..."
		stop
		check
		;;
	restart)
		echo "restart redis server..."
		start
		stop
		check
		;;
	*)
		echo "Usage:$0 {start|stop|restart}" >&2
		exit 1
		;;
esac
exit 0
