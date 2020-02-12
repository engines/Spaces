require_relative '../../../products/script'

module Images
  module Scripts
    class Finalisation < Products::Script
      def body
        %Q(
        grep :$data_gid: /etc/group >/dev/null
          if test $? -ne 0
           then
            groupadd -g $data_gid writegrp
          fi
        echo "  id $ContUser | grep $data_gid '"
         id $ContUser | grep $data_gid

          id $ContUser | grep $data_gid >/dev/null
          if test $? -ne 0
           then
          echo "add contuser to data group"
            usermod -G $data_gid -a $ContUser
          fi
          chown -R  $data_uid.$data_gid #{context.home_app_path}
          chown -R $ContUser /home/home_dir
           mkdir -p ~$ContUser/.ssh
             chown -R $ContUser ~$ContUser/.ssh

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
        chown -R  $ContUser $HOME
        )
      end

      def framework_script_file_name
        "/#{framework_build_script_path}/#{identifier}.sh"
      end

      def framework_build_script_path
        context.tensor.framework.build_script_path
      end

      def identifier
        'finalisation'
      end
    end
  end
end
