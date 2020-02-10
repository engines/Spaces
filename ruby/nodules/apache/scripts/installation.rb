require_relative '../../../spaces/script'

module Nodules
  module Apache
    module Scripts
      class Installation < Spaces::Script

        def body
          "a2enmod #{context.name}"
        end

      end
    end
  end
end
