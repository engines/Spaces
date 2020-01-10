#!/bin/sh


for directory in $*
 do
   directory=`echo $directory | sed "/[.][.]/s///g"` 
   echo not .. $directory
   directory=`echo $directory | sed "/^\/home\/app/s///"`
   echo no prefix $directory
   directory=`echo $directory | sed "/\/$/s///"`
   echo no suffix $directory
    if [ -h  /home/app/$directory ] 
     then 
       dest=`ls -la /home/app/$directory |cut -f2 -d'>'`
       echo "Soft link  chmod -R gu+rw $dest ;chgrp $data_gid -R $dest"
       ls -la $dest
       ls -la /home/app/$directory 
      #no chmod -R gu+rw $dest
      #no chgrp $data_gid -R $dest
    elif [ ! -d /home/app/$directory ] 
      then 
        echo "Create Dir  -p /home/app/$directory "
        echo "  chown $data_uid  /home/app/$directory "
        echo "   chmod -R gu+rw /home/app/$directory "       
        mkdir  -p /home/app/$directory
        chown $data_uid  /home/app/$directory
        chmod -R gu+rw /home/app/$directory 
     else
        echo "Dir exists   chmod -R gu+rw /home/app/$directory  ; chgrp $data_gid -R /home/app/$directory" 
        chgrp $data_gid -R /home/app/$directory
        chmod -R gu+rw /home/app/$directory  
    fi   
  dirs=`find /home/app/$directory -type d -print0`
 
  files=`find /home/app/$directory -type f -print0`
  echo set file perms
    if ! test -z "$files" 
      then
       # find /home/app/$directory -type f -print0 | xargs -0 chmod 664
       chmod 664 -R /home/app/$directory
    fi
       
        echo set dir perms
    if ! test -z "$dirs" 
      then
        find /home/app/$directory -type d -print0 | xargs -0 chmod 775
    fi        
done
