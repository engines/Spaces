require_relative '../../texts/one_time_script'

module Frameworks
  module Scripts
    class Finalisation < Texts::OneTimeScript
      def body
        #Notes for future improvements
        #May be Dynamically setup but has default $data_gid $data_uid
        #$HOME is a shell env from base
        #Paths referenced are static but global
        %Q(
        grep :$data_gid: /etc/group >/dev/null
          if test $? -ne 0
           then
            groupadd -g $data_gid writegrp
          fi
        echo "  id #{user_identifier} | grep $data_gid '"
         id #{user_identifier} | grep $data_gid

          id #{user_identifier} | grep $data_gid >/dev/null
          if test $? -ne 0
           then
          echo "add contuser to data group"
            usermod -G $data_gid -a #{user_identifier}
          fi
          chown -R  $data_uid.$data_gid #{home_app_path}
          chown -R #{user_identifier} /home/home_dir
           mkdir -p ~#{user_identifier}/.ssh
             chown -R #{user_identifier} ~#{user_identifier}/.ssh

          if test -f #{script_file_name}
            then
              echo "running finalisation.sh"
              #{script_file_name}
          fi
          if ! test -z "$VOLDIR"
          then
            ln -s $VOLDIR /data
          fi

          if test -f /home/database_seed
           then
            service_path=`head -1 /home/database_seed | sed "/#/s///"`
            cat /home/database_seed | grep -v  ^\# | /home/engine/services/$service_path/restore.sh
           fi
        chown -R #{user_identifier} $HOME
        )
      end

      def user_identifier
        context.user_identifier
      end

      def script_file_name
        "/#{context.build_script_path}/#{identifier}.sh"
      end

    end
  end
end
