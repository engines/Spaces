#!/bin/sh

cd /home
					
if test -d /home/engines/templates/
 then
templates=`find /home/engines/templates/ -type f |grep -v keep_me`
 for file in $templates
   do     
     dest_file=`echo $file | sed "/^.*templates\//s///"`
      dest_dir=`dirname $dest_file`
       mkdir -p $dest_dir
       # If soft link copy to destination  
        if test -h $dest_file
         then
           dest_file=`ls -l $dest_file |cut -f2 -d">"`
        fi
     echo Install template $dest_file
     cp $file $dest_file
   done
fi
