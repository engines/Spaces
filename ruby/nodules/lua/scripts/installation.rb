require_relative '../../../spaces/script'

module Nodules
  module Lua
    module Scripts

      class Installation < Spaces::Script

        def body
          "luarocks install #{context.name}"
        end

      end
    end
  end
end
