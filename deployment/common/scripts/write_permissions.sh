#!/bin/sh

 for path in $*
  do
   path=`echo $path | sed "/[.][.]/s///g"` 
   path=`echo $path | sed "/\/$/s///"`
   path=`echo $path | sed "/^\/home\/app/s///"`
     if [ -h  /home/app/$path ] 
      then
  		dest=`ls -la /home/app/$path |cut -f2 -d'>'`
        chmod -R gu+rw $dest
     elif test -d  /home/app/$path 
  	  then
   		chmod  775 /home/app/$path   
     elif test ! -f /home/app/$path 
  	  then
   		mkdir -p  `dirname /home/app/$path`
   		touch  /home/app/$path 
 	 fi
   chown $ContUser /home/app/$path
   chmod  ug+rw /home/app/$path   
done    
        