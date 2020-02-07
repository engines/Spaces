require_relative 'requires'

module Nodules
  class Pear
    class Installation < Spaces::Script

      def body
        "pear install #{context.name}"
      end

    end
  end
end
