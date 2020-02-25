require_relative '../../../texts/script'

module Nodules
  module PHP
    module Scripts
      class Installation < Texts::Script

        def body
          "phpenmod #{context.name}"
        end

      end
    end
  end
end
