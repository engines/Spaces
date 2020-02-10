require_relative 'requires'

module Frameworks
  module ApachePHP
    module Steps
      class FromImage < Docker::Files::Step

        def content
          "FROM engines/php:current"
        end

      end
    end
  end
end
