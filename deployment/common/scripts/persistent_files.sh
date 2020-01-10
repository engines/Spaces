#!/bin/sh
#cat /home/fs/vol_file_maps
#echo ls -l fs
#ls -l /home/fs
#echo ls home
#ls -l /home
#echo ls -l fs_src
#ls -l /home/fs_src
#
if test -d /home/volumes/
 then
for file  in `cat /home/fs/vol_file_maps | awk '{ print $1}'`
 do 
   volume=`grep "$file " /home/fs/vol_file_maps| awk '{print $2}'`	
   dest_path=`cat /home/volumes/$volume`
   echo Dest Path $dest_path
   ln_destination=$dest_path/$file
    destination=/home/fs/$file
   echo $volume maps to $dest_path, for persistent file $file
   if ! test -d `dirname $destination`
    then
    echo "mkdir -p $destination"
    	mkdir -p `dirname $destination`
    fi
     file_abs_path=$file
     echo $file | grep ^/home/app/
     if ! test $? -eq 0
      then      
       echo $file | grep ^/home/home_dir/
        if ! test $? -eq 0
     	 then 
    	   echo $file | grep ^/usr/local/ 
    	     if ! test $? -eq 0
     	      then
     	        file_abs_path=/home/$file
     	     fi 
     	fi      
    fi
    
    if ! test -f $file_abs_path
     then
      touch $file_abs_path
    fi
    echo cp -np $file_abs_path $destination 
 	cp -np $file_abs_path $destination 
 	rm $file_abs_path
 	echo "ln -s $ln_destination $file_abs_path"
 	ln -s $ln_destination $file_abs_path
 done
fi 