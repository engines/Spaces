require_relative '../../../texts/script'

module Nodules
  module R
    module Scripts
      class Install < Texts::Script

        def body
          "R -e 'install.packages(\"#{context.name}\")' "
        end

      end
    end
  end
end
