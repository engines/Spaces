require_relative '../../../texts/one_time_script'

module Nodules
  module Pear
    module Scripts
      class Prepare < Texts::OneTimeScript

        def body
          %Q(
          apt-get -y install php-pear
          pear channel-update pear.php.net
          )
        end

      end
    end
  end
end
