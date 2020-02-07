require_relative 'requires'

module Frameworks
  class Rails5
    class FromImage < Docker::Files::Step

      def content
        "FROM engines/ngpassenger:current"
      end

    end
  end
end
