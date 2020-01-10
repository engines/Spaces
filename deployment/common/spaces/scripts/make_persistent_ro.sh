#!/bin/sh

/home/spaces/scripts/make_persistent.sh $*

for target in $*
 do
 /home/spaces/scripts/make_persistent.sh $target
 chmod ugo-w "$VOLDIR/$target" "/home/app/$target"
done


