#!/bin/bash
#
# description: Bash CLI for minecraft servers
# processname: MCControl

start() {
    if [ -f /etc/$1.pid ]
        then
            ps -p `cat /etc/$1.pid`> /dev/null;
            if [ $? = 1 ]
                then
                    echo 'Starting '$1;
                    rm -f /etc/$1.pid;
                    screen -S $1 -d -m /servers/$1/rtoolkit.sh;
                    screen -list | grep $1 | cut -f1 -d'.' | sed 's/\W//g' > /etc/$1.pid;
                    timeout 20 tail -f /servers/$1/server.log;
                else 
                    echo 'Unholding '$1;
                    screen -x `cat /etc/$1.pid` -p 0 -X stuff '.unhold'$'\012';
                    timeout 20 tail -f /servers/$1/server.log;
            fi;
        else
            echo 'Starting '$1;
            rm -f /etc/$1.pid;
            screen -S $1 -d -m /servers/$1/rtoolkit.sh;
            screen -list | grep $1 | cut -f1 -d'.' | sed 's/\W//g' > /etc/$1.pid;
            timeout 20 tail -f /servers/$1/server.log;
    fi;
}

stop() {
    if [ -f /etc/$1.pid ]
        then
            ps -p `cat /etc/$1.pid`> /dev/null;
            if [ $? = 1 ]
                then
                    echo $1' is not running. Perhaps you meant to start it?'
                else
                    echo 'Stopping '$1
                    screen -x `cat /etc/$1.pid` -p 0 -X stuff '.hold'$'\012';
                    timeout 20 tail -f /servers/$1/server.log;
            fi;
        else
            echo $1' is not running. Perhaps you meant to start it?'
    fi;
}
attach() {
    if [ -f /etc/$1.pid ]
        then
            ps -p `cat /etc/$1.pid`> /dev/null;
            if [ $? = 1 ]
                then
                    echo $1' is not running. Perhaps you meant to start it?'
                else
                    echo 'Attaching to '$1
                    screen -x `cat /etc/$1.pid`
            fi;
        else
            echo $1' is not running. Perhaps you meant to start it?'
    fi;
}
restart() {
    if [ -f /etc/$1.pid ]
        then
            ps -p `cat /etc/$1.pid`> /dev/null;
            if [ $? = 1 ]
                then
                    echo $1' is not running. Perhaps you meant to start it?'
                else
                    echo 'Restarting '$1
                    screen -x `cat /etc/$1.pid` -p 0 -X stuff '.restart'$'\012';
                    timeout 20 tail -f /servers/$1/server.log;
            fi;
        else
            echo $1' is not running. Perhaps you meant to start it?'
    fi;
}
reload() {
    if [ -f /etc/$1.pid ]
        then
            ps -p `cat /etc/$1.pid`> /dev/null;
            if [ $? = 1 ]
                then
                    echo $1' is not running. Perhaps you meant to start it?'
                else
                    echo 'Reloading '$1
                    screen -x `cat /etc/$1.pid` -p 0 -X stuff 'reload'$'\012';
                    timeout 20 tail -f /servers/$1/server.log;
            fi;
        else
            echo $1' is not running. Perhaps you meant to start it?'
    fi;
}
send() {
    if [ -f /etc/$1.pid ]
        then
            ps -p `cat /etc/$1.pid`> /dev/null;
            if [ $? = 1 ]
                then
                    echo $1' is not running. Perhaps you meant to start it?'
                else
                    echo 'sending command '$2' to '$1
                    screen -x `cat /etc/$1.pid` -p 0 -X stuff $2$'\012';
                    timeout 3 tail -n 1 -f /servers/$1/server.log;
            fi;
        else
            echo $1' is not running. Perhaps you meant to start it?'
    fi;
}
kill() {
    if [ -f /etc/$1.pid ]
        then
            ps -p `cat /etc/$1.pid`> /dev/null;
            if [ $? = 1 ]
                then
                    echo $1' is not running. Perhaps you meant to start it?'
                else
                    echo 'Killing '$1
                    screen -x `cat /etc/$1.pid` -p 0 -X stuff '.stopwrapper'$'\012';
                    timeout 25 tail -f /servers/$1/server.log;
                    kill `cat /etc/$1.pid`
                    screen -wipe
                    rm -fv /etc/$1.pid
            fi;
        else
            echo $1' is not running. Perhaps you meant to start it?'
    fi;
}
status() {
    if [ -f /etc/$1.pid ]
        then
            ps -p `cat /etc/$1.pid`> /dev/null;
            if [ $? = 1 ]
                then
                    echo $1' is not running. Perhaps you meant to start it?'
                else
                    echo -e 'Checking Status of '$1'\n';
                    normal=$(printf "\033[m")
                    screen -x `cat /etc/$1.pid` -p 0 -X stuff 'ping'$'\012';
                    sleep 1;
                    tail -2 /servers/$1/server.log | grep -q "Pong!"
                    if [ $? = 1 ]
                        then
                            echo 'Status: "stopped"' >> /tmp/$1.status;
                        else
                            echo 'Status: "running"' >> /tmp/$1.status;
                            screen -x `cat /etc/$1.pid` -p 0 -X stuff 'lag'$'\012';
                            sleep 0.5;
                            echo "Uptime: \"`tail -n 20 /servers/$1/server.log | grep "Uptime:" | awk '{for(i=5;i<=NF;i++){printf "%s ",$i}}'`\"" >> /tmp/$1.status
                            echo "TPS: \"`tail -n 20 /servers/$1/server.log | grep "TPS" | awk '{print $7}'`\"" >> /tmp/$1.status
                            echo "Memory: \"`tail -n 20 /servers/$1/server.log | grep "Maximum" | awk '{print $6}'` Maximum | `tail -n 20 /servers/$1/server.log | grep "Free memory:" | awk '{print $6}'` Free\"" >> /tmp/$1.status
                            screen -x `cat /etc/$1.pid` -p 0 -X stuff 'list'$'\012';
                            sleep 0.5;
                            echo "Players: \"`tail -n 10 /servers/$1/server.log | grep "There are" | awk '{print $6}'`\"" >> /tmp/$1.status
                    fi;
                awk -F'"' '{ printf "%-20s %s\n", $1, $2}' /tmp/$1.status
                rm -f /tmp/$1.status
                printf "\033[m"
            fi;
        else
            echo $1' is not running. Perhaps you meant to start it?'
    fi;
}

# See how we were called.
case "$2" in
  start)
	start $1
	;;
  stop)
	stop $1
	;;
  restart)
    restart $1
    ;;
  attach)
    attach $1
    ;;
  reload)
    reload $1
    ;;
  send)
    send $1 $3
    ;;
  kill)
    kill $1
    ;;
  status)
    status $1
    ;;
*)
	echo $"Usage: $0 %SERVERNAME% {start|stop|attach|restart|reload|send|kill|status}"
	exit 1
esac
