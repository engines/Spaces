require_relative '../../../texts/one_time_script'

module WebServers
  module Apache
    module Scripts
      class Finalisation < Texts::OneTimeScript

        def body
          [
            %Q(
            mkdir  -p /var/log/apache2/
            chown www-data /var/log/apache2/
            mkdir  -p /run/apache2/
            chown www-data /run/apache2/
            ),
            super
          ]
        end

      end
    end
  end
end
