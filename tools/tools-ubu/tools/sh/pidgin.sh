#! /bin/sh
### BEGIN INIT INFO
# Provides:          pidgind
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Chatting with Nary
# Description:       The program pidgin is an internet messenger tool.
#                    This provides pidgind daemon functionality.
### END INIT INFO

# INSTRUCTIONS:
#   This sh script was copied from /etc/init.d/skeleton
#   pidgind is the name of a daemon that will be running at all times
#   I give it a process ID of 777 (use top to see this)
#   /etc/init.d/pidgin.sh is this sh script to start and stop the pidgind daemon
#   /usr/bin/pidgin is the location of the executable
#   Use update-rc.d to set the /etc/rc2.d/S77pidgin links as follows:
#     sudo cp --preserve=timestamps /home/kurt/ubu/tools/sh/pidgin.sh /etc/init.d/ 
#     sudo echo 777 > /var/run/pidgind.pid NO!!!
#     sudo update-rc.d pidgin.sh start 77 2 3 4 5 . stop 77 0 1 6 .
#   Adding system startup for /etc/init.d/pidgin.sh ...
#     /etc/rc0.d/K77pidgin.sh -> ../init.d/pidgin.sh
#     /etc/rc1.d/K77pidgin.sh -> ../init.d/pidgin.sh
#     /etc/rc6.d/K77pidgin.sh -> ../init.d/pidgin.sh
#     /etc/rc2.d/S77pidgin.sh -> ../init.d/pidgin.sh
#     /etc/rc3.d/S77pidgin.sh -> ../init.d/pidgin.sh
#     /etc/rc4.d/S77pidgin.sh -> ../init.d/pidgin.sh
#     /etc/rc5.d/S77pidgin.sh -> ../init.d/pidgin.sh
#  ps -e (to see the active processes)

# sudo update-rc.d -f pidgin.sh remove && rm /etc/init.d/pidgin.sh

# Do NOT "set -e" (however, rsync does so maybe I should)
# set -e
# /etc/init.d/pidgin: sh script to start and stop the pidgin daemon

#PATH=/sbin:/usr/sbin:/bin:/usr/bin
DESC="Pidgin Internet Messenger"
NAME=pidgind
DAEMON=/usr/bin/pidgin
DAEMON_ARGS=""
PIDFILE=/var/run/$NAME.pid
SCRIPTNAME=/etc/init.d/pidgin.sh

# Exit if the package is not installed
[ -x "$DAEMON" ] || exit 0

# Read configuration variable file if it is present
[ -r /etc/default/$NAME ] && . /etc/default/$NAME

# Load the VERBOSE setting and other rcS variables
. /lib/init/vars.sh

# Define LSB log_* functions.
# Depend on lsb-base (>= 3.2-14) to ensure that this file is present
# and status_of_proc is working.
. /lib/lsb/init-functions

#
# Function that starts the daemon/service
#
do_start()
{
	# Return
	#   0 if daemon has been started
	#   1 if daemon was already running
	#   2 if daemon could not be started
	start-stop-daemon --start --quiet --pidfile $PIDFILE --exec $DAEMON --test > /dev/null \
		|| return 1
	start-stop-daemon --start --quiet --pidfile $PIDFILE --exec $DAEMON -- $DAEMON_ARGS \
		|| return 2
	# Add code here, if necessary, that waits for the process to be ready
	# to handle requests from services started subsequently which depend
	# on this one.  As a last resort, sleep for some time.
}

#
# Function that stops the daemon/service
#
do_stop()
{
	# Return
	#   0 if daemon has been stopped
	#   1 if daemon was already stopped
	#   2 if daemon could not be stopped
	#   other if a failure occurred
	start-stop-daemon --stop --quiet --retry=TERM/30/KILL/5 --pidfile $PIDFILE --name $NAME
	RETVAL="$?"
	[ "$RETVAL" = 2 ] && return 2
	# Wait for children to finish too if this is a daemon that forks
	# and if the daemon is only ever run from this initscript.
	# If the above conditions are not satisfied then add some other code
	# that waits for the process to drop all resources that could be
	# needed by services started subsequently.  A last resort is to
	# sleep for some time.
	start-stop-daemon --stop --quiet --oknodo --retry=0/30/KILL/5 --exec $DAEMON
	[ "$?" = 2 ] && return 2
	# Many daemons don't delete their pidfiles when they exit.
	rm -f $PIDFILE
	return "$RETVAL"
}

#
# Function that sends a SIGHUP to the daemon/service
#
do_reload() {
	#
	# If the daemon can reload its configuration without
	# restarting (for example, when it is sent a SIGHUP),
	# then implement that here.
	#
	start-stop-daemon --stop --signal 1 --quiet --pidfile $PIDFILE --name $NAME
	return 0
}

case "$1" in
  start)
	[ "$VERBOSE" != no ] && log_daemon_msg "Starting $DESC" "$NAME"
	do_start
	case "$?" in
		0|1) [ "$VERBOSE" != no ] && log_end_msg 0 ;;
		2) [ "$VERBOSE" != no ] && log_end_msg 1 ;;
	esac
	;;
  stop)
	[ "$VERBOSE" != no ] && log_daemon_msg "Stopping $DESC" "$NAME"
	do_stop
	case "$?" in
		0|1) [ "$VERBOSE" != no ] && log_end_msg 0 ;;
		2) [ "$VERBOSE" != no ] && log_end_msg 1 ;;
	esac
	;;
  status)
       status_of_proc "$DAEMON" "$NAME" && exit 0 || exit $?
       ;;
  #reload|force-reload)
	#
	# If do_reload() is not implemented then leave this commented out
	# and leave 'force-reload' as an alias for 'restart'.
	#
	#log_daemon_msg "Reloading $DESC" "$NAME"
	#do_reload
	#log_end_msg $?
	#;;
  restart|force-reload)
	#
	# If the "reload" option is implemented then remove the
	# 'force-reload' alias
	#
	log_daemon_msg "Restarting $DESC" "$NAME"
	do_stop
	case "$?" in
	  0|1)
		do_start
		case "$?" in
			0) log_end_msg 0 ;;
			1) log_end_msg 1 ;; # Old process is still running
			*) log_end_msg 1 ;; # Failed to start
		esac
		;;
	  *)
	  	# Failed to stop
		log_end_msg 1
		;;
	esac
	;;
  *)
	#echo "Usage: $SCRIPTNAME {start|stop|restart|reload|force-reload}" >&2
	echo "Usage: $SCRIPTNAME {start|stop|status|restart|force-reload}" >&2
	exit 3
	;;
esac

:
