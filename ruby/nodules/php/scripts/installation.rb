require_relative '../../../spaces/script'

module Nodule
  class PHP
    class Installation < Spaces::Script

      def body
        "phpenmod #{context.name}"
      end

    end
  end
end
