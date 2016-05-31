#!/bin/sh
#===========> svn manager tool 2013.05.07 <=======

DAEMON=/usr/bin/svnserve
REPOS=/home/svnroot

case "$1" in
	start)
		echo "start svn server..."
		$DAEMON -d -r $REPOS
		netstat -antp|grep svnserve
		;;
	stop)
		echo "stop svn server..."
		killall svnserve
		;;
	restart)
		echo "restart svn server..."
		killall svnserve
		$DAEMON -d -r $REPOS
		netstat -antp|grep svnserve
		;;
	*)
		echo "Usage:$0 {start|stop|restart}" >&2
		exit 1
		;;
esac
exit 0
