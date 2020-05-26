require_relative '../../../texts/one_time_script'

module Frameworks
  module Rails5
    module Scripts
      class Configure < Texts::OneTimeScript

        def body
          %Q(
          www_dir=''
           if ! test -z  $WWW_DIR
            then
          	www_dir=`basename $WWW_DIR`
            fi
          cat /etc/nginx/sites-enabled/default  | sed "s/WWW_DIR/$www_dir/" > /tmp/.000-default.conf
          cat  /tmp/.000-default.conf  | sed "s/^#SERVER_NAME/ ServerName $fqdn/" > /tmp/.000-default.conf-2
          cp /tmp/.000-default.conf-2 /etc/nginx/sites-enabled/default
          )
        end

      end
    end
  end
end
