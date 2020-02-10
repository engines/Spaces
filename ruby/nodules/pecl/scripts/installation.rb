require_relative '../../../spaces/script'

module Nodules
  module Pecl
    module Scripts
      class Installation < Spaces::Script

        def body
          "echo \"  \" |  pecl install #{context.name}"
        end

      end
    end
  end
end
