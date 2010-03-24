#!/bin/bash
case $1 in
   start)
      echo $$ > log/dj.pid;
      exec 2>&1 rake jobs:work >> log/dj.out
      ;;
    stop)  
      kill `cat log/dj.pid` ;;
    *)  
      echo "usage: start_dj.sh {start|stop}" ;;
esac
exit 0
