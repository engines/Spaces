require_relative '../../../collaborators/script_once'

module Images
  module Scripts
    class SetDataPermissions < Collaborators::ScriptOnce
      def body
        #Notes for future improvements
        %Q(
        id data-user | cut -f2 -d: |grep $data_uid >/dev/null
         if test $? -ne 0
          then
            /usr/sbin/usermod -u $data_uid data-user
         fi
         #only change perms on files that dont already have those perms
        chown -R $data_uid.$data_gid #{home_app_path} /home/fs_src
        chmod -R 774 /home/fs_src
        chmod g+rx `find /home/fs_src -type d`
        )
      end
    end
  end
end
