require_relative '../../texts/one_time_script'

module Images
  module Scripts
    class BuildFunctions < Texts::OneTimeScript
      def body
        %Q(
      
       
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

        )
      end
    end
  end
end
