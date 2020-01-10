#!/bin/sh
id data-user | cut -f2 -d: |grep $data_uid >/dev/null	
 if test $? -ne 0
  then
    /usr/sbin/usermod -u $data_uid data-user
 fi

chown -R $data_uid.$data_gid /home/app /home/fs_src
chmod -R 774 /home/fs_src
chmod g+rx ` find /home/fs_src -type d`
#chmod g+rx ` find /home/app -type d`