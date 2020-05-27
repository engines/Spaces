require_relative '../../../texts/one_time_script'

module WebServers
  module Apache
    module Scripts
      class Configure < Texts::OneTimeScript
        def body
          [
            ap_config,
            install_php_config
          ].join("\n")
        end

        def install_php_config
          %Q(
          if test -f /home/engines/injections/framework/php/custom.ini 
           then
             cp /home/engines/injections/framework/php/custom.ini /etc/php/7.?/apache2/conf.d/
           fi
          )
        end

        def ap_config
          [
            base_config_file,
            complete_config,
            extra_config
          ].join("\n")
        end

        def extra_config
          %Q(
           if test -f /home/engines/injections/webserver/apache/extra.conf 
             then
              cp /home/engines/injections/webserver/apache/extra.conf /etc/apache2/conf-enabled/
           fi
          )
        end

        def complete_config
          %Q(
          www_dir=#{context.root_directory}
          APACHE_LOG_DIR=/var/log/
          echo  ServerName #{context.stage.resolution.domain.fqdn} > /etc/apache2/sites-enabled/000-default.conf
          cat $SRC_FILE | while read LINE
           do
            eval echo \\"$LINE\\" >> /etc/apache2/sites-enabled/000-default.conf
           done
           )
        end

        def base_config_file
          %Q(
        if test -f /home/engines/injections/app/web_server/apache/site.conf
         then
             SRC_FILE=/home/engines/injections/app/web_server/apache/site.conf
         else
             SRC_FILE=/home/engines/etc/setup/000-default.conf
        fi )
        end
      end
    end
  end
end
