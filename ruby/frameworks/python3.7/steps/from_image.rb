require_relative '../../steps/requires'

module Frameworks
  module Python37
    module Steps
      class FromImage < Docker::Files::Step

        def instructions
          "FROM engines/python3.7:current"
        end

      end
    end
  end
end
