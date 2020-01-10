wait_for_debug()
{
if ! test -z "$Engines_Debug_Run"
 then
  if test "$Engines_Debug_Run" = true
   then  
     echo "Stopped by Sleeping for 500 seconds to allow debuging"
     sleep 500 &
     echo -n " $!" >> $PID_FILE
     wait
   fi
fi  	 
 }
  
volume_setup()
{	 
if test  ! -f /home/engines/run/flags/volume_setup_complete
 then
   echo "Waiting for Volume setup to Complete"
 	while test ! -f /home/engines/run/flags/volume_setup_complete
 	  do
 	  echo  "."
 		sleep 4
 	 done
 echo "Volume setup to Complete "
fi
}

dynamic_persistence()
{	  
if test -f "$VOLDIR/.dynamic_persistence"
  then
	if ! test -f /home/app/.dynamic_persistence_restored
	  then
 		/home/engines/scripts/restore_dynamic_persistence.sh
 		echo "Dynamic persistence restore Complete"
 	fi
 fi
}


first_run()
{

if ! test -f /home/engines/run/flags/first_run_done
 then  
  if test -f /home/engines/scripts/engine/first_run.sh
   then
    /home/engines/scripts/engine/first_run.sh
     touch /home/engines/run/flags/first_run_done		
  fi  
  if test -f /home/engines/scripts/engine/post_install.sh
	then 				
	  echo "Has Post install"
	   if ! test -f /home/engines/run/flags/post_install.done
		 then
		  if test -f /home/engines/run/flags/started_once
		   then		  
		   echo "Running Post Install"
		   /bin/sh /home/engines/scripts/engine/post_install.sh 							
		   touch /home/engines/run/flags/post_install.done		
		  fi	
	  fi
  fi
fi	
}

restart_required()
{	
if test -f /home/engines/run/flags/restart_required 
 then
  if test -f /home/engines/run/flags/started_once
   then
  	rm -rf /home/engines/run/flags/restart_required  
  else
    touch /home/engines/run/flags/started_once
  fi
fi

}

custom_start()
{
#if not blocking continues
if test -f /home/engines/scripts/engine/custom_start.sh
 then
   echo "Custom start"	   
   result=`/home/engines/scripts/engine/custom_start.sh`
   exit_code=$?
	 if test "$result" = "exit"
	  then 
		wait_for_debug
		exit $exit_code
	  fi
fi
}

pre_running()
{
if test -f /home/engines/scripts/engine/pre-running.sh
 then
	echo "launch pre running"
	/home/engines/scripts/engine/pre-running.sh
fi	
}

start_apache()
{
if ! test -d /var/log/apache2/ 
 then
  mkdir -p /var/log/apache2/
fi   
if test -f /home/engines/scripts/engine/blocking.sh 
 then   
    echo started 
   /usr/sbin/apache2ctl -DFOREGROUND &		
      echo -n " $!" >  $PID_FILE
   /home/engines/scripts/engine/blocking.sh  &
    echo -n " $!" >>  $PID_FILE
   echo started blocking script
   echo  -n " $!" >> /home/engines/run/blocking.pid
    else		
   /usr/sbin/apache2ctl -DFOREGROUND &
      echo -n " $!" >  $PID_FILE
   echo started 
fi

}

configure_passenger()
{
cp /home/ruby_env /home/.env_vars
  for env_name in `cat /home/app.env `
  	do
  	  env_name=`eval echo '$'$env_name`
   	  if ! test -z  "${env_name}"
        then
  	      echo  "passenger_env_var $env_name \"${env_name}\";" >> /home/.env_vars
  	  fi
  	done
echo " passenger_env_var RAILS_ENV $RAILS_ENV;" >> /home/.env_vars
echo " passenger_env_var SECRET_KEY_BASE $SECRET_KEY_BASE;" >> /home/.env_vars
}
 
start_nginx()
{
if ! test -d /var/log/nginx 
 then
  mkdir /var/log/nginx
 fi  
 if test -f /home/ruby_env 
   then
     configure_passenger
  fi	
  if test -f /home/engines/scripts/engine/blocking.sh 
	then
	  nginx &
	  echo -n " $!" >> $PID_FILE
	  /home/engines/scripts/engine/engine/blocking.sh  &
	  echo -n " $!" >> $PID_FILE
	else		
	  nginx &
	  echo -n "pid $!"
	  echo -n " $!" >> $PID_FILE
  fi
}

launch_app()
{
/home/engines/scripts/start/startwebapp.sh 
echo $! > $PID_FILE
 if test -f /home/engines/scripts/engine/blocking.sh
   then
	/home/engines/scripts/engine/blocking.sh &
	blocking_pid=$!
	echo -n " $blocking_pid " >>  $PID_FILE
 fi
}