require_relative '../../texts/one_time_script'

module Images
  module Scripts
    class SetDataPermissions < Texts::OneTimeScript
      def body
        #Notes for future improvements
        %Q(
        id data-user | cut -f2 -d: |grep #{data_uid} >/dev/null
         if test $? -ne 0
          then
            /usr/sbin/usermod -u #{data_uid}d data-user
         fi
         #only change perms on files that dont already have those perms
        chown -R #{data_uid}.#{data_gid} #{home_app_path} /home/fs_src
        chmod -R 774 /home/fs_src
        chmod g+rx `find /home/fs_src -type d`
        )
      end

      def data_uid
        context.collaboration.user.data_uid
      end

      def data_gid
        context.collaboration.user.data_gid
      end
    end

  end
end
