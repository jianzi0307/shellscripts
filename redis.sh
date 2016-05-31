#!/bin/sh
SCRIPT_DIR=/usr/local/bin/
DAEMON=redis-server
CLIENT=redis-cli

function start()
{
    $SCRIPT_DIR$DAEMON /etc/redis.conf &
}

function stop()
{
    $SCRIPT_DIR$CLIENT shutdown
}

function check()
{
    netstat -antp|grep $DAEMON
}
case "$1" in
	start)
        echo "start redis server..."
		start
		check
		;;
	stop)
		echo "stop redis server..."
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
