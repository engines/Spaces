require_relative '../../../products/script'

module Frameworks
  module ApachePHP
    module Scripts
      class Configuration < Products::Script

        def body
          %Q(
          if test -f /home/engines/templates/site_config.conf
           then
               cp /home/engines/templates/site_config.conf /home/engines/setup/000-default.conf
         fi

         www_dir=''
          if ! test -z $WWW_DIR
           then
         	www_dir=$WWW_DIR
           fi

         APACHE_LOG_DIR=/var/log/

         rm /etc/apache2/sites-enabled/000-default.conf
         cat /home/engines/setup/000-default.conf | while read LINE
         do
          eval echo \"$LINE\" >> /etc/apache2/sites-enabled/000-default.conf
         done


         echo  ServerName $fqdn > /tmp/apache2.conf
         cat /etc/apache2/apache2.conf >> /tmp/apache2.conf
         mv /tmp/apache2.conf /etc/apache2/apache2.conf

         	if [ -f /home/engines/configs/php/01-custom.ini ]
         		then
         			cp /home/engines/configs/php/01-custom.ini /etc/php/7.*/apache2/conf.d/
         	fi
         	if [ -f /home/engines/configs/apache2/extra.conf ]
         		then
         			cp /home/engines/configs/apache2/extra.conf /etc/apache2/conf-enabled/
         	fi
         	if [ -f /home/engines/configs/apache2/site.conf ]
         		then
         		 cp /home/engines/configs/apache2/site.conf /etc/apache2/sites-enabled/000-default.conf
         	fi

         /build_scripts/install_htaccess.sh
         )
        end

        def identifier
          'configuration'
        end

      end
    end
  end
end
