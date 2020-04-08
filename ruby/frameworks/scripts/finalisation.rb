require_relative '../../texts/one_time_script'

module Frameworks
  module Scripts
    class Finalisation < Texts::OneTimeScript
      def body
        #Notes for future improveme
        #$HOME is a shell env from base
        #Paths referenced are static but global
        %Q(
        grep :#{data_gid}: /etc/group >/dev/null
          if test $? -ne 0
           then
            groupadd -g #{data_gid} writegrp
          fi
        echo "  id #{user_name} | grep #{data_gid} '"
         id #{user_name} | grep #{data_gid}

          id #{user_name} | grep #{data_gid} >/dev/null
          if test $? -ne 0
           then
          echo "add contuser to data group"
            usermod -G #{data_gid} -a #{user_name}
          fi
          chown -R  $data_uid.#{data_gid} #{home_app_path}
          chown -R #{user_name} /home/home_dir
           mkdir -p ~#{user_name}/.ssh
             chown -R #{user_name} ~#{user_name}/.ssh

          if test -f #{script_file_name}
            then
              echo "running finalisation.sh"
              #{script_file_name}
          fi
          if ! test -z "$VOLDIR"
          then
            ln -s $VOLDIR /data
          fi

        chown -R #{user_name} $HOME
        )
      end

      def data_gid
        context.installation.user.data_gid
      end

      def script_file_name
        "/#{context.build_script_path}/#{identifier}.sh"
      end

    end
  end
end
