require_relative '../../../texts/script'

module Nodules
  module NPM
    module Scripts
      class Install < Texts::Script

        def body
          "npm install #{context.name}"
        end

      end
    end
  end
end
