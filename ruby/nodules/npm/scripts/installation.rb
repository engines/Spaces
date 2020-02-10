require_relative '../../../spaces/script'

module Nodules
  module NPM
    module Scripts
      class Installation < Spaces::Script

        def body
          "npm install #{context.name}"
        end

      end
    end
  end
end
