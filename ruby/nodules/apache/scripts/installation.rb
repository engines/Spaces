require_relative '../../../spaces/script'

module Nodules
  class Apache
    class Installation < Spaces::Script

      def body
        "a2enmod #{context.name}"
      end

    end
  end
end
