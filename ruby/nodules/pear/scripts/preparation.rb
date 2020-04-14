require_relative 'requires'

module Nodules
  module Pear
    module Scripts
      class Preparation < Texts::OneTimeScript

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
