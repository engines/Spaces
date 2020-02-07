require_relative '../../../spaces/script'

module Nodule
  class R
    class Installation < Spaces::Script

      def body
        "R -e install.packages(\"#{context.name}\") "
      end

    end
  end
end
