require_relative 'requires'

module Frameworks
  module Python37
    module Steps
      class FromImage < Docker::Files::Step

        def product
          "FROM engines/python3.7:current"
        end

      end
    end
  end
end
