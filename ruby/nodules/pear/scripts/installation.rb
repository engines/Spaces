require_relative 'requires'

module Nodules
  module Pear
    module Scripts
      class Installation < Spaces::Script

        def body
          "pear install #{context.name}"
        end

      end
    end
  end
end
