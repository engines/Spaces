require_relative '../../../products/script'

module Nodules
  module Lua
    module Scripts

      class Installation < Products::Script

        def body
          "luarocks install #{context.name}"
        end

      end
    end
  end
end
