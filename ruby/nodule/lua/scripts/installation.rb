require_relative '../../../spaces/script'

module Nodule
  class Lua
    class Installation < Spaces::Script

      def body
        "luarocks install #{context.name}"
      end

    end
  end
end
