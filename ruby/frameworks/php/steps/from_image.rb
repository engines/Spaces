require_relative '../../steps/requires'

module Frameworks
  module PHP
    module Steps
      class FromImage < Docker::Files::Step

        def product
          "FROM engines/php:v2"
        end

      end
    end
  end
end
