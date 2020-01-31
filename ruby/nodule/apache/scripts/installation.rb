require_relative 'requires'

module Nodule
  class Apache
    class Installation < Spaces::Script

      def body
        "RUN a2enmod #{context.name}"
      end

    end
  end
end
