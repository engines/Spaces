require_relative '../../../collaborators/script'

module Nodules
  module Pear
    module Scripts
      class Installation < Collaborators::Script

        def body
          "pear install #{context.name}"
        end

      end
    end
  end
end
