require_relative 'requires'

module Frameworks
  module Rails5
    module Steps
      class FromImage < Docker::Files::Step

        def content
          "FROM engines/ngpassenger:current"
        end

      end
    end
  end
end
