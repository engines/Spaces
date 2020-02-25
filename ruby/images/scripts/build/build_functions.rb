require_relative '../../../texts/script_once'

module Images
  module Scripts
    class BuildFunctions < Texts::ScriptOnce
      def body
        %Q(
        install_template()
        {
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
        }

        set_recursive_write_permissions()
          {
           #FixMe only change perms if not already set
           if [ -h  #{home_app_path}/$directory ]
            then
              dest=`ls -la #{home_app_path}/$directory |cut -f2 -d'>'`
              echo "Soft link  chmod -R gu+rw $dest ;chgrp $data_gid -R $dest"
              ls -la $dest
              ls -la #{home_app_path}/$directory
             #no chmod -R gu+rw $dest
             #no chgrp $data_gid -R $dest
           elif [ ! -d #{home_app_path}/$directory ]
             then
               mkdir  -p #{home_app_path}/$directory
               chown $data_uid  #{home_app_path}/$directory
               chmod -R gu+rw #{home_app_path}/$directory
            else
               chgrp $data_gid -R #{home_app_path}/$directory
               chmod -R gu+rw #{home_app_path}/$directory
           fi
         dirs=`find #{home_app_path}/$directory -type d -print0`

         files=`find #{home_app_path}/$directory -type f -print0`
           if ! test -z "$files"
             then
              # find #{home_app_path}/$directory -type f -print0 | xargs -0 chmod 664
              chmod 664 -R #{home_app_path}/$directory
           fi

               echo set dir perms
           if ! test -z "$dirs"
             then
               find #{home_app_path}/$directory -type d -print0 | xargs -0 chmod 775
           fi
           }
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
        set_path_permission()
         {
           if [ -h  #{home_app_path}/$path ]
            then
            dest=`ls -la #{home_app_path}/$path |cut -f2 -d'>'`
              chmod -R gu+rw $dest
           elif test -d  #{home_app_path}/$path
            then
            chmod  775 #{home_app_path}/$path
           elif test ! -f #{home_app_path}/$path
            then
            mkdir -p  `dirname #{home_app_path}/$path`
            touch  #{home_app_path}/$path
         fi
         chmod  ug+rw #{home_app_path}/$path
         }
        )
      end
    end
  end
end
