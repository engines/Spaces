require_relative '../../../texts/one_time_script'

module Images
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
        echo "  id #{cont_user} | grep $data_gid '"
         id #{cont_user} | grep $data_gid

          id #{cont_user} | grep $data_gid >/dev/null
          if test $? -ne 0
           then
          echo "add contuser to data group"
            usermod -G $data_gid -a #{cont_user}
          fi
          chown -R  $data_uid.$data_gid #{home_app_path}
          chown -R #{cont_user} /home/home_dir
           mkdir -p ~#{cont_user}/.ssh
             chown -R #{cont_user} ~#{cont_user}/.ssh

          if test -f #{framework_script_file_name}
            then
              echo "running finalisation.sh"
              #{framework_script_file_name}
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
        chown -R #{cont_user} $HOME
        )
      end

      def cont_user
        context.installation.framework&.cont_user
      end

      def framework_script_file_name
        "/#{framework_build_script_path}/#{identifier}.sh"
      end

    end
  end
end
