require_relative '../../../collaborators/script'

module Nodules
  module Apache
    module Scripts
      class Installation < Collaborators::Script

        def body
          "a2enmod #{context.name}"
        end

      end
    end
  end
end
