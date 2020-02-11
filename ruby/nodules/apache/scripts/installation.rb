require_relative '../../../products/script'

module Nodules
  module Apache
    module Scripts
      class Installation < Products::Script

        def body
          "a2enmod #{context.name}"
        end

      end
    end
  end
end
