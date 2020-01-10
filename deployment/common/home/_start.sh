#!/bin/sh

PID_FILE=/home/spaces/run/spaces.pid	

export PID_FILE

if test -f /home/spaces/functions/trap.sh 
 then
 . /home/spaces/functions/trap.sh
 else
. /home/trap.sh
fi

. /home/spaces/functions/start_functions.sh

volume_setup
dynamic_persistence

if test -f /home/_init.sh
 then
   /home/_init.sh
fi

first_run

restart_required

pre_running

custom_start


touch home/spaces/run/flags/started_once

if ! test -z $exit_start
 then
  exit
fi   

#for non apache framework (or use custom start)
if test -f /home/spaces/scripts/start/startwebapp.sh 
 then
   launch_app
elif test -f /usr/sbin/apache2ctl
 then

 export APACHE_PID_FILE=$PID_FILE
   start_apache
elif test -d /etc/nginx
 then
   start_nginx	
elif test -f /home/spaces/scripts/blocking.sh 
  then
	 /home/spaces/scripts/blocking.sh  &
	 echo -n " $!" >>  $PID_FILE		   
else
 echo "Nothing to run!"
fi

startup_complete
wait 
exit_code=$?
shutdown_complete
exit $exit_code
