require_relative '../../steps/requires'

module Frameworks
  module PHP
    module Steps
      class FromImage < Docker::Files::Step

        def instructions
          "FROM engines/php:current"
        end

      end
    end
  end
end
