require_relative 'requires'

module Nodules
  module Pear
    module Scripts
      class Finalisation < Collaborators::ScriptOnce

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
