require_relative 'requires'

module Frameworks
  module PHP
    module Steps
      class FromImage < Docker::Files::Step

        def product
          "FROM engines/php:current"
        end

      end
    end
  end
end
