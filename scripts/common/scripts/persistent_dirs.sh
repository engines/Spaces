#!/bin/sh
#cat /home/fs/vol_dir_maps
#echo ls -l fs
#ls -l /home/fs
#echo ls -l fs_src
#ls -l /home/fs_src
#echo ls home
#ls -l /home
if test -d /home/volumes/
 then
  for dir  in `cat /home/fs/vol_dir_maps | awk '{ print $1}'`
   do 
    volume=`grep "$dir " /home/fs/vol_dir_maps| awk '{print $2}'`	
    dest_path=`cat /home/volumes/$volume`
    echo Dest Path $dest_path
    ln_destination=$dest_path/$dir 
    destination=/home/fs/$dir
     
    echo $volume maps to $dest_path, for persistent dir $dir
     
    if ! test -d `dirname $destination`
     then
     	echo "creating Destination $destination"
     	mkdir -p `dirname $destination`
     fi
               
     dir_abs_path=$dir
     
     echo "Resolve path $dir "
     echo $dir/ | grep -e '^/home/app/'
      if test $? -ne 0
       then      
        echo $dir/ | grep ^/home/home_dir/
         if test $? -ne 0
      	 then 
     	   echo $dir/ | grep ^/usr/local/ 
     	     if test $? -ne 0
      	      then
      	        dir_abs_path=/home/$dir
      	     fi 
      	fi      	      
     fi          
     echo "Resolved path $dir_abs_path"
     
     if ! test -d $dir_abs_path
      then
       echo "Creating Resolved path $dir_abs_path"
       mkdir -p $dir_abs_path
     fi
     
     echo "cp -rnp $dir_abs_path $destination "
  	cp -rnp $dir_abs_path  $destination 
  	rm -rf $dir_abs_path
  	echo "ln -s $ln_destination $dir_abs_path"
  	ln -s $ln_destination $dir_abs_path
  done 
fi
