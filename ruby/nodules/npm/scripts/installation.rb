require_relative '../../../products/script'

module Nodules
  module NPM
    module Scripts
      class Installation < Products::Script

        def body
          "npm install #{context.name}"
        end

      end
    end
  end
end
