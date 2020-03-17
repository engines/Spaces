require_relative '../../scripts/finalisation'

module Frameworks
  module PHP
    module Scripts
      class Finalisation < Frameworks::Scripts::Finalisation

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
