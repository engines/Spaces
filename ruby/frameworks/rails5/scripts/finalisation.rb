require_relative '../../../texts/one_time_script'

module Frameworks
  module Rails5
    module Scripts
      class Finalisation < Texts::OneTimeScript

        def body
          %Q(
          for dir in #{home_app_path}/tmp/ #{home_app_path}/public/cache/ #{home_app_path}/public/assets /run/nginx
           do
             if ! test -d $dir
              then
                if ! test -h $dir
                 then
          		 mkdir -p $dir
          	   fi
             fi
          done

          chown www-data.$data_gid -R #{home_app_path}/public
          chown www-data.$data_gid -R #{home_app_path}/tmp/ /run/nginx #{home_app_path}/public/cache/

          mkdir -p /home/engines/var/log/
          chmod -R g+w  /home/engines/var/log/

          if test -d #{home_app_path}/db
            then
             chmod -R g+w  #{home_app_path}/db
          fi
          )
        end

      end
    end
  end
end
