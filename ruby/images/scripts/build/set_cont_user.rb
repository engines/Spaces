require_relative '../../../collaborators/script_once'

module Images
  module Scripts
    class SetContUser < Collaborators::ScriptOnce
      def body
        #Notes for future improvements
        %Q(
        . #{framework_build_script_path}/build_functions.sh
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

        )
      end
    end
  end
end
