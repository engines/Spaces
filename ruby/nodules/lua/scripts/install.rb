require_relative '../../../texts/script'

module Nodules
  module Lua
    module Scripts
      class Install < Texts::Script

        def body
          "luarocks install #{context.name}"
        end

      end
    end
  end
end
