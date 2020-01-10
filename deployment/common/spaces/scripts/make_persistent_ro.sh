#!/bin/sh

/home/engines/scripts/make_persistent.sh $*

for target in $*
 do
 /home/engines/scripts/make_persistent.sh $target
 chmod ugo-w "$VOLDIR/$target" "/home/app/$target"
done


