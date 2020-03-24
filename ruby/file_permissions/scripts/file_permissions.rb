require_relative '../../texts/one_time_script'

module FilePermissions
  module Scripts
    class FilePermissions < Texts::OneTimeScript
      def body
        #Notes for future improvements
        #
        #for each file to permission #remove ^../ and /../ from string
        #also strip any proceeding #{home_app_path} and remove any trailing /
        # then for each file_to_permission
        #Paths referenced are static but global
        %Q(
         set_path_permission()
          {
           if [ -h  #{home_app_path}/$path ]
            then
            dest=`ls -la #{home_app_path}/$path |cut -f2 -d'>'`
              chmod gu+rw $dest
           elif test -d  #{home_app_path}/$path
            then
            chmod 775 #{home_app_path}/$path
           elif test ! -f #{home_app_path}/$path
            then
            mkdir -p  `dirname #{home_app_path}/$path`
            touch  #{home_app_path}/$path
          fi
          chmod ug+rw #{home_app_path}/$path
         }

        set_recursive_write_permissions()
         {
          #FixMe only change perms if not already set
          if [ -h  #{home_app_path}/$path ]
           then
             dest=`ls -la #{home_app_path}/$path |cut -f2 -d'>'`
             echo "Soft link  chmod -R gu+rw $dest ;chgrp $data_gid -R $dest"
             ls -la $dest
             ls -la #{home_app_path}/$path
            #no chmod -R gu+rw $dest
            #no chgrp $data_gid -R $dest
          elif [ ! -d #{home_app_path}/$path ]
            then
              mkdir  -p #{home_app_path}/$path
              chown $data_uid  #{home_app_path}/$path
              chmod -R gu+rw #{home_app_path}/$path
           else
              chgrp $data_gid -R #{home_app_path}/$path
              chmod -R gu+rw #{home_app_path}/$path
          fi
         dirs=`find #{home_app_path}/$path -type d -print0`
         files=`find #{home_app_path}/$path -type f -print0`
          if ! test -z "$files"
            then
             # find #{home_app_path}/$path -type f -print0 | xargs -0 chmod 664
             chmod 664 -R #{home_app_path}/$path
          fi

              echo set dir perms
          if ! test -z "$dirs"
            then
            find #{home_app_path}/$path -type d -print0 | xargs -0 chmod 775
          fi
        }
            #{file_permissions_commands}
           )
      end

      def file_permissions_commands
        context.all.map do |p|
          if p.recursive?
            "path=#{p.path} set_recursive_write_permissions"
          else
            "path=#{p.path} set_path_permissions"
          end
        end.join("\n")
      end

    end
  end
end
