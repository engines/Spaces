require_relative '../../../collaborators/script'

module Nodules
  module R
    module Scripts
      class Installation < Collaborators::Script

        def body
          "R -e install.packages(\"#{context.name}\") "
        end

      end
    end
  end
end
