require_relative 'requires'

module Nodules
  module Pear
    module Scripts
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
end
