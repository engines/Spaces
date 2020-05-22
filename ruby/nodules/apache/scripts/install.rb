require_relative '../../../texts/script'

module Nodules
  module Apache
    module Scripts
      class Install < Texts::Script

        def body
          "a2enmod #{context.name}"
        end

      end
    end
  end
end
