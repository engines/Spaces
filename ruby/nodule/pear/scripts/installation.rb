require_relative '../../../spaces/script'

module Nodule
  class Pear
    class Installation < Spaces::Script

      def header # once only
        [
          super,
          %Q(
          cd /tmp
          wget http://pear.php.net/go-pear.phar
          echo suhosin.executor.include.whitelist = phar >>/etc/php/7.?/cli/conf.d/suhosin.ini
          php go-pear.phar
          )
        ]
      end

      def body
        "pear install #{context.name}"
      end

      def final # once only
        %Q(
          cd /tmp
          rm go-pear.phar
        )
      end

    end
  end
end
