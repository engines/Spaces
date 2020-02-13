require_relative '../../../collaborators/script'

module Nodules
  module NPM
    module Scripts
      class Installation < Collaborators::Script

        def body
          "npm install #{context.name}"
        end

      end
    end
  end
end
