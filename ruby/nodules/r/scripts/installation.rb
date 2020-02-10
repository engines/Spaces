require_relative '../../../products/script'

module Nodules
  module R
    module Scripts
      class Installation < Products::Script

        def body
          "R -e install.packages(\"#{context.name}\") "
        end

      end
    end
  end
end
