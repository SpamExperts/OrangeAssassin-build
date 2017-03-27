#!/bin/sh

### BEGIN INIT INFO
# Provides:          orangeassassin
# Required-Start:    $remote_fs $network
# Required-Stop:     $remote_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start orangeassassin daemon
# Description: Start orangeassassin daemon
### END INIT INFO

NAME=orangeassassin
DAEMON=/opt/OrangeAssassin/bin/oad.py
# Exit if executable is not installed
[ -x $DAEMON ] || exit 0

PID=/var/run/oad.pid

case "$1" in
  start)
    /opt/OrangeAssassin/bin/oad.py -d -r $PID --prefork 4 -C /usr/share/spamassassin -S /etc/mail/spamassassin
  ;;
  stop)
    kill -15 `cat $PID`
  ;;
  status)
    if kill -0 `cat $PID` 2>/dev/null;then
      echo "$NAME is running"
    else
      echo "$NAME is NOT running"
    fi
  ;;
  restart|force-reload)
    $0 stop
    sleep 1
    $0 start
  ;;
  *)
    echo "Usage: /etc/init.d/$NAME {start|stop|restart|status}" >&2
    exit 1
  ;;
esac
