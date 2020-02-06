require_relative 'requires'

module Nodule
  class Pear
    class Preparation < Spaces::Script

      def body
        %Q(
        cd /tmp
        wget http://pear.php.net/go-pear.phar
        echo suhosin.executor.include.whitelist = phar >>/etc/php/7.?/cli/conf.d/suhosin.ini
        php go-pear.phar
        )
      end

    end
  end
end
