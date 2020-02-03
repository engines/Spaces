require_relative '../../../spaces/script'

module Nodule
  class Apache
    class Installation < Spaces::Script

      def body
        "RUN a2enmod #{context.name}"
      end

    end
  end
end
