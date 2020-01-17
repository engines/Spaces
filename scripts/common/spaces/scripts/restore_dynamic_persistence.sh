#!/bin/sh


for path in `cat $VOLDIR/.dynamic_persistence`
 do
  path=`echo $path | sed "/[.][.]/s///g" | sed "/[&;><|]/s///g"` 
    if ! test -e /home/app/$path
      then
 	   path=`echo $path | sed "/\/$/s///"`
 	   echo 	ln -s "$VOLDIR/$path" "/home/app/$path"
	   ln -s "$VOLDIR/$path" "/home/app/$path"
	fi	
done
	
touch /home/app/.dynamic_persistence_restored