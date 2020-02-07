require_relative '../../../spaces/script'

module Nodules
  class NPM
    class Installation < Spaces::Script

      def body
        "npm install #{context.name}"
      end

    end
  end
end
