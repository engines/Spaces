require_relative '../../../products/script'

module Nodules
  module PHP
    module Scripts
      class Installation < Products::Script

        def body
          "phpenmod #{context.name}"
        end

      end
    end
  end
end
