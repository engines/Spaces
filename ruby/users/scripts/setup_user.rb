require_relative '../../texts/one_time_script'

module Users
  module Scripts
    class SetupUser < Texts::OneTimeScript
      def body
        #Notes for future improvements
        %Q(
        set_guids()
               {
               user=`cat /home/engines/etc/user/name`
               getent passwd $ContUser | grep $ContUser
                if test $? -eq 0
                 then
                 /usr/sbin/usermod -u #{user_id} $ContUser
                else
                  /usr/sbin/useradd -u #{user_id} -d /home/home_dir/ $ContUser
                fi

               group=`cat /home/engines/etc/group/name`

               /usr/bin/getent group $group | grep $group
               if test $? -ne 0
                then
                 /usr/sbin/groupadd -g #{user_id} $group
               else
                 /usr/sbin/groupmod -g #{user_id} $group
               fi

               /usr/sbin/usermod -u #{data_uid} data-user
               /usr/sbin/groupmod -g #{data_gid} data-user
               /usr/sbin/usermod -g data-user data-user
               /usr/sbin/usermod -G data-user $ContUser
               /usr/sbin/usermod -g $group $ContUser
               /usr/sbin/usermod -G containers $ContUser
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
            chown $ContUser $file
           done
        fi
        if test -f /home/engines/etc/user/dirs
         then
          for dir in  `cat /home/engines/etc/user/dirs`
           do
            mkdir -p $dir
            chown -R $ContUser $dir
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
            chgrp $group $file
            chmod g+w $file
        done
        fi
        if test -f /home/engines/etc/group/dirs
         then
          for dir in  `cat /home/engines/etc/group/dirs`
           do
            mkdir -p $dir
            chgrp -R $group $dir
            chmod -R g+w $dir
           done
        fi
        }

        set_guids
        set_permissions
        )
      end

      def user_id
        context.user.identifier
      end

      def data_uid
        context.user.data_uid
      end

      def data_gid
        context.user.data_gid
      end
    end
  end
end
