require_relative '../../../collaborators/script'

module Nodules
  module PHP
    module Scripts
      class Installation < Collaborators::Script

        def body
          "phpenmod #{context.name}"
        end

      end
    end
  end
end
