require_relative 'requires'

module Nodules
  module Pear
    module Scripts
      class Preparation < Texts::OneTimeScript

        def body
          %Q(
          cd /tmp
          wget https://pear.php.net/install-pear-nozlib.phar
          echo suhosin.executor.include.whitelist = phar >>/etc/php/7.?/cli/conf.d/suhosin.ini
          php install-pear-nozlib.phar
          )
        end

      end
    end
  end
end
