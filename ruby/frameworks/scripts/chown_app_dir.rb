
require_relative '../../texts/one_time_script'

module Frameworks
  module Scripts
    class ChownAppDir < Texts::OneTimeScript
      def body
        #Notes for future improvements
        #group=`cat /home/engines/etc/group/name` and user=`cat /home/engines/etc/user/name` can be dynamic
        #Paths referenced are static but global
        %Q(
        if [ ! -d #{home_app_path} ]
         then
           mkdir -p #{home_app_path}
          fi

        mkdir -p /home/fs ; mkdir -p /home/fs/local
        chown -R #{user_name} #{home_app_path} /home/fs /home/fs/local

         set_permissions()
        {
        user=`cat /home/engines/etc/user/name`

        if test -f /home/engines/etc/user/files_post_install
         then
          for file in `cat /home/engines/etc/user/files_post_install`
           do
            if ! test -f $file
            then
             touch $file
            fi
            chown $user $file
           done
        fi
        if test -f /home/engines/etc/user/dirs_post_install
         then
          for dir in  `cat /home/engines/etc/user/dirs_post_install`
           do
            mkdir -p $dir
            chown -R $user $dir
           done
        fi

        group=`cat /home/engines/etc/group/name`

        if test -f /home/engines/etc/group/files_post_install
         then
          for file in  `cat /home/engines/etc/group/files_post_install`
           do
            if ! test -f $file
            then
             touch $file
            fi

            chown $group $file
           done
        fi
        if test -f /home/engines/etc/group/dirs_post_install
         then
          for dir in  `cat /home/engines/etc/group/dirs_post_install`
           do
           mkdir -p $dir
            chown -R $group $dir
           done
        fi
        }

        set_permissions

        )
      end

      # def user_name
      #   context.installation.framework.user_name
      # end

    end
  end
end
