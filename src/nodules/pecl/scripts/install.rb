require_relative '../../../texts/script'

module Nodules
  module Pecl
    module Scripts
      class Install < Texts::Script

        def body
          "echo \"  \" |  pecl install #{context.name}"
        end

      end
    end
  end
end
