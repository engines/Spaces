require_relative 'requires'

module Nodules
  module Pear
    module Scripts
      class Finalisation < Products::Script

        def body
          %Q(
          cd /tmp
          rm go-pear.phar
          )
        end

        def identifier
          'finalisation'
        end

      end
    end
  end
end
