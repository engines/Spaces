require_relative '../../../spaces/script'

module Nodules
  module PHP
    module Scripts
      class Installation < Spaces::Script

        def body
          "phpenmod #{context.name}"
        end

      end
    end
  end
end
