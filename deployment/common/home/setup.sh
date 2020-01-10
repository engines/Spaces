#!/bin/sh

	
if test -f /home/engines/scripts/engine/custom_install.sh 
then
  echo running custom install
	if ! test -f /tmp/custom_install_run 
	 then
       /home/engines/scripts/engine/custom_install.sh
    fi
fi 
	
touch /tmp/custom_install_run 
	
	