require_relative '../../../products/script'

module Nodules
  module Pecl
    module Scripts
      class Installation < Products::Script

        def body
          "echo \"  \" |  pecl install #{context.name}"
        end

      end
    end
  end
end
