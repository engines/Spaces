require_relative '../../../spaces/script'

module Nodule
  class NPM
    class Installation < Spaces::Script

      def body
        "npm install #{context.name}"
      end

    end
  end
end
