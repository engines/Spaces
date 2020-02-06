require_relative 'requires'

module Nodule
  class Pear
    class Completion < Spaces::Script

      def body
        %Q(
        cd /tmp
        rm go-pear.phar
        )
      end

    end
  end
end
