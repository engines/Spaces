require_relative '../../../collaborators/script_once'

module Frameworks
  module Rails5
    module Scripts
      class Finalisation < Collaborators::ScriptOnce

        def body
          %Q(
          for dir in /home/app/tmp/ /home/app/public/cache/ /home/app/public/assets /run/nginx
           do
             if ! test -d $dir
              then
                if ! test -h $dir
                 then
          		 mkdir -p $dir
          	   fi
             fi
          done

          chown www-data.$data_gid -R /home/app/public
          chown www-data.$data_gid -R /home/app/tmp/ /run/nginx /home/app/public/cache/

          mkdir -p /home/engines/var/log/
          chmod -R g+w  /home/engines/var/log/

          if test -d /home/app/db
            then
             chmod -R g+w  /home/app/db
          fi
          )
        end

      end
    end
  end
end
