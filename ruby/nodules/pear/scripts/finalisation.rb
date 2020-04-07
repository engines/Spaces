require_relative 'requires'

module Nodules
  module Pear
    module Scripts
      class Finalisation < Texts::OneTimeScript

        def body
          %Q(
          cd /tmp
          rm install-pear-nozlib.phar
          )
        end

      end
    end
  end
end
