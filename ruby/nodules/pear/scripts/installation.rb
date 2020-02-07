require_relative 'requires'

module Nodule
  class Pear
    class Installation < Spaces::Script

      def body
        "pear install #{context.name}"
      end

    end
  end
end
