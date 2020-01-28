#!/bin/sh


set_guids()
{
user=`cat /home/engines/etc/user/name`
getent passwd $user | grep $user
 if test $? -eq 0
  then
	/usr/sbin/usermod -u $cont_uid $user
 else
   /usr/sbin/useradd -u $cont_uid -d /home/home_dir/ $user 
 fi 	

group=`cat /home/engines/etc/group/name`

/usr/bin/getent group $group | grep $group 
if test $? -ne 0
 then
  /usr/sbin/groupadd -g $cont_uid $group
else
  /usr/sbin/groupmod -g $cont_uid $group
fi


/usr/sbin/usermod -u $data_uid data-user
/usr/sbin/groupmod -g $data_gid data-user
/usr/sbin/usermod -g data-user data-user 
/usr/sbin/usermod -G data-user $user
/usr/sbin/usermod -g $group $user
/usr/sbin/usermod -G containers $user


}

set_permissions()
{

if test -f /home/engines/etc/user/files
 then
  for file in `cat /home/engines/etc/user/files`
   do
    if ! test -f $file
    then
     touch $file
    fi
    chown $user $file
   done
fi
if test -f /home/engines/etc/user/dirs
 then
  for dir in  `cat /home/engines/etc/user/dirs`
   do
    mkdir -p $dir
    chown -R $user $dir
   done
fi




if test -f /home/engines/etc/group/files
 then
  for file in  `cat /home/engines/etc/group/files`
   do
    if ! test -f $file
    then
     touch $file
    fi
     
    chown $group $file
   done
fi
if test -f /home/engines/etc/group/dirs
 then
  for dir in  `cat /home/engines/etc/group/dirs`
   do
   mkdir -p $dir
    chown -R $group $dir
   done
fi   
}

set_guids
set_permissions


