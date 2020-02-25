require_relative '../../../texts/one_time_script'

module Frameworks
  module ApachePHP
    module Scripts
      class Finalisation < Texts::OneTimeScript

        def body
          %Q(
          mkdir  -p /var/log/apache2/
          chown www-data /var/log/apache2/
          mkdir  -p /run/apache2/
          chown www-data /run/apache2/
          )
        end

      end
    end
  end
end
