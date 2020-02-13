require_relative '../../../collaborators/script'

module Nodules
  module Pecl
    module Scripts
      class Installation < Collaborators::Script

        def body
          "echo \"  \" |  pecl install #{context.name}"
        end

      end
    end
  end
end
