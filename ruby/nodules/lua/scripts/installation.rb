require_relative '../../../collaborators/script'

module Nodules
  module Lua
    module Scripts
      class Installation < Collaborators::Script

        def body
          "luarocks install #{context.name}"
        end

      end
    end
  end
end
