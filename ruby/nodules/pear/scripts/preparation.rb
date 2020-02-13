require_relative 'requires'

module Nodules
  module Pear
    module Scripts
      class Preparation < Products::Script

        def body
          %Q(
          cd /tmp
          wget http://pear.php.net/go-pear.phar
          echo suhosin.executor.include.whitelist = phar >>/etc/php/7.?/cli/conf.d/suhosin.ini
          php go-pear.phar
          )
        end

        def identifier
          'preparation'
        end

      end
    end
  end
end
