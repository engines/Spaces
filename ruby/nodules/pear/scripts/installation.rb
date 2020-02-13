require_relative '../../../products/script'

module Nodules
  module Pear
    module Scripts
      class Installation < Products::Script

        def body
          "pear install #{context.name}"
        end

      end
    end
  end
end
