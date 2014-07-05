#!/bin/bash

#############################################################
# name:        MC-CLI                                       # 
# author:      Colgate                                      #
# description: Bash CLI for minecraft server administration #
#############################################################  


#Server process check function
isOnline() {
<<<<<<< HEAD
    proc=/tmp/$1.pid
    [[ -f $proc ]] && ps -p `cat $proc` &> /dev/null && return 0 || return 1;
=======
    proc=/etc/$1.pid
    [[ ! -f $proc ]] && {
        ps -p `cat $proc` > /dev/null && return 1 || return 0;
    } || return 1;
>>>>>>> origin/master
}

#Start server if not already running
start() {
    isOnline $1 && {
        echo 'Unholding '$1;
<<<<<<< HEAD
        screen -x `cat /tmp/$1.pid` -p 0 -X stuff '.unhold'$'\012';
    } || {
        echo 'Starting '$1;
        rm -f /tmp/$1.pid;
        screen -S $1 -d -m /servers/$1/rtoolkit.sh;
        screen -list | grep $1 | cut -f1 -d'.' | sed 's/\W//g' > /tmp/$1.pid;
=======
        screen -x `cat /etc/$1.pid` -p 0 -X stuff '.unhold'$'\012';
        timeout 20 tail -f /servers/$1/server.log;
    } || {
        echo 'Starting '$1;
        rm -f /etc/$1.pid;
        screen -S $1 -d -m /servers/$1/rtoolkit.sh;
        screen -list | grep $1 | cut -f1 -d'.' | sed 's/\W//g' > /etc/$1.pid;
        timeout 20 tail -f /servers/$1/server.log;
>>>>>>> origin/master
    }
}

#Stop the server, but do not kill it (.hold the server)
stop() {
    isOnline $1 && {
        echo 'Stopping '$1
<<<<<<< HEAD
        screen -x `cat /tmp/$1.pid` -p 0 -X stuff '.hold'$'\012';
=======
        screen -x `cat /etc/$1.pid` -p 0 -X stuff '.hold'$'\012';
        timeout 20 tail -f /servers/$1/server.log;
>>>>>>> origin/master
    } || echo "$1 is already stopped or not running!"
}    

#Attach to server screen session/console.
attach() {
    isOnline $1 && {
<<<<<<< HEAD
        screen -x `cat /tmp/$1.pid`
=======
        screen -x `cat /etc/$1.pid`
>>>>>>> origin/master
    } || echo "$1 is not currently running!"
}

#Hard restart the server.
restart() {
    isOnline $1 && {
        echo 'Restarting '$1
<<<<<<< HEAD
        screen -x `cat /tmp/$1.pid` -p 0 -X stuff '.restart'$'\012';
=======
        screen -x `cat /etc/$1.pid` -p 0 -X stuff '.restart'$'\012';
        timeout 20 tail -f /servers/$1/server.log;
>>>>>>> origin/master
    } || echo "$1 is not currently running!"

}

#Soft restart the server. (send "reload" command)
reload() {
    isOnline $1 && {
<<<<<<< HEAD
        screen -x `cat /tmp/$1.pid` -p 0 -X stuff 'reload'$'\012';     
=======
        screen -x `cat /etc/$1.pid` -p 0 -X stuff 'reload'$'\012';
        timeout 20 tail -f /servers/$1/server.log;        
>>>>>>> origin/master
    } || echo "$1 is not currently running!"
}

#Execute commands without actually attaching to server console
exec() {
    isOnline $1 && {
        echo 'sending command '"$2 $3 $4 $5 $6 $7 $8 $9"' to '$1
<<<<<<< HEAD
        screen -x `cat /tmp/$1.pid` -p 0 -X stuff "$2 $3 $4 $5 $6 $7 $8 $9"$'\012';
=======
        screen -x `cat /etc/$1.pid` -p 0 -X stuff "$2 $3 $4 $5 $6 $7 $8 $9"$'\012';
        timeout 3 tail -n 1 -f /servers/$1/server.log;
>>>>>>> origin/master
    } || echo "$1 is not currently running!"
}

#Completely kill server and end process
kill() {
    isOnline $1 && {
        echo 'Killing '$1
<<<<<<< HEAD
        screen -x `cat /tmp/$1.pid` -p 0 -X stuff '.stopwrapper'$'\012';
        { kill `cat /tmp/$1.pid`; screen -wipe; rm -f /tmp/$1.pid; } | at now + 5 minutes
=======
        screen -x `cat /etc/$1.pid` -p 0 -X stuff '.stopwrapper'$'\012';
        timeout 25 tail -f /servers/$1/server.log;
        kill `cat /etc/$1.pid`
        screen -wipe
        rm -f /etc/$1.pid
>>>>>>> origin/master
    } || echo "$1 is not currently running!"
}

# See how we were called.
case "$2" in
  start)
<<<<<<< HEAD
    start $1 ;;
  stop)
    stop $1 ;;
=======
    start $1
    ;;
  stop)
    stop $1
    ;;
>>>>>>> origin/master
  restart)
    restart $1 ;;
  attach)
    attach $1 ;;
  reload)
<<<<<<< HEAD
    reload $1 ;;
  exec)
    exec $1 "$3 $4 $5 $6 $7 $8" ;;
  status)
    isOnline $1 && echo -e "\n\tServer $1(pid `cat /tmp/$1.pid`) is running.\n" ;;
  kill)
    kill $1 ;;
  *)
    echo $"Usage: $0 servername {start|stop|attach|restart|reload|exec|kill|status}"; exit 1 ;;
esac
=======
    reload $1
    ;;
  exec)
    exec $1 "$3 $4 $5 $6 $7 $8"
    ;;
  kill)
    kill $1
    ;;
*)
    echo $"Usage: $0 %SERVERNAME% {start|stop|attach|restart|reload|exec|kill}"
    exit 1
esac
>>>>>>> origin/master
